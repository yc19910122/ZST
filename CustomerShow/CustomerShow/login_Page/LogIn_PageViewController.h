//
//  ViewController.h
//  Icicle
//
//  Created by User #⑨ on 13-5-13.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MProgressAlertView.h"
#import "DataPist.h"
#import "ASINetworkQueue.h"
@interface LogIn_PageViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UIAlertViewDelegate>
{
    UITextField *username;
    UITextField *password;
    UIButton *login;
    UIButton *setting;
    UIScrollView *scroll;
    BOOL ret;
     UIProgressView *progressView;
    UILabel *progressLabel;
    NSMutableDictionary *writedic;
    NSMutableArray *array;

    NSString *screen_id;
    NSString  *isDown;
    NSMutableDictionary *Down_array;
    MBProgressHUD  *mb;
    NSString *line_img;
    NSArray *zip_names;
    NSMutableDictionary *dics;
    NSDictionary  *leftrightImageUrl;
    NSString *update_flg;
    UIImageView *imageLogo;
    
    BOOL Flag;
    BOOL IsFail;
//    BOOL   IsOk ;
    int connectNum;
    
    
    NSArray *ImageInfoArrys;
    NSDictionary *plistDicInfo;
     NSMutableDictionary *dicUserInfo;
     NSString *lastupdate;
    BOOL isSetLastDate;
    NSArray *Keys;
    NSMutableArray *arrykeys;
    int munberImage;
    NSDictionary *weatherDic ;
//    NSString *lastupdate;
    NSDictionary *dicVersion ;
}

@property (strong, nonatomic) UITextField *username;
@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UIButton *saveBtn;
@property (strong, nonatomic) UIButton *login;
@property (strong, nonatomic) UIButton *setting;
@property (nonatomic,strong)  UILabel *progressLabel;
@property (nonatomic,strong)  UIProgressView *progressView;
@property (nonatomic, strong)NSMutableDictionary *arr;
@property (nonatomic,strong)NSString *zip_name;
@property (nonatomic, strong) ASINetworkQueue *networkQueue;
-(void)download;
@end
