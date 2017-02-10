//
//  UserModel.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-29.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class UserTag,UserSource,UserNewest_Pet,UserAddress_Json;
@interface UserModel : RLMObject


@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *errorMsg;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) UserTag *tag;

@property (nonatomic, copy) NSString *target;


@end
@interface UserTag : RLMObject

@property (nonatomic, strong) UserSource *source;

@end

@interface UserSource : RLMObject

@property (nonatomic, assign) NSInteger fans_count;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, copy) NSString *praise_count;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *is_follow;

@property (nonatomic, assign) NSInteger follow_count;

@property (nonatomic, copy) NSString *user_ticket;

@property (nonatomic, copy) NSString *starseat;

@property (nonatomic, copy) NSString *favorite_pet;

@property (nonatomic, copy) NSString *professional;

@property (nonatomic, strong) UserAddress_Json *address_json;

@property (nonatomic, copy) NSString *explain;

@property (nonatomic, copy) NSString *often_appear;

@property (nonatomic, strong) UserNewest_Pet *newest_pet;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *interests;

@property (nonatomic, copy) NSString *raisingpets_time;

+ (instancetype)randomUser;

@end

@interface UserNewest_Pet : RLMObject

@property (nonatomic, copy) NSString *pet_id;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *image;

@end

@interface UserAddress_Json : RLMObject

@property (nonatomic, copy) NSString *district;

@property (nonatomic, copy) NSString *streetname;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *streetnumber;

@end

