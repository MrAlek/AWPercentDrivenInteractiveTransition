//
//  AWPercentDrivenInteractiveTransition.m
//
//  Created by Alek Astrom on 2014-04-27.
//
// Copyright (c) 2014 Alek Åström
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "AWPercentDrivenInteractiveTransition.h"

@implementation AWPercentDrivenInteractiveTransition {
    __weak id<UIViewControllerContextTransitioning> _transitionContext;
    BOOL _isInteracting;
    CADisplayLink *_displayLink;
}

#pragma mark - Initialization
- (instancetype)initWithAnimator:(id<UIViewControllerAnimatedTransitioning>)animator {
    
    self = [super init];
    if (self) {
        [self _commonInit];
        _animator = animator;
    }
    return self;
}
- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self _commonInit];
    }
    return self;
}
- (void)_commonInit {
    _completionSpeed = 1;
}

#pragma mark - Public methods
- (BOOL)isInteracting {
    return _isInteracting;
}
- (CGFloat)duration {
    return [_animator transitionDuration:_transitionContext];
}
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSAssert(_animator, @"The animator property must be set at the start of an interactive transition");
    
    _transitionContext = transitionContext;
    [_transitionContext containerView].layer.speed = 0;
    
    [_animator animateTransition:_transitionContext];
}
- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    self.percentComplete = fmaxf(fminf(percentComplete, 1), 0); // Input validation
}
- (void)cancelInteractiveTransition {
    [_transitionContext cancelInteractiveTransition];
    [self _completeTransition];
}
- (void)finishInteractiveTransition {
    
    /*CALayer *layer = [_transitionContext containerView].layer;
     layer.speed = 1;
     
     CFTimeInterval pausedTime = [layer timeOffset];
     layer.timeOffset = 0.0;
     layer.beginTime = 0.0; // Need to reset to 0 to avoid flickering :S
     CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
     layer.beginTime = timeSincePause;*/
    
    [_transitionContext finishInteractiveTransition];
    [self _completeTransition];
}
- (UIViewAnimationCurve)completionCurve {
    return UIViewAnimationCurveLinear;
}

#pragma mark - Private methods
- (void)setPercentComplete:(CGFloat)percentComplete {
    _percentComplete = percentComplete;
    
    [self _setTimeOffset:percentComplete*[self duration]];
    [_transitionContext updateInteractiveTransition:percentComplete];
}
- (void)_setTimeOffset:(NSTimeInterval)timeOffset {
    [_transitionContext containerView].layer.timeOffset = timeOffset;
}
- (void)_completeTransition {
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_tickAnimation)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)_tickAnimation {
    
    NSTimeInterval timeOffset = [self _timeOffset];
    NSTimeInterval tick = [_displayLink duration]*[self completionSpeed];
    timeOffset += [_transitionContext transitionWasCancelled] ? -tick : tick;
    
    if (timeOffset < 0 || timeOffset > [self duration]) {
        [self _transitionFinished];
    } else {
        [self _setTimeOffset:timeOffset];
    }
}
- (CFTimeInterval)_timeOffset {
    return [_transitionContext containerView].layer.timeOffset;
}
- (void)_transitionFinished {
    [_displayLink invalidate];
    
    CALayer *layer = [_transitionContext containerView].layer;
    layer.speed = 1;
    
    if (![_transitionContext transitionWasCancelled]) {
        CFTimeInterval pausedTime = [layer timeOffset];
        layer.timeOffset = 0.0;
        layer.beginTime = 0.0; // Need to reset to 0 to avoid flickering :S
        CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        layer.beginTime = timeSincePause;
    }
}

@end
