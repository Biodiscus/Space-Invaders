package
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;

	public class Keys
	{
		public var space:Boolean;
		public var down:Boolean;
		public var up:Boolean;
		public var right:Boolean;
		public var left:Boolean;
		
		public function Keys(list:Stage)
		{
			list.addEventListener(KeyboardEvent.KEY_DOWN, downing);
			list.addEventListener(KeyboardEvent.KEY_UP, uping);
		}
		
		protected function downing(event:KeyboardEvent):void
		{
			if(event.keyCode == 37 || event.keyCode == 65) // Left arrow && A
			{
				left = true;
			}
			if(event.keyCode == 39 || event.keyCode == 68) // right arrow && D
			{
				right = true;
			}
			if(event.keyCode == 38 || event.keyCode == 87) // Up arrow && W
			{
				up = true;
			}
			if(event.keyCode == 40 || event.keyCode == 83) // Down arrow && S
			{
				down = true;
			}
			if(event.keyCode == 32) // Space
			{
				space = true;
			}
		}
		
		protected function uping(event:KeyboardEvent):void
		{
			if(event.keyCode == 37 || event.keyCode == 65) // Left arrow
			{
				left = false;
			}
			if(event.keyCode == 39 || event.keyCode == 68) // right arrow
			{
				right = false;
			}
			if(event.keyCode == 38 || event.keyCode == 87) // Up arrow
			{
				up = false;
			}
			if(event.keyCode == 40 || event.keyCode == 83) // Down arrow && S
			{
				down = false;
			}
			if(event.keyCode == 32) // Space
			{
				space = false;
			}
		}
	}
}