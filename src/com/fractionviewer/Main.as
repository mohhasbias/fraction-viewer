package com.fractionviewer
{
	import com.greensock.TimelineLite;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.greensock.TweenLite;
	
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	[SWF(width="960",height="540",frameRate="24",backgroundColor="#CCCCCC")]
	public class Main extends Sprite
	{
		//private var circle_fraction:CircleFraction;
		private var _active_screen:Sprite;
		
		private var screen_list:Array;
		
		private const SHAPE_SELECT_SCREEN:int = 0;
		private const CIRCLE_PENYEBUT_SCREEN:int = 1;
		private const CIRCLE_PEMBILANG_SCREEN:int = 2;
		
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
			
			// initialize screens
			var circle_radius:Number = 120;
			var circle_fraction:CircleFraction = new CircleFraction(circle_radius, 0, 1);
			screen_list = new Array();
			var screen1:ShapeChooserScreen = createAndSetupShapeChooserScreen();
			var screen2:CirclePenyebutScreen = createAndSetupCirclePenyebutScreen(circle_fraction);
			var screen3:CirclePembilangScreen = createAndSetupCirclePembilangScreen(circle_fraction);
			
			screen_list[SHAPE_SELECT_SCREEN] = screen1; 
			screen_list[CIRCLE_PENYEBUT_SCREEN] = screen2; 
			screen_list[CIRCLE_PEMBILANG_SCREEN] = screen3;
			
			// activate first screen
			//active_screen = screen_list[SHAPE_SELECT_SCREEN];
			//active_screen = screen_list[CIRCLE_PENYEBUT_SCREEN];
			//active_screen = screen_list[CIRCLE_PEMBILANG_SCREEN];
			
			//var rect_fraction:RectFraction = new RectFraction(2.25 * circle_radius, 1.75 * circle_radius);
			//rect_fraction.x = stage.stageWidth / 2 - rect_fraction.rect_width / 2;
			//rect_fraction.y = stage.stageHeight / 2 - rect_fraction.rect_height / 2;
			//addChild(rect_fraction);
			
			var rects:Array = new Array();
			rects.push(new RectFraction(2.25 * circle_radius, 1.75 * circle_radius, 1, 2));
			rects.push(new RectFraction(2.25 * circle_radius, 1.75 * circle_radius, 2, 3));
			rects.push(new RectFraction(2.25 * circle_radius, 1.75 * circle_radius, 3, 4));
			rects.push(new RectFraction(2.25 * circle_radius, 1.75 * circle_radius, 5, 6));
			
			for (var i:int = 0; i < rects.length; i++) {
				rects[i].x = (i % 3) * (rects[i].rect_width + 15);
				rects[i].y = Math.floor(i / 3) * (rects[i].rect_height + 15);
				addChild(rects[i]);
			}
		}
		
		private function createAndSetupShapeChooserScreen():ShapeChooserScreen {
			var screen:ShapeChooserScreen = new ShapeChooserScreen();
			screen.addEventListener(ShapeChooserScreen.CIRCLE_CLICKED,
				function(e:Event):void {
					trace("circle selected");
					active_screen = screen_list[CIRCLE_PENYEBUT_SCREEN];
				});
				
			screen.addEventListener(ShapeChooserScreen.RECT_CLICKED,
				function(e:Event):void {
					trace("rect selected");
					active_screen = null;
				});
				
			return screen;
		}
		
		private function createAndSetupCirclePenyebutScreen(circle_fraction:CircleFraction):CirclePenyebutScreen {
			var screen:CirclePenyebutScreen = new CirclePenyebutScreen(circle_fraction);
			
			screen.addEventListener(CirclePenyebutScreen.NEXT_CLICKED, function (e:Event):void {
				trace("next...");
				active_screen = screen_list[CIRCLE_PEMBILANG_SCREEN];
			});
			
			screen.addEventListener(CirclePenyebutScreen.BACK_CLICKED, function (e:Event):void {
				trace("back..");
				active_screen = screen_list[SHAPE_SELECT_SCREEN];
			});
			
			return screen;
		}
		
		private function createAndSetupCirclePembilangScreen(circle_fraction:CircleFraction):CirclePembilangScreen {
			var screen:CirclePembilangScreen = new CirclePembilangScreen(circle_fraction);
			
			//screen.addEventListener(CirclePenyebutScreen.NEXT_CLICKED, function (e:Event):void {
				//trace("next...");
				//active_screen = screen_list[CIRCLE_PEMBILANG_SCREEN];
			//});
			
			screen.addEventListener(CirclePembilangScreen.BACK_CLICKED, function (e:Event):void {
				trace("back..");
				active_screen = screen_list[CIRCLE_PENYEBUT_SCREEN];
			});
			
			return screen;
		}
		
		private function set active_screen(screen:Sprite):void {
			if ( _active_screen) {
				removeChild(_active_screen);
				_active_screen = screen;
			}
				
			_active_screen = screen;
			if(_active_screen){
				addChild(_active_screen);
			}
		}
	}

}