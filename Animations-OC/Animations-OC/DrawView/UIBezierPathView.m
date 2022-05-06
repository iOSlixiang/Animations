//
//  UIBezierPathView.m
//  Animations-OC
//
//  Created by 张理想 on 2022/5/6.
//

#import "UIBezierPathView.h"

@implementation UIBezierPathView
 
- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    switch (self.type) {
        case 0:   // 直线
            [self createLine];
            break;
        case 1:   // 三角形
            [self createTrianglePath];
            break;
        case 2:  // 矩形
            [self createRect];
            break;
        case 3:  // 圆形
            [self createOvalInRect];
            break;
        case 4:  // 椭圆
            [self createOvalPath];
            break;
        case 5:  // 圆角矩形
            [self createRoundedInRect];
            break;
        case 6: // 特定圆角矩形
            [self createRoundedInRect:CGRectMake(50, 50, 100, 100) roundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5,5)];;
            break;
        case 7: // 创建圆弧
            [self createArcCenter:CGPointMake(100, 100) radius:50 startAngle:0 endAngle:1.5*M_PI clockwise:YES];
            break;
        case 8: //通过路径A创建路径B
            [self createWithPath];
            break;
        case 9: //二次贝塞尔曲线
            [self createQuadCurveToPoint:CGPointMake(50, 250) controlPoint:CGPointMake(150, 150)];
            break;
        case 10: //三次贝塞尔曲线
            [self createCurveToPoint:CGPointMake(100, 300) controlPoint1:CGPointMake(300, 150) controlPoint2:CGPointMake(-50, 250)];
            break;
            
        case 11: //添加圆弧
            [self createAddArcWithCenter:CGPointMake(50, 50) radius:25 startAngle:0 endAngle:1.5*M_PI clockwise:YES];
            break;
           
        case 12: //追加路径
            [self appendPath];
            break;
            
        case 13: //路径翻转
            [self createReversingPath];
            break;
        case 14: //路径仿射变换
            [self createApplyTransform];
            break;
            
        case 15: //创建虚线
        {
            CGFloat dashStyle[] = {1.0f, 2.0f};
            [self createLineDash:dashStyle count:2 phase:0.0];
        }
            break;
        case 16: //混合模式
            [self createBlendMode];
            break;
            
        case 17: //填充区域
            [self createAddClip];
            break;
 
            
        default:
            break;
            
    }
 
}

-(void)setupCommon:(UIBezierPath *)path{
    
    path.lineWidth = 5.0f;
    path.lineCapStyle = kCGLineCapRound;   //线条拐角
    path.lineJoinStyle = kCGLineJoinBevel; //终点处理
    
    //填充
    [[UIColor yellowColor] setFill];
    [path fill];
 
    //描边
    [[UIColor orangeColor] setStroke];
    [path stroke];
    
}

///  绘制直线
- (void)createLine{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(100, 200)];
    
    [self setupCommon:path];
}
/// 三角形
- (void)createTrianglePath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 20)];
    [path addLineToPoint:CGPointMake(self.frame.size.width - 45, 20)];
    [path addLineToPoint:CGPointMake(self.frame.size.width - 45, self.frame.size.height - 20)];
    
    // 起点与终点闭合
    [path closePath];
    
    [self setupCommon:path];
    
}

///  创建矩形
- (void)createRect{
 
    CGRect rect = CGRectMake(50, 50, 100, 100);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
 
    [self setupCommon: path];
}

/// 圆形
- (void)createOvalInRect {
    //注意需要传入正方形
    CGRect rect = CGRectMake(50, 100, 100, 100);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
 
    [self setupCommon: path];

}
//椭圆
- (void)createOvalPath
{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, self.frame.size.width - 40, self.frame.size.height - 60)];
    
    [self setupCommon: path];

}
///  创建带有圆角的矩形，当矩形变成正圆的时候，Radius就不再起作用
- (void)createRoundedInRect{
    
    CGRect rect = CGRectMake(50, 100, 100, 100);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:15.0];
 
    [self setupCommon: path];
}


