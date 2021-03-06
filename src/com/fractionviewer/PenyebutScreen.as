package com.fractionviewer 
{
	import com.greensock.TweenLite;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import mx.binding.utils.BindingUtils;
	
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	public class PenyebutScreen extends Screen 
	{
		public static const NEXT_CLICKED:String = "Next Clicked";
		public static const BACK_CLICKED:String = "Back Clicked";
		
		private var the_fraction:ShapeFraction;
		
		public function PenyebutScreen(the_fraction:ShapeFraction = null) 
		{
			super();
			
			// initialize fraction
			if(the_fraction){
				this.the_fraction = the_fraction;
			} else {
				//this.the_fraction = new CircleFraction(120, 0, 1);
				this.the_fraction = new RectFraction(2.25 * 120, 1.75 * 120, 0, 1);
				trace("width x height: " + this.the_fraction.view_width + "x" + this.the_fraction.view_height);
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
			
			// fraction placement
			the_fraction.x = stage.stageWidth / 2 - (the_fraction.view_width/2) - 3;
			the_fraction.y = stage.stageHeight / 3 - (the_fraction.view_height / 2) - 3; // hard coded position
			the_fraction.buttonMode = true;
			the_fraction.addEventListener(MouseEvent.CLICK, onShapeClicked);
			addChild(the_fraction);
				
			// navigation buttons
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
			//display_penyebut.border = true;
			display_penyebut.autoSize = TextFieldAutoSize.CENTER;
			display_penyebut.x = stage.stageWidth / 2;
			display_penyebut.y = 2 * oneThirdStageHeight - oneThirdStageHeight/3;
			display_penyebut.defaultTextFormat = new TextFormat("Verdana", 72, 0x000000, true);
			display_penyebut.selectable = false;
			addChild(display_penyebut);
			
			// bindings
			BindingUtils.bindSetter(
				function(valueReceived:int):void {
					display_penyebut.text = valueReceived + " bagian";
				},
				the_fraction,
				"penyebut");
				
			// buttons behaviour
			next_button.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void {
				dispatchEvent(new Event(NEXT_CLICKED));
			});
			
			back_button.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void {
				TweenLite.to(display_penyebut, 0.5, { alpha: 0 } );
				TweenLite.to(back_button, 0.5, { alpha: 0 } );
				TweenLite.to(next_button, 0.5, { alpha: 0 } );
				if(the_fraction is CircleFraction){
					TweenLite.to(the_fraction, 0.5, 
						{ 
							x: stage.stageWidth / 3 - (the_fraction.width / 2),
							onComplete: function():void {
								dispatchEvent(new Event(BACK_CLICKED));
							}
						});
				} else if(the_fraction is RectFraction){
					TweenLite.to(the_fraction, 0.5, 
						{ 
							x: stage.stageWidth*2 / 3 - (the_fraction.width / 2),
							onComplete: function():void {
								dispatchEvent(new Event(BACK_CLICKED));
							}
						});
				}
			});
			
			// screen behaviour
			addEventListener(Event.REMOVED_FROM_STAGE, function (e:Event):void {
				the_fraction.removeEventListener(MouseEvent.CLICK, onShapeClicked);
			});
			
			addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void {
				if ( !contains(the_fraction) ) {
					addChild(the_fraction);
				}
				the_fraction.x = stage.stageWidth / 2 - (the_fraction.view_width/2);
				the_fraction.y = stage.stageHeight / 3 - (the_fraction.view_height/2) - 2;
				the_fraction.addEventListener(MouseEvent.CLICK, onShapeClicked);
				display_penyebut.alpha = 1;
				back_button.alpha = 1;
				next_button.alpha = 1;
			});
		}
		
		private function onShapeClicked(e:MouseEvent):void {
			trace("ouch");
			the_fraction.penyebut += 1;
		}
		
		public static function test(the_stage:Stage, the_fraction:ShapeFraction = null):void {
			var screen:PenyebutScreen;
			
			var radius:Number = 120;
			
			if (the_fraction) {
				screen = new PenyebutScreen(the_fraction);
			} else {
				if ( Math.floor(Math.random() * 2) == 1) {
					screen = new PenyebutScreen(new RectFraction(2.25 * radius, 1.75 * radius, 0, 1));
				} else {
					screen = new PenyebutScreen(new CircleFraction(radius, 0, 1));
				}
			}
			
			the_stage.addChild(screen);
		}
	}

}