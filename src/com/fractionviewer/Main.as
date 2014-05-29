package com.fractionviewer
{
	import adobe.utils.CustomActions;
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
		private const CIRCLE_TEST:int = 3;
		private const RECT_PENYEBUT_SCREEN:int = 4;
		private const RECT_PEMBILANG_SCREEN:int = 5;
		
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
			var rect_fraction:RectFraction = new RectFraction(2.25 * circle_radius, 1.75 * circle_radius, 0, 1);
			screen_list = new Array();
			//var screen1:ShapeChooserScreen = createAndSetupShapeChooserScreen();
			//var screen2:CirclePenyebutScreen = createAndSetupCirclePenyebutScreen(circle_fraction);
			//var screen3:CirclePembilangScreen = createAndSetupCirclePembilangScreen(circle_fraction);
			//var screen4:PenyebutScreen = createAndSetupPenyebutScreen(rect_fraction);
			
			screen_list[SHAPE_SELECT_SCREEN] = createAndSetupShapeChooserScreen(); 
			screen_list[CIRCLE_PENYEBUT_SCREEN] = createAndSetupPenyebutScreen(circle_fraction); 
			screen_list[CIRCLE_PEMBILANG_SCREEN] = createAndSetupPembilangScreen(circle_fraction);
			screen_list[CIRCLE_TEST] = createAndSetupTestScreen(TestScreen.CIRCLE_TEST);
			screen_list[RECT_PENYEBUT_SCREEN] = createAndSetupPenyebutScreen(rect_fraction);
			screen_list[RECT_PEMBILANG_SCREEN] = createAndSetupPembilangScreen(rect_fraction);
			
			// activate first screen
			//active_screen = screen_list[SHAPE_SELECT_SCREEN];
			//active_screen = screen_list[CIRCLE_PENYEBUT_SCREEN];
			//active_screen = screen_list[CIRCLE_PEMBILANG_SCREEN];
			//active_screen = screen_list[RECT_PENYEBUT_SCREEN];
			//active_screen = screen_list[RECT_PEMBILANG_SCREEN];
			active_screen = screen_list[CIRCLE_TEST];
			
			//RectFraction.test(stage);
			//PenyebutScreen.test(stage);
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
					active_screen = screen_list[RECT_PENYEBUT_SCREEN];
				});
				
			return screen;
		}
		
		private function createAndSetupPenyebutScreen(the_fraction:ShapeFraction):PenyebutScreen {
			var screen:PenyebutScreen = new PenyebutScreen(the_fraction);
			
			screen.addEventListener(PenyebutScreen.NEXT_CLICKED, function (e:Event):void {
				trace("next...");
				if(the_fraction is CircleFraction){
					active_screen = screen_list[CIRCLE_PEMBILANG_SCREEN];
				} else if (the_fraction is RectFraction) {
					active_screen = screen_list[RECT_PEMBILANG_SCREEN];
				}
			});
			
			screen.addEventListener(PenyebutScreen.BACK_CLICKED, function (e:Event):void {
				trace("back..");
				active_screen = screen_list[SHAPE_SELECT_SCREEN];
				//active_screen = null;
			});
			
			return screen;
		}
		
		private function createAndSetupPembilangScreen(the_fraction:ShapeFraction):PembilangScreen {
			var screen:PembilangScreen = new PembilangScreen(the_fraction);
			
			//screen.addEventListener(CirclePenyebutScreen.NEXT_CLICKED, function (e:Event):void {
				//trace("next...");
				//active_screen = screen_list[CIRCLE_PEMBILANG_SCREEN];
			//});
			
			screen.addEventListener(PembilangScreen.BACK_CLICKED, function (e:Event):void {
				trace("back to..");
				if( the_fraction is RectFraction){
					active_screen = screen_list[RECT_PENYEBUT_SCREEN];
				} else if (the_fraction is CircleFraction) {
					active_screen = screen_list[CIRCLE_PENYEBUT_SCREEN];
				}
			});
			
			return screen;
		}
		
		private function createAndSetupTestScreen(test_type:int):Screen {
			var screen:Screen = new TestScreen(TestScreen.CIRCLE_TEST);
			
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