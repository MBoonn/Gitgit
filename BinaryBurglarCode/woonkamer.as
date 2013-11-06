package burglar 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Rachel, Kjeld, Mike
	 */
	public class woonkamer extends MovieClip
	{
		private var SlumLivingRoom:slumwoonkamer = new slumwoonkamer;
		private var HiddenVault:vault = new vault;
		public static var gotoVault:Boolean = false;
		public static var stayHidden:Boolean = true;
		
		private var format:TextFormat = new TextFormat();
		private var Format:TextFormat = new TextFormat();
		
		private var antwoord:TextField = new TextField();
		private var gAntwoord:TextField = new TextField();
		private var wAntwoord:TextField = new TextField();
		
		private var answerCheck:int;
		private var rightAnswer:int = 1000;
		public static var levelEnd:Boolean = false;
		private var numberOfTries:int = 0;
		
		private var Vault:MovieClip = new vaultscreen();
		
		private var Button1:MovieClip = new onebutton();
		private var Button0:MovieClip = new zerobutton();
		private var Btn1Press:Boolean = false;
		private var Btn0Press:Boolean = false;
		private var EnterButton:enterbutton = new enterbutton();
		private var okButtonPress:Boolean = false;
		private var backButton:MovieClip = new backbutton();
		private var RandomNumber:int = 0;
		
		public function woonkamer() 
		{
			addChild(SlumLivingRoom);
			
			HiddenVault.x = 370;
			HiddenVault.y = 150;
			addChild(HiddenVault);
			
			setChildIndex(SlumLivingRoom, 0);
			setChildIndex(HiddenVault, 1);
			
			addEventListener(Event.ENTER_FRAME, loop);
			antwoord.addEventListener(MouseEvent.CLICK, ResetText);
			addEventListener(KeyboardEvent.KEY_DOWN, Keydown);
			addEventListener(KeyboardEvent.KEY_UP, Keyup);
			
			HiddenVault.addEventListener(MouseEvent.CLICK, enterVault);
			
			//vault
			Vault.x = 100;
			Vault.y = 200;
			
			
			//textfield
			format.size = 15;
			format.align = "center";
			
			antwoord.defaultTextFormat = format;
			antwoord.textColor = 0x40FF00;
			antwoord.width = 150;
			antwoord.height = 30;
			antwoord.border = false;
			antwoord.x = 470;
			antwoord.y = 290;
			antwoord.type = TextFieldType.INPUT;
			antwoord.maxChars = 5;
			antwoord.restrict = "0-1";
			antwoord.type = "input";
			antwoord.text = "Enter passkey";
			
			
			//de buttons
			Button1.x = 370;
			Button1.y = 325;
			Button1.gotoAndStop(1);
			
			
			Button0.x = 520;
			Button0.y = 325;
			Button0.gotoAndStop(1);
			
			EnterButton.x = 520;
			EnterButton.y = 455;
			EnterButton.scaleX = 0.5;
			EnterButton.scaleY = 0.5;
			EnterButton.gotoAndStop(1);
			
			
			//goed antwoord / fout antwoord
			Format.size = 40;
			Format.align = "center";
			
			gAntwoord.alpha = 0;
			gAntwoord.defaultTextFormat = Format;
			gAntwoord.textColor = 0xFF4000;
			gAntwoord.x = 50;
			gAntwoord.y =100;
			gAntwoord.height = 50;
			gAntwoord.width = 750;
			gAntwoord.border = false;
			
			
			wAntwoord.alpha = 0;
			wAntwoord.defaultTextFormat = Format;
			wAntwoord.textColor = 0xFF0000;
			wAntwoord.x = 50;
			wAntwoord.y =100;
			wAntwoord.height = 50;
			wAntwoord.width = 750;
			wAntwoord.border = false;
			
			
			backButton.x = 300;
			backButton.y = 400;
			
			backButton.addEventListener(MouseEvent.CLICK, endThisGame);
		}
		
		private function endThisGame(e:Event):void 
		{
			levelEnd = true;
		}
		
		public function enterVault(e:Event):void 
		{
			gotoVault = true;
			
		}
		
		private function loop(e:Event):void 
		{
			if (gotoVault == true)
			{	
				
				addChild(Vault);
				//setChildIndex(Vault, 2);
				addChild(antwoord);
				//setChildIndex(antwoord, 3);
				
				addChild(Button1);
				//setChildIndex(Button1, 3);
				addChild(Button0);
				//setChildIndex(Button0, 3);
				addChild(EnterButton);
				//setChildIndex(EnterButton, 3);
				
				addChild(gAntwoord);
				//setChildIndex(gAntwoord, 3);
				addChild(wAntwoord);
				//setChildIndex(wAntwoord, 3);
			}
		}
		
		private function Keydown(ke:KeyboardEvent):void 
		{
			
			switch(ke.keyCode)
			{
				case 48:						//dit word pas uitgevoerd als de 0 key word ingedrukt(48 en 96 is de key code van de 0 knop)
					Button0.gotoAndStop(2);
					break;
					
				case 49:						//dit word pas uitgevoerd als de 1 key word ingedrukt(49 en 97 is de key code van de 1 knop)
					Button1.gotoAndStop(2);
					break;
					
				case 96:						//dit word pas uitgevoerd als de 0 key word ingedrukt(48 en 96 is de key code van de 0 knop)
					Button0.gotoAndStop(2);
					break;

				case 97:						//dit word pas uitgevoerd als de 1 key word ingedrukt(49 en 97 is de key code van de 1 knop)
					Button1.gotoAndStop(2);
					break;		
					
				case 13:						//dit word pas uitgevoerd als de enter key word ingedrukt(13 is de key code van de enter knop)
					checkAnswer();
					break;
			}
		}
		
		private function Keyup(ke:KeyboardEvent):void 
		{
			switch(ke.keyCode)
			{
				case 48:						//dit word pas uitgevoerd als de 0 key word losgelaten(48 is de key code van de 0 knop)
					Button0.gotoAndStop(1);
					break;
					
				case 49:						//dit word pas uitgevoerd als de 1 key word losgelaten(49 is de key code van de 1 knop)
					Button1.gotoAndStop(1);
					break;
					
				case 96:						//dit word pas uitgevoerd als de 0 key word ingedrukt(48 en 96 is de key code van de 0 knop)
					Button0.gotoAndStop(1);
					break;
					
				case 97:						//dit word pas uitgevoerd als de 1 key word ingedrukt(49 en 97 is de key code van de 1 knop)
					Button1.gotoAndStop(1);
					break;			
			}
		}
		
		
		private function ResetText(e:MouseEvent):void 
		{
			if(antwoord.text == "Enter passkey")
			{
				antwoord.replaceText(0, 13, "");
			}
			
		}
	
		private function checkAnswer():void
		{
			answerCheck = int(antwoord.text)
			if (answerCheck == rightAnswer)
			{
				RandomNumber = Math.random() * 30;
				gAntwoord.text = "You opened the vault! this is your loot € "+ RandomNumber+".-";
				Main.Loot += RandomNumber;
				gAntwoord.alpha = 1;
				gotoVault = false;
				removeChild(Vault);
				removeChild(Button0);
				removeChild(HiddenVault);
				removeChild(Button1);
				removeChild(EnterButton);
				removeChild(antwoord);
				addChild(backButton);
			}
			else if (numberOfTries == 2)
			{
				RandomNumber = Math.random() * 25;
				wAntwoord.text = "You got BUSTED you got fined for € "+ RandomNumber+".-";
				Main.Loot -= RandomNumber;
				gotoVault = false;
				wAntwoord.alpha = 1;
				removeChild(Vault);
				removeChild(Button0);
				removeChild(Button1);
				removeChild(EnterButton);
				removeChild(antwoord);
				addChild(backButton);
			}
			else
			{
				if (numberOfTries <= 2)
				{
					numberOfTries++;
				}
			}
		}
	}

}