package burglar 
{/*
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
	 *//*
	public class kluis extends MovieClip
	{	
		private var format:TextFormat = new TextFormat();
		private var Format:TextFormat = new TextFormat();
		
		private var antwoord:TextField = new TextField();
		private var gAntwoord:TextField = new TextField();
		private var wAntwoord:TextField = new TextField();
		
		private var answerCheck:int;
		private var rightAnswer:int = 1000;
		public static var levelEnd:Boolean = false;
		private var numberOfTries:int = 0;
		
		private var livnRoom:MovieClip = new slumwoonkamer();
		private var Vault:MovieClip = new vaultscreen();
		
		private var Button1:MovieClip = new onebutton();
		private var Button0:MovieClip = new zerobutton();
		private var Btn1Press:Boolean = false;
		private var Btn0Press:Boolean = false;
		private var EnterButton:enterbutton = new enterbutton();
		private var okButtonPress:Boolean = false;
		
		
		public function kluis()
		{
			//woonkamer
			livnRoom.x = 0;
			livnRoom.y = 0;
			addChild(livnRoom);
			setChildIndex(livnRoom, 0);
			
			//vault
			Vault.x = 100;
			Vault.y = 200;
			addChild(Vault);
			setChildIndex(Vault, 1);
			
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
			addChild(antwoord);
			setChildIndex(antwoord, 2);
			
			//de buttons
			Button1.x = 370;
			Button1.y = 325;
			Button1.gotoAndStop(1);
			addChild(Button1);
			setChildIndex(Button1, 3);
			
			Button0.x = 520;
			Button0.y = 325;
			Button0.gotoAndStop(1);
			addChild(Button0);
			setChildIndex(Button0, 3);
			
			EnterButton.x = 520;
			EnterButton.y = 455;
			EnterButton.scaleX = 0.5;
			EnterButton.scaleY = 0.5;
			EnterButton.gotoAndStop(1);
			addChild(EnterButton);
			setChildIndex(EnterButton, 3);
			
			//goed antwoord / fout antwoord
			Format.size = 40;
			Format.align = "center";
			
			gAntwoord.alpha = 0;
			gAntwoord.defaultTextFormat = Format;
			gAntwoord.textColor = 0xFF4000;
			gAntwoord.x = 200;
			gAntwoord.y =100;
			gAntwoord.height = 50;
			gAntwoord.width = 350;
			gAntwoord.border = false;
			gAntwoord.text = "You opened the vault!";
			addChild(gAntwoord);
			setChildIndex(gAntwoord, 5);
			
			wAntwoord.alpha = 0;
			wAntwoord.defaultTextFormat = Format;
			wAntwoord.textColor = 0xFF0000;
			wAntwoord.x = 200;
			wAntwoord.y =100;
			wAntwoord.height = 50;
			wAntwoord.width = 350;
			wAntwoord.border = false;
			wAntwoord.text = "You got BUSTED";
			addChild(wAntwoord);
			setChildIndex(gAntwoord, 5);

			
			//de Eventlisteners worden hier aangemaakt
			addEventListener(Event.ENTER_FRAME, loop);
			antwoord.addEventListener(MouseEvent.CLICK, ResetText);
			addEventListener(KeyboardEvent.KEY_DOWN, Keydown);
			addEventListener(KeyboardEvent.KEY_UP, Keyup);
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
		
		
		private function loop(e:Event):void 
		{
			if (numberOfTries == 2)
			{
				wAntwoord.alpha = 1;
				removeChild(Vault);
				removeChild(Button0);
				removeChild(Button1);
				removeChild(EnterButton);
				removeChild(antwoord);
				levelEnd = true;
			}
		}
		
		private function checkAnswer():void
		{
			answerCheck = int(antwoord.text)
			if (answerCheck == rightAnswer)
			{
				gAntwoord.alpha = 1;
				removeChild(Vault);
				removeChild(Button0);
				removeChild(Button1);
				removeChild(EnterButton);
				removeChild(antwoord);
				levelEnd = true;
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
*/
}