//
//  prdouct_BigImageViewController.h
//  Icicle
//
//  Created by 讯 鹿 on 13-5-30.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRZoomScrollView.h"
@interface prdouct_ImagePageViewController : UIViewController<UIGestureRecognizerDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>{
    CGFloat lastScale;
    UIScrollView *scroll;
    UIScrollView *scrollOne;

    UIButton *btn;
    BOOL  ret;
    UIImageView *imageLogo;
    int scor;
//    UILabel   *left;
//    UILabel *right;
    UIView *infoView;
    int currentNum;
    int  n;
    BOOL isHave;
    int tags;
    UIImageView  *bigImage;
     CGFloat offset;
    BOOL flag;
    UIImageView *imageView;
    UIImageView *BigView;

}
@property(nonatomic,strong)UIImageView *iamge;
@property(nonatomic,strong)UIImageView *iamgeOne;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)NSDictionary *image_info;
@property(nonatomic,strong)NSString *image_Name;
@property(nonatomic,strong)NSArray *imageArrys;
@property(nonatomic,strong)UIView *infoView;
@property (nonatomic)int currentNum;
@property (nonatomic, retain) MRZoomScrollView  *zoomScrollView;

@end
