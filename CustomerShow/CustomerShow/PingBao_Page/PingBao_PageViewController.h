//
//  Pic_PageViewController.h
//  Icicle
//
//  Created by 讯 鹿 on 13-5-28.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTransitionImageView.h"

@interface PingBao_PageViewController : UIViewController{
    LTransitionImageView *_transitionImageView;
    int flag;
    BOOL Flag;
    NSTimer *timer;
}
@property(nonatomic,strong)NSMutableArray *pingBaoArrys;
@end
