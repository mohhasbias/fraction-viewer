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
		private var circle_fraction:CircleFraction;
		
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
			var screen1:ShapeChooserScreen = new ShapeChooserScreen();
			
			// activate first screen
			addChild(screen1);
			screen1.addEventListener(ShapeChooserScreen.CIRCLE_CLICKED,
				function(e:Event):void {
					trace("circle selected");
					screen1.swapChildren(screen1.circle_button, screen1.rect_button);
					screen1.circle_button.enabled = false;
					TweenLite.to(screen1.rect_button, 0.5, { alpha: 0 } );
					TweenLite.to(
						screen1.circle_button, 0.5, 
						{
							x: stage.stageWidth / 2 - screen1.circle_button.width / 2, 
							y: screen1.circle_button.y,
							onComplete: function() {
								trace("compeleted")}} );
				});
				
			screen1.addEventListener(ShapeChooserScreen.RECT_CLICKED,
				function(e:Event):void {
					trace("rect selected");
				});
		}
		
		private function onCircleClicked(e:MouseEvent):void
		{
			circle_fraction.penyebut += 1;
		}
	}

}