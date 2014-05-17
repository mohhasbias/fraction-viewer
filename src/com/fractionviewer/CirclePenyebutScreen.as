package com.fractionviewer 
{
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	public class CirclePenyebutScreen extends Sprite 
	{
		
		public function CirclePenyebutScreen() 
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
			
			var circle_fraction:CircleFraction = new CircleFraction(120, 0, 1);
			trace(circle_fraction.radius);
			circle_fraction.x = stage.stageWidth / 2 - (circle_fraction.radius);
			circle_fraction.y = stage.stageHeight / 3 - (circle_fraction.radius) - 2; // hard coded position
			circle_fraction.buttonMode = true;
			addChild(circle_fraction);
			
			circle_fraction.addEventListener(
				MouseEvent.CLICK,
				function (e:MouseEvent):void {
					trace("ouch");
					circle_fraction.penyebut += 1;
				});
				
			var rect_width:int = 150;
			var rect_height:int = 50;
			var round_rect:Shape = new Shape();
			round_rect.graphics.lineStyle(1, 0x666666);
			round_rect.graphics.beginFill(0xEFEFEF);
			round_rect.graphics.drawRoundRect(0, 0, rect_width, rect_height, 7, 7);
			round_rect.graphics.endFill();
			var round_rect_darker:Shape = new Shape();
			round_rect_darker.graphics.lineStyle(1, 0x666666);
			round_rect_darker.graphics.beginFill(0xD4D4D4);
			round_rect_darker.graphics.drawRoundRect(0, 0, rect_width, rect_height, 7, 7);
			round_rect_darker.graphics.endFill();
			
			var next_button:SimpleButton = new SimpleButton();
			next_button.upState = next_button.downState = next_button.hitTestState = round_rect;
			next_button.overState = round_rect_darker;
			addChild(next_button);
		}
	}

}