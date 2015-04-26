//
//  NSObject+Common4IOS_Animation.h
//  缘圈
//
//  Created by 徐 阳 on 15/4/25.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^AnimationBlock)();

typedef void (^AnimationCompletionBlock)(BOOL finished);

@interface NSObject (Common4IOS_Animation)
//旋转X轴
+ (id)rotateXFromValue:(float)fromValue toValue:(float)toValue duration:(float)duration;
//旋转Y轴
+ (id)rotateYFromValue:(float)fromValue toValue:(float)toValue duration:(float)duration;
//旋转Z轴
+ (id)rotateZFromValue:(float)fromValue toValue:(float)toValue duration:(float)duration;

//透明度
+ (void) doAnimationForView:(UIView *) view toAlpha:(float) toAlpha duration:(float) duration;

//透明度
+ (void) doAnimationForView:(UIView *) view fromAlpha:(float) fromAlpha toAlpha:(float) toAlpha duration:(float) duration;

//位移
+ (void) doAnimationForView:(UIView *) view toX:(float) toX duration:(float) duration;

//位移
+ (void) doAnimationForView:(UIView *) view fromX:(float) fromX toX:(float) toX duration:(float) duration;
//位移
+ (void) doAnimationForView:(UIView *) view toPoint:(CGPoint) toPoint duration:(float) duration;

//位移
+ (void) doAnimationForView:(UIView *) view fromPoint:(CGPoint) fromPoint toPoint:(CGPoint) toPoint duration:(float) duration;

//缩放/变形
+(void) doAnimationForView:(UIView *)view toSize:(CGSize) toSize duration:(float) duration;

//缩放/变形
+(void) doAnimationForView:(UIView *)view fromSize:(CGSize) fromSize toSize:(CGSize) toSize duration:(float) duration;

//自定义
+(void) doAnimationForView:(UIView *) view duration:(float) duration AnimationBlock:(AnimationBlock)AnimationBlock AnimationCompletionBlock:(AnimationCompletionBlock)AnimationCompletionBlock;

@end
