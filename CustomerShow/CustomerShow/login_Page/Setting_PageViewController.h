//
//  Setting_PageViewController.h
//  Icicle
//
//  Created by User #⑨ on 13-5-13.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenSaveAnimation_ViewController.h"
#import "ScreenSaveType_ViewController.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

@interface Setting_PageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    UITableView *table;
    MBProgressHUD  *mb;
    UIBarButtonItem *barButton;
    UIView *alterView;
    UITextField *textIP;
    UILabel *addIPText;
    NSMutableArray *IpList;
    

}
@property(nonatomic,retain)UILabel *screenSaveAnimationLabel;
@property(nonatomic,retain)UILabel *screenSaveTypeLabel;



@end
