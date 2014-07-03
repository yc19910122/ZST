//
//  DataPist.m
//  Icicle
//
//  Created by 讯 鹿 on 13-6-17.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "DataPist.h"
NSString * const KEY_USERNAME_PASSWORD = @"com.company.app.udid";
NSString * const KEY_USERNAME = @"com.company.app.udid";
@implementation DataPist
@synthesize plistInfo,jianBaoArry,ipString,plistKeys,username,titleArry,companyInfo,arryRight,arryLeft,leftOrright,isCurrent;
static DataPist *ShareDataPist = nil;

+(DataPist *) shared{
    
    @synchronized(self)
    {
        if (ShareDataPist == nil)
        {
            ShareDataPist = [[self alloc] init] ;
            
        }
    }
    return ShareDataPist;
}

+(id) allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (ShareDataPist == nil)
        {
            ShareDataPist = [super allocWithZone:zone];            
            return ShareDataPist;
        }
    }  
    return nil;
}

+(void)showLoading{
       [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows objectAtIndex:0] animated:YES];
}
+(void)hideLoading{
    [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].windows objectAtIndex:0] animated:YES];
}
+ (NSString *)getFilePath:(NSString *)imageName{
    //写入library
    NSString *name=[NSString stringWithFormat:@"Documents/%@",imageName];
    NSString *pathName=[NSHomeDirectory() stringByAppendingPathComponent:name];
    
//    NSString *pathNext = [NSString stringWithFormat:@"%@/Caches",path];
//    NSString *fileNamepath=[path stringByAppendingPathComponent:];
    return pathName;
}

#pragma mark writee plist
+(NSArray *)readPlist:(NSString *)plistName{
    
    NSString *stringName=[NSString stringWithFormat:@"Library/%@",plistName];
    NSString *filePath=[NSHomeDirectory() stringByAppendingPathComponent:stringName];
    NSMutableArray *dic=[[NSMutableArray alloc]initWithContentsOfFile:filePath];
    return dic;
}


@end
