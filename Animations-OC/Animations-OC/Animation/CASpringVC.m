//
//  CASpringVC.m
//  Animations-OC
//
//  Created by 张理想 on 2022/4/28.
//

#import "CASpringVC.h"

@interface CASpringVC ()
@property (nonatomic, strong) CALayer *animationLayer;
@end

@implementation CASpringVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"弹簧动画";
}
 
-(void)initView{
    [super initView];
    [super setupOperateUI];

    self.animationLayer = [[CALayer alloc] init];
    self.animationLayer.frame = CGRectMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2-50,50,50);
    self.animationLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:_animationLayer];

}
-(NSArray *)titleArray{
    return [NSArray arrayWithObjects: @"Animation0",@"Animation1", nil];
}

-(void)titleClick:(NSInteger)index {
    switch (index) {
        case 0:
            [self springAnimation0];
            break;
        case 1:
            [self springAnimation1];
            break;
        default:
            break;
    }
}
 
-(void)springAnimation0{
    CASpringAnimation * springAnimation = [CASpringAnimation animationWithKeyPath:@"position.x"];
    //mass:质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大，动画的速度变慢，并且波动幅度变大
    springAnimation.mass = 0.5;
    //stiffness:刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
    springAnimation.stiffness = 100;
    //damping:阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
    springAnimation.damping = 0.1;
    //initialVelocity:初始速率，动画视图的初始速度大小速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
    springAnimation.initialVelocity = 0;
    //settlingDuration:结算时间 返回弹簧动画到停止时的估算时间，根据当前的动画参数估算通常弹簧动画的时间使用结算时间比较准确
    NSLog(@"%f",springAnimation.settlingDuration);
//    springAnimation.fromValue =
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(_animationLayer.frame.origin.x+ 100, _animationLayer.frame.origin.y)];
    springAnimation.duration = springAnimation.settlingDuration;
    [self.animationLayer addAnimation:springAnimation forKey:@"springAnimation"];
}
-(void)springAnimation1{
    CASpringAnimation *springAni = [CASpringAnimation animationWithKeyPath:@"position"];
    springAni.damping = 2;
    springAni.stiffness = 50;
    springAni.mass = 1;
    springAni.initialVelocity = 2;
    springAni.toValue = [NSValue valueWithCGPoint:CGPointMake(270, 350)];
    springAni.duration = springAni.settlingDuration;
    [self.animationLayer addAnimation:springAni forKey:@"springAnimation"];
}
#pragma mark - right
//控制动画状态按钮点击
-(void)operateClick:(NSInteger)index{
    switch (index) {
        case 100:
            [self animationPause];
            break;
        case 101:
            [self animationResume];
            break;
        case 102:
            [self animationStop];
            break;
        default:
            break;
    }
}

//暂停动画
-(void)animationPause{
    //获取当前layer的动画媒体时间
    CFTimeInterval interval = [_animationLayer convertTime:CACurrentMediaTime() toLayer:nil];
    //设置时间偏移量,保证停留在当前位置
    _animationLayer.timeOffset = interval;
    //暂定动画
    _animationLayer.speed = 0;
}
//恢复动画
-(void)animationResume{
    //获取暂停的时间
    CFTimeInterval beginTime = CACurrentMediaTime() - _animationLayer.timeOffset;
    //设置偏移量
    _animationLayer.timeOffset = 0;
    //设置开始时间
    _animationLayer.beginTime = beginTime;
    //开始动画
    _animationLayer.speed = 1;
}
//停止动画
-(void)animationStop{
    [_animationLayer removeAllAnimations];//移除当前层所有动画
    //[_animationLayer removeAnimationForKey:@"groupAnimation"];//移除当前层上名称是groupAnimation的动画
}

#pragma mark - CAAnimationDelegate
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"动画 ---- %@  ---- 开始",anim);
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"动画 ---- %@  ---- 已停止",anim);
}
 
@end
