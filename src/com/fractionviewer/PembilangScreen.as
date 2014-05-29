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
	import flash.display.CapsStyle;
	
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	public class PembilangScreen extends Screen 
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
				onShapeClicked);
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
			//separator.graphics.moveTo(display_penyebut.x, display_penyebut.y + display_penyebut.height/2);
			//separator.graphics.lineTo(display_penyebut.x + display_penyebut.textWidth, display_penyebut.y + display_penyebut.height/2);
			addChild(separator);
			
			BindingUtils.bindSetter(
				function(valueReceived:int):void {
					display_penyebut.text = valueReceived + "\n" + the_fraction.penyebut;
					trace(display_penyebut.textWidth);
					separator.graphics.clear();
					separator.graphics.lineStyle(10, 0x000000, 1, true, "normal", CapsStyle.SQUARE);
					separator.graphics.moveTo(display_penyebut.x, display_penyebut.y + 0.52 * display_penyebut.height);
					separator.graphics.lineTo(display_penyebut.x + display_penyebut.textWidth, display_penyebut.y + 0.52 * display_penyebut.height);
				},
				the_fraction,
				"pembilang");
				
			//var next_button:Sprite = createButton("Test");
			//next_button.x = 2 * oneThirdStageWidth;
			//next_button.y = 2 * oneThirdStageHeight + oneThirdStageHeight/2;
			//addChild(next_button);
			
			//next_button.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void {
				//dispatchEvent(new Event(TEST_CLICKED));
			//});
			
			var back_button:Sprite = createButton("Back");
			back_button.x = oneThirdStageWidth - back_button.width;
			back_button.y = 2 * oneThirdStageHeight + oneThirdStageHeight/2;
			addChild(back_button);
			
			back_button.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void {
				dispatchEvent(new Event(BACK_CLICKED));
			});
			
			addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void {
				trace("contains circle_fraction: " + contains(the_fraction));
				if ( !contains(the_fraction) ) {
					addChild(the_fraction);
				}
				display_penyebut.text = the_fraction.pembilang + "\n" + the_fraction.penyebut;
				the_fraction.addEventListener(MouseEvent.CLICK, onShapeClicked);
			});
			
			addEventListener(Event.REMOVED_FROM_STAGE, function(e:Event):void {
				the_fraction.removeEventListener(MouseEvent.CLICK, onShapeClicked);
			});
		}
		
		private function onShapeClicked(e:MouseEvent):void {
			trace("ouch");
			the_fraction.pembilang += 1;
			trace("pembilang: " + the_fraction.pembilang);
		}
	}

}