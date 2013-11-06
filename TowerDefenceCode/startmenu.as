package src 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.fscommand;
	/**
	 * ...
	 * @author Yron Breeveld
	 */
	public class startmenu extends MovieClip
	{
		public var vStartScreen:Startscherm = new Startscherm;
		public var gameState:int;
		
		public function startmenu() 
		{
			vStartScreen.x = 512;
			vStartScreen.y = 375;
			vStartScreen.start.addEventListener(MouseEvent.CLICK, StartButton);
			vStartScreen.how.addEventListener(MouseEvent.CLICK, HowButton);
			vStartScreen.quit.addEventListener(MouseEvent.CLICK, QuitButton);
			vStartScreen.addEventListener(Event.ENTER_FRAME, loop);

			
			
			vStartScreen.gotoAndStop(1);
			addChild(vStartScreen);
		}
		
		private function StartButton(e:Event):void
		{
			vStartScreen.removeEventListener(Event.ENTER_FRAME, loop);
			gameState = 1;
		}
		
		private function HowButton(e:Event):void
		{
			vStartScreen.gotoAndStop(2);
			vStartScreen.back.addEventListener(MouseEvent.CLICK, BackButton);
		}
		
		private function BackButton(e:Event):void
		{
			vStartScreen.back.removeEventListener(MouseEvent.CLICK, BackButton);
			vStartScreen.gotoAndStop(1);
			vStartScreen.start.addEventListener(MouseEvent.CLICK, StartButton);
			vStartScreen.how.addEventListener(MouseEvent.CLICK, HowButton);
			vStartScreen.quit.addEventListener(MouseEvent.CLICK, QuitButton);
		}
		
		private function QuitButton(e:Event):void
		{
			fscommand("quit");
		}
		
		public function loop(e:Event):void
		{
			vStartScreen.rotationX = (mouseY - stage.stageHeight/2)/5;
			vStartScreen.rotationY = (mouseX - stage.stageWidth/2)/5;
			if (vStartScreen.rotationY < -15) {vStartScreen.rotationY = -15;}
			if (vStartScreen.rotationY > 15) {vStartScreen.rotationY = 15;}
			if (vStartScreen.rotationX < -15) {vStartScreen.rotationX = -15;}
			if (vStartScreen.rotationX > 15) {vStartScreen.rotationX = 15;}
		}
	}
}