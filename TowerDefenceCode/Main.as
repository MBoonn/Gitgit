package src 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import src.Game;
	import src.startmenu;
	/**
	 * ...
	 * @author Mike
	 */

	public class Main extends MovieClip
	{
		public static var gameScreen:Game = new Game();
		public var StartMenu:startmenu = new startmenu();
		public var vBackground:MovieClip = new background;
		
		public var introMusic:Intro_Music = new Intro_Music;
		public var inGameMusic:Ingame_Music = new Ingame_Music;
		public var soundChannel:SoundChannel = new SoundChannel;
		
		public function Main() 
		{
			soundChannel = introMusic.play();
			vBackground.alpha = 0.5;
			addChild(vBackground);
			
			addChild(StartMenu);
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void 
		{
			if(StartMenu.gameState)
			{
				soundChannel.stop();
				soundChannel = inGameMusic.play(0, 9999);
				gameScreen.gameState = 1;
				addChild(gameScreen);
				removeChild(StartMenu);
				StartMenu.gameState = 0;
			}
		}
	}
}