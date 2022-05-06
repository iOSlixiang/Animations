//
//  UIBezierPathVC.m
//  Animations-OC
//
//  Created by 张理想 on 2022/5/6.
//

#import "UIBezierPathVC.h"
#import "UIBezierPathView.h"

@interface UIBezierPathVC ()

@property (nonatomic, weak)  UIBezierPathView *pathView ;
@end

@implementation UIBezierPathVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIBezierPath";
    
}
-(void)initView{
    [super initView];
   
    
    UIBezierPathView *view = [[UIBezierPathView alloc] initWithFrame:CGRectMake(160, 30, 200, 400)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];

    self.pathView = view;
    
    CGRect rect = self.tableView.frame;
    rect.size.width = 150;
    self.tableView.frame = rect;
    
    
}
-(NSArray *)titleArray{
    return @[@"直线",
             @"三角形",
             @"矩形",
             @"圆形",
             @"椭圆",
             @"圆角矩形",
             @"特定圆角矩形",
             @"创建圆弧",
             @"通过路径A创建",
             @"二次贝塞尔曲线",
             @"三次贝塞尔曲线",
             @"添加圆弧",
             @"追加路径",
             @"路径翻转",
             @"路径仿射变换",
             @"创建虚线",
             @"混合模式",
             @"填充区域"];
}
 
-(void)titleClick:(NSInteger)index{
    
    self.pathView.type = index;
    [self.pathView setNeedsDisplay];
}

 
@end
