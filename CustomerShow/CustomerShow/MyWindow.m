//
//  MyWindow.m
//  Icicle
//
//  Created by 讯 鹿 on 13-5-28.
//  Copyright (c) 2013年 Yang Chao. All rights reserved.
//

#import "MyWindow.h"
#import "AppDelegate.h"
@implementation MyWindow{
    NSString *viewInfo;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];

    }
    return self;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"stopClick" object:Nil];
}
- (void)sendEvent:(UIEvent *)event
{
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    if (event.type == UIEventTypeTouches || event.type == UIEventTypeMotion || event.type == UIEventTypeRemoteControl) {
//        NSLog(@"点击后设置NSTimer清零，然后重新开始timer");
     
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(touch:) name:@"stopClick" object:Nil];
        if ([viewInfo isEqualToString:@"otherView"]) {
            [appdelegate zeroTimer];
            [appdelegate startTimer];
        }else if([viewInfo isEqualToString:@"loginView"]){
//            NSLog(@"不执行");
        }
    }
    [super sendEvent:event];
}

-(void)touch:(NSNotification *)nocitify{
  viewInfo=nocitify.object;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
