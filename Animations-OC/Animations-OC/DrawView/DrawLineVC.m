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
-(NSArray *)titleArray{
    return @[@"画椭圆",@"画路径",@"不规则时间"];
}
 
-(void)titleClick:(NSInteger)index{
    
    switch (index) {
        case 0://位移
            [self pathOvalInRect];
            break;
            
        case 1:
            [self pathPoint];
            break;
        case 2:
            [self pathSquare];
            break;
        default:
            break;
            
    }
}

-(void)pathOvalInRect{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(160,30,100,100)];
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithOvalInRect:bgView.frame];
    
    UIImage *image = [UIImage imageNamed:@"雪花0"];
    
    CAShapeLayer * shapeLayer = [[CAShapeLayer alloc]init];
    shapeLayer.strokeColor = [UIColor colorWithPatternImage:image].CGColor;
//    shapeLayer.strokeColor = [UIColor purpleColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 10;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.strokeStart= 0;
    shapeLayer.strokeEnd = 1;
    [self.view.layer addSublayer:shapeLayer];
    
    
    
    //  Animation是控制 stroke[0,1]的进度
    CABasicAnimation * pathAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnim.duration = 2.0;
    pathAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnim.fromValue = @(0);
    pathAnim.toValue = @(3);
    //    pathAnim.autoreverses = true;
    pathAnim.fillMode = kCAFillModeForwards;
    //    [pathAnim setRemovedOnCompletion:false];
    pathAnim.repeatCount = 1;
    [shapeLayer addAnimation:pathAnim forKey:@"pathAnim"];
    
}
-(void)pathPoint{
    
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, 150, 100, 100)];
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
/// 不规律时间花矩形
-(void)pathSquare{
     
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(160, 300, 200, 200)];
    [self.view addSubview:bgView];
    
    // 1. 绘制一条直线,即一次贝塞尔曲线
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // 设置起始点
    [path moveToPoint:CGPointMake(10, 10)];
    // 添加子路径
    [path addLineToPoint:CGPointMake(190, 10)];
    [path addLineToPoint:CGPointMake(190, 190)];
    [path addLineToPoint:CGPointMake(10, 190)];
    [path addLineToPoint:CGPointMake(10, 10)];
    
    // 根据坐标点连线
    [path stroke];

    CAShapeLayer * yesShape = [[CAShapeLayer alloc]init];
    yesShape.path = path.CGPath;
    
    yesShape.strokeColor = [UIColor blueColor].CGColor;
    yesShape.fillColor = [UIColor clearColor].CGColor;
    yesShape.lineJoin = kCALineJoinRound;
    yesShape.lineCap = kCALineCapRound;
    yesShape.lineWidth = 4;
    
    [bgView.layer addSublayer:yesShape];
    
    /// 可以绘制动画的绘制过程，但是一个path内不能暂定绘制
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
     
    anima.values = @[ @(0), @(0.25), @(0.5), @(0.6),@(1)];;
    // 控制时间
    anima.duration = 8;
    anima.keyTimes = @[ @(0), @(0.1), @(0.3), @(0.6), @(1)];
    
    [yesShape addAnimation:anima forKey:@"pathAnimation"];
    
    
}
@end
