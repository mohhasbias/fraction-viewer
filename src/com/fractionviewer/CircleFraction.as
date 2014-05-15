package com.fractionviewer 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	public class CircleFraction extends Sprite
	{
		private var radius:int;
		
		private const OUTER_STROKE:int = 0x666666;
		
		public function CircleFraction() 
		{
			super();
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			radius = 90;
			graphics.clear();
			graphics.lineStyle(5, OUTER_STROKE);
			graphics.beginFill(0x0000FF);
			graphics.moveTo(radius, radius);
			graphics.drawCircle(radius, radius, radius);
			graphics.endFill();
		}
	}

}