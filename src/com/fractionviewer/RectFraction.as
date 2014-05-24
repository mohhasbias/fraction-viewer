package com.fractionviewer 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	public class RectFraction extends Sprite 
	{	
		private const FILL_COLOR_EMPTY:int = 0xF7F7F7;
		private const FILL_COLOR_SELECTED:int = 0x23ED36;
		private const LINE_THICKNESS_OUTER:int = 5;
		private const STROKE_COLOR_OUTER:int = 0x666666;
		
		private var _rect_width:Number;
		private var _rect_height:Number;
		
		private var _pembilang:Number;
		private var _penyebut:Number;
		
		public function RectFraction(width:int = 2.25*90, height:int = 1.75*90, pembilang:int = 3, penyebut:int = 4) 
		{
			super();
			
			rect_width = width;
			rect_height = height;
			
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
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void {
			//trace("width, height: " + rect_width + "x" + rect_height);
			
			// remove all child
			while (numChildren > 0)
			{
				removeChildAt(0);
			}
			
			// draw placeholder
			var rect:Shape = new Shape();
			rect.graphics.lineStyle(LINE_THICKNESS_OUTER, STROKE_COLOR_OUTER);
			rect.graphics.beginFill(FILL_COLOR_EMPTY);
			rect.graphics.drawRect(0, 0, rect_width, rect_height);
			rect.graphics.endFill();
			
			addChild(rect);
			
			var sub_width:Number = rect_width / penyebut;
			var i:int;
			
			// draw sections
			for ( i = 0; i < pembilang; i++) {
				var section:Shape = new Shape();
				section.graphics.beginFill(FILL_COLOR_SELECTED);
				section.graphics.drawRect(i * sub_width + LINE_THICKNESS_OUTER/2, LINE_THICKNESS_OUTER/2, sub_width, rect_height - LINE_THICKNESS_OUTER);
				section.graphics.endFill();
				addChild(section);
			}
			
			// draw divider
			for ( i = 1; penyebut > 1 && i < penyebut; i++) {
				var line:Shape = new Shape();
				line.graphics.lineStyle(0.75 * LINE_THICKNESS_OUTER, STROKE_COLOR_OUTER);
				line.graphics.moveTo(i * sub_width, 0);
				line.graphics.lineTo(i * sub_width, rect_height);
				addChild(line);
			}
		}
		
		public function get pembilang():Number 
		{
			return _pembilang;
		}
		
		public function set pembilang(value:Number):void 
		{
			_pembilang = value;
		}
		
		public function get penyebut():Number 
		{
			return _penyebut;
		}
		
		public function set penyebut(value:Number):void 
		{
			_penyebut = value;
		}
		
		public function get rect_width():Number 
		{
			return _rect_width;
		}
		
		public function set rect_width(value:Number):void 
		{
			_rect_width = value;
		}
		
		public function get rect_height():Number 
		{
			return _rect_height;
		}
		
		public function set rect_height(value:Number):void 
		{
			_rect_height = value;
		}
		
		public static function test(the_stage:Stage):void {
			import flash.events.MouseEvent;
			
			//trace("stage: " + stage);
			var dummy_sprite:Sprite = new Sprite();
			
			var circle_radius:Number = 120;
			
			var rects:Array = new Array();
			rects.push(new RectFraction(2.25 * circle_radius, 1.75 * circle_radius, 1, 2));
			rects.push(new RectFraction(2.25 * circle_radius, 1.75 * circle_radius, 2, 3));
			rects.push(new RectFraction(2.25 * circle_radius, 1.75 * circle_radius, 3, 4));
			rects.push(new RectFraction(2.25 * circle_radius, 1.75 * circle_radius, 5, 6));
			
			for (var i:int = 0; i < rects.length; i++) {
				rects[i].x = (i % 3) * (rects[i].rect_width + 15);
				rects[i].y = Math.floor(i / 3) * (rects[i].rect_height + 15);
				the_stage.addChild(rects[i]);
				
				rects[i].buttonMode = true;
				rects[i].addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
					var rect:RectFraction = e.currentTarget as RectFraction;
					
					rect.penyebut += 1;
				});
			}
		}
	}

}