//
//  CGContextOne.m
//  Animations-OC
//
//  Created by 张理想 on 2022/5/7.
//

#import "CGContextOne.h"

@implementation CGContextOne


- (id)initWithFrame:(CGRect)frame{
   
   self = [super initWithFrame:frame];
   
   if (self) {
       self.backgroundColor = [UIColor whiteColor];
   }
   return self;
}

- (void)drawRect:(CGRect)rect{
   
   switch (self.type) {
       case 1:   // 折线
           [self createLine];
           break;
       case 2:  // 虚线
           [self createLineDash];
           break;
       case 3: // 多条线段
           [self createLineCount];
           break;
       case 4: // 文字绘制
           [self createString];
           break;
       case 5: // 画圆
           [self createrRounded];
           break;
       case 6: // 添加线
           [self createAddLines];
           break;
       case 7: // 画曲线
           [self createAddArc];
           break;
       case 8: // 填充颜色
           [self createColorSpace];
           break;
       case 9: // 椭圆
           [self createAddEllipse];
           break;
       case 10: // 曲线
           [self createAddQuad];
           break;
       case 11: // 图像绘制
           [self createDrawImage];
           break;
       case 12: // 给图像绘制文字
           [self createDrawImageAndText];
           break;
           
       default:
           break;
           
   }

}
/// 折线
- (void)createLine{
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //设置线条粗细宽度
    CGContextSetLineWidth(context, 3.0);
    //设置颜色
    CGContextSetRGBStrokeColor(context,  1, 0, 0, 1.0);
    //开始一个起始路径
    CGContextBeginPath(context);
    //起始点设置为(100, 100)
    CGContextMoveToPoint(context, 100, 100);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, 200, 200);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, 100, 250);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, 150, 280);
    //连接上面定义的坐标点
    CGContextStrokePath(context);
}
/// 虚线
-(void)createLineDash{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置虚线颜色
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    //设置虚线宽度
    CGContextSetLineWidth(context, 20);
    //设置虚线绘制起点
    CGContextMoveToPoint(context, 10, 110);
    //设置虚线绘制终点
    CGContextAddLineToPoint(context, self.frame.size.width, 110);
    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
    CGFloat arr[] = {3,1};
    //下面最后一个参数“2”代表排列的个数。
    CGContextSetLineDash(context, 0, arr, 2);
    CGContextDrawPath(context, kCGPathStroke);
}
/// 多条线段
-(void)createLineCount{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置画笔属性
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    // 多线交汇点
    CGPoint point = CGPointMake(SCREEN_WIDTH/2, SCREEN_WIDTH/2);
    
    CGContextMoveToPoint(ctx, SCREEN_WIDTH/2, SCREEN_WIDTH/2-100);
    CGContextAddLineToPoint(ctx, point.x, point.y);
    
    CGContextMoveToPoint(ctx, SCREEN_WIDTH/2-100, SCREEN_WIDTH/2);
    CGContextAddLineToPoint(ctx, point.x, point.y);
    
    CGContextMoveToPoint(ctx, SCREEN_WIDTH/2+50, SCREEN_WIDTH/2+50);
    CGContextAddLineToPoint(ctx, point.x, point.y);
    
    CGContextMoveToPoint(ctx, SCREEN_WIDTH/2+100, SCREEN_WIDTH/2-50);
    CGContextAddLineToPoint(ctx, point.x, point.y);
    
    CGContextStrokePath(ctx);
}

