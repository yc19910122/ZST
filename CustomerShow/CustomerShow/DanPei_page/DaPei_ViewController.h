//
//  DaPei_ViewController.h
//  CustomerShow
//
//  Created by 讯 鹿 on 13-12-6.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaPei_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableLeft;
    UITableView *tableRight;
    UIView *viewBg;
    NSArray *arryLeft;
    NSArray *arryRight;
}

@end
