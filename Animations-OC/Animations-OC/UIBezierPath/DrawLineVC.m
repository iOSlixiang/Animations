//
//  DrawLineVCViewController.m
//  Animations-OC
//
//  Created by 张理想 on 2022/4/28.
//

#import "DrawLineVC.h"

@interface DrawLineVC ()

@end

@implementation DrawLineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"画线";
}
-(NSArray *)operateTitleArray{
    return @[@"画椭圆",@"画路径"];
}
-(BOOL)isShowRight{
    return NO;
}
-(void)tapAction:(UIButton *)button{
    
    switch (button.tag) {
        case 0://位移
            [self pathOvalInRect];
            break;
            
        case 1:
            [self pathPoint];
            break;
        default:
            break;
            
    }
}

-(void)pathOvalInRect{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2,30,50,50)];
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithOvalInRect:bgView.frame];
    
    CAShapeLayer * shapeLayer = [[CAShapeLayer alloc]init];
    shapeLayer.strokeColor = [UIColor purpleColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 10;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = bezierPath.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    
    CABasicAnimation * pathAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnim.duration = 2.0;
    pathAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnim.fromValue = @(0);
    pathAnim.toValue = @(1);
    //    pathAnim.autoreverses = true;
    pathAnim.fillMode = kCAFillModeForwards;
    //    [pathAnim setRemovedOnCompletion:false];
    pathAnim.repeatCount = HUGE_VALF;
    [shapeLayer addAnimation:pathAnim forKey:@"pathAnim"];
    
}
-(void)pathPoint{
    
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, 100, 100, 100)];
    bgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgView];
    
    // 1. 绘制一条直线,即一次贝塞尔曲线
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = 0.5;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.miterLimit = 5.f;
    path.flatness = 5.f;
    path.usesEvenOddFillRule = YES;
    // 设置起始点
    [path moveToPoint:CGPointMake(10, 50)];
    // 添加子路径
    [path addLineToPoint:CGPointMake(30, 80)];//添加一条子路径
    [path addLineToPoint:CGPointMake(50, 35)]; // 再添加一条路径
    // 根据坐标点连线
    [path stroke];

    CAShapeLayer * yesShape = [[CAShapeLayer alloc]init];
    yesShape.strokeColor = [UIColor blueColor].CGColor;
    yesShape.fillColor = [UIColor clearColor].CGColor;
    yesShape.lineJoin = kCALineJoinRound;
    yesShape.lineCap = kCALineCapRound;
    yesShape.path = path.CGPath;
    yesShape.lineWidth = 10;
    [bgView.layer addSublayer:yesShape];
    
    CABasicAnimation * yesAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    yesAnimation.duration = 2;
    yesAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    yesAnimation.fromValue = @(0);
    yesAnimation.toValue = @(1);
    yesAnimation.fillMode = kCAFillModeForwards;
    yesAnimation.repeatCount = HUGE_VALF;
    [yesShape addAnimation:yesAnimation forKey:@"yesAnimation"];
}
@end
