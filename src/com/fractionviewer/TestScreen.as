package com.fractionviewer 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	public class TestScreen extends Screen 
	{
		public static const CIRCLE_TEST:int = 0;
		public static const RECT_TEST:int = 1;
		
		private var test_type:int;
		private var fractions:Array;
		
		public static const BACK_CLICKED:String = "Back Clicked";
		
		public function TestScreen(test_type:int = CIRCLE_TEST) 
		{
			super();
			
			this.test_type = test_type;
			
			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var oneThirdStageWidth:Number = stage.stageWidth / 3;
			var oneThirdStageHeight:Number = stage.stageHeight / 3;
			
			var back_button:Sprite = createButton("Back");
			back_button.x = oneThirdStageWidth - back_button.width;
			back_button.y = 2 * oneThirdStageHeight + oneThirdStageHeight/2;
			addChild(back_button);
			
			back_button.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void {
				dispatchEvent(new Event(BACK_CLICKED));
			});
			
			var cek_button:Sprite = createButton("Cek Jawaban", 250, 50);
			cek_button.x = stage.stageWidth / 2 - cek_button.width / 2;
			cek_button.y = 2 * oneThirdStageHeight + oneThirdStageHeight / 2;
			addChild(cek_button);
			
			cek_button.addEventListener(MouseEvent.CLICK, onCekButtonClicked);
			
			var text_fraction:TextFieldFraction = new TextFieldFraction();
			addChild(text_fraction);
			
			var numFraction:int = 3;
			var i:int;
			fractions = new Array();
			var max_fraction:int = 10;
			for (i = 0; i < numFraction; i++) {
				var penyebut:int = 2 + Math.floor(Math.random() * (max_fraction-2));
				var pembilang:int = 1 + Math.floor(Math.random() * (penyebut-1));
				trace(pembilang + "/" + penyebut);
				if (test_type == CIRCLE_TEST) {
					fractions.push(new CircleFraction(90, pembilang, penyebut));
				}
			}
			var sub_width:Number = stage.stageWidth / numFraction;
			var sub_height:Number = stage.stageHeight / 3;
			trace(sub_height);
			for (i = 0; i < numFraction; i++) {
				fractions[i].x = i * sub_width + (sub_width - fractions[i].view_width) / 2;
				fractions[i].y = (sub_height - fractions[i].view_height/2) / 2;
				
				addChild(fractions[i]);
			}
		}
		
		private function onCekButtonClicked(e:MouseEvent):void {
			
		}
	}

}