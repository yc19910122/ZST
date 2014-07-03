//
//  Ip_ViewController.h
//  CustomerShow
//
//  Created by 讯 鹿 on 13-11-13.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ip_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *array;
    
}
@property(nonatomic,strong)NSMutableArray *array;
@end
