//
//  UIImage+Extension.m
//  DianYinTai
//
//  Created by Leo on 2017/5/14.
//  Copyright © 2017年 A2Live. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (UIImage *)resizablewith:(NSString *)imgname{
    UIImage *normal = [UIImage imageNamed:imgname];
    CGFloat x = normal.size.width/2;
    CGFloat y = normal.size.height/2;
    NSLog(@"hahaha");
    NSLog(@"test again");
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(y, x, y, x)];
    
}

+ (UIImage*)imageWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [[UIColor clearColor] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGFloat lengths[] = { 3, 1 };
    CGContextSetLineDash(context, 0, lengths, 1);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, size.width, 0.0);
    CGContextAddLineToPoint(context, size.width, size.height);
    CGContextAddLineToPoint(context, 0, size.height);
    CGContextAddLineToPoint(context, 0.0, 0.0);
    CGContextStrokePath(context);
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)imageFromContextWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect=(CGRect){{0.0f,0.0f},size};
    //开启一个图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    //获取图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    //获取图像
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageCornerRadiusWith:(UIImage *)image size:(CGSize)size{
    UIGraphicsBeginImageContext(image.size);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    [path addClip];
    [image drawAtPoint:CGPointZero];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageFromContextWithColor:(UIColor *)color Alpha:(CGFloat)alpha{
    UIImage *colorImage = [self imageFromContextWithColor:color];
    return [self imageByApplyingAlpha:alpha image:colorImage];
}

+ (UIImage *)imageFromContextWithColor:(UIColor *)color{
    CGSize size=CGSizeMake(1.0f, 1.0f);
    return [self imageFromContextWithColor:color size:size];
}

+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(UIImage*)image{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)compressImage:(UIImage *)image
             compressRatio:(CGFloat)ratio{
    return [[self class] compressImage:image compressRatio:ratio maxCompressRatio:0.1f];
}

+ (UIImage *)compressImage:(UIImage *)image compressRatio:(CGFloat)ratio maxCompressRatio:(CGFloat)maxRatio{
    
    //We define the max and min resolutions to shrink to
    int MIN_UPLOAD_RESOLUTION = 960 * 375;
    int MAX_UPLOAD_SIZE = 300*300;
    
    float factor;
    float currentResolution = image.size.height * image.size.width;
    
    //We first shrink the image a little bit in order to compress it a little bit more
    if (currentResolution > MIN_UPLOAD_RESOLUTION) {
        factor = sqrt(currentResolution / MIN_UPLOAD_RESOLUTION) * 2;
        image = [self scaleDown:image withSize:CGSizeMake(image.size.width / factor, image.size.height / factor)];
    }
    
    //Compression settings
    CGFloat compression = ratio;
    CGFloat maxCompression = maxRatio;
    
    //We loop into the image data to compress accordingly to the compression ratio
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > MAX_UPLOAD_SIZE && compression > maxCompression) {
        compression -= 0.10;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    //Retuns the compressed image
    return [[UIImage alloc] initWithData:imageData];
}


+ (UIImage *)compressRemoteImage:(NSString *)url
                   compressRatio:(CGFloat)ratio
                maxCompressRatio:(CGFloat)maxRatio{
    //Parse the URL
    NSURL *imageURL = [NSURL URLWithString:url];
    
    //We init the image with the rmeote data
    UIImage *remoteImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
    
    //Returns the remote image compressed
    return [[self class] compressImage:remoteImage compressRatio:ratio maxCompressRatio:maxRatio];
}

+ (UIImage *)compressRemoteImage:(NSString *)url compressRatio:(CGFloat)ratio{
    return [[self class] compressRemoteImage:url compressRatio:ratio maxCompressRatio:0.1f];
}

+ (UIImage*)scaleDown:(UIImage*)image withSize:(CGSize)newSize{
    //We prepare a bitmap with the new size
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);
    //Draws a rect for the image
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    //We set the scaled image from the context
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)compressToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    CGRect rect = {{0,0}, size};
    [self drawInRect:rect];
    UIImage *compressedImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return compressedImg;
}

@end
