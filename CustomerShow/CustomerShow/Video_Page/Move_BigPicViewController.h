//
//  Move_BigPicViewController.h
//  Icicle
//
//  Created by 讯 鹿 on 13-5-23.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Choose_LineViewController.h"
#import "WeiBo_PageViewController.h"
#import "JianBao_PageViewController.h"
#import "News_PageViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
@interface Move_BigPicViewController : UIViewController{
    
    UIScrollView *scrollLeft;
    UIImageView *alphaView;
    NSArray *arryImageInfo;
    
    UIImageView *BigView;
    UIImageView *imageView;
    UIScrollView *scroll;
    int n;
    MPMoviePlayerController *MovieView;
    ASINetworkQueue *networkQueue;
    MBProgressHUD *hub;
    NSMutableData *DataAll;
//    NSString *stringByte;
//    NSMutableData *dataBytes;
    int byteall;
    NSString *movieName;
    UILabel *LoadLabel;
    NSString *isDown;
    UIView  *TanChuView;
    NSMutableDictionary *dicBtnIS;
}
@property(nonatomic,strong)MPMoviePlayerController *MovieView;
@property(nonatomic,strong)NSString *isDown;
@end
