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
    self.title = @"CATransition";
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

-(NSArray *)titleArray{
    return [NSArray arrayWithObjects:@"fade",@"moveIn",@"push",@"reveal",@"cube ",@"suckEffect",@"oglFlip",@"rippleEffect ",@"pageCurl ",@"pageUnCurl",@"caOpen",@"caClose", nil];
}

-(void)titleClick:(NSInteger)index {
    switch (index) {
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
    kCATransitionFade; 交叉淡化过渡(不支持过渡方向)
    kCATransitionMoveIn;  //新视图把旧视图推出去
    kCATransitionPush;  新视图移到旧视图上面
    kCATransitionReveal; 将旧视图移开,显示下面的新视图
 */
/*
 subType:
    kCATransitionFromRight;
    kCATransitionFromLeft;
    kCATransitionFromTop;
    kCATransitionFromBottom;
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

//下面几个也是过渡效果，但它们是私有API效果，使用的时候要小心，可能会导致app审核不被通过
//cube     //立方体翻滚效果
//oglFlip  //上下左右翻转效果
//suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
//rippleEffect //滴水效果(不支持过渡方向)
//pageCurl     //向上翻页效果
//pageUnCurl   //向下翻页效果
//cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
//cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
 

//立体翻滚效果
-(void)cubeAnimation{

    CATransition *anima = [CATransition animation];
    anima.type = @"cube";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    anima.delegate =self;

    [_demoView.layer addAnimation:anima forKey:@"revealAnimation"];
}

//收缩效果，如一块布被抽走
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
//滴水效果
-(void)rippleEffectAnimation{
    
    CATransition *anima = [CATransition animation];
    anima.type = @"rippleEffect";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    anima.delegate =self;

    [_demoView.layer addAnimation:anima forKey:@"rippleEffectAnimation"];
}
//向上翻一页
-(void)pageCurlAnimation{
 
    CATransition *anima = [CATransition animation];
    anima.type = @"pageCurl";//设置动画的类型
    anima.subtype = kCATransitionFromBottom; //设置动画的方向
    anima.duration = 1.0f;
    anima.delegate =self;

    [_demoView.layer addAnimation:anima forKey:@"pageCurlAnimation"];
}
//向下翻一页
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
