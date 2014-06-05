package com.fractionviewer 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import flash.filters.BevelFilter;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.display.CapsStyle;
	import flash.text.TextFieldType;
	import flash.text.TextFormatAlign;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	public class TextFieldFraction extends Sprite 
	{
		private var _pembilang:int;
		private var _penyebut:int;
		
		private var separator:Shape;
		
		//private var spacing:int;
		private var thickness:int;
		
		public function TextFieldFraction(pembilang:int = 3, penyebut:int = 4 ) 
		{
			super();
			
			this.pembilang = pembilang;
			this.penyebut = penyebut;
			
			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var oneThirdStageWidth:Number = stage.stageWidth / 3;
			var oneThirdStageHeight:Number = stage.stageHeight / 3;
			
			var display_pembilang:TextField = new TextField();
			display_pembilang.autoSize = TextFieldAutoSize.CENTER;
			display_pembilang.x = stage.stageWidth / 2;
			display_pembilang.y = oneThirdStageHeight + oneThirdStageHeight/3;
			//display_pembilang.filters = [new DropShadowFilter(2, 180+45, 0x000000, 1, 4, 4, 1, 3, true)];
			display_pembilang.filters = [new BevelFilter(1)];
			display_pembilang.defaultTextFormat = 
				new TextFormat("Verdana", 72, 0x000000, true, false, false, null, null, TextFormatAlign.CENTER);
			//display_fraction.selectable = false;
			display_pembilang.type = TextFieldType.INPUT;
			display_pembilang.background = true;
			display_pembilang.restrict = "0-9";
			display_pembilang.maxChars = 2;
			addChild(display_pembilang);
			
			display_pembilang.text = pembilang.toString();
			
			display_pembilang.addEventListener(FocusEvent.FOCUS_IN, onTextFieldFocused);
			
			var spacing:int = 16;
			//spacing = 16;
			
			var display_penyebut:TextField = new TextField();
			display_penyebut.autoSize = TextFieldAutoSize.CENTER;
			display_penyebut.x = stage.stageWidth / 2;
			display_penyebut.y = display_pembilang.y + display_pembilang.height + spacing;
			//display_penyebut.filters = [new DropShadowFilter(2, 180+45, 0x000000, 1, 4, 4, 1, 3, true)];
			display_penyebut.filters = [new BevelFilter(1)];
			display_penyebut.defaultTextFormat = 
				new TextFormat("Verdana", 72, 0x000000, true, false, false, null, null, TextFormatAlign.CENTER);
			//display_penyebut.selectable = false;
			display_penyebut.type = TextFieldType.INPUT;
			display_penyebut.background = true;
			display_penyebut.restrict = "0-9";
			display_penyebut.maxChars = 2;
			addChild(display_penyebut);
			
			display_penyebut.text = penyebut.toString();
			
			display_penyebut.addEventListener(FocusEvent.FOCUS_IN, onTextFieldFocused);
			display_penyebut.addEventListener(TextEvent.TEXT_INPUT, onTextFieldInput);
			
			//var thickness:int = 10;
			thickness = 10;
			//var separator:Shape = new Shape();
			separator = new Shape();
			separator.x = display_pembilang.x - display_pembilang.width/2;
			separator.y = display_penyebut.y - spacing / 2;
			addChild(separator);
			
			separator.graphics.lineStyle(thickness, 0x000000, 1, true, "normal", CapsStyle.SQUARE);
			separator.graphics.lineTo(display_pembilang.width * 2, 0);
			
			stage.focus = display_pembilang;
		}
		
		private function onTextFieldFocused(e:FocusEvent):void {
			var textfield:TextField = e.currentTarget as TextField;
			setTimeout(function():void{
				textfield.setSelection(0, textfield.text.length); 
				}, 50);
		}
		
		private function onTextFieldInput(e:TextEvent):void {
			//separator.graphics.clear();
			//separator.graphics.lineStyle(thickness, 0x000000, 1, true, "normal", CapsStyle.SQUARE);
			//separator.graphics.lineTo(e.currentTarget.width, 0);
		}
		
		public function get pembilang():int 
		{
			return _pembilang;
		}
		
		public function set pembilang(value:int):void 
		{
			_pembilang = value;
		}
		
		public function get penyebut():int 
		{
			return _penyebut;
		}
		
		public function set penyebut(value:int):void 
		{
			_penyebut = value;
		}
	}

}