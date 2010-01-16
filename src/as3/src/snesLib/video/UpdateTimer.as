package snesLib.video
{
	import flash.events.Event;
	
	/**
	 * @private
	 * 
	 * Update timer is responsible for iterating the application's main() loop and updating VideoSurface. 
	 */
	internal class UpdateTimer {
		
		private var surface:VideoSurface;
		private var bufferLocation:uint;
		
		public function set paused( paused:Boolean ):void
		{
			if (paused)
			{
				this.surface.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			}
			else
			{
				this.surface.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			}
		}
		
		
		public function UpdateTimer( surface:VideoSurface )
		{
			this.surface = surface;
			this.surface.addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		
		private function onEnterFrame( e:Event ):void
		{
			surface.libSDL.cLib.tick( surface.libSDL.eventManager.pumpKeyEvents() );
//			surface.libSDL.cLib.tick();
			
			if (!this.bufferLocation){
				this.bufferLocation = surface.libSDL.cLib.getDisplayPointer();
			}
			surface.updateDisplay( bufferLocation );
		}
	}
}