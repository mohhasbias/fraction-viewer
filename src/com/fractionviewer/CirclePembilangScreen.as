package com.fractionviewer 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	public class CirclePembilangScreen extends Sprite 
	{
		
		public function CirclePembilangScreen() 
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
			
			var circle_fraction:CircleFraction = new CircleFraction(120,0,4);
			trace(circle_fraction.radius);
			circle_fraction.x = stage.stageWidth / 2 - (circle_fraction.radius);
			circle_fraction.y = stage.stageHeight / 3 - (circle_fraction.radius) - 2; // hard coded position
			circle_fraction.buttonMode = true;
			addChild(circle_fraction);
			
			circle_fraction.addEventListener(
				MouseEvent.CLICK,
				function (e:MouseEvent):void {
					trace("ouch");
					circle_fraction.pembilang += 1;
					trace("pembilang: " + circle_fraction.pembilang);
				});
		}
	}

}