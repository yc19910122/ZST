//
//  JianBao_PageViewController.h
//  Icicle
//
//  Created by 讯 鹿 on 13-5-29.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "Choose_LineViewController.h"
#import "News_PageViewController.h"
#import "WeiBo_PageViewController.h"
#import "Move_BigPicViewController.h"
@interface JianBao_PageViewController : UIViewController<iCarouselDataSource,iCarouselDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIView *viewBg;
@property (nonatomic, strong) IBOutlet UIScrollView *scroll;
@property (nonatomic, strong) IBOutlet UIButton *btn;
@property (nonatomic, strong) NSArray *jianbaoArrys;
@end
