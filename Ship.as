package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Ship extends Sprite
	{
		private var xSpeed:int = 2;
		private var acc:Number = 0.5;
		public var yPos:Number;		
		public var move:Boolean = false;
		
		private var color:Array = new Array(0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF);
		private var bullet_cont:Array = new Array();
		public var shoot:Boolean;
		private var shoot_timer:Timer;
		private var time:int;
		private var bullets:Array;
		private var s:Stage;
		
		private var min:int = 4000;
		private var max:int = 10000;
		
		
		public function Ship(id:int)
		{
			this.s = stage;
			if(id < color.length + 1)
				graphics.beginFill(color[id]);
			else
				graphics.beginFill(color[1]);
			
			bullets = new Array();
		
			graphics.drawRect(0, 0, SpaceInvaders.size, SpaceInvaders.size);
			graphics.endFill();
			
			time = Math.round(min + Math.random() * max);

			shoot_timer = new Timer(time);
			shoot_timer.addEventListener(TimerEvent.TIMER, tick);
			shoot_timer.start();
		
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		protected function tick(event:TimerEvent):void
		{
			shoot = true;
			
			shoot_timer.stop();
			shoot_timer.removeEventListener(TimerEvent.TIMER, tick);
			
			time = Math.round(min + Math.random() * max);
			
			shoot_timer = new Timer(time);
			shoot_timer.addEventListener(TimerEvent.TIMER, tick);
			shoot_timer.start();
		}
		private function loop(e:Event):void
		{
			if(SpaceInvaders.pauze)
				return;
			
			for(var i:int = 0; i < bullet_cont.length; i++)
			{
				var a:Bullet = bullet_cont[i];
				if(this.hitTestObject(a) && a.visible && this.visible)
				{
					this.visible = false;
					
					a.visible = false;
				}
			}
			
			if(move)
			{
				move = false;
				
				if(xSpeed >= 0)
					xSpeed += acc;
				else
					xSpeed -= acc;
				
				xSpeed = -xSpeed;
				yPos += 0.4;
				
			}
			if(xSpeed > 0)
				xSpeed + ((Math.round(yPos) * 2) * SpaceInvaders.level);
			else
				xSpeed - ((Math.round(yPos) * 2) * SpaceInvaders.level);
			
			this.x += xSpeed;
			this.y = 10 + (SpaceInvaders.size + (SpaceInvaders.size / 2)) * yPos;
		}
		public function update(bul:Array):void
		{
			bullet_cont = bul;
		}
	}
}