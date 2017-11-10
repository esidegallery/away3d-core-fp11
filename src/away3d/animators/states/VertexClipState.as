package away3d.animators.states
{
	import away3d.core.base.Geometry;
	import away3d.animators.*;
	import away3d.animators.nodes.*;

	/**
	 *
	 */
	public class VertexClipState extends AnimationClipState implements IVertexAnimationState
	{
		private var _frames:Vector.<Geometry>;
		private var _vertexClipNode:VertexClipNode;
		private var _currentGeometry:Geometry;
		private var _nextGeometry:Geometry;
		private var _lastFrame:uint = 0;

		/**
		 * @inheritDoc
		 */
		public function get currentGeometry():Geometry
		{
			if (_framesDirty)
				updateFrames();

			return _currentGeometry;
		}

		/**
		 * @inheritDoc
		 */
		public function get nextGeometry():Geometry
		{
			if (_framesDirty)
				updateFrames();

			return _nextGeometry;
		}

		function VertexClipState(animator:IAnimator, vertexClipNode:VertexClipNode)
		{
			super(animator, vertexClipNode);

			_vertexClipNode = vertexClipNode;
			_frames = _vertexClipNode.frames;
		}

		// Fix for the really iritating bug
		override public function offset(startTime:int):void
		{
			super.offset(startTime);

			if ( _startTime < 15 ) {
				_currentFrame = _lastFrame = 0;
				_currentGeometry = _frames[_currentFrame];
			}
		}

		public function setToLastFrame():void {
			_currentFrame = this._frames.length-1;
			_currentGeometry = _frames[_currentFrame];
		}


		/**
		 * @inheritDoc
		 */
		override protected function updateFrames():void
		{
			super.updateFrames();

			_currentGeometry = _frames[_currentFrame];

			//if (_vertexClipNode.looping && _nextFrame >= _vertexClipNode.lastFrame) {
			if (_nextFrame >= _vertexClipNode.lastFrame) {
				if ( _vertexClipNode.looping) _nextGeometry = _frames[0];
				if ( _lastFrame != _currentFrame )
					//VertexAnimator(_animator).dispatchCycleEvent();
					VertexAnimator(_animator).animationCallback();
			} else {
				_nextGeometry = _frames[_nextFrame];
				if ( _lastFrame != _currentFrame )
					VertexAnimator(_animator).frameCallback(_currentFrame);
			}

			_lastFrame = _currentFrame;
		}

		/**
		 * @inheritDoc
		 */
		override protected function updatePositionDelta():void
		{
			//TODO:implement positiondelta functionality for vertex animations
		}
	}
}
