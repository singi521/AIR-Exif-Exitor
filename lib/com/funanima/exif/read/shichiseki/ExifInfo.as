/**
 * @author	Copyright (c) 2008 shichiseki.jp
 * @version	1.0
 * @link		http://code.shichiseki.jp/as3/ExifInfo/
 */
package com.funanima.exif.read.shichiseki {
	import flash.utils.ByteArray;

	/**
  * The ExifInfo class contains information about a JPEG file. It includes some IFD
  * which contain some tags. The ExifInfo class also contains the thumbnail image of
  * the JPEG file. The ExifInfo class is loosely based on Exif Version 2.2.
  * See <a href="http://www.exif.org/Exif2-2.PDF">http://www.exif.org/Exif2-2.PDF</a>
  * for more detail of Exif specification.
  */
	public class ExifInfo {
		private var _app1DataSize:uint;
		private var _app1DataSizePos:uint;
		protected const SOI_MAKER:Array = [0xff, 0xd8];
		public const APP1_MAKER:Array = [0xff, 0xe1];
		protected const EXIF_HEADER:Array = [0x45, 0x78, 0x69, 0x66, 0x00, 0x00];
		protected const JFIF_MAKER:Array = [0xff, 0xe0];

		protected var _tiffHeader:TIFFHeader;
		/**
		 * An TIFF header of the JPEG APP1.
		 *
		 * @see jp.shichiseki.exif.TIFFHeader;
		 */
		public function get tiffHeader():TIFFHeader { return _tiffHeader; }

		protected var _ifds:IFDSet;
		/**
		 * A set of IFD that read from a JPEG file.
		 *
		 * @see jp.shichiseki.exif.IFDSet
		 */
		public function get ifds():IFDSet { return _ifds; }

		protected var _thumbnailData:ByteArray;
		/**
		 * A thumbnail data extracted from a JPEG file.
		 *
		 * @example The following example shows the thumbnail image.
		 * <listing version="3.0">
		 * protected var loadImage(jpeg:ByteArray):void {
		 *	 var exif:ExifInfo = new ExifInfo(jpeg);
		 *   var loader:Loader = new Loader();
		 *	 loader.loadBytes(exif.thumbnailData);
		 *   appendChild(loader);
		 * }
		 * </listing>
		 */
		public function get thumbnailData():ByteArray { return _thumbnailData; }
		
		public function get app1DataSize():uint 
		{
			return _app1DataSize;
		}
		
		public function get app1DataSizePos():uint 
		{
			return _app1DataSizePos;
		}

		/**
		 * Create the Exif information instance from a JPEG file.
		 * @param stream	JPEG file stored in a ByteArray object.
		 */
		public function ExifInfo(stream:ByteArray) {
			if (!validate(stream)) {
				return;
			}
			_tiffHeader = new TIFFHeader(stream);
			trace( "stream position: " + stream.position );
			readIFDs(stream);
			readThumbnail(stream);
		}

		protected function validate(stream:ByteArray):Boolean {
			// JPG format check
			if (!hasSoiMaker(stream) ) {
				return false;
			}
			if(hasJFIFMaker(stream)) { // Skip the JFIF marker, if present. CWW
				stream.position += 16;
			} else {
				stream.position -=2; // Set position back to start of APP1 marker
			}
			
			if ( !hasAPP1Maker(stream)) {
				return false;
			}
			// handle app1 data size
			_app1DataSizePos = stream.position;
			_app1DataSize = stream.readUnsignedShort();
			trace( "_app1DataSize : " + _app1DataSize );
			if (!hasExifHeader(stream)) {
				return false;
			}
			return true;
		}

		protected function readIFDs(stream:ByteArray):void {
			_ifds = new IFDSet();

			// primary ifd
			//trace("============================== primary ifd ==============================");
			ifds._primary = new IFD(stream, Tags.getSet("primary"), tiffHeader.position);
			
			// 1st ifd (for thumbnail) 
			trace("============================== 1st ifd (for thumbnail) ==============================");
			var nextIFDPointer:uint = stream.readUnsignedInt();
			//trace( "nextIFDPointer : " + nextIFDPointer );
			if (nextIFDPointer != 0) {
				stream.position = nextIFDPointer + tiffHeader.position;
				ifds._thumbnail = new IFD(stream, Tags.getSet("thumbnail"), tiffHeader.position);
			}
			// Exif ifd
			//trace("============================== Exif ifd ==============================");
			
			if (ifds.primary.ExifIFDPointer) {
				stream.position = ifds.primary.ExifIFDPointer + tiffHeader.position;
				ifds._exif = new IFD(stream, Tags.getSet("exif"), tiffHeader.position);
				delete ifds._primary.ExifIFDPointer;
			}
			// GPS ifd
			//trace("============================== GPS ifd ==============================");
			if (ifds.primary.GPSInfoIFDPointer) {
				stream.position = ifds.primary.GPSInfoIFDPointer + tiffHeader.position;
				ifds._gps = new IFD(stream, Tags.getSet("gps"), tiffHeader.position);
				delete ifds._primary.GPSInfoIFDPointer;
			}
			// Interoperability ifd
			//trace("============================== Interoperability ifd ==============================");
			if (ifds.exif && ifds.exif.InteroperabilityIFDPointer) {
				stream.position = ifds.exif.InteroperabilityIFDPointer + tiffHeader.position;
				ifds._interoperability = new IFD(stream, Tags.getSet("interoperability"), tiffHeader.position);
				delete ifds._exif.InteroperabilityIFDPointer;
			}
		}

		protected function readThumbnail(stream:ByteArray):void {
			// read thumbnail
			if (ifds.thumbnail &&
					ifds.thumbnail.JPEGInterchangeFormat &&
					ifds.thumbnail.JPEGInterchangeFormatLength) {
				_thumbnailData = new ByteArray();
				stream.position = ifds.thumbnail.JPEGInterchangeFormat + tiffHeader.position;
				stream.readBytes(_thumbnailData, 0, ifds.thumbnail.JPEGInterchangeFormatLength);
				delete ifds._thumbnail.JPEGInterchangeFormat;
				delete ifds._thumbnail.JPEGInterchangeFormatLength;
			}
		}

		protected function hasSoiMaker(stream:ByteArray):Boolean {
			return compareStreamBytes(stream, SOI_MAKER);
		}

		protected function hasJFIFMaker(stream:ByteArray):Boolean {
			return compareStreamBytes(stream, JFIF_MAKER);
		}
		
		protected function hasAPP1Maker(stream:ByteArray):Boolean {
			return compareStreamBytes(stream, APP1_MAKER);
		}

		protected function hasExifHeader(stream:ByteArray):Boolean {
			return compareStreamBytes(stream, EXIF_HEADER);
		}

		protected function compareStreamBytes(stream:ByteArray, data:Array, offset:uint=0):Boolean {
			var b:uint;
			if (offset > 0)
				stream.position = offset;
			for (var i:int = 0; i < data.length; i++) {
				b = stream.readUnsignedByte();
				if (b != data[i]) return false;
			}
			return true;
		}
	}
}
