package com.fractionviewer 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import mx.binding.utils.BindingUtils;
	
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
			
			var circle_fraction:CircleFraction = new CircleFraction(90,0,4);
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
				
			var oneThirdStageWidth:Number = stage.stageWidth / 3;
			var oneThirdStageHeight:Number = stage.stageHeight / 3;
				
			var display_penyebut:TextField = new TextField();
			//display_penyebut.border = true;
			display_penyebut.autoSize = TextFieldAutoSize.CENTER;
			display_penyebut.x = stage.stageWidth / 2;
			display_penyebut.y = 2 * oneThirdStageHeight - oneThirdStageHeight/3;
			display_penyebut.defaultTextFormat = new TextFormat("Verdana", 72, 0x000000, true);
			display_penyebut.text = circle_fraction.pembilang + "/" + circle_fraction.penyebut;
			addChild(display_penyebut);
			
			BindingUtils.bindSetter(
				function(valueReceived:int):void {
					display_penyebut.text = valueReceived + "/" + circle_fraction.penyebut;
				},
				circle_fraction,
				"pembilang");
		}
	}

}