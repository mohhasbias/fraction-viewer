package com.fractionviewer 
{
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	public class ShapeChooserScreen extends Sprite 
	{	
		private const FILL_COLOR_EMPTY:int = 0xF7F7F7;
		private const LINE_THICKNESS_OUTER:int = 5;
		private const STROKE_COLOR_OUTER:int = 0x666666;
		private const GLOW_COLOR:int = 0xFF9900;
		
		public function ShapeChooserScreen() 
		{
			super();
			
			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			trace(parent);
			
			var circle_button:SimpleButton = createCircleButton();
			circle_button.x = 100;
			circle_button.y = 100;
		
			addChild(circle_button);
			
			var rect_button:SimpleButton = createRectButton();
			rect_button.x = 300;
			rect_button.y = 100 + (circle_button.height - rect_button.height)/2;
			
			addChild(rect_button);
		}
		
		private function createCircleButton(radius:int = 90):SimpleButton {
			var button:SimpleButton = new SimpleButton();
			
			var circle_regular:Shape = new Shape();
			circle_regular.graphics.lineStyle(LINE_THICKNESS_OUTER, STROKE_COLOR_OUTER);
			circle_regular.graphics.beginFill(FILL_COLOR_EMPTY);
			circle_regular.graphics.drawCircle(radius, radius, radius);
			circle_regular.graphics.endFill();
			
			button.upState = button.downState = circle_regular;
			
			var circle_glow:Sprite = new Sprite();
			circle_glow.graphics.lineStyle(LINE_THICKNESS_OUTER, STROKE_COLOR_OUTER);
			circle_glow.graphics.beginFill(FILL_COLOR_EMPTY);
			circle_glow.graphics.drawCircle(radius, radius, radius);
			circle_glow.graphics.endFill();
			circle_glow.filters = [new GlowFilter(GLOW_COLOR, 0.8, 27, 27)];
			
			button.overState = circle_glow;
			
			button.hitTestState = circle_regular;
			
			return button;
		}
		
		private function createRectButton(width:int = 2.25*90, height:int = 1.75*90):SimpleButton {
			
			var rect_regular:Shape = new Shape();
			rect_regular.graphics.lineStyle(LINE_THICKNESS_OUTER, STROKE_COLOR_OUTER);
			rect_regular.graphics.beginFill(FILL_COLOR_EMPTY);
			rect_regular.graphics.drawRect(0, 0, width, height);
			rect_regular.graphics.endFill();
		
			var rect_glow:Shape = new Shape();
			rect_glow.graphics.lineStyle(LINE_THICKNESS_OUTER, STROKE_COLOR_OUTER);
			rect_glow.graphics.beginFill(FILL_COLOR_EMPTY);
			rect_glow.graphics.drawRect(0, 0, width, height);
			rect_glow.graphics.endFill();
			rect_glow.filters = [ new GlowFilter(GLOW_COLOR, 0.8, 27, 27) ];
			
			var button:SimpleButton = new SimpleButton();
			button.upState = button.downState = rect_regular;
			button.overState = rect_glow;
			button.hitTestState = rect_regular;
			
			return button;
		}
	}

}