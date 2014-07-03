//
//  Choose_LineViewController.h
//  Icicle
//
//  Created by User #⑨ on 13-5-13.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Move_BigPicViewController.h"
#import "WeiBo_PageViewController.h"
#import "JianBao_PageViewController.h"
#import "News_PageViewController.h"
#import "ProdouctView.h"
@interface Choose_LineViewController : UIViewController{
    NSString *post;
    NSString *season;
    NSMutableDictionary     *dics ;
    NSString *left_img;
    NSString *right_img;
    NSDictionary *image_letforRight;
    ProdouctView *proView;
    
}
@property(nonatomic,strong)NSDictionary *image_letforRight;
@property(nonatomic,strong)ProdouctView *proView;

@end
