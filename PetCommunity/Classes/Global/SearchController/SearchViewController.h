//
//  SearchViewController.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-31.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATBaseViewController.h"

@interface SearchViewController : ATBaseViewController

typedef NS_ENUM(NSUInteger, SearchType){
    SearchTypeCamera,
    SearchTypeUser,
    SearchTypePet,
};

// search type
@property (assign, nonatomic) SearchType searchType;

@end
