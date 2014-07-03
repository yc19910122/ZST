//
//  WeiBo_PageViewController.h
//  Icicle
//
//  Created by User #⑨ on 13-5-16.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Choose_LineViewController.h"
#import "News_PageViewController.h"
#import "JianBao_PageViewController.h"
#import "Move_BigPicViewController.h"
@interface WeiBo_PageViewController : UIViewController<UIWebViewDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    UIWebView *WeiBo;
    NSURLConnection *connection;
}

@end
