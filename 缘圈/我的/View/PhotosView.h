//
//  PhotosView.h
//  缘圈
//
//  Created by FangZhouZhiLian on 15-5-4.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotosViewDelegate <NSObject>
@optional
- (void)photosViewClickImageBtn:(UIButton *)btn;
- (void)photosViewRemoveImageBtn:(UIButton *)btn;
@end

@interface PhotosView : UIView
@property (nonatomic, assign) id<PhotosViewDelegate> delegate;
- (void)addImage:(UIImage *)image;
- (NSArray *)getImages;

@end
