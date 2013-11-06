package src 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	import src.Game;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Mike
	 */
	public class Turret1 extends MovieClip
	{
		public var turret1:MovieClip = new Turret_Blue;
		public var bull:MovieClip = new Bullet(1);
		public var turretPlaced:Boolean = false;
		public var turretRange:MovieClip = new TurretRange;
		public var shootTimer:Timer = new Timer(1000, 10);
		public var tHP:Number = new Number;
		public var shootSound:Sound = new Place_Turret;
		public var pew:Boolean = false;
		public var bulletclass:Bullet = new Bullet(.5);
		
		public function Turret1(scale:Number, tHP:Number) 
		{
			turret1.width *= scale;
			turret1.height *= scale;
			turret1.alpha = 0.5;
			
			turretRange.x = turret1.x
			turretRange.y = turret1.y
			turretRange.scaleX = 4;
			turretRange.scaleY = 4;
			turretRange.alpha = 0.2;
			
			this.tHP = tHP;
			bulletclass.bull.x = turret1.x;
			bulletclass.bull.y = turret1.y;
			
			turret1.addChild(turretRange);
			
			turret1.startDrag(true);
			turret1.addEventListener(MouseEvent.CLICK, placeTurret);
		}
		
		public function placeTurret(e:MouseEvent):void
		{
			//Check wheter the turred is already placed or not
			if(!turretPlaced)
			{
				turretPlaced = true;
				turret1.stopDrag();
				turret1.alpha = 1.0;
				turret1.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
				turret1.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
				shootTimer.addEventListener(TimerEvent.TIMER, shootListener);
			}
		}
		
		public function mouseOver(e:MouseEvent):void
		{
			if(turretPlaced)
			{
				turretRange.alpha = 0.2;
			}
		}
		
		public function mouseOut(e:MouseEvent):void
		{
			turretRange.alpha = 0;
		}
		
		public function shootListener(e:TimerEvent):void 
		{
			for each (var meteor:Meteor in Game.meteor )
			{
				pew = false;
				if (turretRange.hitTestObject(meteor))
				{
					meteor.HP -= 1;
					pew = true;
				}
				 
					//addChild(new Bullet(.5));
						//
					//bulletclass.bull.x += Math.cos(bulletclass.bull.rotation * Math.PI / 180);
					//bulletclass.bull.y += Math.sin(bulletclass.bull.rotation * Math.PI / 180);
					//bulletclass.bull.rotation = turret1.rotation + -270;
				
				if (pew)
				{
					shootSound.play();
				}
				
			}
		}
		
		public function update():void
		{
			for each (var meteor:Meteor in Game.meteor) 
			{
				if (turretPlaced)
				{
					if (turretRange.hitTestObject(meteor))
					{
						shootTimer.start();
						var mdx:Number = meteor.x - turret1.x;
						var mdy:Number = meteor.y - turret1.y;
						var rad:Number = Math.atan2 (mdx, mdy);
						var deg:Number = rad * -180 / Math.PI;
						turret1.rotation = deg;
						
						
					}
				}
			}
		}
	}
}