//
//  ScreenSaveType_ViewController.m
//  Icicle
//
//  Created by 讯 鹿 on 13-5-22.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "ScreenSaveType_ViewController.h"

@interface ScreenSaveType_ViewController ()

@end
@implementation ScreenSaveType_ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:213/255.0 green:216/255.0 blue:221/255.0 alpha:1];

    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(70, 50, 400, 400)style:UITableViewStyleGrouped];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundView=Nil;
    tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:tableView];
//    self.title=@"屏保类型设置";
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 30)];
    label.text=@"屏保类型设置";
    label.font = [UIFont fontWithName:@"FZLTHJW--GB1-0" size:16];
    self.navigationItem.titleView=label;
    
    array = [NSArray arrayWithObjects:@"图片",@"无屏保",nil];

}

#pragma mark UITableView -methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identy=[NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identy];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        cell.textLabel.text=[NSString stringWithFormat:@"%@",[array objectAtIndex:indexPath.row]];
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arry=[tableView visibleCells];
    for (UITableViewCell *cell in arry) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    [[tableView cellForRowAtIndexPath:indexPath]setAccessoryType:UITableViewCellAccessoryCheckmark];
    NSString *text=[tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ScreenSaveType" object:text];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
    //    self.interfaceOrientation
    
}
@end
