package com.fractionviewer
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Moh Hasbi Assidiqi
	 */
	public class CircleFraction extends ShapeFraction
	{
		private var _radius:int;
		private var _pembilang:int;
		private var _penyebut:int;
		
		private var x_origin:int, y_origin:int;
		
		private const STROKE_COLOR_OUTER:int = 0x666666;
		private const FILL_COLOR_EMPTY:int = 0xF7F7F7;
		private const FILL_COLOR_SELECTED:int = 0x23ED36;
		private const LINE_THICKNESS_OUTER:int = 5;
		
		public static const VALUE_CHANGED:String = "Value Changed";
		
		public function CircleFraction(radius:int = 90, pembilang:int = 3, penyebut:int = 4)
		{
			super();
			
			this.radius = radius;
			this.penyebut = penyebut;
			this.pembilang = pembilang;
			
			this.x_origin = radius;
			this.y_origin = radius;
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			// remove all child
			while (numChildren > 0)
			{
				removeChildAt(0);
			}
			
			// draw placeholders
			var placeholder:Shape = createPlaceholder();
			addChild(placeholder);
			
			// theta setup
			var theta_offset:Number = -Math.PI / 2;
			var theta_diff:Number = 2 * Math.PI / this.penyebut;
			
			
			// draw pembilang
			var i:int;
			for (i = 0; this.penyebut > 0 && i < this.pembilang; i++)
			{
				var theta_start:Number = theta_offset + i * theta_diff;
				var theta_end:Number = theta_offset + (i + 1) * theta_diff;
			
				drawSector(theta_start, theta_end);
			}
			
			// draw penyebut
			for (i = 0; this.penyebut > 1 && i < this.penyebut; i++)
			{
				var theta:Number = theta_offset + i * theta_diff;
				
				var p:Point = Point.polar(this.radius, theta);
				
				var line:Shape = new Shape();
				line.graphics.lineStyle(0.75 * LINE_THICKNESS_OUTER, STROKE_COLOR_OUTER);
				line.graphics.moveTo(this.x_origin, this.y_origin);
				line.graphics.lineTo(this.x_origin + p.x, this.y_origin + p.y);
				
				addChild(line);
			}
			
		}
		
		private function drawSector(theta_start:Number, theta_end:Number):void 
		{	
			var the_radius:Number = this.radius - LINE_THICKNESS_OUTER/2;
			
			var start_point:Point = Point.polar(the_radius, theta_start);
			start_point.x += this.x_origin;
			start_point.y += this.y_origin;
			
			var anchor_points:Array = new Array();
			var control_points:Array = new Array();
			
			var theta_diff:Number = Math.abs(theta_end - theta_start);
			var theta_diff_minimum:Number = 2 * Math.PI / 6;
			var control_point_length:Number;
			var control_point_angle:Number;
			var control_point:Point;
			var anchor_point:Point;
			if ( theta_diff >  theta_diff_minimum) {
				var sub_theta_start:Number = theta_start;
				var sub_theta_end:Number = sub_theta_start + theta_diff_minimum;
				if ( sub_theta_end > theta_end ) {
					sub_theta_end = theta_end;
				}					
				
				while (sub_theta_start < theta_end) {
					var sub_theta_diff:Number = sub_theta_end - sub_theta_start;
					
					control_point_length = the_radius / Math.cos((sub_theta_diff)/2);
					control_point_angle = sub_theta_start + ((sub_theta_diff) / 2.0);
					control_point = Point.polar(control_point_length, control_point_angle);
					control_point.x += this.x_origin;
					control_point.y += this.y_origin;
					
					anchor_point = Point.polar(the_radius, sub_theta_end);
					anchor_point.x += this.x_origin;
					anchor_point.y += this.y_origin;
				
					anchor_points.push(anchor_point);
					control_points.push(control_point);
					
					sub_theta_start = sub_theta_end;
					sub_theta_end = sub_theta_start + theta_diff_minimum;
					if ( sub_theta_end > theta_end ) {
						sub_theta_end = theta_end;
					}
				}
			} else {
				control_point_length = the_radius / Math.cos((theta_diff)/2);
				control_point_angle = theta_start + ((theta_diff) / 2.0);
				control_point = Point.polar(control_point_length, control_point_angle);
				control_point.x += this.x_origin;
				control_point.y += this.y_origin;
				
				anchor_point = Point.polar(the_radius, theta_end);
				anchor_point.x += this.x_origin;
				anchor_point.y += this.y_origin;
			
				anchor_points.push(anchor_point);
				control_points.push(control_point);
			}
			
			var sector:Shape = new Shape();
			//sector.graphics.lineStyle(5, 0xFF0000);
			sector.graphics.beginFill(FILL_COLOR_SELECTED);
			sector.graphics.moveTo(this.x_origin, this.y_origin);
			sector.graphics.lineTo(start_point.x, start_point.y);
			for (var i:int = 0 ; i < anchor_points.length; i++){
				sector.graphics.curveTo(control_points[i].x, control_points[i].y, anchor_points[i].x, anchor_points[i].y);
			}
			sector.graphics.lineTo(this.x_origin, this.y_origin);
			sector.graphics.endFill();
			
			addChild(sector);
			
			//var control_circle:Shape = new Shape();
			//control_circle.graphics.lineStyle(5, 0x000000);
			//for (var i:int = 0; i < control_points.length; i++){
				//control_circle.graphics.drawCircle(control_points[i].x, control_points[i].y, 1);
			//}
			//addChild(control_circle);
		}
		
		private function createPlaceholder():Shape 
		{
			var placeholder:Shape = new Shape();
			placeholder.graphics.lineStyle(LINE_THICKNESS_OUTER, STROKE_COLOR_OUTER);
			placeholder.graphics.beginFill(FILL_COLOR_EMPTY);
			placeholder.graphics.drawCircle(x_origin, y_origin, radius);
			placeholder.graphics.endFill();
			
			return placeholder;
		}
		
		[Bindable]
		override public function get pembilang():int 
		{
			return _pembilang;
		}
		
		override public function set pembilang(value:int):void 
		{
			if( value >= 0 && value <= penyebut){
				_pembilang = value;
			}
			dispatchEvent(new Event(VALUE_CHANGED));
		}
		
		[Bindable]
		override public function get penyebut():int 
		{
			return _penyebut;
		}
		
		override public function set penyebut(value:int):void 
		{
			_penyebut = value;
			dispatchEvent(new Event(VALUE_CHANGED));
		}
		
		public function get radius():int 
		{
			return _radius;
		}
		
		public function set radius(value:int):void 
		{
			trace("set radius");
			_radius = value;
		}
		
		override public function get view_width():int 
		{
			return radius*2;
		}
		
		override public function get view_height():int 
		{
			return radius*2;
		}
	}

}