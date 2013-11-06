package burglar 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import burglar.menu;
	import burglar.woonkamer;
	import flash.ui.Mouse;
	/**
	 * ...
	 * @author Rachel, Kjeld, Mike
	 */
	public class deur extends MovieClip
	{
		public var Door:MovieClip = new deurtje;
		private var SlumH1:MovieClip = new slumHouse;
		private var SlumEnvir:slumenvironment = new slumenvironment;
		private var DoorPress:Boolean = false;
		private var ChargeBar:MovieClip = new chargebar;
		private var CrowBar:MovieClip = new crowbar;
		private var wrikken:Boolean = false;
		private var doorHealt:Number = 3;
		private var doorRemove:Boolean = false;
		private var Arrow:MovieClip = new arrow;
		public static var arrowActive:Boolean = false;
		public static var woonkamerStart:Boolean = false;
		
		
		public function deur() 
		{
			//Hier plaatsen we alles op de stage en we geven het een positie
			
			addChild(SlumEnvir);
			addChild(SlumH1);
			addChild(Door);
			addChild(CrowBar);
			CrowBar.gotoAndStop(1);
			SlumH1.x = 110;
			SlumH1.y = 100;
			Door.x = 300;
			Door.y = 250;
			addChild(ChargeBar);
			ChargeBar.x = 100;
			ChargeBar.y = 50;
			Door.gotoAndStop(1);
			setChildIndex(SlumEnvir, 0);
			setChildIndex(SlumH1, 1);
			setChildIndex(Door, 2);
			setChildIndex (CrowBar, 3)
			CrowBar.mouseEnabled = false;
			
			Arrow.x = 530;
			Arrow.y = 450;
			Arrow.rotation = 270;
			Arrow.alpha = 0;
			addChild(Arrow);
			
			//EventListeners
			
			addEventListener(Event.ENTER_FRAME, loop);
			Door.addEventListener(MouseEvent.CLICK, wrik);
			Arrow.addEventListener(MouseEvent.CLICK, goIn);
			
		}
		
		private function goIn(e:Event):void 
		{
			arrowActive = true;
		}
		
		private function wrik(e:MouseEvent):void 
		{
			if (Door.currentFrame != 4)		//dit wordt uitgevoerd als de currenframe niet gelijk is aan 4
			{
				wrikken = true;
			}
			
		}
		
		private function doorDamage():void
		{
			
			if(doorHealt > 0 && Door.currentFrame != 4) //als doorHealt groter is dan 0 en de Door zijn currentFrame niet gelijk is aan 4 wordt dit uitgevoerd
			{
				doorHealt--;
			}
		}
		
		
		public function loop(e:Event):void
		{
			if (wrikken == true && Door.currentFrame != 4)	//als wrikken true is en de Door zijn currentFrame niet gelijk is aan 4 gaat de  crowbar gaat frame 2 en is wrikken false
			{
				CrowBar.gotoAndStop(2);	
				wrikken = false;
			}
			else if (wrikken == false)		//als wrikken gelijk is aan false is de currentFrame van de CrowBar 1
			{
				CrowBar.gotoAndStop(1);
			}
			
			//we koppelen de muis aan de crowbar
			CrowBar.x = mouseX;
			CrowBar.y = mouseY;
			
			
			if (CrowBar.currentFrame == 2 && ChargeBar.currentFrame > 20 && ChargeBar.currentFrame < 30)
			{
				if (Door.currentFrame != 4)
				{
					doorDamage();
				}
			}
			//als de currframe van de deur 4 is word deze if statement uitgevoerd 
			if (Door.currentFrame != 4)
			{
				if (doorHealt == 3)
				{
					Door.gotoAndStop(1);
				}
				else if (doorHealt == 2)
				{
					Door.gotoAndStop(2);
				}
				else if (doorHealt == 1)
				{
					Door.gotoAndStop(3);
				}
			}
			
			if (doorHealt <= 0)
			{
				Door.gotoAndStop(4);
				ChargeBar.alpha = 0;
				CrowBar.alpha = 0;
			}
			//als de currentframe van de deur 4 is dan moet arrowspawn ook true zijn om de arrow te plaatsen en te positioneren
			if (Door.currentFrame == 4)
			{
				Arrow.alpha = 1;
				//arrowActive = true;
			}
		}
	}
}

