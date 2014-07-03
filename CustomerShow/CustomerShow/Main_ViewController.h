//
//  Main_ViewController.h
//  CustomerShow
//
//  Created by 讯 鹿 on 13-11-18.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Choose_LineViewController.h"
#import "Move_BigPicViewController.h"
#import "JianBao_PageViewController.h"
#import "News_PageViewController.h"
#import "WeiBo_PageViewController.h"
#import "DaPei_ViewController.h"
#import "companyView.h"
@interface Main_ViewController : UIViewController{
    UIViewController *currentViewController;

    Choose_LineViewController *chooseView;
    Move_BigPicViewController *videoView;
    JianBao_PageViewController *jianBaoView;
    News_PageViewController    *newsView;
    WeiBo_PageViewController *weiBoView;
    DaPei_ViewController *dapeiView;
    UIImageView *imageLogo;
    UIButton     * productBtn;
    UIButton     * videoBtn;
    UIButton     * jianBaoBtn;
    UIButton    *newsBtn;
    UIButton *dapei;
    UIButton *weiBoBtn;
    NSString *isDown;
    UIView *viewBg;
    NSArray *arryImages;
    UIImageView *image;
    BOOL Isopen;
    UIView *viewshade;
    int weizhi;
    UIImageView *imageWeiXin;
    BOOL isOpenWeiXin;
    companyView *company;
}

@end
