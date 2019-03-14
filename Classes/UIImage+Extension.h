//
//  UIImage+Extension.h
//  DianYinTai
//
//  Created by Leo on 2017/5/14.
//  Copyright © 2017年 A2Live. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
//从中心点拉伸一张图片
+ (UIImage *)resizablewith:(NSString *)imgname;
//绘制边框线
+ (UIImage*)imageWithSize:(CGSize)size
              borderColor:(UIColor *)color
              borderWidth:(CGFloat)borderWidth;
//返回一张纯色图片
+(UIImage *)imageFromContextWithColor:(UIColor *)color;
+(UIImage *)imageFromContextWithColor:(UIColor *)color
                                 size:(CGSize)size;
+(UIImage *)imageCornerRadiusWith:(UIImage *)image
                             size:(CGSize)size;
+(UIImage *)imageFromContextWithColor:(UIColor *)color
                                Alpha:(CGFloat)alpha;

+ (UIImage *)compressImage:(UIImage *)image
             compressRatio:(CGFloat)ratio;

+ (UIImage *)compressImage:(UIImage *)image
             compressRatio:(CGFloat)ratio
          maxCompressRatio:(CGFloat)maxRatio;

+ (UIImage *)compressRemoteImage:(NSString *)url
                   compressRatio:(CGFloat)ratio;

+ (UIImage *)compressRemoteImage:(NSString *)url
                   compressRatio:(CGFloat)ratio
                maxCompressRatio:(CGFloat)maxRatio;

- (UIImage *)compressToSize:(CGSize)size;
@end
