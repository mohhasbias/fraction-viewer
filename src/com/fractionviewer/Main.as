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
			screen_list = new Array();
			var screen1:ShapeChooserScreen = createAndSetupShapeChooserScreen();
			var screen2:CirclePenyebutScreen = createAndSetupCirclePenyebutScreen();
			
			screen_list[SHAPE_SELECT_SCREEN] = screen1; 
			screen_list[CIRCLE_PENYEBUT_SCREEN] = screen2; 
			
			// activate first screen
			active_screen = screen1;
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
		
		private function createAndSetupCirclePenyebutScreen():CirclePenyebutScreen {
			var screen:CirclePenyebutScreen = new CirclePenyebutScreen();
			
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