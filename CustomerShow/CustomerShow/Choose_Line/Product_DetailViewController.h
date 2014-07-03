//
//  Product_DetailViewController.h
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
@interface Product_DetailViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    UITableView *tbView;
	NSMutableArray *data;
    UIButton *btn;
    UIView *view;
    BOOL yet;
    int  m;
    int scor;
    UIView *zheZhaoview;
    NSString *code;
    NSDictionary *dic_line;
    BOOL is_Clcik;
    UIView *TanChuView;
    NSTimer *timer;
    
    
    
    NSArray *arryImages;
}
@property(strong,nonatomic)UIScrollView *scroll;
@property (nonatomic, retain)UITableView *tableData;
@property (nonatomic, retain)NSString *titleName;
@property (nonatomic, strong)NSArray *line_detailInfo;
@property (nonatomic, retain)NSString *season;
@property (nonatomic, strong)NSDictionary *line_name;
@property (nonatomic, strong)NSDictionary *dic_line;

@property (nonatomic, strong)NSArray *arryImages;
@property (nonatomic, strong)NSString *isXianLu;

@property(nonatomic)BOOL is_Clcik;


@end
