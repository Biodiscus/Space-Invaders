package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class Button extends MovieClip
	{
		public function Button()
		{
			graphics.beginFill(0x444444);
			graphics.drawRect(0, 0, 100, 40);
			graphics.endFill();
			
			var style:TextFormat = new TextFormat();
			style.color = 0xFFFFFF;
			style.font = "Verdana";
			style.size = 20;
			style.align = "center";
			
			var text:TextField = new TextField();
			text.selectable = false;
			text.width = 100;
			text.height = 50;
			text.x = 0;
			text.y = 5;
			text.defaultTextFormat = style;
			
			text.text = "Retry!";
			addChild(text);
			
			addEventListener(MouseEvent.CLICK, clicking);
		}
		
		protected function clicking(event:MouseEvent):void
		{
			SpaceInvaders.retry = true;
		}
	}
}