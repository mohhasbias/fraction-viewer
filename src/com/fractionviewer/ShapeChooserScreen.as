package com.fractionviewer 
{
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import com.greensock.TweenLite;
	
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
		
		public static const CIRCLE_CLICKED:String = "Circle Clicked";
		public static const RECT_CLICKED:String = "Rect Clicked";
		
		private var _circle_button:SimpleButton;
		private var _rect_button:SimpleButton;
		
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
			
			var radius:Number = 120;
			
			_circle_button = createCircleButton(radius);
			_circle_button.x = stage.stageWidth/3 - (circle_button.width/2);
			_circle_button.y = stage.stageHeight/3 - (circle_button.height/2);
		
			addChild(circle_button);
			circle_button.addEventListener(MouseEvent.MOUSE_DOWN, onCircleClicked);
			
			
			_rect_button = createRectButton(2.25*radius, 1.75*radius);
			_rect_button.x = stage.stageWidth/3*2 - (rect_button.width/2);
			_rect_button.y = stage.stageHeight / 3 - (rect_button.height / 2);// + (circle_button.height - rect_button.height) / 2;
			
			addChild(rect_button);
			rect_button.addEventListener(MouseEvent.MOUSE_DOWN, onRectClicked);
		}
		
		private function onCircleClicked(e:MouseEvent):void {
			trace(circle_button);
			var animation_duration:Number = 0.5;
			swapChildren(circle_button, rect_button);
			circle_button.enabled = false;
			circle_button.overState = circle_button.downState;
			TweenLite.to(rect_button, animation_duration, { alpha: 0 } );
			TweenLite.to(
				circle_button, animation_duration, 
				{
					x: stage.stageWidth / 2 - circle_button.width / 2, 
					y: circle_button.y,
					onComplete: function():void {
						trace("completed");
						circle_button.x = stage.stageWidth / 3 - (circle_button.width / 2);
						circle_button.enabled = true;
						circle_button.overState = circle_button.hitTestState;
						rect_button.alpha = 1;
						dispatchEvent(new Event(CIRCLE_CLICKED));
						}} );
		}
		
		private function onRectClicked(e:MouseEvent):void {
			rect_button.enabled = false;
			rect_button.overState = rect_button.downState;
			TweenLite.to(circle_button, 0.5, { alpha: 0 } );
			TweenLite.to(
				rect_button, 0.5, 
				{
					x: stage.stageWidth / 2 - rect_button.width / 2, 
					y: rect_button.y,
					onComplete: function():void {
						dispatchEvent(new Event(RECT_CLICKED));
						trace("completed")}} );
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
			button.hitTestState = circle_glow;
			//button.hitTestState = circle_regular;
			
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
			//button.hitTestState = rect_regular;
			button.hitTestState = rect_glow;
			
			return button;
		}
		
		public function get circle_button():SimpleButton 
		{
			return _circle_button;
		}
		
		public function get rect_button():SimpleButton 
		{
			return _rect_button;
		}
	}

}