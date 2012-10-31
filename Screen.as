package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class Screen extends Sprite
	{
		public function Screen(s:String = "s")
		{
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, SpaceInvaders.dim.x, SpaceInvaders.dim.y);
			
			var style:TextFormat = new TextFormat();
			style.color = 0xFFFF00;
			style.font = "Verdana";
			style.size = 50;
			style.align = "center";
			
			var text:TextField = new TextField();
			text.selectable = false;
			text.width = SpaceInvaders.dim.x;
			text.height = 100;
			text.x = 0;
			text.y = (SpaceInvaders.dim.y / 2) - (text.height / 2);
			text.defaultTextFormat = style;
			
			if(s == "s")
			{
				text.text = "Level: "+SpaceInvaders.level;
			}
			else
			{
				text.text = "LOSE";
			}
			
			addChild(text);
		}
	}
}