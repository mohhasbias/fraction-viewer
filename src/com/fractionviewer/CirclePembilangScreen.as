package com.fractionviewer 
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import mx.binding.utils.BindingUtils;
	import flash.display.SimpleButton;
	
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	public class PembilangScreen extends Sprite 
	{
		private var the_fraction:ShapeFraction;
		
		public static const TEST_CLICKED:String = "Next Clicked";
		public static const BACK_CLICKED:String = "Back Clicked";
		
		public function PembilangScreen(the_fraction:ShapeFraction = null) 
		{
			super();
			
			if (the_fraction) {
				this.the_fraction = the_fraction;
			} else {
				this.the_fraction = new CircleFraction();
			}
			
			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//var circle_fraction:CircleFraction = new CircleFraction(90,0,4);
			//trace(circle_fraction.radius);
			the_fraction.x = stage.stageWidth / 2 - (the_fraction.view_width/2) - 3;
			the_fraction.y = stage.stageHeight / 3 - (the_fraction.view_height/2) - 3; // hard coded position
			the_fraction.buttonMode = true;
			the_fraction.addEventListener(
				MouseEvent.CLICK,
				onCircleClicked);
			addChild(the_fraction);	
			
			var oneThirdStageWidth:Number = stage.stageWidth / 3;
			var oneThirdStageHeight:Number = stage.stageHeight / 3;
				
			var display_penyebut:TextField = new TextField();
			//display_penyebut.border = true;
			display_penyebut.autoSize = TextFieldAutoSize.CENTER;
			display_penyebut.x = stage.stageWidth / 2;
			display_penyebut.y = 2 * oneThirdStageHeight - oneThirdStageHeight/3;
			display_penyebut.defaultTextFormat = 
				new TextFormat("Verdana", 72, 0x000000, true, null, null, null, null, TextFormatAlign.CENTER);
			display_penyebut.text = the_fraction.pembilang + "\n" + the_fraction.penyebut;
			addChild(display_penyebut);
			
			var separator:Shape = new Shape();
			separator.graphics.lineStyle(10, 0x000000);
			separator.graphics.moveTo(display_penyebut.x, display_penyebut.y + display_penyebut.height/2);
			separator.graphics.lineTo(display_penyebut.x + display_penyebut.textWidth, display_penyebut.y + display_penyebut.height/2);
			addChild(separator);
			
			BindingUtils.bindSetter(
				function(valueReceived:int):void {
					display_penyebut.text = valueReceived + "\n" + the_fraction.penyebut;
					trace(display_penyebut.textWidth);
					separator.graphics.clear();
					separator.graphics.lineStyle(10, 0x000000);
					separator.graphics.moveTo(display_penyebut.x, display_penyebut.y + display_penyebut.height/2);
					separator.graphics.lineTo(display_penyebut.x + display_penyebut.textWidth, display_penyebut.y + display_penyebut.height/2);
				},
				the_fraction,
				"pembilang");
				
			var next_button:Sprite = createButton("Test");
			next_button.x = 2 * oneThirdStageWidth;
			next_button.y = 2 * oneThirdStageHeight + oneThirdStageHeight/2;
			addChild(next_button);
			
			var back_button:Sprite = createButton("Back");
			back_button.x = oneThirdStageWidth - back_button.width;
			back_button.y = 2 * oneThirdStageHeight + oneThirdStageHeight/2;
			addChild(back_button);
			
			next_button.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void {
				dispatchEvent(new Event(TEST_CLICKED));
			});
			
			back_button.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void {
				dispatchEvent(new Event(BACK_CLICKED));
			});
			
			addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void {
				trace("contains circle_fraction: " + contains(the_fraction));
				if ( !contains(the_fraction) ) {
					addChild(the_fraction);
				}
				display_penyebut.text = the_fraction.pembilang + "\n" + the_fraction.penyebut;
				the_fraction.addEventListener(MouseEvent.CLICK, onCircleClicked);
			});
			
			addEventListener(Event.REMOVED_FROM_STAGE, function(e:Event):void {
				the_fraction.removeEventListener(MouseEvent.CLICK, onCircleClicked);
			});
		}
		
		private function onCircleClicked(e:MouseEvent):void {
			trace("ouch");
			the_fraction.pembilang += 1;
			trace("pembilang: " + the_fraction.pembilang);
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