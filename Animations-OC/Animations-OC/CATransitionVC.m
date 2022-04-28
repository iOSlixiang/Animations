//
//  CATransitionVC.m
//  Animations-OC
//
//  Created by 张理想 on 2022/4/28.
//

#import "CATransitionVC.h"

@interface CATransitionVC ()<CAAnimationDelegate>

@property (nonatomic , strong) UIView *demoView;

@property (nonatomic , strong) UILabel *demoLabel;

@property (nonatomic , assign) NSInteger index;

@end

@implementation CATransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转场动画";
}
-(void)initView{
    [super initView];
    
    _demoView = [[UIView alloc] init];
    _demoView.frame = CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2 -100, 100, 100);
    [self.view addSubview:_demoView];
    
    _demoLabel = [[UILabel alloc] init];
    _demoLabel.frame = CGRectMake(0, 0, 100, 100);
    _demoLabel.textAlignment = NSTextAlignmentCenter;
    _demoLabel.font = [UIFont systemFontOfSize:40];
    [_demoView addSubview:_demoLabel];
    
}

-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"fade",@"moveIn",@"push",@"reveal",@"cube",@"suck",@"oglFlip",@"ripple",@"Curl",@"UnCurl",@"caOpen",@"caClose", nil];
}

-(void)tapAction:(UIButton *)btn {
    switch (btn.tag) {
        case 0:
            [self fadeAnimation];
            break;
        case 1:
            [self moveInAnimation];
            break;
        case 2:
            [self pushAnimation];
            break;
        case 3:
            [self revealAnimation];
            break;
        case 4:
            [self cubeAnimation];
            break;
        case 5:
            [self suckEffectAnimation];
            break;
        case 6:
            [self oglFlipAnimation];
            break;
        case 7:
            [self rippleEffectAnimation];
            break;
        case 8:
            [self pageCurlAnimation];
            break;
        case 9:
            [self pageUnCurlAnimation];
            break;
        case 10:
            [self cameraIrisHollowOpenAnimation];
            break;
        case 11:
            [self cameraIrisHollowCloseAnimation];
            break;
        default:
            break;
    }
}


//-----------------------------public api------------------------------------
/*
 type:
    kCATransitionFade;  淡出
    kCATransitionMoveIn; 覆盖原图
    kCATransitionPush;  推出
    kCATransitionReveal; 底部显出来  
 */
/*
 subType:
    kCATransitionFromRight;
    kCATransitionFromLeft;
    kCATransitionFromTop;
    kCATransitionFromBottom;
 */

/**
 *  逐渐消失
 */
-(void)fadeAnimation{

    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionFade;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    //anima.startProgress = 0.3;//设置动画起点
    //anima.endProgress = 0.8;//设置动画终点
    anima.duration = 1.0f;
    anima.delegate =self;
    [_demoView.layer addAnimation:anima forKey:@"fadeAnimation"];
}

-(void)moveInAnimation{
 
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionMoveIn;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    anima.delegate =self;
    
    [_demoView.layer addAnimation:anima forKey:@"moveInAnimation"];
}

-(void)pushAnimation{

    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionPush;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    anima.delegate =self;
    
    [_demoView.layer addAnimation:anima forKey:@"pushAnimation"];
}

-(void)revealAnimation{

    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionReveal;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    anima.delegate =self;

    [_demoView.layer addAnimation:anima forKey:@"revealAnimation"];
}

//-----------------------------private api------------------------------------
/*
    Don't be surprised if Apple rejects your app for including those effects,
    and especially don't be surprised if your app starts behaving strangely after an OS update.
*/


/**
 *  立体翻滚效果
 */
-(void)cubeAnimation{

    CATransition *anima = [CATransition animation];
    anima.type = @"cube";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    anima.delegate =self;

    [_demoView.layer addAnimation:anima forKey:@"revealAnimation"];
}


-(void)suckEffectAnimation{

    CATransition *anima = [CATransition animation];
    anima.type = @"suckEffect";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    anima.delegate =self;

    [_demoView.layer addAnimation:anima forKey:@"suckEffectAnimation"];
}

-(void)oglFlipAnimation{
 
    CATransition *anima = [CATransition animation];
    anima.type = @"oglFlip";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    anima.delegate =self;

    [_demoView.layer addAnimation:anima forKey:@"oglFlipAnimation"];
}

-(void)rippleEffectAnimation{
    
    CATransition *anima = [CATransition animation];
    anima.type = @"rippleEffect";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    anima.delegate =self;

    [_demoView.layer addAnimation:anima forKey:@"rippleEffectAnimation"];
}

-(void)pageCurlAnimation{
 
    CATransition *anima = [CATransition animation];
    anima.type = @"pageCurl";//设置动画的类型
    anima.subtype = kCATransitionFromBottom; //设置动画的方向
    anima.duration = 1.0f;
    anima.delegate =self;

    [_demoView.layer addAnimation:anima forKey:@"pageCurlAnimation"];
}

-(void)pageUnCurlAnimation{
 
    CATransition *anima = [CATransition animation];
    anima.type = @"pageUnCurl";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    anima.delegate =self;

    [_demoView.layer addAnimation:anima forKey:@"pageUnCurlAnimation"];
}

-(void)cameraIrisHollowOpenAnimation{

    CATransition *anima = [CATransition animation];
    anima.type = @"cameraIrisHollowOpen";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    anima.delegate =self;

    [_demoView.layer addAnimation:anima forKey:@"cameraIrisHollowOpenAnimation"];
}

-(void)cameraIrisHollowCloseAnimation{

    CATransition *anima = [CATransition animation];
    anima.type = @"cameraIrisHollowClose";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    anima.delegate = self;
    
    [_demoView.layer addAnimation:anima forKey:@"cameraIrisHollowCloseAnimation"];
}
 

#pragma mark - CAAnimationDelegate
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"动画 ---- %@  ---- 开始",anim);
    _index++ ;
    _demoView.backgroundColor = RandomColor;
    _demoLabel.text = [NSString stringWithFormat:@"%ld",(long)_index];
    
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"动画 ---- %@  ---- 已停止",anim);
}
 

@end