/// 文字绘制
-(void)createString{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    /*写文字*/
    CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);//设置填充颜色
    UIFont *font = [UIFont boldSystemFontOfSize:15.0];//设置
    
     NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor redColor]};
    [@"这是一条文字：" drawInRect:CGRectMake(110, 120, 180, 20) withAttributes:attributes];
    [@"画线及孤线：" drawInRect:CGRectMake(110, 180, 100, 20) withAttributes:@{NSFontAttributeName:font}];

    CGContextStrokePath(context);
    
}
/// 画圆
-(void)createrRounded{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //边框圆
    CGContextSetRGBStrokeColor(context,1,0.5,0,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 1.0);//线的宽度
   
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextAddArc(context, 100, 120, 15, 0, 2 * M_PI, 0); //添加一个圆
   
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    
    //填充圆，无边框
    CGContextAddArc(context, 150, 130, 30, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);//绘制填充
    
    //画大圆并填充颜
    UIColor *aColor = [UIColor colorWithRed:1 green:0.0 blue:0 alpha:1];
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    CGContextSetLineWidth(context, 3.0);//线的宽度
    CGContextAddArc(context, 250, 140, 40, 0, 2*M_PI, 0); //添加一个圆
    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
    
    CGContextStrokePath(context);
}
/// 添加线
-(void)createAddLines{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画线
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);//改变画笔颜色
    CGPoint aPoints[2];//坐标点
    aPoints[0] = CGPointMake(100, 80);//坐标1
    aPoints[1] = CGPointMake(230, 80);//坐标2
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    CGContextAddLines(context, aPoints, 2);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
}
///画曲线
-(void)createAddArc{
    CGContextRef context = UIGraphicsGetCurrentContext();
     
    //画笑脸弧线
    //左
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);//改变画笔颜色
    CGContextMoveToPoint(context, 140, 80);//开始坐标p1
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //x1,y1跟p1形成一条切线(切点p2)，x2,y2跟x1,y1形成一条切线(切点p3),radius半径,注意, 需要算好半径的长度,
    CGContextAddArcToPoint(context, 148, 68, 156, 80, 10);
    CGContextStrokePath(context);//绘画路径

    //右
    CGContextMoveToPoint(context, 160, 80);//开始坐标p1
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //x1,y1跟p1形成一条切线(切点p2)，x2,y2跟x1,y1形成一条切线(切点p3),radius半径,注意, 需要算好半径的长度,
    CGContextAddArcToPoint(context, 168, 68, 176, 80, 10);
    CGContextStrokePath(context);//绘画路径

    //下
    CGContextMoveToPoint(context, 150, 90);//开始坐标p1
    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
    //x1,y1跟p1形成一条切线(切点p2)，x2,y2跟x1,y1形成一条切线(切点p3),radius半径,注意, 需要算好半径的长度,
    CGContextAddArcToPoint(context, 158, 102, 166, 90, 10);
    
    CGContextStrokePath(context);
}
/// 填充颜色
-(void)createColorSpace{
    CGContextRef context = UIGraphicsGetCurrentContext();
     
    /*画矩形*/
    CGContextStrokeRect(context,CGRectMake(100, 120, 10, 10));//画方框
    CGContextFillRect(context,CGRectMake(120, 120, 10, 10));//填充框
    
    //矩形，并填弃颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);//填充颜色
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);//线框颜色
    CGContextAddRect(context,CGRectMake(140, 120, 60, 30));//画方框
    CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
    
    
    //矩形，并填弃渐变颜色
    //第一种填充方式，第一种方式必须导入类库quartcore并#import <QuartzCore/QuartzCore.h>，这个就不属于在context上画，而是将层插入到view层上面。那么这里就设计到Quartz Core 图层编程了。
    CAGradientLayer *gradient1 = [CAGradientLayer layer];
    gradient1.frame = CGRectMake(240, 120, 60, 60);
    gradient1.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor,
                        (id)[UIColor grayColor].CGColor,
                        (id)[UIColor blackColor].CGColor,
                        (id)[UIColor yellowColor].CGColor,
                        (id)[UIColor blueColor].CGColor,
                        (id)[UIColor redColor].CGColor,
                        (id)[UIColor greenColor].CGColor,
                        (id)[UIColor orangeColor].CGColor,
                        (id)[UIColor brownColor].CGColor,nil];
    [self.layer insertSublayer:gradient1 atIndex:0];
    
    //第二种填充方式
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        1,1,1, 1.00,
        1,1,0, 1.00,
        1,0,0, 1.00,
        1,0,1, 1.00,
        0,1,1, 1.00,
        0,1,0, 1.00,
        0,0,1, 1.00,
        0,0,0, 1.00,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents
    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));//形成梯形，渐变的效果
    CGColorSpaceRelease(rgb);
    
    //画线形成一个矩形
    //CGContextSaveGState与CGContextRestoreGState的作用
    /*
     CGContextSaveGState函数的作用是将当前图形状态推入堆栈。之后，您对图形状态所做的修改会影响随后的描画操作，但不影响存储在堆栈中的拷贝。在修改完成后，您可以通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态。这种推入和弹出的方式是回到之前图形状态的快速方法，避免逐个撤消所有的状态修改；这也是将某些状态（比如裁剪路径）恢复到原有设置的唯一方式。
     */
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 220, 90);
    CGContextAddLineToPoint(context, 240, 90);
    CGContextAddLineToPoint(context, 240, 110);
    CGContextAddLineToPoint(context, 220, 110);
    CGContextClip(context);//context裁剪路径,后续操作的路径
    
    
    //CGContextDrawLinearGradient(CGContextRef context,CGGradientRef gradient, CGPoint startPoint, CGPoint endPoint,CGGradientDrawingOptions options)
    //gradient渐变颜色,startPoint开始渐变的起始位置,endPoint结束坐标,options开始坐标之前or开始之后开始渐变
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (220,90) ,CGPointMake(240,110),
                                kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);// 恢复到之前的context
    
    //再写一个看看效果
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 260, 90);
    CGContextAddLineToPoint(context, 280, 90);
    CGContextAddLineToPoint(context, 280, 100);
    CGContextAddLineToPoint(context, 260, 100);
    CGContextClip(context);//裁剪路径
    //说白了，开始坐标和结束坐标是控制渐变的方向和形状
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (260, 90) ,CGPointMake(260, 100),
                                kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);// 恢复到之前的context
}

