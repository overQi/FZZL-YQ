//
//  NSObject+Common4IOS_Animation.m
//  缘圈
//
//  Created by 徐 阳 on 15/4/25.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "NSObject+Common4IOS_Animation.h"

@implementation NSObject (Common4IOS_Animation)

+ (id)rotateXFromValue:(float)fromValue toValue:(float)toValue duration:(float)duration{
	
	CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
	rotationAnimation.fromValue = [NSNumber numberWithInt:fromValue];
	rotationAnimation.toValue = [NSNumber numberWithInt:toValue];
	rotationAnimation.duration = duration;
	rotationAnimation.fillMode=kCAFillModeForwards;
	rotationAnimation.removedOnCompletion = NO;
	//动画旋转完毕，需要将view 的transform重新设置一下。
	//    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	return rotationAnimation;
	
	//  [NSNumber numberWithFloat:(2 * M_PI) * direction];
	
	//	[logoLayer addAnimation:rotationAnimation forKey:@"rotateAnimation"];
	
}

+ (id)rotateYFromValue:(float)fromValue toValue:(float)toValue duration:(float)duration{
	
	CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
	rotationAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
	rotationAnimation.toValue = [NSNumber numberWithFloat:toValue];
	rotationAnimation.duration = duration;
	rotationAnimation.fillMode=kCAFillModeForwards;
	rotationAnimation.removedOnCompletion = NO;
	return rotationAnimation;
	
}

+ (id)rotateZFromValue:(float)fromValue toValue:(float)toValue duration:(float)duration{
	
	CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	rotationAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
	rotationAnimation.toValue = [NSNumber numberWithFloat:toValue];
	rotationAnimation.duration = duration;
	rotationAnimation.fillMode=kCAFillModeForwards;
	rotationAnimation.removedOnCompletion = NO;
	return rotationAnimation;
	
}

+ (void) doAnimationForView:(UIView *) view toAlpha:(float) toAlpha duration:(float) duration{
	
	[UIView animateWithDuration:duration animations:^{
		view.alpha = toAlpha;
	} completion:^(BOOL finished) {
		
	}];
}

+ (void) doAnimationForView:(UIView *) view fromAlpha:(float) fromAlpha toAlpha:(float) toAlpha duration:(float) duration{
	
	view.alpha = fromAlpha;
	
	[UIView animateWithDuration:duration animations:^{
		view.alpha = toAlpha;
	} completion:^(BOOL finished) {
		
	}];
}

+ (void) doAnimationForView:(UIView *) view toPoint:(CGPoint) toPoint duration:(float) duration{
	
	[UIView animateWithDuration:duration animations:^{
		view.frame = CGRectMake(toPoint.x, toPoint.y,view.frame.size.width,view.frame.size.height);
	} completion:^(BOOL finished) {
		
	}];
}

+ (void) doAnimationForView:(UIView *) view toX:(float) toX duration:(float) duration{
	
	[UIView animateWithDuration:duration animations:^{
		view.center = CGPointMake(toX, view.center.y);
	} completion:^(BOOL finished) {
		
	}];
	
}

+ (void) doAnimationForView:(UIView *) view fromX:(float) fromX toX:(float) toX duration:(float) duration{
	
	view.center = CGPointMake(fromX, view.center.y);
	
	[UIView animateWithDuration:duration animations:^{
		view.center = CGPointMake(toX, view.center.y);
	} completion:^(BOOL finished) {
		
	}];
	
}

+ (void) doAnimationForView:(UIView *) view fromPoint:(CGPoint) fromPoint toPoint:(CGPoint) toPoint duration:(float) duration{
	
	view.frame = CGRectMake(fromPoint.x, fromPoint.y,view.frame.size.width,view.frame.size.height);
	
	[UIView animateWithDuration:duration animations:^{
		view.frame = CGRectMake(toPoint.x, toPoint.y,view.frame.size.width,view.frame.size.height);
	} completion:^(BOOL finished) {
		
	}];
}

+(void) doAnimationForView:(UIView *)view toSize:(CGSize) toSize duration:(float) duration{
	
	[UIView animateWithDuration:duration animations:^{
		view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, toSize.width, toSize.height);
	} completion:^(BOOL finished) {
		
	}];
}

+(void) doAnimationForView:(UIView *)view fromSize:(CGSize) fromSize toSize:(CGSize) toSize duration:(float) duration{
	view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, fromSize.width, fromSize.height);
	[UIView animateWithDuration:duration animations:^{
		view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, toSize.width, toSize.height);
	} completion:^(BOOL finished) {
		
	}];
}

+(void) doAnimationForView:(UIView *) view duration:(float) duration AnimationBlock:(AnimationBlock)AnimationBlock AnimationCompletionBlock:(AnimationCompletionBlock)AnimationCompletionBlock{
	[UIView animateWithDuration:duration animations:^{
		AnimationBlock();
	} completion:^(BOOL finished) {
		AnimationCompletionBlock(finished);
	}];
	
}

@end
