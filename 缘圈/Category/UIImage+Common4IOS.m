//
//  UIImage+Common4IOS.m
//  youyouapp
//
//  Created by Yi Xu on 12-11-30.
//  Copyright (c) 2012年 CuiYiLong. All rights reserved.
//

#import "UIImage+Common4IOS.h"

@implementation UIImage (Common4IOS)



- (UIImage *)compressedImage {
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    if (width <= MAX_IMAGEPIX && height <= MAX_IMAGEPIX) {
        // no need to compress.
        return self;
    }
    
    if (width == 0 || height == 0) {
        // void zero exception
        return self;
    }
    
    UIImage *newImage = nil;
    CGFloat widthFactor = MAX_IMAGEPIX / width;
    CGFloat heightFactor = MAX_IMAGEPIX / height;
    CGFloat scaleFactor = 0.0;
    
    if (widthFactor > heightFactor)
        scaleFactor = heightFactor; // scale to fit height
    else
        scaleFactor = widthFactor; // scale to fit width
    
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    CGSize targetSize = CGSizeMake(scaledWidth, scaledHeight);
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

- (NSData *)compressedDataWithCompressionQuality:(CGFloat)compressionQuality {
    assert(compressionQuality <= 1.0 && compressionQuality >= 0);
    
    return UIImageJPEGRepresentation(self, compressionQuality);
}

- (CGFloat)compressionQuality {
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    NSUInteger dataLength = [data length];
    
    if(dataLength > MAX_IMAGEDATA_LEN) {
        return 1.0 - MAX_IMAGEDATA_LEN / dataLength;
    } else {
        return 1.0;
    }
}

- (NSData *)compressedData {
    CGFloat quality = [self compressionQuality];
    
    return [self compressedDataWithCompressionQuality:quality];
}


+(NSData *) getJPEGDataFromImage:(UIImage*) image{
    return UIImageJPEGRepresentation(image, 1.0);
}

+(NSData *) getJPEGDataFromImage:(UIImage*) image withCompressionQuality:(CGFloat) compressionQuality {
    return UIImageJPEGRepresentation(image, compressionQuality);
}

+(NSData *) getPNGDataFromImage:(UIImage*) image{
    return UIImagePNGRepresentation(image);
}

+(UIImage *) getResizeImage:(UIImage *)image toSize:(CGSize) size;
{
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

+(UIImage *) getRoundCornerImage:(UIImage*) image withPixels:(int) pixels
{
    int w = image.size.width;
    int h = image.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    addRoundedRectToPath(context, rect, pixels, pixels);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), image.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *roundCornerImage  = [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    
    return roundCornerImage;
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect,
                                 float ovalWidth,float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect),
                           CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


+(UIImage *)addToOldImage:(UIImage *)oldImage newImage:(UIImage *)newImage point:(CGPoint)point
{
    //get image width and height
    int w = oldImage.size.width;
    int h = oldImage.size.height;
    int newImageWidth = newImage.size.width;
    int newImageHeight = newImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), oldImage.CGImage);
    CGContextDrawImage(context, CGRectMake(point.x, point.y, newImageWidth, newImageHeight), [newImage CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage *waterImage  = [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    return waterImage;
    //  CGContextDrawImage(contextRef, CGRectMake(100, 50, 200, 80), [smallImg CGImage]);
}


+(UIImage *)getImageFromText:(NSString *)text withFont:(UIFont *)font{
    
    CGSize size  = [text sizeWithFont:font];
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // optional: add a shadow
    // optional: also, to avoid clipping you should make the context size bigger
    //    CGContextSetShadowWithColor(ctx, CGSizeMake(2.0, -2.0), 5.0, [color CGColor]);
    
    CGContextSetRGBFillColor(ctx, 255, 255, 255, 1);
    // draw in context
    
    CGContextSetTextDrawingMode (ctx, kCGTextFill); // 5
    [text drawAtPoint:CGPointMake(0.0, 0.0) withFont:font];
    // transfer image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)getImageFromText:(NSString *)text withFont:(UIFont *)font withColor:(UIColor *)color{
    CGSize size  = [text sizeWithFont:font];
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGColorRef colorRef = [color CGColor];
    int numComponents = CGColorGetNumberOfComponents(colorRef);
    if (numComponents >= 3){
        const CGFloat *rgbComponents = CGColorGetComponents(colorRef);
        CGContextSetRGBFillColor(ctx, rgbComponents[0], rgbComponents[1], rgbComponents[2], rgbComponents[3]);
    }
    
    CGContextSetTextDrawingMode (ctx, kCGTextFill); // 5
    [text drawAtPoint:CGPointMake(0.0, 0.0) withFont:font];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)getImageFromText:(NSString*)text inRect:(CGRect)rect withFont:(UIFont *)font
{
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetTextDrawingMode (ctx, kCGTextFill); // 5
    CGContextSetRGBFillColor(ctx, 255, 255, 255, 1);
    [text drawInRect:rect withFont:font];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)getImageFromText:(NSString *)text inRect:(CGRect)rect withFont:(UIFont *)font withColor:(UIColor *)color{
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetTextDrawingMode (ctx, kCGTextFill); // 5
    
    CGColorRef colorRef = [color CGColor];
    int numComponents = CGColorGetNumberOfComponents(colorRef);
    if (numComponents >= 3){
        const CGFloat *rgbComponents = CGColorGetComponents(colorRef);
        CGContextSetRGBFillColor(ctx, rgbComponents[0], rgbComponents[1], rgbComponents[2], rgbComponents[3]);
    }
    
    [text drawInRect:rect withFont:font];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(float)left top:(float)top
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.height*top];
}

+ (UIImage *)getImageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