/**
 *  设定特定的角为圆角的矩形
 *  @param corners     指定的圆角
 *  @param cornerRadii 圆角的大小
 */
- (void)createRoundedInRect:(CGRect)rect roundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
    
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
 *  通过路径A创建路径B
 */
- (void)createWithPath{

    UIBezierPath *path_A = [UIBezierPath bezierPath];
    
    [path_A moveToPoint:CGPointMake(50, 50)];
    
    [path_A addLineToPoint:CGPointMake(150, 150)];
   
     
    UIBezierPath *path_B = [UIBezierPath bezierPathWithCGPath:path_A.CGPath];
    
    [self setupCommon:path_B];
    
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

/**
 *  添加圆弧
 *
 *  @param center     圆点
 *  @param radius     半径
 *  @param startAngle 起始位置
 *  @param endAngle   结束为止
 *  @param clockwise  是否顺时针方向
 */
- (void)createAddArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 直线
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(150, 50)];
    
    // 设置圆弧
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
     
    [path closePath];
    
    [self setupCommon:path];
    
}

/// 追加路径
- (void)appendPath{

    UIBezierPath *path_A = [UIBezierPath bezierPath];
    
    [path_A moveToPoint:CGPointMake(50, 50)];
    [path_A addLineToPoint:CGPointMake(150, 50)];
    
    UIBezierPath *path_B = [UIBezierPath bezierPath];
    
    [path_B moveToPoint:CGPointMake(150, 50)];
    [path_B addLineToPoint:CGPointMake(150, 300)];
    
    [path_A appendPath:path_B];
    
    
    [self setupCommon:path_A];
    [self setupCommon:path_B];
 
}

/// 创建翻转路径，即起点变成终点，终点变成起点
- (void)createReversingPath{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(150, 50)];
 
    NSLog(@"%@",NSStringFromCGPoint(path.currentPoint));
    // 终点发生变化
    UIBezierPath *path_b = [path bezierPathByReversingPath];
    [path_b addLineToPoint:CGPointMake(150, 300)];
    
    NSLog(@"%@",NSStringFromCGPoint(path_b.currentPoint));

    [path_b stroke];
}

/**
 *  路径进行仿射变换
 */
- (void)createApplyTransform{
    
    CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(100, 50)];
    [path addLineToPoint:CGPointMake(100, 200)];
    
    // 仿射变换
    [path applyTransform:transform];
 
    [self setupCommon:path];
    
}

/**
 *  创建虚线
 *
 *  @param pattern C类型线性数据
 *  @param count   pattern中数据个数
 *  @param phase   起始位置
 */
- (void)createLineDash:(nullable const CGFloat *)pattern count:(NSInteger)count phase:(CGFloat)phase{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(150, 50)];
    [path addLineToPoint:CGPointMake(150, 300)];

    
    [path setLineDash:pattern count:count phase:0];
    
    [path stroke];
 
}
 
/**
 *   设置混合模式  与图片结合使用
 *   CGBlendMode 混合模式
 *   alpha   透明度
 */
- (void)createBlendMode{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 100)];
       
//    [[UIColor yellowColor] setFill];
//    [path fillWithBlendMode:kCGBlendModeSaturation alpha:5];
//
//    [path fill];
    
    path.lineWidth = 10.0f;
    [[UIColor greenColor] setStroke];
    [path strokeWithBlendMode:kCGBlendModeSaturation alpha:1.0];
    [path stroke];

}
 
/**
 *  修改当前图形上下文的绘图区域可见,随后的绘图操作导致呈现内容只有发生在指定路径的填充区域
 */
- (void)createAddClip{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 100)];
    
    [[UIColor greenColor] setStroke];

    
    [path stroke];
    
    UIBezierPath *path_A = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 150, 100, 100)];
    
    [[UIColor greenColor] setStroke];
    
    [path_A addClip];
    
    [path_A stroke];
    
}
@end
