//
//  AWPercentDrivenInteractiveTransition.h
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

#import <UIKit/UIKit.h>

/**
 A drop-in replacement for UIPercentDrivenInteractiveTransition
 for use in custom container view controllers
 
 @see UIPercentDrivenInteractiveTransition
 */
@interface AWPercentDrivenInteractiveTransition : NSObject <UIViewControllerInteractiveTransitioning>

- (instancetype)initWithAnimator:(id<UIViewControllerAnimatedTransitioning>)animator;

@property (nonatomic, readonly) CGFloat duration;
@property (readonly) CGFloat percentComplete;

/**
 The animated transitioning that this percent driven interaction should control.
 This property must be set prior to the start of a transition.
 */
@property (nonatomic, weak) id<UIViewControllerAnimatedTransitioning>animator;

@property (nonatomic) CGFloat completionSpeed; // Defaults to 1
@property (nonatomic, readonly) UIViewAnimationCurve animationCurve; // Unused, returns UIViewAnimationCurveLinear

- (void)updateInteractiveTransition:(CGFloat)percentComplete;
- (void)cancelInteractiveTransition;
- (void)finishInteractiveTransition;

@end
