//
//  PetConst.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-08.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "PetConst.h"

CGFloat sMargin = 8.0;
CGFloat sAvatarWH = 32.0;
CGFloat sEstimateImageHeight = 300.0;

inline UIFont *FontForNickName(){
    return [UIFont boldSystemFontOfSize:14];
}

inline UIFont *FontForFootnote(){
    return [UIFont systemFontOfSize:12];
}

inline UIFont *FontForContentText(){
    return [UIFont systemFontOfSize:15];
}

inline UIFont *FontWithNormalSize(CGFloat size){
    return [UIFont systemFontOfSize:size];
}

inline UIFont *FontWithBoldSize(CGFloat size){
    return [UIFont boldSystemFontOfSize:size];
}


inline CGSize CGSizeWithTextFontMaxSize(NSString *text,UIFont *font,CGSize maxSize){
    NSDictionary *dict = @{NSFontAttributeName:font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

inline CGFloat HeightWithTextFontMaxWidth(NSString *text,UIFont *font,CGFloat maxWidth){
    NSDictionary *dict = @{NSFontAttributeName:font};
    
    return [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil].size.height;
}



inline UIImage *DefaultImageForCell(){
    return [UIImage imageNamed:@"icon_defaultUser"];
}

inline UIImage *DefaultImageForView(){
    return [UIImage imageNamed:@"image_noPet"];
}

inline UIImage *DefaultImageForAvatar(){
    return [UIImage imageNamed:@"icon_defaultUser"];
}

inline NSURL *URLWithString(NSString *str){
    return [NSURL URLWithString:str];
}


@implementation PetConst

@end
