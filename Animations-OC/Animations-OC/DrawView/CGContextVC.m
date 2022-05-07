//
//  CGContextVC.m
//  Animations-OC
//
//  Created by 张理想 on 2022/5/7.
//

#import "CGContextVC.h"
#import "CGContextAll.h"
#import "CGContextOne.h"

@interface CGContextVC ()
@property (nonatomic, strong) CGContextOne *oneView;
@property (nonatomic, strong) CGContextAll *allView;

@end

@implementation CGContextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"CGContextRef";
    
    [self titleClick:0];
    
}
-(void)initView{
    [super initView];
    
    CGContextAll *allView = [[CGContextAll alloc]initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:allView];
    self.allView = allView;
    
    CGContextOne *oneView = [[CGContextOne alloc]initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:oneView];
    self.oneView = oneView;
    
    CGRect rect = self.tableView.frame;
    rect.size.height = 300;
    self.tableView.frame = rect;
    
}
-(NSArray *)titleArray{
    return @[@"AllView",
             @"折线",
             @"虚线",
             @"多条线段",
             @"文字绘制",
             @"画圆",
    @"添加线",
    @"曲线",
    @"填充颜色"];
}
 
-(void)titleClick:(NSInteger)index{
    
    self.oneView.hidden = self.allView.hidden = YES;
    
    if (index == 0) {
        self.allView.hidden = NO;

    }else{
        self.oneView.hidden = NO;

        self.oneView.type = index;
        [self.oneView setNeedsDisplay];
    }

}

 

@end
