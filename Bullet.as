package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Bullet extends Sprite
	{
		private var s:String;
		public function Bullet(s:String = "p")
		{
			this.s = s;
			
			if(s == "p")
			{
				graphics.beginFill(0x00FF00);
				graphics.drawCircle(0, 0, SpaceInvaders.size / 5);
				graphics.endFill();
			}
			else
			{
				graphics.beginFill(0xFFFFFF);
				graphics.drawCircle(0, 0, SpaceInvaders.size / 5);
				graphics.endFill();
			}
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		protected function loop(event:Event):void
		{
			if(SpaceInvaders.pauze)
				return;
			if(s == "p")
			{
				this.y -= 7.5;
			}
			else
			{
				this.y += 5;
			}
		}
	}
}