package
{
	import flash.display.Sprite;
	
	public class Life extends Sprite
	{
		public function Life()
		{
			graphics.beginFill(0xFF00FF);
			graphics.drawRect(0, 0, SpaceInvaders.size, SpaceInvaders.size);
			graphics.endFill();
		}
	}
}