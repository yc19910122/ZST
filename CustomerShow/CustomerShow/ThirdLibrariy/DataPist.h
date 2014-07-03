//
//  DataPist.h
//  Icicle
//
//  Created by 讯 鹿 on 13-6-17.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DataPist : NSObject{
    NSMutableArray *plistInfo;
    NSArray *plistKeys;
    NSString *username;
    NSArray *titleArry;
    NSArray *companyInfo;
    NSArray  *arryLeft;
    NSArray *arryRight;
    NSString *leftOrright;
    NSString *isCurrent;
}
@property(nonatomic,strong)NSMutableArray *plistInfo;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSArray *plistKeys;
@property(nonatomic,strong)NSArray *titleArry;
@property(nonatomic,strong)NSArray *companyInfo;
@property(nonatomic,strong)NSArray *arryLeft;
@property(nonatomic,strong)NSArray *arryRight;
@property(nonatomic,strong)NSString *leftOrright;
@property(nonatomic,strong)NSString *isCurrent;

@property(nonatomic,strong)NSArray *jianBaoArry;
@property(nonatomic,strong)NSString *ipString;
+(DataPist *) shared;
+(id) allocWithZone:(NSZone *)zone;
+(void)showLoading;
+(void)hideLoading;
+ (NSString *)getFilePath:(NSString *)imageName;
+(NSMutableArray *)readPlist:(NSString *)plistName;
@end
