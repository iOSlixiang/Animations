//
//  UIAnimationVC.m
//  Animations-OC
//
//  Created by 张理想 on 2022/4/27.
//

// UIViewAnimation

/*
1.常规动画属性设置（可以同时选择多个进行设置）
UIViewAnimationOptionLayoutSubviews：动画过程中保证子视图跟随运动。**提交动画的时候布局子控件，表示子控件将和父控件一同动画。**
UIViewAnimationOptionAllowUserInteraction：动画过程中允许用户交互。
UIViewAnimationOptionBeginFromCurrentState：所有视图从当前状态开始运行。
UIViewAnimationOptionRepeat：重复运行动画。
UIViewAnimationOptionAutoreverse ：动画运行到结束点后仍然以动画方式回到初始点。**执行动画回路,前提是设置动画无限重复**
UIViewAnimationOptionOverrideInheritedDuration：忽略嵌套动画时间设置。**忽略外层动画嵌套的时间变化曲线**
UIViewAnimationOptionOverrideInheritedCurve：忽略嵌套动画速度设置。**通过改变属性和重绘实现动画效果，如果key没有提交动画将使用快照**
UIViewAnimationOptionAllowAnimatedContent：动画过程中重绘视图（注意仅仅适用于转场动画）。
UIViewAnimationOptionShowHideTransitionViews：视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）**用显隐的方式替代添加移除图层的动画效果**
UIViewAnimationOptionOverrideInheritedOptions ：不继承父动画设置或动画类型。**忽略嵌套继承的�选项**
----------------------------------------------------------------------------
2.动画速度控制（可从其中选择一个设置）时间函数曲线相关**时间曲线函数**
UIViewAnimationOptionCurveEaseInOut：动画先缓慢，然后逐渐加速。
UIViewAnimationOptionCurveEaseIn ：动画逐渐变慢。
UIViewAnimationOptionCurveEaseOut：动画逐渐加速。
UIViewAnimationOptionCurveLinear ：动画匀速执行，默认值。
-----------------------------------------------------------------------------
3.转场类型（仅适用于转场动画设置，可以从中选择一个进行设置，基本动画、关键帧动画不需要设置）**转场动画相关的**
UIViewAnimationOptionTransitionNone：没有转场动画效果。
UIViewAnimationOptionTransitionFlipFromLeft ：从左侧翻转效果。
UIViewAnimationOptionTransitionFlipFromRight：从右侧翻转效果。
UIViewAnimationOptionTransitionCurlUp：向后翻页的动画过渡效果。
UIViewAnimationOptionTransitionCurlDown ：向前翻页的动画过渡效果。
UIViewAnimationOptionTransitionCrossDissolve：旧视图溶解消失显示下一个新视图的效果。
UIViewAnimationOptionTransitionFlipFromTop ：从上方翻转效果。
UIViewAnimationOptionTransitionFlipFromBottom：从底部翻转效果。

补充：关于最后一组转场动画它一般是用在这个方法中的：
　　　　[UIView transitionFromView: toView: duration: options:  completion:^(****BOOL****finished) {}];
该方法效果是插入一面视图移除一面视图，期间可以使用一些转场动画效果。
*/

#import "UIAnimationVC.h"


@interface UIAnimationVC ()

@property (strong ,nonatomic) UIView *customView;

@end

@implementation UIAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"UIView 动画";
  
}

-(NSArray *)operateTitleArray{
    return @[@"位移",@"缩放",@"透明度",@"弹动",@"转场",@"变色龙"];
}
 
-(void)initView{
    [super initView];
    self.customView = [[UIView alloc]initWithFrame:CGRectMake(150, 100, 100, 100)];
    self.customView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.customView];
}

