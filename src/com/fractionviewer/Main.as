package com.fractionviewer
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	[SWF(width="1920", height="1080", frameRate="24", backgroundColor="#CCCCCC")]
	public class Main extends Sprite 
	{
		private var circle_fraction:CircleFraction;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			circle_fraction = new CircleFraction();
			circle_fraction.x = 100;
			circle_fraction.y = 100;
			
			addChild(circle_fraction);
		}
		
	}
	
}