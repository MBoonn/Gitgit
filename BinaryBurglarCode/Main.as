package burglar 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import burglar.menu;
	import burglar.deur;
	import burglar.woonkamer;
	import burglar.kluis;
	import flash.events.Event;
	import flash.ui.Mouse;
	/**
	 * ...
	 * @author Rachel, Kjeld, Mike
	 */
	public class Main extends MovieClip
	{
		public var StartMenuCLASS:menu = new menu();
		public var DoorCLASS:deur = new deur();
		public var LivingRoomCLASS:woonkamer = new woonkamer();
		public static var Loot:int = 30;
		//public var VaultCLASS:kluis = new kluis();
		
		
		public function Main() 
		{
			//hier word de startMenuClass op de stage gezet en easyLevelStart op false gezet
			
			addChild(StartMenuCLASS);
			menu.easyLevelStart = false;
			
			//Eventlistener
			addEventListener(Event.ENTER_FRAME, loop);
			
		}
		
		private function loop(e:Event):void 
		{
			//als easyLevelStart true is dan word de muis hide, de DoorCLASS op de stage gezet en de StartMenuCLASS van de stage gehaald
			
			if (menu.easyLevelStart == true)
			{
				DoorCLASS = new deur();
				addChild(DoorCLASS); 
				menu.easyLevelStart = false;
				if (contains(StartMenuCLASS))
				{
					removeChild(StartMenuCLASS);
				}
				
			}
			if (deur.arrowActive == true)
			{
				deur.arrowActive = false;
				LivingRoomCLASS = new woonkamer();
				addChild(LivingRoomCLASS);
				if (contains(DoorCLASS))
				{
					removeChild(DoorCLASS);
				}	
					
			}
			
			if (woonkamer.levelEnd == true)
			{
				
				woonkamer.levelEnd = false;
				if (contains(LivingRoomCLASS))
				{
					StartMenuCLASS = new menu;
					addChild(StartMenuCLASS);
					removeChild(LivingRoomCLASS);
				}
			}
			
		}
		
	}

}