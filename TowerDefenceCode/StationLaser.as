package src 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Yron Breeveld
	 */
	public class StationLaser extends MovieClip
	{

		public var vLaser:MovieClip = new MovieClip;
		
		public function StationLaser() 
		{
			vLaser.graphics.beginFill(0x990000, 1);
			vLaser.graphics.drawRect(0, 0, 2, 15);
			vLaser.graphics.endFill();
			addChild(vLaser);
			vLaser.addEventListener(Event.ENTER_FRAME, Loop);
		}
		
		public function Loop(e:Event):void
		{
			vLaser.y += 10;
		}
	}
}