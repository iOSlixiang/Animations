//
//  CAAKeyframe.m
//  Animations-OC
//
//  Created by 张理想 on 2022/4/28.
//

#import "CAAKeyframeVC.h"

@interface CAAKeyframeVC () <CAAnimationDelegate>
@property (nonatomic , strong) UIView *demoView;

@end

@implementation CAAKeyframeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关键帧动画";
}
-(void)initView{
    [super initView];
    
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2-50,50,50)];
    _demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_demoView];
}

-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"关键帧",@"路径",@"抖动",@"CASpring ", nil];
}

-(void)tapAction:(UIButton *)btn {
    switch (btn.tag) {
        case 0:
            [self keyFrameAnimation];
            break;
        case 1:
            [self pathAnimation];
            break;
        case 2:
            [self shakeAnimation];
            break;
        case 3:
            [self springAnimation];
            break;
        default:
            break;
    }
}

/**
 *  关键帧动画
 */
-(void)keyFrameAnimation{
    
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    
    anima.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    anima.duration = 2.0f;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设置动画的节奏
    anima.delegate = self;//设置代理，可以检测动画的开始和结束
    [_demoView.layer addAnimation:anima forKey:@"keyFrameAnimation"];
    
}

/**
 *  path动画
 */
-(void)pathAnimation{
    //曲线位移  跟随UIBezierPath的路径移动
    
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200)];
    
    // 圆形路径
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2) radius:60 startAngle:0.0f endAngle:M_PI*2 clockwise:YES];
    
    anima.path = path.CGPath;
    anima.duration = 2.0f;
    [_demoView.layer addAnimation:anima forKey:@"pathAnimation"];
}

/**
 *  抖动效果
 */
-(void)shakeAnimation{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];//在这里@"transform.rotation"==@"transform.rotation.z"

    anima.values = @[@(-M_PI/180*4),@(M_PI/180*4),@(-M_PI/180*4)];

    anima.values = @[@(-(6) / 180.0*M_PI),@((6) / 180.0*M_PI),@(-(5) / 180.0*M_PI),@((5) / 180.0*M_PI),@(-(4) / 180.0*M_PI),@((4) / 180.0*M_PI),@(-(4) / 180.0*M_PI)];
    /// 控制时间
    anima.duration = 2;
    anima.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1)];
    
    anima.repeatCount = 1;
    [_demoView.layer addAnimation:anima forKey:@"shakeAnimation"];
     
}

//CASpringAnimation
-(void)springAnimation{
    CASpringAnimation *springAni = [CASpringAnimation animationWithKeyPath:@"position"];
    springAni.damping = 2;
    springAni.stiffness = 50;
    springAni.mass = 1;
    springAni.initialVelocity = 2;
    springAni.toValue = [NSValue valueWithCGPoint:CGPointMake(270, 350)];
    springAni.duration = springAni.settlingDuration;
    [_demoView.layer addAnimation:springAni forKey:@"springAnimation"];
}
 
#pragma mark - delegate
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"开始动画");
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"结束动画");
}


@end
