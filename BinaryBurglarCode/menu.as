package burglar 
{
	import flash.display.MorphShape;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Rachel, Kjeld, Mike
	 */
	public class menu extends MovieClip
	{
		public var backGround:achtergrond = new achtergrond;
		public var endGame:MovieClip = new endgame;
		public var button:MovieClip = new playButton;
		private var ButtonPress:Boolean = false;
		private var ButtonRemove:Boolean = false;
		private var easyButton:MovieClip = new EasyButton;
		private var easyButtonPress:Boolean = false;
		private var easyButtonRemove:Boolean = false;
		private var slumMap:MovieClip = new SlumDistrict;
		private var house:MovieClip = new HuisBlok;
		private var instructionB:MovieClip = new instructionsbutton;
		public static var LootText:TextField = new TextField;
		private var Format:TextFormat = new TextFormat();
		private var moneyCounter:MovieClip = new blankbutton;
		public static var easyLevelStart:Boolean = false;
		public var instructionsGO:Boolean = false;
		public var instructionSCR:MovieClip = new instructionscreen;
		public var BackBTN:MovieClip = new backbutton;
		public var BacktoMenu:Boolean = false;
		
		
		
		public function menu() 
		{
			//Background
			addChild(backGround);
			backGround.x = 400;
			backGround.y = 300;
			
			//Buttons
			addChild(button);
			button.x = 250;
			button.y = 500;
			button.gotoAndStop(1);
			
			instructionB.x = 500;
			instructionB.y = 500;
			addChild(instructionB);
			
			instructionSCR.x = 50;
			instructionSCR.y = 10;
			
			BackBTN.x = 200;
			BackBTN.y = 520;
			
			slumMap.x = 370;
			slumMap.y = 250;
			
			house.x = slumMap.x + 50;
			house.y = slumMap.y + 50;
			
			easyButton.x = 250;
			easyButton.y = 300;
			
			addChild(moneyCounter);
			moneyCounter.x = 600;
			moneyCounter.y = 100;
			
			Format.size = 40;
			Format.align = "center";
			
			addChild(LootText);
			LootText.x = 615;
			LootText.y = 110;
			LootText.defaultTextFormat = Format;
			LootText.textColor = 0x20ff00;
			LootText.height = 50;
			LootText.width = 100;
			LootText.border = false;
			LootText.text = "€"+Main.Loot;
			
			//EventListeners
			addEventListener(Event.ENTER_FRAME, loop);
			button.addEventListener(MouseEvent.CLICK, playing);
			instructionB.addEventListener(MouseEvent.CLICK, instructionspop);
			easyButton.addEventListener(MouseEvent.CLICK, easyLevelSelect);
			house.addEventListener(MouseEvent.CLICK, levelStart);
			BackBTN.addEventListener(MouseEvent.CLICK, Back);
		}
		
		private function Back(e:MouseEvent):void 
		{
			BacktoMenu = true;
		}
		
		private function instructionspop(e:MouseEvent):void 
		{
			instructionsGO = true;
			
		}
		
		public function playing(e:Event):void
		{
			ButtonPress = true;
		}
		
		
		private function loop(e:Event):void 
		{
			//start button
			
			if (ButtonPress == true && button.currentFrame != 2 )	
			{
				button.gotoAndStop(2);
			}
			
			if (button.currentFrame == 2)		//met deze if statements zorgen we ervoor dat de button weg fade als erop wordt geklikt als de current frame van de button 2 is
			{
				if (button.alpha != 0.1)		
				{
					button.alpha -= 0.1;
				}
				
				if (button.alpha <= 0.1)
				{
					button.gotoAndStop(1);
					ButtonPress = false;
					ButtonRemove = true;
				}
			}
			if (button != null)					//als de button niet gelijk is aan null word de button verwijderd en de easy button op de stage gezet
			{
				if (ButtonRemove == true)
				{
					removeChild(button);
					removeChild(instructionB);
					ButtonRemove = false;
					addChild(easyButton);
					
				}
			}
			
			//Instruction button
			
			if (instructionsGO == true)	
			{

				if (instructionB.alpha != 0.1)		
				{
					instructionB.alpha -= 0.1;
				}
					
				if (instructionB.alpha <= 0.1)
				{
					instructionsGO = false;
					removeChild(instructionB);
					removeChild(button);
					addChild(instructionSCR);
					addChild(BackBTN);
					instructionB.alpha = 1;
				}
			}
			
			if (BacktoMenu == true)	
			{

				if (BackBTN.alpha != 0.1)		
				{
					BackBTN.alpha -= 0.1;
				}
					
				if (BackBTN.alpha <= 0.1)
				{
					BacktoMenu = false;
					removeChild(BackBTN);
					removeChild(instructionSCR);
					addChild(instructionB);
					addChild(button);
					BackBTN.alpha = 1;
				}
			}	
			
			
			//level select
			
			if (easyButtonPress == true)			//met deze if statements zorgen we ervoor dat de easyButton weg fade 
			{	
				if (easyButton.alpha != 0.1)
				{
					easyButton.alpha -= 0.1;
				}
				
				if (easyButton.alpha <= 0.1)
				{
					easyButtonPress = false;
					easyButtonRemove = true;
					
				}
			}
			
			if (easyButton != null)		//als de easy button niet gelijk is aan null word de easyButton verwijder en de slumMap en het huis op de stage gezet
			{
				if (easyButtonRemove == true)
				{
					removeChild(easyButton);
					easyButtonRemove = false;
					addChild(slumMap);
					addChild(house);
					
					
				}
			}
			
			if (Main.Loot <= 0)
			{
				addChild(endGame);
			}
			
		}
		
		public function easyLevelSelect(e:Event):void
		{
			easyButtonPress = true;	
		}
		
		public function levelStart(e:Event):void		//als levelstart word uitgevoerd dan word de backGround,de slumMap en het huis van de stage verwijderd
		{
			easyLevelStart = true;
			removeChild(backGround);
			removeChild(slumMap);
			removeChild(house);
			
		}
		
		
	}

}