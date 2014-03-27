package com.funanima.exif 
{
	import com.funanima.exif.vo.tagsRelating.ifd0Entries.BaseIFDPointer;
	import com.funanima.exif.vo.tagsRelating.ifd0Entries.ExifIFDPointer;
	import com.funanima.exif.vo.TagDataDefine;
	import com.funanima.utils.MathUtil;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author 
	 */
	public class IFDGroup 
	{
		
		private var _stram:ByteArray;
		
		
		//若寫入的資料超過4byte 則需要等待IFD寫完後面區塊的位置寫入，因此有這個資料當作偏移
		private var offsetValueBasicPos:uint;
		//要寫入超過4BYTE的的位置
		private var offsetValuePos:uint = 0;
		private var _offsetValueAccumulate:uint = 0;
		
		///大於4BYTE的資料開始寫入的指標位置
		private var level1Size:uint;
		
		public function IFDGroup() 
		{
			_stram = new ByteArray();
			
		}
		
		private function streamPosMove(offset:uint):void {
			//trace( "瞬間移動 IFDGroup.streamPosMove > offset : " + offset );
			_stram.position = offset;
		}
		
		/**
		 * 寫入IFD的進入點
		 * @param	newIFDEntry			要增加的Entry
		 * @param	endian				寫入位元組高序還是低序
		 * @param	ifdEntriesCount		寫入的數量
		 * @param	isWriteEndIFDFlag	是否要在尾巴寫入 空白4 byte(NextIFD)
		 * @param	offset				偏移多少開始寫入
		 */
		public function writeIFD(newIFDEntry:Vector.<BaseIFDEntry>,endian:String,ifdEntriesCount:int = -1,isWriteEndIFDFlag:Boolean = false,offset:uint=0):void {
			_stram.endian = endian;
			streamPosMove(offset);
			
			var entryCount:uint = 0;
			if (ifdEntriesCount >= 0) {
				entryCount = newIFDEntry.length;
				//trace("寫入數量("+entryCount+")的位置:" + _stram.position.toString());
				_stram.writeShort(entryCount);
				
				addOffsetValueAccumulate = addIFDCountSize;
			}
			
			if(level1Size==0){
				level1Size = tiffSize + addIFDCountSize + addIFDEntrySize(entryCount) + addNextIFDSize; 
			}
			//2=IFDCountSize + 4=next ifd tag size + 12= n個entry  (這邊寫完的位置就是value的位置)
			offsetValueBasicPos += addIFDCountSize + addIFDEntrySize(entryCount) + addNextIFDSize; 
			//因為可能超出4BYTE的value可能會增加 所以這邊做了增加後要寫入的位置
			
			offsetValuePos = offsetValueBasicPos;
			
			for (var i:uint = 0; i < entryCount; i++) {
				
				var entries:BaseIFDEntry = newIFDEntry[i];
				//trace( "======================== Entries : " + entries );
				
				addOffsetValueAccumulate = addIFDEntrySize(1); //一定有12
				var valueTotalSize:uint = entries.count * TagDataDefine.getTagByTypeValue(entries.valueType).size;
				
				//Exif Pointer or GPS Pointer
				if (entries is BaseIFDPointer) {
					
					var pointerIFDEntriesCount:uint = BaseIFDPointer(entries).IFDEntries.length;
					if (pointerIFDEntriesCount <= 0) {
						throw new Error("entries:"+entries + " 未設定任何資料！");
						continue;
					}
					entries.value = [offsetValuePos + tiffSize];
					//寫入IFDPointer的內容
					getEntriesBytes(entries, endian, 0,0);
					
					var ifdPos:uint = _stram.position;
					
					level1Size += addIFDCountSize + addIFDEntrySize(pointerIFDEntriesCount) + addNextIFDSize;
					
					//********************指標移動並寫入IFDPointer 下的其他內容
					writeIFD(BaseIFDPointer(entries).IFDEntries, _stram.endian, pointerIFDEntriesCount, true,offsetValuePos);
					
					//再把位置還給要寫IFD的位置
					streamPosMove(ifdPos);
					continue;
				}else{
					//資料先算出超過4BYTE 就累加
					if (valueTotalSize > ifdContentSize) {
						addOffsetValueAccumulate = valueTotalSize;
						offsetValuePos += (valueTotalSize);
						
						getEntriesBytes(entries, endian, level1Size, valueTotalSize);
						
						level1Size += valueTotalSize;//後面資料有寫入 就必須加上寫入value的size
						
					}else {
						getEntriesBytes(entries, endian, 0,0);
					}
				}
			}
			
			if (isWriteEndIFDFlag) {
				writeNextIFD();
			}
		}
		
		private function writeNextIFD():void {
			addOffsetValueAccumulate = addNextIFDSize;
			_stram.writeInt(0x0);//NEXT IFD 空白
		}
		
		public function get stram():ByteArray 
		{
			return _stram;
		}
		
		
		public function get offsetValueAccumulate():uint 
		{
			return _offsetValueAccumulate;
		}
		
		private function set addOffsetValueAccumulate(value:uint):void {
			//trace( "offsetValueAccumulate : " + value );
			_offsetValueAccumulate += value;
		}
		
		
		/**
		 * 寫入新的IFD資料
		 * @param	newIFDEntry		
		 * @param	endian			位元組排序依據
		 * @param	valueOffset		若>0 代表需要把資料從這個位置開始寫
		 * @param	valueTotalSize	要寫入資料的大小
		 */
		private function getEntriesBytes(newIFDEntry:BaseIFDEntry,endian:String,valueOffset:uint,valueTotalSize:uint):void 
		{
			var valueType:TagDataDefine = TagDataDefine.getTagByTypeValue(newIFDEntry.valueType);
			
			//寫入 名稱代碼
			writeTagID(newIFDEntry.tagID);
			
			
			//寫入 值的型態
			writyValueType(newIFDEntry.valueType);
			
			
			//寫入 值的數量
			var valueCount:uint = newIFDEntry.count;
			writeValueCount(valueCount);
			
			
			//預計下次寫入IFD位置
			var nextIFDPos:uint = _stram.position + ifdContentSize;
			
			//寫入 值
			var wSpace:int = valueType.size * valueCount;//有幾個空間必須寫入
			
			if (valueOffset > 0 ) {
				
				var whereStart:uint = valueOffset;
				
				//trace("資料超過4BYTE 位置資料GPSLat: " + (whereStart));
				_stram.writeInt(whereStart);//資料超過4BYTE 這邊改為位置資料
				streamPosMove(whereStart-tiffSize);
				
				wSpace += 4;//補滿0個位元組
				
			}
			
			
			for (var i:uint = 0; i < valueCount; i++) {
				var value:* = newIFDEntry.value[i];
				
				//trace("[WRITE] ("+_stram.position+") value:" + value);
				
				switch(newIFDEntry.valueType) {
					case 1://BYTE
					case 7://UNDEFINED
						_stram.writeByte(value);
						break;
					case 2://ASCII
						//_stram.writeUTFBytes(value);
						var ascCode:Number = 0;
						if(value is String)
							ascCode = String(value).charCodeAt(0);
						_stram.writeByte(ascCode);
						break;
					case 3://SHORT
						_stram.writeShort(value);
						break;
					case 4://LONG
					case 9://SLONG
						_stram.writeInt(value);
						break;
					case 5://RATIONAL
					case 10://SRATIONAL
						var fraction:Array = MathUtil.approximateFraction(value);
						//if -1 分子 numerator = 1
						
						var numerator:uint 	= fraction[0];
						var denominator:uint = fraction[1];
						
						_stram.writeInt(numerator);
						_stram.writeInt(denominator);
						
						break;
					default:
						throw new Error("沒解析到 type:"+newIFDEntry.valueType);
						break;
				}
			}
			
			var fillByteCount:uint = wSpace % ifdContentSize;
			if(fillByteCount>0){
				for (var j:int = 0; j < fillByteCount; j++) 
				{
					_stram.writeByte(0);
					//trace("補0");
				}
			}
			streamPosMove(nextIFDPos);
			//_stram.position = nextIFDPos;
			
			//return entriesStream;
		}
		
		private function writeValueCount(valueCount:uint):void 
		{
			_stram.writeInt(valueCount);
		}
		
		private function writyValueType(valueType:uint):void 
		{
			_stram.writeShort(valueType);
		}
		
		private function writeTagID(tagID:uint):void 
		{
			_stram.writeShort(tagID);
			//trace("[WRITE] Short tagID: [0x"+_stram.position.toString(16)+"] 0x"+tagID.toString(16));
		}
		
		private function get addNextIFDSize():uint {
			//trace( "-------結束 NextIFD-------\n");
			return 4;
		}
		
		
		private function get ifdContentSize():uint {
			//trace( "-------IFD 內容大小-------\n");
			return 4;
		}
		
		///有"幾組"IFD的SIZE
		private function get addIFDCountSize():uint {
			//trace( "-------IFD Count-------");
			return 2;
		}
		
		private function addIFDEntrySize(count:uint):uint {
			//trace( "-------內容-------"+(count * 12));
			//每個 Entries 大小  TagID(2b) + Value Type(2b) + Count(4b) + data(4b)
			return count * 12;
		}
		
		///TIFF HEADERS SIZE
		private function get tiffSize():uint {
			//TIFF SIZE 固定的
			//2 Bytes ByteOrder ||(低序little endian) or MM(高序 big endian) 決定後面寫的內容
			//2 Bytes (fixed)
			//4 Bytes Offset of IFD
			return 8;
		}
		
	}

}