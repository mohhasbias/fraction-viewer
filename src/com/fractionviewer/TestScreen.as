package com.fractionviewer 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	public class TestScreen extends Screen 
	{
		public static const CIRCLE_TEST:int = 0;
		public static const RECT_TEST:int = 1;
		
		public function TestScreen(test_type:int = CIRCLE_TEST) 
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
			var cek_button:Sprite = createButton("Cek Jawaban", 250, 50);
			cek_button.x = stage.stageWidth / 2 - cek_button.width / 2;
			cek_button.y = 2 * stage.stageHeight / 3 - cek_button.height / 2;
			addChild(cek_button);
		}
	}

}