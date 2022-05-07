//
//  CAShapeLayerVC.m
//  Animations-OC
//
//  Created by 张理想 on 2022/5/6.
//

//
#import "CAShapeLayerVC.h"

@interface CAShapeLayerVC ()

@property (nonatomic, strong) CAShapeLayer *pathLayer ;

@end

@implementation CAShapeLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CAShapeLayer";
    NSLog(@"%@", self.pathLayer);
    
}
-(void)initView{
    [super initView];
    
  
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    
    // 不设置frame 默认同self.view
    shapeLayer.frame = CGRectMake(150, 30, 200, 400);
    shapeLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    //设置填充颜色
    shapeLayer.fillColor = [UIColor yellowColor].CGColor;
    
    //设置线宽
    shapeLayer.lineWidth = 2.0;
    
    //设置线的颜色
    shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1;
  
    self.pathLayer = shapeLayer;
}

-(void)setupCommon:(UIBezierPath *)path{
    // 设置CAShapeLayer与UIBezierPath关联
    self.pathLayer.path = path.CGPath;
    
    // 将CAShaperLayer放到某个层上显示
    [self.view.layer addSublayer:self.pathLayer];
 
    
}
-(NSArray *)titleArray{
    return @[@"矩形",
             @"圆形",
             @"创建圆弧",
             @"二次贝塞尔曲线",
             @"三次贝塞尔曲线",
             @"进度条"];
}
 
-(void)titleClick:(NSInteger)index{
    
    switch (index) {
        case 0:  // 矩形
            [self createRect];
            break;
        case 1:  // 圆形
            [self createOvalInRect];
            break;
        case 2: // 创建圆弧
            [self createArcCenter:CGPointMake(100, 100) radius:50 startAngle:0 endAngle:1.5*M_PI clockwise:YES];
            break;
        case 3: //二次贝塞尔曲线
            [self createQuadCurveToPoint:CGPointMake(50, 250) controlPoint:CGPointMake(150, 150)];
            break;
        case 4: //三次贝塞尔曲线
            [self createCurveToPoint:CGPointMake(100, 300) controlPoint1:CGPointMake(300, 150) controlPoint2:CGPointMake(-50, 250)];
            break;
        case 5:
            [self drawProgress];
            break;
        default:
            break;
            
    }
}

///  矩形
-(void)createRect1{
    CGRect rect = CGRectMake(50, 50, 100, 100);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    
    [self setupCommon: path];
}

///  矩形
-(void)createRect{
    // 矩形的尺寸
    CGRect rect = CGRectMake(50, 50, 100, 100);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    
    // 在view上直接绘制，而不是添加控件图层
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    
    // 不设置frame 默认同self.view
    shapeLayer.frame = CGRectMake(150, 30, 200, 400);
    shapeLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    //设置填充颜色
    shapeLayer.fillColor = [UIColor yellowColor].CGColor;
    //设置线的颜色
    shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    //设置线宽
    shapeLayer.lineWidth = 2.0;
    // 边线路径的完成情况
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1;
    
    // 设置CAShapeLayer与UIBezierPath关联
    shapeLayer.path = path.CGPath;
    
    // 将CAShaperLayer放到某个层上显示
    [self.view.layer addSublayer:shapeLayer];
}

/// 圆形
- (void)createOvalInRect {
    //注意需要传入正方形
    CGRect rect = CGRectMake(50, 100, 100, 100);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
 
    [self setupCommon: path];

}
/**
 *  创建圆弧
 *
 *  @param center     圆点
 *  @param radius     半径
 *  @param startAngle 起始位置
 *  @param endAngle   结束为止
 *  @param clockwise  是否顺时针方向
 */
- (void)createArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise{

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    
    [self setupCommon: path];
}

/**
 *  创建二次贝塞尔曲线
 *
 *  @param endPoint     终点
 *  @param controlPoint 控制点
 */
- (void)createQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(50, 50)];
    
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    
    [self setupCommon:path];
}

/**
 *  创建三次贝塞尔曲线
 *
 *  @param endPoint      终点
 *  @param controlPoint1 控制点1
 *  @param controlPoint2 控制点2
 */
- (void)createCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2{

    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(100, 50)];
    
    [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    [self setupCommon:path];

}
/// 进度条
- (void)drawProgress{
     
  
    UIBezierPath *grayPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100)
                                                            radius:60
                                                        startAngle:M_PI * 3 / 2
                                                          endAngle:M_PI * 7 / 2
                                                         clockwise:YES];
    
    
    CAShapeLayer *grayLayer =[CAShapeLayer layer];
    grayLayer.frame = CGRectMake(150, 30, 200, 400);
    grayLayer.path = grayPath.CGPath;
    grayLayer.strokeColor = [UIColor grayColor].CGColor;
    grayLayer.fillColor = [UIColor clearColor].CGColor;
    grayLayer.lineWidth = 3;
    [self.view.layer addSublayer:grayLayer];
    
    grayLayer.strokeStart  = 0;
    grayLayer.strokeEnd = 1;
     
    
    CAShapeLayer *greenLayer = [CAShapeLayer layer];
    greenLayer.frame = CGRectMake(150, 30, 200, 400);
    greenLayer.path = grayPath.CGPath;
    greenLayer.strokeColor = [UIColor greenColor].CGColor;
    greenLayer.fillColor = [UIColor clearColor].CGColor;
    greenLayer.lineWidth = 3;
    [self.view.layer addSublayer:greenLayer];

    greenLayer.strokeStart = 0;
    greenLayer.strokeEnd = 0.5;
    
    
}
@end
