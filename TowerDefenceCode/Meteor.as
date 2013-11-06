package src 
{
	import flash.display.MovieClip;
	import src.Game;
	/**
	 * ...
	 * @author Mike
	 */
	public class Meteor extends MovieClip
	{
		private var meteor:MovieClip = new Meteoriet();
		public var speed:int;
		public var HP:int;
		public var gameclass:Game;
		
		public function Meteor(speed:int, scale:Number, HP:int) 
		{
			this.speed = speed;
			this.HP = HP;
			meteor.width *= scale;
			meteor.height *= scale;
			gameclass = Main.gameScreen;
			addChild(meteor);
		}
		
		public function update():void
		{
			if (HP >= 0)
			{
				this.x += speed;
			}
			if (HP <= 0)
			{
				if (contains(meteor))
				{
					removeChild(meteor);
					gameclass.money += 3;
					gameclass.KillCount += 1;
				}
			}
			
			if (meteor.hitTestObject(gameclass.earth))
			{
				if (contains(meteor))
				{
					removeChild(meteor);
					gameclass.KillCount += 1;
					gameclass.earthHP -= 1;
				}
			}
		}
	}
}