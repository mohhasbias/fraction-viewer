package com.fractionviewer
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	[SWF(width="960",height="540",frameRate="24",backgroundColor="#CCCCCC")]
	
	public class Main extends Sprite
	{
		private var circle_fraction:CircleFraction;
		
		public function Main()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			circle_fraction = new CircleFraction();
			circle_fraction.x = 100;
			circle_fraction.y = 100;
			
			addChild(circle_fraction);
			
			circle_fraction.addEventListener(MouseEvent.CLICK, onCircleClicked);
		}
		
		private function onCircleClicked(e:MouseEvent):void
		{
			circle_fraction.penyebut += 1;
		}
	}

}