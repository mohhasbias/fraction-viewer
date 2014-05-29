package com.fractionviewer 
{
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	public class Screen extends Sprite 
	{
		
		public function Screen() 
		{
			super();
			
		}
		
		protected function createButton(text:String, width:int = 150, height:int = 50):Sprite 
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