-(void)tapAction:(UIButton*)button{
    switch (button.tag) {
        case 0://位移
            [self positionAnimation];
            break;
        case 1://缩放
            [self scaleAnimation];
            break;
        case 2://透明度
            [self opacityAnimation];
            break;
        case 3://弹动
            [self bounceAnimation];
            break;
        case 4://转场动画
            [self transitionAnimation];
            break;
        case 5://随机色
            [self randomColorAnimation];
            break;
        case 6:
           
            break;
        default:
            break;
    }
}
#pragma mark - DeprecatedAnimations
//位移动画
-(void)positionAnimation{
    //
    //打印动画块的位置
    NSLog(@"动画执行之前的位置：%@",NSStringFromCGPoint(self.customView.center));
    
    //首尾式动画
    [UIView beginAnimations:nil context:nil];
    //执行动画
    
    //设置动画执行时间
    [UIView setAnimationDuration:2.0];
    
    //设置动画速度类别
    //UIViewAnimationCurveEaseInOut,         // 慢出慢入
    //UIViewAnimationCurveEaseIn,            // 慢出快入
    //UIViewAnimationCurveEaseOut,           // 快出慢入
    //UIViewAnimationCurveLinear,            // 匀速
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

    //设置代理
    [UIView setAnimationDelegate:self];
    //设置动画执行完毕调用的事件
    [UIView setAnimationDidStopSelector:@selector(didStopAnimation)];
    self.customView.center = CGPointMake(270, 300);
    [UIView commitAnimations];
    
    //打印动画块的位置
    NSLog(@"动画执行之后的位置：%@",NSStringFromCGPoint(self.customView.center));
}


-(void)didStopAnimation
{
    NSLog(@"动画执行完毕");
}


#pragma mark - UIViewAnimationWithBlocks
//缩放动画
-(void)scaleAnimation{
    // UIViewAnimationOptionRepeat  无限循环
    // UIViewAnimationOptionAutoreverse //来回运行动画
    
    [UIView animateWithDuration:2 //动画时长 单位为秒
                          delay:0 //动画延时， 不需要延时，设0
                        options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionRepeat //执行的动画选项
                     animations:^{ //动画的内容
                         self.customView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                     } completion:^(BOOL finished) {
                         //嵌套动画（恢复原来视图大小）
                         [UIView animateWithDuration:1 animations:^{
                             self.customView.transform = CGAffineTransformMakeScale(1, 1);
                         }];
                        
                     }];
}

//透明度动画
-(void)opacityAnimation{
    [UIView animateWithDuration:2 animations:^{
        self.customView.alpha = 0.1;
    } completion:^(BOOL finished) {
        //嵌套动画
        [UIView animateWithDuration:2 animations:^{
             self.customView.alpha = 1;
        }];
    }];
   
}
//弹动动画

-(void)bounceAnimation{
    
    [UIView animateWithDuration:2
                          delay:0
         usingSpringWithDamping:0.1
          initialSpringVelocity:1
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
        self.customView.transform = CGAffineTransformMakeTranslation(0, 200);
        
                     }completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            self.customView.transform = CGAffineTransformMakeTranslation(0, 0);
            
        }];
    }];
}

//转场动画
-(void)transitionAnimation{

    [UIView transitionWithView:self.customView duration:2 options:(UIViewAnimationOptionTransitionCurlUp) animations:^{
        
        [self.customView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        
//        self.customView.center=CGPointMake(150, 500);
        
    } completion:^(BOOL finished) {
        
    }];
}
//随机色动画  关键帧
-(void)randomColorAnimation{
    [UIView animateKeyframesWithDuration:6 delay:0 options:(UIViewKeyframeAnimationOptionRepeat) animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0   // 相对于6秒所开始的时间（第0秒开始动画）
                                relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
                                      animations:^{
                                          self.customView.backgroundColor = RandomColor;
                                      }];
        
        [UIView addKeyframeWithRelativeStartTime:1/3.0 // 相对于6秒所开始的时间（第2秒开始动画）
                                relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
                                      animations:^{
                                          self.customView.backgroundColor = RandomColor;
                                      }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0 // 相对于6秒所开始的时间（第4秒开始动画）
                                relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
                                      animations:^{
                                          self.customView.backgroundColor = RandomColor;                                                          }];
        
        
    } completion:nil];
}


@end
