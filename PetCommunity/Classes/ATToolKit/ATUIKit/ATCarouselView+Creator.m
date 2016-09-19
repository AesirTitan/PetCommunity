//
//  ATCarouselView+Creator.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-27.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATCarouselView+Creator.h"
#import "UIImageView+WebCache.h"

@implementation ATCarouselView (Creator)


+ (instancetype)carouselWithView:(UIView *)view imageURLs:(NSArray<NSString *> *)imageURLs titles:(NSArray<NSString *> *)titles action:(void (^)(NSUInteger index))action {
    return [ATCarouselView carouselWithView:view count:imageURLs.count image:^(UIImageView *imageView, NSUInteger index) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageURLs[index]]];
    } title:^NSString *(NSUInteger index) {
        return titles[index];
    } indicator:^(UIPageControl *indicator) {
        
    } timeout:5 action:action];
}



@end
