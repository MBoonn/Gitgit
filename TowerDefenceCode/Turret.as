package src 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.ui.Mouse;
	import src.Game;
	/**
	 * ...
	 * @author Mike
	 */
	public class Turret extends MovieClip
	{
		private var vStation:MovieClip = new turretmodel();
		public var vStationInfo:TextField = new TextField;
		public var vStationPlaced:Boolean;
		
		public var vShootDelay:Timer = new Timer(1000, 0);
		public var vStationRange:MovieClip = new MovieClip;
		public var vMaxHP:Number = 100;
		public var vCurrentHP:Number = vMaxHP;
		
		public var following:Boolean = false;
		
		public var testobject:Object = new Object;
		
		public function Turret()
		{
			vStation.scaleX = 0.25;
			vStation.scaleY = 0.25;
			
			//Start following the mouse 
			vStation.x = mouseX;
			vStation.y = mouseY;
			vStation.alpha = 0.5;
			vStation.startDrag(true);
			vStationPlaced = false;
			
			vStationRange.graphics.beginFill(0x0099BB, 0.25);
			vStationRange.graphics.drawCircle(0, 0, 500);
			vStationRange.graphics.endFill();


			//Setup the info box with information about the turret
			//it's health, shield, and firepower.
			vStationInfo.scaleX = 5;
			vStationInfo.scaleY = 5;
			vStationInfo.width = 50;
			vStationInfo.height = 15;
			vStationInfo.x = this.x - 100;
			vStationInfo.y = this.y - 150;
			vStationInfo.selectable = false;
			vStationInfo.text = "HP: " + vCurrentHP;
			vStationInfo.alpha = 0;
			
			vStation.addChild(vStationInfo);
			vStation.addChild(vStationRange);
			
			vStation.addEventListener(MouseEvent.CLICK, FollowMouse);
			addChild(vStation);
			
			following = true;
		}
		
		public function FollowMouse(e:MouseEvent):void
		{
			//First check whether the user is able to drag a turret.
			if(!vStationPlaced)
			{
				vStation.stopDrag();
				vStation.alpha = 1.0;
				vStationPlaced = true;
				vStation.addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
				vStation.addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
				vStation.addEventListener(Event.ENTER_FRAME, FollowTarget);
				vShootDelay.addEventListener(TimerEvent.TIMER, Fire);
				vShootDelay.start();
			}
		}
		
		public function MouseOver(e:MouseEvent):void
		{
			if(vStationPlaced)
			{
				vStationInfo.alpha = 1;
				vStationRange.alpha = 1;
			}
		}
		
		public function MouseOut(e:MouseEvent):void
		{
			vStationInfo.alpha = 0;
			vStationRange.alpha = 0;
		}
		
		public function FollowTarget(xPos:Number, yPos:Number):void
		{
			trace("DEBUG: " + xPos + " + " + yPos);
			
			var mdx:Number = xPos - vStation.x;
			var mdy:Number = yPos - vStation.y;
			var rad:Number = Math.atan2 (mdx, mdy);
			var deg:Number = rad * -180 / Math.PI;
			vStation.rotation = deg;
		}
		
		
		public function Fire(e:Event):void
		{
			//Call the "StationLaser" class, put it on the stage
			//then get the position of the station and the rotation
			//and apply it to the laser.
			var vLaser:MovieClip = new StationLaser();
			vLaser.rotation = vStation.rotation;
			vLaser.x = vStation.x;
			vLaser.y = vStation.y;
			addChild(vLaser);
		}
	}
}