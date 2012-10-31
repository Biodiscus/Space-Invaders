package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	[SWF(width='700', height='500', frameRate='32', backgroundColor=0x000000)]
	public class SpaceInvaders extends Sprite
	{
		public static var size:int = 25;
		
		private var gridY:int = 6;
		private var gridX:int = 11;
		
		private var start:Point;
		private var ships:Array;
		private var move:Boolean;
		private var p:Player;
		private var k:Keys;
		private var bullets:Array;
		
		private var shoot_timer:Timer;
		private var canShoot:Boolean = false;
		private var shootTime:int = 350;
		public static var pauze:Boolean = false;
		private static var s_b:Array;
		
		private var life:int = 3;
		
		private var lifes:Array;
		public static var level:int = 1;
		public static var dim:Point = new Point(700, 500);
		private var screens:Array;
		private var go:Boolean = false;
		private var countdown:Timer;
		
		public static var retry:Boolean = false;
		private var begin:Boolean = true;

		public function SpaceInvaders()
		{
			stage.focus = this;
			k = new Keys(stage);
			screen();
			
		}
		private function screen(a:String = "s"):void
		{
			go = false;
			screens = new Array();
			
			var s:Screen = new Screen(a);
			addChild(s);
			screens.push(s);
			
			countdown = new Timer(2000);
			countdown.addEventListener(TimerEvent.TIMER, count);
			countdown.start();
		}
		
		protected function count(event:TimerEvent):void
		{
			go = true;
			
			for (var i:int = 0; i < screens.length; i++) 
			{
				if(life > 0)
					deleteEntity(screens[i]);
			}
			
			if(life > 0)
				init();
			
			countdown.stop();
			countdown.removeEventListener(TimerEvent.TIMER, count);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function reset(id:int = 0):void
		{
			pauze = true;
			
			shoot_timer.stop();
			shoot_timer.removeEventListener(TimerEvent.TIMER, tick);
			
			for(var a:int = 0; a < lifes.length; a ++)
			{
				deleteEntity(lifes[a]);
			}
			
			resetGame();
			
			if(life == 0)
			{
				screen("a");
				return;
			}
			
			if(id > 0)
			{
				screen();
			}
			else
			{
				init();
			}
			
			pauze = false;
		}
		private function resetGame():void
		{
			for(var a:int = 0; a < ships.length; a++)
			{
				if(life == 0)
					deleteEntity(ships[a]);
			}
			
			for (var b:int = 0; b < s_b.length; b++) 
			{
				deleteEntity(s_b[b]);
			}
			
			for(var c:int = 0; c < bullets.length; c++)
			{
				deleteEntity(bullets[c]);
			}
			
			deleteEntity(p);
		}
		private function makeLife(length:int):void
		{
			for(var a:int = 0; a < length; a ++)
			{
				var l:Life = new Life();
				l.x = (size/2) + (size + (size / 2)) * a;
				l.y = size/2;
				addChild(l);
				
				lifes.push(l);
			}
		}
		private function init():void
		{
			if(begin)
			{
				ships = new Array();
				drawGrid();	
			}
			
			bullets = new Array();
			s_b = new Array();
			lifes = new Array();
			screens = new Array();
			
			shoot_timer = new Timer(shootTime);
			shoot_timer.addEventListener(TimerEvent.TIMER, tick);
			
			p = new Player();
			addChild(p);
			
			p.y = stage.stageHeight - (p.height - 20);
			p.x = (stage.stageWidth / 2) - (p.width);
			
			makeLife(life);
						
			begin = false;
		}
		private function drawGrid():void
		{
			for(var y:int = 0; y < gridY; y ++)
			{
				for(var x:int = 0; x < gridX; x ++)
				{
					var a:Ship = new Ship(y);
					
					a.x = 100 + (x * (size + size/2));
					a.y = 20 + (y * (size + size/2));
					a.yPos = y + 1;
					addChild(a);
					
					ships.push(a);
				}
			}
		}
		protected function loop(event:Event):void
		{
			if(go)
			{
				if(pauze)
					return;
				
				var w:int = stage.stageWidth;
				var h:int = stage.stageHeight;
				
				if(k.left)
				{
					if(p.x > 0)
						p.x -= 5;
				}
				else if(k.right)
				{
					if(p.x < w - p.width)
						p.x += 5;
				}
				
				if(k.space)
				{
					shoot_timer.start();
				}
				else
				{
					shoot_timer.stop();
					shoot_timer.removeEventListener(TimerEvent.TIMER, tick);
					
					shoot_timer = new Timer(shootTime);
					shoot_timer.addEventListener(TimerEvent.TIMER, tick);
				}
				
				if(canShoot)
				{
					Shoot(p.x, p.y);
					canShoot = false;
				}
				
				for (var i:int = 0; i < ships.length; i++) 
				{
					ships[i].update(bullets);
					
					if(ships[i].shoot)
					{
						ShipShoot(ships[i].x, ships[i].y);
						ships[i].shoot = false;
					}
					
					if((ships[i].x > (w - (ships[i].width)) || ships[i].x < 0) && ships[i].visible)
					{
						move = true;
					}
					
					if(!ships[i].visible)
					{
						ships.splice(i, 1);
					}
				}
				
				if(move)
				{
					for(var a:int = 0; a < ships.length; a++)
					{
						ships[a].move = true;
					}
					move = false;
				}
				
				for (var j:int = 0; j < s_b.length; j++) 
				{
					if(p.hitTestPoint(s_b[j].x, s_b[j].y))
					{
						life --;
						
						reset();
					}
				}
				
				
				for(var b:int = 0; b < bullets.length; b++)
				{
					
					if(bullets[b].y < 0)
					{
						deleteEntity(bullets[b]);
					}
				}
				if(ships.length <= 0 && !begin)
				{
					newLevel();
				}
			}
		}
		
		private function newLevel():void
		{
			level ++;
			begin = true;
			
			reset(1);
		}
		protected function tick(event:TimerEvent):void
		{
			canShoot = true;
		}
		private function Shoot(x:Number, y:Number):void
		{
			var b:Bullet = new Bullet();
			b.x = x + size;
			b.y = y - 20;
			bullets.push(b);
			addChild(b);
		}
		
		private function ShipShoot(x:Number, y:Number):void
		{
			var b:Bullet = new Bullet("a");
			b.x = x;
			b.y = y;
			s_b.push(b);
			addChild(b);
		}
		private function deleteEntity(ar:Sprite):void
		{
			if(contains(ar))
			{
				removeChild(ar);
			}
		}
	}
}