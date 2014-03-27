package com.funanima.exif.read.shichiseki {
	import flash.utils.ByteArray;

/**
 * The IFD class represents an IFD in the Exif.
 * The IFD contains some IFDEntry which contain the information about the JPEG file.
 * You can get all IFDEntry information using following an example:
 * <listing version="3.0">
 * public function showEntries(ifd:IFD):void {
 *   for (var name:String in ifd) {
 *     log(name + ": " + ifd[name]);
 *   }
 * }
 * </listing>
 */
	dynamic public class IFD {
		private var entries:Array;
		private var _position:uint;
		private var _endPosition:uint;
		
		private var _tagSet:XML;
		private var _numEnt:uint;
		/**
		 * A set of tags represented as a XML that may be included in this IFD.
		 */
		public function get tagSet():XML { return _tagSet; }

		/**
		 * Constructor.
		 */
		public function IFD(stream:ByteArray, tagSet:XML, offset:uint) {
			_tagSet = tagSet;
			_position = stream.position;
			//trace("讀取IFD位置:" + _position);
			//有幾組EXIF TAG
			_numEnt = stream.readUnsignedShort();
			//trace( "0th_ifd_tiff.xml 共幾組資料 : " + _numEnt );
			
			entries = new Array();
			for (var i:uint = 0; i < _numEnt; i++) {
				//trace( "0th_ifd_tiff.xml >> "+i+"/" + _numEnt );
				readIFDEntries(stream, offset);
			}
			_endPosition = stream.position;
			//trace("結束IFD位置:" + _endPosition);
		}

		/**
		 * Indicates the level of this IFD.
		 */
		public function get level():String { 
			return tagSet.@level.toString();
		}
		
		public function get position():uint 
		{
			return _position;
		}
		
		public function get endPosition():uint 
		{
			return _endPosition;
		}
		
		public function get numEnt():uint 
		{
			return _numEnt;
		}
		

		/**
		 * Searches for an IFD by using <code>tagID</code>, and returns
		 * the IFD which matched the ID.
		 * @param	tagID		A tagID.
		 */
		public function getEntryByTagID(tagID:uint):IFDEntry {
			for each (var e:IFDEntry in entries) {
				if (e.tagID == tagID)
					return e;
			}
			return null;
		}

		/**
		 * Searches for an IFD by using <code>tagName</code>, and returns
		 * the IFD which mached the name.
		 * @param	tagName	A tag name.
		 */
		public function getEntryByTagName(tagName:String):IFDEntry {
			for each (var e:IFDEntry in entries) {
				if (e.tagName == tagName)
					return e;
			}
			return e;
		}
		
		

		private function readIFDEntries(stream:ByteArray, offset:uint):void {
			var entry:IFDEntry = new IFDEntry(stream, tagSet, offset);
			//寫入資料到OBJECT內
			if (entry.data) {
				this[entry.tagName] = entry.data;
			}
			entries.push(entry);
		}
	}
}
