package com.fractionviewer 
{
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import mx.binding.utils.BindingUtils;
	
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
				
			var oneThirdStageWidth:Number = stage.stageWidth / 3;
			var oneThirdStageHeight:Number = stage.stageHeight / 3;
				
			var next_button:Sprite = createButton("Next");
			next_button.x = 2 * oneThirdStageWidth;
			next_button.y = 2 * oneThirdStageHeight + oneThirdStageHeight/2;
			addChild(next_button);
			
			var back_button:Sprite = createButton("Back");
			back_button.x = oneThirdStageWidth - back_button.width;
			back_button.y = 2 * oneThirdStageHeight + oneThirdStageHeight/2;
			addChild(back_button);
			
			var display_penyebut:TextField = new TextField();
			display_penyebut.text = circle_fraction.penyebut.toString();
			addChild(display_penyebut);
			BindingUtils.bindProperty(display_penyebut, "text", circle_fraction, "penyebut");
			
			BindingUtils.bindSetter(
				function(valueReceived:int):void {
					display_penyebut.text = valueReceived + " bagian";
				},
				circle_fraction,
				"penyebut");
		}
		
		private function createButton(text:String, width:int = 150, height:int = 50):Sprite 
		{
			var rect_width:int = width;
			var rect_height:int = height;
			
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
			
			
			var label:TextField = new TextField();
			label.width = rect_width;
			label.height = rect_height;
			label.defaultTextFormat = new TextFormat("Verdana", 36, 0x000000,null,null,null,null,null,TextFormatAlign.CENTER);
			label.text = text;
			label.mouseEnabled = false;
			
			var the_button:SimpleButton = new SimpleButton();
			the_button.downState = the_button.hitTestState = round_rect;
			the_button.overState = round_rect_darker;
			the_button.upState = round_rect;
			
			var button_sprite:Sprite = new Sprite();
			button_sprite.addChild(the_button);
			button_sprite.addChild(label);
			
			return button_sprite;
		}
	}

}