//
//  PhotosView.m
//  缘圈
//
//  Created by FangZhouZhiLian on 15-5-4.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import "PhotosView.h"

@implementation PhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
    }
    return self;
}

- (void)addImage:(UIImage *)image
{
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.image = image;
//    [self addSubview:imageView];
    UIButton *imageBtn = [[UIButton alloc] init];
    [imageBtn setImage:image forState:UIControlStateNormal];
    [self addSubview:imageBtn];
}

- (void)layoutSubviews
{
    CGFloat imageX      = 0;
    CGFloat imageY      = 0;
    CGFloat imageWH     = 70;
    int maxColumns = 4;
    CGFloat imageMargin =  (self.frame.size.width - maxColumns * imageWH) / (maxColumns +1);
    
    for(int i=0; i<self.subviews.count; i++)
    {
        UIButton *btn = (UIButton *)self.subviews[i];
        imageX = imageMargin + (i % maxColumns) * (imageWH + imageMargin);
        imageY = (i / maxColumns) * (imageWH + imageMargin);
        [btn setFrame:CGRectMake(imageX, imageY, imageWH, imageWH)];
        [btn setTag:i];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
}

- (NSArray *)getImages
{
    NSMutableArray *mutableArray = [NSMutableArray array];
//    for(UIImageView *imageView in self.subviews)
//    {
//        //上传需要的是UIImage 而不是UIImageView
//        [mutableArray addObject:imageView.image];
//    }
    for(UIButton *imageBtn in self.subviews)
    {
        //上传需要的是UIImage 而不是UIImageView
        [mutableArray addObject:imageBtn.imageView.image];
    }
    
    return mutableArray;
}

- (void)clickBtn:(UIButton *)btn
{
    if([self.delegate respondsToSelector:@selector(photosViewClickImageBtn:)])
    {
        [self.delegate photosViewClickImageBtn:btn];
    }
}
@end
