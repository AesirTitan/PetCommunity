//
//  NetworkManager.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-27.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "NetworkManager.h"

NSString *kLoginUser = @"307935";

NSString *kURLHotCamera = @"HotCamera.plist";
NSString *kURLFollowedCamera = @"FollowedCamera.plist";


inline NSString *URLWith(NSString *url){
    return [kBaseURL stringByAppendingString:url];
};


inline NSMutableDictionary *paramWithDefaultUser(){
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[kUserId] = kLoginUser;
    return dict;
};




NSMutableDictionary *ParamForCamera(){
    return paramWithDefaultUser().appendChannelId(@"").appendType(@"hot");
}



NSMutableDictionary *ParamForCameraWithPage(NSUInteger page){
    NSMutableDictionary *dict = ParamForCamera().appendPage(page);
    switch (page) {
        case 0:
        case 1: //
            dict.appendGuid(@"AF13C59E-F211-4787-926A-D74FDFFFFBFE").appendTokenCipher(@"7e0d86ce7cd7010e11fd028d2ff319dca8c9d0fc3fa868f88b42ca707715043e4c01ec83f586205dd1dfa9660401cfc97404b63f2ef348799ec22ab85702d7cb");
            break;
        case 2: //
            dict.appendGuid(@"58F8E71B-9599-4CD3-A002-D835F61507DC").appendTokenCipher(@"d4e65c34f8380b4e909b327eb0520db69c633493b38354fa1762736576cb0c3f972ed3e5d13a76691357e92bba9d4fd7e1014b3becd0b61af18ec686a81ef5b7");
            break;
        case 3: //
            dict.appendGuid(@"4A8D7E34-9F9E-41DC-8D25-84F2E7CF6289").appendTokenCipher(@"63804ea16184990103f273253eeaca1c24157aba33992a73ca1be4e18deede4aedca2b7bb4ea45e3a801ae75a4089fbafd3e8e991d6a2b5fbae1495d42c82716");
            break;
        case 4: //
            dict.appendGuid(@"83254513-5439-40CD-B8E9-816310920656").appendTokenCipher(@"c37afac5698e467c03a85c54b260a61cd0c38975e55cc63522a6760aa24bbb859ca2fb46d9edf1e63944d784863fecbd930a7c70b39b489bc30d52eaba82e725");
            break;
        default:
            break;
    }
    return dict;
}


NSMutableDictionary *ParamForFollowedCamera(){
    return paramWithDefaultUser().appendChannelId(@"").appendType(@"hot")
    .appendPage(1).appendGuid(@"D0593103-9692-4983-A42C-62C4F347F3E9").appendTokenCipher(@"b1c3261a41357aa1dcb2167226f6407c33917649c44e94a18308a1e8e381d9788e5b3457b5d2a2b40c7bd6a24567f2f36a8ed2853646e7f9bfe2eeb80f916225");
}





@implementation NetworkManager


@end

@implementation NSMutableDictionary (Param)

- (NSMutableDictionary *(^)(NSString *, NSString *))append{
    return ^(NSString *key, NSString *value){
        self[key] = value;
        return self;
    };
}

- (NSMutableDictionary *(^)(NSString *))appendChannelId{
    return ^(NSString *value){
        self[kChannelId] = value;
        return self;
    };
}

- (NSMutableDictionary *(^)(NSString *))appendGuid{
    return ^(NSString *value){
        self[kGuid] = value;
        return self;
    };
}
- (NSMutableDictionary *(^)(NSUInteger))appendPage{
    return ^(NSUInteger value){
        self[kPi] = NSStringFromNSUInteger(value);
        return self;
    };
}
- (NSMutableDictionary *(^)(NSString *))appendTokenCipher{
    return ^(NSString *value){
        self[kTokenCipher] = value;
        return self;
    };
}
- (NSMutableDictionary *(^)(NSString *))appendType{
    return ^(NSString *value){
        self[kType] = value;
        return self;
    };
}


@end
