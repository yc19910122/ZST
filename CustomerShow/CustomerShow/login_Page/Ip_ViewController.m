//
//  Ip_ViewController.m
//  CustomerShow
//
//  Created by 讯 鹿 on 13-11-13.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "Ip_ViewController.h"

@interface Ip_ViewController ()

@end

@implementation Ip_ViewController
@synthesize array;
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
    
    
//    array = [NSArray arrayWithObjects:@"图片",@"无屏保",nil];
	// Do any additional setup after loading the view.
}

#pragma mark UITableView -methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identy=[NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identy];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        cell.textLabel.text=[array objectAtIndex:indexPath.row];
        
        UILabel  *label=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, 300, 30)];
        label.backgroundColor=[UIColor whiteColor];
        label.text=[array objectAtIndex:indexPath.row];

    }
    NSLog(@"9-----$%@",array);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arry=[tableView visibleCells];
    for (UITableViewCell *cell in arry) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    [[tableView cellForRowAtIndexPath:indexPath]setAccessoryType:UITableViewCellAccessoryCheckmark];
    NSString *text=[tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"IPSet" object:text];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
