//
//  ProdouctView.h
//  CustomerShow
//
//  Created by 讯 鹿 on 13-11-18.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProdouctDetailView.h"
@interface ProdouctView : UIView<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
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
    ProdouctDetailView *product_Detail;
    int a;
}
@property(strong,nonatomic)UIScrollView *scroll;
@property (nonatomic, retain)UITableView *tableData;
@property (nonatomic, retain)NSString *titleName;
@property (nonatomic, retain)UIView *zheZhaoview;
@property (nonatomic, strong)NSArray *line_name;
@property (nonatomic, strong)NSString *season;
-(void)loadView;


@end
