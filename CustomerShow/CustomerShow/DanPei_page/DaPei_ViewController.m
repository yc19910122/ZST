//
//  DaPei_ViewController.m
//  CustomerShow
//
//  Created by 讯 鹿 on 13-12-6.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "DaPei_ViewController.h"

@interface DaPei_ViewController ()

@end

@implementation DaPei_ViewController

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
    [DataPist shared].arryLeft=[[NSMutableArray alloc]init];
    [DataPist shared].arryRight=[[NSMutableArray alloc]init];
    [DataPist shared].arryLeft=[DataPist readPlist:[NSString stringWithFormat:@"%@_%@.plist",[DataPist shared].username,[[DataPist shared].plistKeys objectAtIndex:8]]];
     [DataPist shared].arryRight=[DataPist readPlist:[NSString stringWithFormat:@"%@_%@.plist",[DataPist shared].username,[[DataPist shared].plistKeys objectAtIndex:9]]];
    self.view.backgroundColor=[UIColor clearColor];
    self.view.frame=CGRectMake(0, 0, 1024, 768);

    
    UIView *viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024/2-5, 768)];
    viewLeft.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:viewLeft];
    
    
    
    UIView *viewRight=[[UIView alloc]initWithFrame:CGRectMake(521, 0, 1024/2, 768)];
    viewRight.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:viewRight];
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(1024/2-4, 0, 8, 768)];
    image.image=[UIImage imageNamed:@"shu.png"];
    [self.view addSubview:image];
    
    UILabel *labelLeft=[[UILabel alloc]initWithFrame:CGRectMake(30, 10, 200, 50)];
   labelLeft.text=@"搭配建议";
    labelLeft.font=[UIFont boldSystemFontOfSize:20];
    [viewLeft addSubview:labelLeft];
    
    UILabel *labelRight=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 50)];
    labelRight.text=@"兴趣知识";
    labelRight.font=[UIFont boldSystemFontOfSize:20];
    [viewRight addSubview:labelRight];
    
    
    tableLeft=[[UITableView alloc]initWithFrame:CGRectMake(10, 70, 497, 600)style:0];
    tableLeft.delegate=self;
    tableLeft.dataSource=self;
    tableLeft.backgroundColor=[UIColor clearColor];
    tableLeft.backgroundView=Nil;
    [tableLeft setSeparatorStyle:0];
    [viewLeft addSubview:tableLeft];
    
    tableRight=[[UITableView alloc]initWithFrame:CGRectMake(10, 70, 497, 600) style:0];
    tableRight.delegate=self;
    tableRight.dataSource=self;
   [ tableRight setSeparatorStyle:0];
    tableLeft.backgroundColor=[UIColor clearColor];
    [viewRight addSubview:tableRight];
    
    
    
    
}
#pragma mark -UITabeView
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
  
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int page;
    if (tableView==tableLeft) {
        page=[DataPist shared].arryLeft.count;
    }else {
        page=[DataPist shared].arryRight.count;
    }
    return page;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 156.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (tableView==tableLeft) {
        NSString *cellString=[NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (cell==Nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellString];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UIImageView *leftImage=[[UIImageView alloc]initWithFrame:CGRectMake(30, 28, 100, 100)];
            NSString *name=[NSString stringWithFormat:@"s_%@",[[[[DataPist shared].arryLeft objectAtIndex:indexPath.row]objectForKey:@"images"] objectAtIndex:0]];
            NSLog(@"---%@",name);
            NSData *Data=[NSData dataWithContentsOfFile:[DataPist getFilePath:name]];
            
            UIImage *IMage=[UIImage imageWithData:Data];
            if (IMage.size.height>=100) {
                leftImage.frame=CGRectMake(30, 28, 100/IMage.size.height*IMage.size.width, 100);
            }else{
                leftImage.frame=CGRectMake(30, 28, IMage.size.width, 100);

            }
            
//            if (Image.size.width>=517) {
//                viewshade.frame=CGRectMake(400/2+45, 154+15, 517+10, 517/Image.size.width*Image.size.height+10);
//                image.frame=CGRectMake(400/2+50, 154+20, 517+10, 517/Image.size.width*Image.size.height+10);
//            }else{
//                viewshade.frame=CGRectMake(400/2+45+100, 154+15, Image.size.width+10, Image.size.height+10);
//                image.frame=CGRectMake(400/2+50+100, 154+20, Image.size.width, Image.size.height);
//                
//            }
            
            
            
            
            leftImage.image=[UIImage imageWithContentsOfFile:[DataPist getFilePath:name]];
            [cell addSubview:leftImage];
            
            UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(140, 28, 300, 30)];
            labelTitle.font=[UIFont systemFontOfSize:20];
            labelTitle.text=[NSString stringWithFormat:@"%@",[[[DataPist shared].arryLeft objectAtIndex:indexPath.row] objectForKey:@"title"]];
            labelTitle.backgroundColor=[UIColor clearColor];
            [cell addSubview:labelTitle];
            
            UILabel *labelDetail=[[UILabel alloc]initWithFrame:CGRectMake(140, 60, 300, 70)];
            labelDetail.font=[UIFont systemFontOfSize:18];
            labelDetail.numberOfLines=0;
            labelDetail.text=[NSString stringWithFormat:@"%@",[[[DataPist shared].arryLeft objectAtIndex:indexPath.row] objectForKey:@"content"]];
            labelDetail.backgroundColor=[UIColor clearColor];
            [cell addSubview:labelDetail];
             labelDetail.userInteractionEnabled=NO;
            UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(30, 150, 400, 2)];
            image.image=[UIImage imageNamed:@"line.png"];
            [cell addSubview:image];
            
        }
        return cell;
    }else {
        NSString *cellString=[NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (cell==Nil) {
            
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellString];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UIImageView *rightImage=[[UIImageView alloc]initWithFrame:CGRectMake(30, 28, 100, 100)];
            NSString *name=[NSString stringWithFormat:@"s_%@",[[[[DataPist shared].arryRight objectAtIndex:indexPath.row]objectForKey:@"images"] objectAtIndex:0]];
            
            
            NSData *Data=[NSData dataWithContentsOfFile:[DataPist getFilePath:name]];
            
            UIImage *IMage=[UIImage imageWithData:Data];
            if (IMage.size.height>=100) {
                rightImage.frame=CGRectMake(30, 28, 100/IMage.size.height*IMage.size.width, 100);
            }else{
                rightImage.frame=CGRectMake(30, 28, IMage.size.width, 100);
            }
            
            
            rightImage.image=[UIImage imageWithContentsOfFile:[DataPist getFilePath:name]];
            [cell addSubview:rightImage];
            
            UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(140, 28, 300, 30)];
            labelTitle.font=[UIFont systemFontOfSize:20];
            labelTitle.text=[NSString stringWithFormat:@"%@",[[[DataPist shared].arryRight objectAtIndex:indexPath.row] objectForKey:@"title"]];
            labelTitle.backgroundColor=[UIColor clearColor];
            [cell addSubview:labelTitle];
            
            UILabel *labelDetail=[[UILabel alloc]initWithFrame:CGRectMake(140, 60, 300, 60)];
            labelDetail.font=[UIFont systemFontOfSize:18];
            labelDetail.textAlignment=NSTextAlignmentLeft;
            labelDetail.userInteractionEnabled=NO;
            labelDetail.numberOfLines=0;
            labelDetail.text=[NSString stringWithFormat:@"%@",[[[DataPist shared].arryRight objectAtIndex:indexPath.row] objectForKey:@"content"]];
            labelDetail.backgroundColor=[UIColor clearColor];
            [cell addSubview:labelDetail];
            
            UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(30, 150, 400, 2)];
            image.image=[UIImage imageNamed:@"line.png"];
            [cell addSubview:image];
            
           
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"weixinView" object:Nil];

     NSDictionary *dic=[[NSDictionary alloc]init];
    if (tableView==tableLeft) {
        [DataPist shared].leftOrright=@"left";
        dic=[[DataPist shared].arryLeft objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"openView" object:Nil userInfo:dic];
    }else{
        [DataPist shared].leftOrright=@"Right";
        dic=[[DataPist shared].arryRight objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"openView" object:Nil userInfo:dic];
    }
   
}
-(void)openView{
//    [viewBg removeFromSuperview];
//    viewBg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 700)];
//    viewBg.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"open.png"]];
//    [self.view.superview addSubview:viewBg];
    
    
    

    
}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [viewBg removeFromSuperview];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
