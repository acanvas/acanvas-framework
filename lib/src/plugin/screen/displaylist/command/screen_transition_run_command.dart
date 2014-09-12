part of rockdot_dart;



	 @retain
class ScreenTransitionRunCommand extends AbstractScreenCommand {
		
		 ScreenDisplaylistTransitionApplyVO _vo;
		 CompositeCommandWithEvent _compositeCommand;

		@override dynamic execute([RockdotEvent event=null])
		 {
			super.execute(event);
			_compositeCommand = new CompositeCommandWithEvent(CompositeCommandKind.SEQUENCE);
			_vo = event.data;
			_applyEffect(_vo.transitionType, _vo.targetPrimary, _vo.duration, dispatchCompleteEvent, _vo.targetSecondary);
			
			return null;
		} void _applyEffect(String effectType,ISpriteComponent target,num duration,Function callback,[ISpriteComponent nextTarget=null])
		 {
			
			if(duration == null) duration =  _vo.effect.duration;
			
			int maxdepthTarget = 0;
			int maxdepthNextTarget = 0;
			if(_vo.effect.applyRecursively){
				 maxdepthTarget = _getDepth(target as DisplayObjectContainer, 0);
				 if(nextTarget != null){
					maxdepthNextTarget = _getDepth(nextTarget as DisplayObjectContainer, 0);
				 }
			}
			
			//some day, someone will explain this to you.
			switch(effectType){
				case ScreenConstants.EFFECT_IN:
					if(_vo.effect.applyRecursively){
						_addInEffectRecursively(target, 0 , duration, duration, maxdepthTarget);
					}
					_compositeCommand.addCommandEvent(new RockdotEvent(ScreenDisplaylistEvents.APPLY_EFFECT_IN, new ScreenDisplaylistEffectApplyVO(_vo.effect, target, duration)), _context);
				break;
				case ScreenConstants.EFFECT_OUT:
					if(_vo.effect.applyRecursively){
						_addOutEffectRecursively(target, 0 , duration, 0, maxdepthTarget);
					}
					_compositeCommand.addCommandEvent(new RockdotEvent(ScreenDisplaylistEvents.APPLY_EFFECT_OUT, new ScreenDisplaylistEffectApplyVO(_vo.effect, target, duration)), _context);
				break;
				case ScreenConstants.TRANSITION_SEQUENTIAL:
				
					_compositeCommand.addCommandEvent(new RockdotEvent(ScreenDisplaylistEvents.APPLY_EFFECT_OUT, new ScreenDisplaylistEffectApplyVO(_vo.effect, target, duration)), _context);
				
					if(_vo.effect.applyRecursively){
						_addOutEffectRecursively(target, 0 , duration, 0, maxdepthTarget);
						_addInEffectRecursively(nextTarget, 0 , duration, (maxdepthNextTarget * duration) + 2 * duration, maxdepthNextTarget);
					}
					_compositeCommand.addCommandEvent(new RockdotEvent(ScreenDisplaylistEvents.APPLY_EFFECT_IN, new ScreenDisplaylistEffectApplyVO(_vo.effect, nextTarget, duration)), _context);
				
				break;
				case ScreenConstants.TRANSITION_PARALLEL:
					_compositeCommand.kind = CompositeCommandKind.PARALLEL;
				
					_compositeCommand.addCommandEvent(new RockdotEvent(ScreenDisplaylistEvents.APPLY_EFFECT_OUT, new ScreenDisplaylistEffectApplyVO(_vo.effect, target, duration)), _context);
					
					if(_vo.effect.applyRecursively){
						_addOutEffectRecursively(target, 0 , duration, 0, maxdepthTarget);
						_addInEffectRecursively(nextTarget, 0 , duration, 0, maxdepthNextTarget);
					}
					_compositeCommand.addCommandEvent(new RockdotEvent(ScreenDisplaylistEvents.APPLY_EFFECT_IN, new ScreenDisplaylistEffectApplyVO(_vo.effect, nextTarget, duration)), _context);
					
				break;
			}
			
			
			/* add sequence listeners */
			_compositeCommand.addCompleteListener(dispatchCompleteEvent);
			_compositeCommand.addErrorListener(_handleError);
			_compositeCommand.execute();
			
			_stateModel.compositeEffectCommand = _compositeCommand;
		} void _addInEffectRecursively(ISpriteComponent vcs,int depth,num duration,num delay,int maxdepth)
		 {
			DisplayObject child;
			for (int i = 0; i < (vcs as DisplayObjectContainer).numChildren; i++) {
				child = (vcs as DisplayObjectContainer).getChildAt(i);
				if(child is ISpriteComponent){
					_compositeCommand.addCommandEvent(new RockdotEvent(ScreenDisplaylistEvents.APPLY_EFFECT_IN, new ScreenDisplaylistEffectApplyVO(_vo.effect, child as ISpriteComponent, duration)), _context);
					_addInEffectRecursively(child as ISpriteComponent, depth+1 , duration, delay, maxdepth);
				}
			}
			
		} void _addOutEffectRecursively(ISpriteComponent vcs,int depth,num duration,num delay,int maxdepth)
		 {
			DisplayObject child;
			for (int i = 0; i < (vcs as DisplayObjectContainer).numChildren; i++) {
				child = (vcs as DisplayObjectContainer).getChildAt(i);
				if(child is ISpriteComponent){
					_compositeCommand.addCommandEvent(new RockdotEvent(ScreenDisplaylistEvents.APPLY_EFFECT_OUT, new ScreenDisplaylistEffectApplyVO(_vo.effect, child as ISpriteComponent, duration)), _context);
					_addOutEffectRecursively(child as ISpriteComponent, depth+1 , duration, delay, maxdepth);
				}
			}
		} int _getDepth(DisplayObjectContainer vcs,int depth)
		 {
			int maxd = depth;
			DisplayObject child;
			for (int i = 0; i < vcs.numChildren; i++) {
				child = vcs.getChildAt(i);
				if(child is ISpriteComponent){
					maxd = max(_getDepth(child as DisplayObjectContainer, depth+1), maxd);
				}
			}
			return maxd;
		}
		
		@override bool dispatchCompleteEvent([dynamic result=null])
		 {
			
			if(_vo.transitionType != ScreenConstants.EFFECT_IN){
				_vo.targetPrimary.destroy();
				_vo.targetPrimary = null;
				_vo = null;
			}
			else{
				if(_vo.targetPrimary.enabled != true){
					_vo.targetPrimary.enabled = true;
				}
			}
			
			return super.dispatchCompleteEvent(result);
		}
	}

