//
//  Product_ViewController.h
//  Icicle
//
//  Created by 讯 鹿 on 13-5-30.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Move_BigPicViewController.h"
#import "WeiBo_PageViewController.h"
#import "JianBao_PageViewController.h"
#import "News_PageViewController.h"
#import "Choose_LineViewController.h"
#import "Product_DetailViewController.h"
@interface Product_ViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    UIScrollView *scroll;
    NSMutableArray *imageArry;
    NSMutableArray *labelArry;
    
    UITableView *tbView;
	NSMutableArray *data;
    UIButton *btn;
    UIView *view;
    BOOL yet;
    UIView *zheZhaoview;
    int m;
    NSString *code;
    NSString *urlString;
    NSDictionary *dicLine ;
    BOOL isClick;
    UIView *TanChuView;
    NSTimer *timer;
}
@property(strong,nonatomic)UIScrollView *scroll;
@property (nonatomic, retain)UITableView *tableData;
@property (nonatomic, retain)NSString *titleName;
@property (nonatomic, retain)UIView *zheZhaoview;
@property (nonatomic, strong)NSArray *line_name;
@property (nonatomic, strong)NSString *season;

@end