///椭圆
-(void)createAddEllipse{
 
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画椭圆
    CGContextAddEllipseInRect(context, CGRectMake(120, 120, 200, 88)); //椭圆
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);//填充颜色
    CGContextDrawPath(context, kCGPathFillStroke);
}

///曲线
-(void)createAddQuad{

    CGContextRef context = UIGraphicsGetCurrentContext();
    /*画贝塞尔曲线*/
    //二次曲线
    CGContextMoveToPoint(context, 120, 300);//设置Path的起点
    CGContextAddQuadCurveToPoint(context,190, 310, 120, 390);//设置贝塞尔曲线的控制点坐标和终点坐标
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);//线框颜色
    CGContextSetLineWidth(context, 3.0);//线的宽度

    CGContextStrokePath(context);
    //三次曲线函数
    CGContextMoveToPoint(context, 200, 300);//设置Path的起点
    CGContextAddCurveToPoint(context,250, 280, 250, 400, 280, 300);//设置贝塞尔曲线的控制点坐标和控制点坐标终点坐标
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);//线框颜色
    CGContextSetLineWidth(context, 3.0);//线的宽度

    CGContextStrokePath(context);
}
/// 图像绘制
-(void)createDrawImage{
  
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIImage *image = [UIImage imageNamed:@"雪花0"];
    [image drawInRect:CGRectMake(60, 60, 20, 20)];//在坐标中画出图片
   
    // [image drawAtPoint:CGPointMake(100, 340)];//保持图片大小在point点开始画图片，可以把注释去掉看看
    CGContextDrawImage(context, CGRectMake(100, 69, 20, 20), image.CGImage);
}
/// 给图像绘制文字
-(void)createDrawImageAndText{
 
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIImage *image = [CGContextOne drawText1:@"雪花" forImage:[UIImage imageNamed:@"雪花0"]];
    [image drawInRect:CGRectMake(20, 50, 100, 100)];//在坐标中画出图片
   
    // [image drawAtPoint:CGPointMake(100, 340)];//保持图片大小在point点开始画图片，可以把注释去掉看看
    CGContextDrawImage(context, CGRectMake(150, 50, 150, 150), image.CGImage);
    
}

+ (UIImage *)drawText1:(NSString *)text1 forImage:(UIImage *)image{
    CGSize size = CGSizeMake(image.size.width,image.size.height ); // 画布大小
    
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    
    [image drawAtPoint:CGPointMake(0,0)];
    // 获得一个位图图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawPath(context,kCGPathStroke);
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:10], NSForegroundColorAttributeName:[UIColor redColor]};
   
    // 画文字 让文字处于居中模式
    [text1 drawAtPoint:CGPointMake(3,2) withAttributes:attributes];
    // 返回绘制的新图形
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
