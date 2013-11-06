package src 
{
	import fl.text.IContainerManager;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextLine;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.events.TimerEvent
	import flash.text.TextFieldType;
	import src.Turret1;
	/**
	 * ...
	 * @author Mike
	 */
	public class Game extends MovieClip
	{
		//Settings for the game
		public var meteorTimer:Timer = new Timer(3000, 10);
		public var mrandom:int = 5;
		public var currentWave:int = 1;
		public var earthHP:int = 5;
		public var money:int = new int;
		public var waveSize:int = 5;
		public var GAME_TEXT_FORMAT:TextFormat = new TextFormat("Loaded", 30, 0xFFFFFF);	
		
		public var gameState:int;
		public var GAME_STATE_NULL:int = 0;
		public var GAME_STATE_PLAY:int = 1;
		public var GAME_STATE_PAUSE:int = 2;
		
		public var turret1:Array = new Array;
		public var earth:Earth = new Earth;
		public static var meteor:Array = new Array;
		public var completeWave:MovieClip = new Next_Wave;
		
		public var spawn1:Boolean = false;
		public var spawn2:Boolean = false;
		public var spawn3:Boolean = false;

		
		public var i:int = 0;
		public var o:int = -1;
		public var enemycounter:int = new int;
		public var enemycounter2:int = new int;
		public var turret1Class:Turret1 = new Turret1(0.5, 1);
		public var KillCount:int;
		
		public var layer1:MovieClip = new MovieClip; //Layer for the background and turrets
		public var layer2:MovieClip = new MovieClip; //Layer for meteorites
		public var layer3:MovieClip = new MovieClip; //Layer for the user interface
		
		//Temporary (dont edit)
		public var menuTop:Menu_Top = new Menu_Top;
		public var menuBottom:Menu_Bottom = new Menu_Bottom;
		public var nextWaveScr:MovieClip = new MovieClip;
		public var pauseScr:MovieClip = new MovieClip;
		
		public function Game()
		{	
			//Instantiate each layer with their own sets of art
			addChild(layer1);
			addChild(layer2);
			addChild(layer3);
			
			pauseScr.graphics.beginFill(0x000000, 0.5);
			pauseScr.graphics.drawRect(0, 0, 1024, 768);
			pauseScr.graphics.endFill();
			
			//Position settings for the UI
			menuTop.x = 512;
			menuTop.y = 15;
			
			money = 2000;
			
			menuBottom.x = 25;
			menuBottom.y = 750;
			menuBottom.Button1.addEventListener(MouseEvent.CLICK, turretspawn);
			layer3.addChild(menuTop);
			layer3.addChild(menuBottom);
			
			earth.x = 900;
			earth.y = -100;
			layer1.addChild(earth);
			
			addEventListener(Event.ENTER_FRAME, startLevel)
			meteorTimer.addEventListener(TimerEvent.TIMER, meteorTimerListener);
			pauseScr.addEventListener(MouseEvent.CLICK, completedclick);
		}
		
		public function turretspawn(e:MouseEvent):void 
		{
			//money check voor turret spawning
			if (money >= 20)
			{
				turret1.push(new Turret1(.15, 1));
				o += 1;
				money -= 20;
				layer1.addChild(turret1[o].turret1);
			}
		}
		
		public function completedclick(e:MouseEvent):void 
		{
			enemycounter = 0;
			KillCount = 0
			layer3.removeChild(pauseScr);
			waveSize += 5;
			currentWave += 1;
		}
		
		public function meteorTimerListener(e:TimerEvent):void
		{
			//timer voor meteoren
			mrandom = Math.floor(Math.random() * 4);
		}
		
		public function startLevel(e:Event):void 
		{
			if(gameState == GAME_STATE_PLAY)
			{
				//textfields
				meteorTimer.start();
				menuTop.moneyValue.text = "$" + String(money);
				menuTop.scoreValue.text = String(money * 3);
				menuTop.waveValue.text = String(currentWave);
				
				//wave systeem
				if (enemycounter >= waveSize && KillCount >= waveSize)
				{
					enemycounter = waveSize + 10;
					KillCount = waveSize + 10;
					pauseScr.addChild(completeWave);
					layer3.addChild(pauseScr);
					completeWave.x = stage.stageWidth / 2;
					completeWave.y = stage.stageHeight / 2;
				}
				
				//meteoren spawn systeem
				if (enemycounter < waveSize)
				{
					if (mrandom == 0)
					{
						spawn1 = true;
						if (spawn1)
						{
							meteor.push(new Meteor(2, .5, 2 + 0.7 * currentWave));
							meteor[i].y = 150;
							meteor[i].x = -20;
							enemycounter += 1;
							layer2.addChild(meteor[i]);
							i += 1;
							spawn1 = false;
							mrandom = 5;
						}
					}				
					else if (mrandom == 1)
					{
						spawn2 = true;
						if (spawn2)
						{
							meteor.push(new Meteor(2, .5, 2 + 0.7 * currentWave));
							meteor[i].y = 334;
							meteor[i].x = -20;
							enemycounter += 1;
							layer2.addChild(meteor[i]);
							i+= 1;
							spawn2 = false;
							mrandom = 5;
							}
					}
					else if (mrandom == 2)
					{
						spawn3 = true;
						if (spawn3)
						{
							meteor.push(new Meteor(2, .5, 2 + 0.7 * currentWave));
							meteor[i].y = 518;
							meteor[i].x = -20;
							enemycounter += 1;
							layer2.addChild(meteor[i]);
							i+= 1;
							spawn3 = false;
							mrandom = 5;
						}
					}
					
				}				
					//update funcies van de meteoren en turrets
					for (var j:int = meteor.length -1; j >= 0; j--)
					{
						meteor[j].update();
					}
					
					for (j = turret1.length -1; j >= 0; j--)
					{
						turret1[j].update();
					}
			}
			//earth hp check
			if (earthHP == 0)
			{
				gameState = 0;
				earth.gotoAndStop(1);
			}
		}
	}
}