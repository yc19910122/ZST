//
//  News_PageViewController.h
//  Icicle
//
//  Created by 讯 鹿 on 13-5-29.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Choose_LineViewController.h"
#import "WeiBo_PageViewController.h"
#import "JianBao_PageViewController.h"
#import "Move_BigPicViewController.h"
#import "NewsDetail_ViewController.h"
@interface News_PageViewController : UIViewController<UIScrollViewDelegate>{
     NSMutableArray *newsArry;
    int tag;
}
@property(nonatomic,strong)UIScrollView *scroll;

@end
