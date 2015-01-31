# AWPercentDrivenInteractiveTransition

`AWPercentDrivenInteractiveTransition` is a drop-in replacement for `UIPercentDrivenInteractiveTransition` for use in custom container view controllers.

Why do you need it? Because Apples own `UIPercentDrivenInteractiveTransition` calls undocumented methods on your custom `UIViewControllerContextTransitioning` objects.

Note that this class can be used with UIKits standard container view controllers such as `UINavigationController`, `UITabBarController` and also for presenting modal view controllers.

## Status
0.2.0 - Added support for changing `completionSpeed`
0.1.0 - Basic functionality implemented, usable for a majority of cases

### Unimplemented features
* ~~`completionSpeed` can't be changed from 1.0~~ (fixed in 0.2.0)
* `completionCurve` can't be changed from `UIViewAnimationCurveLinear`
* No support for `UIViewControllerTransitionCoordinator` (for animating other views along transition)

## Installation

### Cocoapods
[CocoaPods](http://cocoapods.org) is the recommended way to add AWPercentDrivenInteractiveTransition to your project.

1. Add a pod entry for AWPercentDrivenInteractiveTransition to your Podfile `pod 'AWPercentDrivenInteractiveTransition', '~> 0.1'`
2. Install the pod(s) by running `pod install`.
3. Include AWPercentDrivenInteractiveTransition wherever you need it with `#import "AWPercentDrivenInteractiveTransition.h"`.

### Source files

Alternatively you can directly add the `AWPercentDrivenInteractiveTransition.h` and `AWPercentDrivenInteractiveTransition.m` source files to your project.

1. Download the [latest code version](https://github.com/MrAlek/AWPercentDrivenInteractiveTransition/archive/master.zip) or add the repository as a git submodule to your git-tracked project.
2. Open your project in Xcode, then drag and drop `AWPercentDrivenInteractiveTransition.h` and `AWPercentDrivenInteractiveTransition.m` onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project.
3. Include AWPercentDrivenInteractiveTransition wherever you need it with `#import "AWPercentDrivenInteractiveTransition.m"`.

### Static library

If you don't want to compile my code all the time, there's an XCode project in the `lib` folder which generates a static `libAWPercentDrivenInteractiveTransition.a` library file you can include in your project. Just remember to include the original `LICENCE` file in your source code.

## Usage

Use as you would do with a regular `UIPercentDrivenInteractiveTransition`. Either by letting your custom interaction controller subclass `AWPercentDrivenInteractiveTransition` or by having an instance and manually call the `updateInteractiveTransition:`, `cancelInteractiveTransition` and `finishInteractiveTransition` methods.

The only difference is that **you need to set the `animator` property** with a `UIViewControllerAnimatedTransitioning` object before starting an interactive transition.

This is what the standard `UIPercentDrivenInteractiveTransition` does by calling private methods on your `UIViewControllerContextTransitioning` object.

There's also a convinience initializer called `initWithAnimator:` that sets the animator property directly.


## Demo

If you wanna se a demo of this drop-in replacement class in action, check out my blog post on [Interactive Custom Container View Controller Transitions](http://www.iosnomad.com/blog/2014/5/12/interactive-custom-container-view-controller-transitions).

## Licence

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
