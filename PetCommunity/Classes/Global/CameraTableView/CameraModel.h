//
//  CellModel.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class CameraTag,CameraSource,CameraCamera,CameraAddress_Json,CameraUrl,CameraPhotoalbum,CameraUser,CameraSocial_Discuz,UserSource;

@interface CameraSocial_Discuz : RLMObject

@property (nonatomic, copy) NSString *images;

@property (nonatomic, copy) NSString *time_add;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *camera_id;

@property (nonatomic, copy) NSString *user_nickname;

@property (nonatomic, copy) NSString *discuz_id;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *pid_image;

@property (nonatomic, copy) NSString *pid_nickname;

@property (nonatomic, copy) NSString *user_image;

@property (nonatomic, copy) NSString *pid;

+ (instancetype)newItemWithUser:(UserSource *)user content:(NSString *)content;

@end
RLM_ARRAY_TYPE(CameraSocial_Discuz)

@interface CameraUser : RLMObject

@property (nonatomic, copy) NSString *explain;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger is_follow;


@end


@interface CameraPhotoalbum : RLMObject

@property (nonatomic, copy) NSString *pet_id;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *varieties;

@end


@interface CameraUrl : RLMObject

@property (nonatomic, copy) NSString *url_push;

@property (nonatomic, copy) NSString *url_hls;

@property (nonatomic, copy) NSString *url_share;

@property (nonatomic, copy) NSString *url_flv;

@property (nonatomic, copy) NSString *url_rtmp;

@property (nonatomic, copy) NSString *url_live;

@property (nonatomic, copy) NSString *url_replay;

@end

@interface CameraAddress_Json : RLMObject

@property (nonatomic, copy) NSString *district;

@property (nonatomic, copy) NSString *streetname;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *streetnumber;

@end








@interface CameraCamera : RLMObject

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *check_status;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, strong) CameraUrl *url;

@property (nonatomic, copy) NSString *favorites_count;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *share_count;

@property (nonatomic, copy) NSString *camera_id;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *discuz_count;

@property (nonatomic, copy) NSString *file_status;

@property (nonatomic, copy) NSString *type_id;

@property (nonatomic, copy) NSString *praise_count;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, strong) CameraUser *user;

@property (nonatomic, strong) CameraPhotoalbum *photoalbum;

@property (nonatomic, assign) NSInteger is_praise;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *time_add;

@property (nonatomic, copy) NSString *explain;

@property (nonatomic, copy) NSString *channel_id;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *platform_id;

@property (nonatomic, copy) NSString *view_count;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *group_id;

@property (nonatomic, copy) NSString *permission;

@property (nonatomic, copy) NSString *enjoy_count;

@property (nonatomic, copy) NSString *share_id;

@property (nonatomic, copy) NSString *heart_count;

@property (nonatomic, copy) NSString *category_id;

@property (nonatomic, strong) CameraAddress_Json *address_json;

@property (nonatomic, copy) NSString *resolution;

@end


@interface CameraSource : RLMObject

@property (nonatomic, strong) CameraCamera *camera;

@property (nonatomic, strong) RLMArray<CameraSocial_Discuz *><CameraSocial_Discuz> *social_discuz;

@end

RLM_ARRAY_TYPE(CameraSource)

@interface CameraTag : RLMObject

@property (nonatomic, copy) NSString *rowcount;

@property (nonatomic, strong) RLMArray<CameraSource *><CameraSource> *source;

@end


@interface CameraModel : RLMObject


@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *errorMsg;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) CameraTag *tag;

@property (nonatomic, copy) NSString *target;


@end