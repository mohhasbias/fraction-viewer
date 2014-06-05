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
		
		private var display_penyebut:TextField;
		private var display_pembilang:TextField;
		
		public function TextFieldFraction(pembilang:int = 3, penyebut:int = 4 ) 
		{
			super();
			
			display_pembilang = new TextField();
			display_penyebut = new TextField();
			
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
		
			//display_pembilang.autoSize = TextFieldAutoSize.CENTER;
			display_pembilang.width = 120;
			display_pembilang.height = 90;
			display_pembilang.filters = [new BevelFilter(1)];
			display_pembilang.defaultTextFormat = 
				new TextFormat("Verdana", 72, 0x000000, true, false, false, null, null, TextFormatAlign.CENTER);
			display_pembilang.type = TextFieldType.INPUT;
			display_pembilang.background = true;
			display_pembilang.restrict = "0-9";
			display_pembilang.maxChars = 2;
			addChild(display_pembilang);
			
			display_pembilang.text = pembilang.toString();
			
			display_pembilang.addEventListener(FocusEvent.FOCUS_IN, onTextFieldFocused);
			display_pembilang.addEventListener(TextEvent.TEXT_INPUT, onTextFieldInput);
			
			var spacing:int = 16;
			
			//display_penyebut.autoSize = TextFieldAutoSize.CENTER;
			display_penyebut.width = 120;
			display_penyebut.height = 90;
			display_penyebut.y = display_pembilang.y + display_pembilang.height + spacing;
			display_penyebut.filters = [new BevelFilter(1)];
			display_penyebut.defaultTextFormat = 
				new TextFormat("Verdana", 72, 0x000000, true, false, false, null, null, TextFormatAlign.CENTER);
			display_penyebut.type = TextFieldType.INPUT;
			display_penyebut.background = true;
			display_penyebut.restrict = "0-9";
			display_penyebut.maxChars = 2;
			addChild(display_penyebut);
			
			display_penyebut.text = penyebut.toString();
			
			display_penyebut.addEventListener(FocusEvent.FOCUS_IN, onTextFieldFocused);
			display_penyebut.addEventListener(TextEvent.TEXT_INPUT, onTextFieldInput);
			
			thickness = 10;
			separator = new Shape();
			separator.x = display_pembilang.x - display_pembilang.width/4;
			separator.y = display_penyebut.y - spacing / 2;
			addChild(separator);
			
			separator.graphics.lineStyle(thickness, 0x000000, 1, true, "normal", CapsStyle.SQUARE);
			separator.graphics.lineTo(display_pembilang.width * 1.5, 0);
			
			//stage.focus = display_pembilang;
		}
		
		private function onTextFieldFocused(e:FocusEvent):void {
			var textfield:TextField = e.currentTarget as TextField;
			setTimeout(function():void{
				textfield.setSelection(0, textfield.text.length); 
				}, 50);
		}
		
		private function onTextFieldInput(e:TextEvent):void {
			
		}
		
		public function get pembilang():int 
		{
			_pembilang = parseInt(display_pembilang.text);
			return _pembilang;
		}
		
		public function set pembilang(value:int):void 
		{
			_pembilang = value;
			display_pembilang.text = _pembilang.toString();
		}
		
		public function get penyebut():int 
		{
			_penyebut = parseInt(display_penyebut.text);
			return _penyebut;
		}
		
		public function set penyebut(value:int):void 
		{
			_penyebut = value;
			display_penyebut.text = _penyebut.toString();
		}
		
		public function get view_width():int {
			return separator.width;
		}
		
		public function focus():void {
			stage.focus = display_pembilang;
		}
	}

}