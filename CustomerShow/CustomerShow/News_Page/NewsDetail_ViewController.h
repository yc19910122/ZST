//
//  NewsDetail_ViewController.h
//  Icicle
//
//  Created by 讯 鹿 on 13-7-9.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Choose_LineViewController.h"
#import "WeiBo_PageViewController.h"
#import "JianBao_PageViewController.h"
#import "Move_BigPicViewController.h"
#import "NewsDetail_ViewController.h"
@interface NewsDetail_ViewController : UIViewController<UIScrollViewDelegate,UITextViewDelegate>
{
    float weizhi;
}
@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong)NSDictionary *contentDic;
@end
