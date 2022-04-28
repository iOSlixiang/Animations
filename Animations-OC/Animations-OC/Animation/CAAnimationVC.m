//
//  CAAnimationVC.m
//  Animations-OC
//
//  Created by 张理想 on 2022/4/27.
//

#import "CAAnimationVC.h"

@interface CAAnimationVC ()<CAAnimationDelegate>{
    NSInteger _transtionIndex;
}

@property(nonatomic,strong)CALayer *animationLayer;

@property(nonatomic,strong)CADisplayLink *displayLink;

@end

@implementation CAAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"CAAnimation 动画";
    
}
-(NSArray *)operateTitleArray{
    return @[@"位移",@"缩放",@"透明度",@"旋转",@"圆角",@"动画组",@"同时添加",@"连续动画"];
}
-(void)initView{
   [super initView];
    
   self.animationLayer = [[CALayer alloc] init];
   _animationLayer.bounds = CGRectMake(0, 0, 100, 100);
   _animationLayer.position = self.view.center;
   _animationLayer.backgroundColor = [UIColor redColor].CGColor;
   [self.view.layer addSublayer:_animationLayer];
}
#pragma mark - left
-(void)tapAction:(UIButton*)button{
    if (button.tag < 5) {
        [self basicAnimationWithTag:button.tag];
    }
    else if(button.tag == 5){
        [self animationGroup1];;
    }
    else if (button.tag == 6){
        [self animationGroup2];
    }
    else if (button.tag == 7){
        [self animationGroup3];
    }
    
}
/// CABasicAnimation 基础动画
-(void)basicAnimationWithTag:(NSInteger)tag{
    CABasicAnimation *basicAni = nil;
    switch (tag) {
        case 0:
            //初始化动画并设置keyPath
            basicAni = [CABasicAnimation animationWithKeyPath:@"position"];
            //到达位置
            basicAni.byValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
            break;
        case 1:
            
            //到达缩放
            basicAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            basicAni.toValue = @(0.1f);
            
            // 修改bounds 大小达到缩放
//            basicAni = [CABasicAnimation animationWithKeyPath:@"bounds"];
//            basicAni.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
            
            break;
        case 2:
            basicAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
            basicAni.toValue= [NSNumber numberWithFloat:0.1];
            break;
        case 3:
            
            //3D  绕着矢量（x,y,z）旋转
//            basicAni = [CABasicAnimation animationWithKeyPath:@"transform"];
//            basicAni.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2+M_PI_4, 1, 1, 0)];
            
            //绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
            basicAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            basicAni.toValue = [NSNumber numberWithFloat:M_PI];
            
            break;
        case 4:
            //圆角
            basicAni = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
            basicAni.toValue=@(50);
            
            // 背景色
            basicAni = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
            basicAni.toValue = (id)[UIColor greenColor].CGColor;
            
            break;
        default:
            break;
    }
    
    //设置代理
    basicAni.delegate = self;
    //延时执行
    //basicAni.beginTime = CACurrentMediaTime() + 2;
    //动画时间
    basicAni.duration = 1;
    //动画节奏
    basicAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //动画速率
    //basicAni.speed = 0.1;
    //图层是否显示执行后的动画执行后的位置以及状态
    //basicAni.removedOnCompletion = NO;
    basicAni.fillMode = kCAFillModeForwards;
    //动画完成后是否以动画形式回到初始值
    basicAni.autoreverses = YES;
    //动画时间偏移
    //basicAni.timeOffset = 0.5;
    //添加动画
    NSString *key = NSStringFromSelector(_cmd);
    NSLog(@"动画的key ======= %@",key);
    [_animationLayer addAnimation:basicAni forKey:key];
}

//动画组
-(void)animationGroup1{
    
    //弹动动画
    CAKeyframeAnimation *keyFrameAni = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    CGFloat ty = _animationLayer.position.y;
    keyFrameAni.values = @[@(ty - 100),@(ty),@(ty - 50),@(ty)];
    //每一个动画可以单独设置时间和重复次数,在动画组的时间基础上,控制单动画的效果
    keyFrameAni.duration = 0.3;
    keyFrameAni.repeatCount= MAXFLOAT;
    keyFrameAni.delegate = self;
    
    
    //圆角动画
    CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    //到达位置
    basicAni.byValue = @(_animationLayer.bounds.size.width/2);
    //
    basicAni.duration = 1;
    basicAni.repeatCount = 1;
    //
    basicAni.removedOnCompletion = NO;
    basicAni.fillMode = kCAFillModeForwards;
    //设置代理
    basicAni.delegate = self;
    //动画时间
    basicAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
    aniGroup.animations = @[keyFrameAni,basicAni];
    aniGroup.autoreverses = YES;
    //动画的表现时间和重复次数由动画组设置的决定
    aniGroup.duration = 3;
    aniGroup.repeatCount= MAXFLOAT;
    //
    [_animationLayer addAnimation:aniGroup forKey:@"groupAnimation"];
}

-(void)animationGroup2{
    //位移动画
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    anima1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    anima1.duration = 4.0f;
    [_animationLayer addAnimation:anima1 forKey:@"aa"];

    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    anima2.duration = 4.0f;
    [_animationLayer addAnimation:anima2 forKey:@"bb"];

    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima3.duration = 4.0f;
    [_animationLayer addAnimation:anima3 forKey:@"cc"];
}
-(void)animationGroup3{
    CFTimeInterval currentTime = CACurrentMediaTime();
    
    //位移动画
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"position"];
    anima1.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-75)];
    anima1.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-75)];
    anima1.beginTime = currentTime;
    anima1.duration = 1.0f;
    anima1.fillMode = kCAFillModeForwards;
    anima1.removedOnCompletion = NO;
    [_animationLayer addAnimation:anima1 forKey:@"aa"];
    
    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    anima2.beginTime = currentTime+1.0f;
    anima2.duration = 1.0f;
    anima2.fillMode = kCAFillModeForwards;
    anima2.removedOnCompletion = NO;
    [_animationLayer addAnimation:anima2 forKey:@"bb"];
    
    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima3.beginTime = currentTime+2.0f;
    anima3.duration = 1.0f;
    anima3.fillMode = kCAFillModeForwards;
    anima3.removedOnCompletion = NO;
    [_animationLayer addAnimation:anima3 forKey:@"cc"];
}

#pragma mark - right
//控制动画状态按钮点击
-(void)rightClick:(UIButton *)sender{
    switch (sender.tag) {
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
