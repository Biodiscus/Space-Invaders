package
{
	import flash.display.Sprite;
	
	public class Player extends Sprite
	{
		public function Player()
		{
			graphics.beginFill(0x00FF00);
			graphics.drawRect(0, 0, SpaceInvaders.size * 2, SpaceInvaders.size / 1.5);
			graphics.endFill();
			graphics.beginFill(0x00FF00);
			graphics.drawRect(20, -20, SpaceInvaders.size/2, SpaceInvaders.size);
		}
	}
}