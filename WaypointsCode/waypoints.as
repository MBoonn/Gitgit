package Opdrachten.waypointsmap 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import Wiskunde.Punt
	import Wiskunde.WVector
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Mike
	 */
	public class wayPoints extends Sprite
	{
		public var bal:target = new target;
		public var level1:level = new level();
		public var vector:WVector = new WVector;
		public var balletjes:Array = new Array(10);
		public var turret:MovieClip = new top;
		
		public function wayPoints() 
		{
			balletjes.push(bal);
			
			addChild(level1);
			level1.addChild(bal);
			
			bal.x = level1.w1.x;
			bal.y = level1.w1.y;
			
			turret.x = stage.stageWidth / 2;
			turret.y = stage.stageHeight / 2 - 100;
			addChild(turret);
			
			this.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void 
		{
			vector.dx = level1.w2.x - bal.x;
			vector.dy = level1.w2.y - bal.y;
			if (vector.r < 5)
			{
				removeEventListener(Event.ENTER_FRAME, loop);
				this.addEventListener(Event.ENTER_FRAME, loop2);
			}
			
			vector.r = 10;
			bal.x += vector.dx;
			bal.y += vector.dy;
			
			
			var mdx:Number = bal.x - turret.x;
			var mdy:Number = bal.y - turret.y;
			var rad:Number = Math.atan2 (mdx, mdy);
			var deg:Number = rad * -180 / Math.PI;
			turret.rotation = deg;
			
			
		}
		
		private function loop2(e:Event):void 
		{
			vector.dx = level1.w3.x - bal.x;
			vector.dy = level1.w3.y - bal.y;
			if (vector.r < 5)
			{
				removeEventListener(Event.ENTER_FRAME, loop2);
				this.addEventListener(Event.ENTER_FRAME, loop3);
			}
			vector.r = 10;
			bal.x += vector.dx;
			bal.y += vector.dy;
			
			var mdx:Number = bal.x - turret.x;
			var mdy:Number = bal.y - turret.y;
			var rad:Number = Math.atan2 (mdx, mdy);
			var deg:Number = rad * -180 / Math.PI;
			turret.rotation = deg;
			
		}
		
		private function loop3(e:Event):void 
		{
			vector.dx = level1.w4.x - bal.x;
			vector.dy = level1.w4.y - bal.y;
			if (vector.r < 5)
			{
				removeEventListener(Event.ENTER_FRAME, loop3);
				this.addEventListener(Event.ENTER_FRAME, loop4);
			}
			vector.r = 10;
			bal.x += vector.dx;
			bal.y += vector.dy;
			
			var mdx:Number = bal.x - turret.x;
			var mdy:Number = bal.y - turret.y;
			var rad:Number = Math.atan2 (mdx, mdy);
			var deg:Number = rad * -180 / Math.PI;
			turret.rotation = deg;
		}
		
		private function loop4(e:Event):void 
		{
			vector.dx = level1.w1.x - bal.x;
			vector.dy = level1.w1.y - bal.y;
			if (vector.r < 5)
			{
				removeEventListener(Event.ENTER_FRAME, loop4);
				this.addEventListener(Event.ENTER_FRAME, loop);
			}
			vector.r = 10;
			bal.x += vector.dx;
			bal.y += vector.dy;
			
			var mdx:Number = bal.x - turret.x;
			var mdy:Number = bal.y - turret.y;
			var rad:Number = Math.atan2 (mdx, mdy);
			var deg:Number = rad * -180 / Math.PI;
			turret.rotation = deg;
		}
	}
}