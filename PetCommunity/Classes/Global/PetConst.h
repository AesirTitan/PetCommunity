//
//  PetConst.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-08.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

CG_EXTERN CGFloat sMargin;

CG_EXTERN CGFloat sAvatarWH;

extern CGFloat sEstimateImageHeight;

FOUNDATION_EXTERN UIFont *FontForNickName();

FOUNDATION_EXTERN UIFont *FontForFootnote();

FOUNDATION_EXTERN UIFont *FontForContentText();


FOUNDATION_EXTERN UIFont *FontWithNormalSize(CGFloat size);

FOUNDATION_EXTERN UIFont *FontWithBoldSize(CGFloat size);

FOUNDATION_EXTERN CGSize CGSizeWithTextFontMaxSize(NSString *text,UIFont *font,CGSize maxSize);
CG_EXTERN CGFloat HeightWithTextFontMaxWidth(NSString *text,UIFont *font,CGFloat maxWidth);


FOUNDATION_EXTERN UIImage *DefaultImageForCell();
FOUNDATION_EXTERN UIImage *DefaultImageForView();
FOUNDATION_EXTERN UIImage *DefaultImageForAvatar();


FOUNDATION_EXTERN NSURL *URLWithString(NSString *str);



@interface PetConst : NSObject

@end
