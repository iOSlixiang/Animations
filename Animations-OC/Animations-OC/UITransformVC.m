//
//  UITransformVC.m
//  Animations-OC
//
//  Created by 张理想 on 2022/4/28.
//

#import "UITransformVC.h"

@interface UITransformVC ()

@property (nonatomic , strong) UIView *demoView;

@end

@implementation UITransformVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"仿射变换";
    
}
-(void)initView{
    [super initView];
    self.demoView = [[UIView alloc]initWithFrame:CGRectMake(150, 100, 100, 100)];
    self.demoView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.demoView];
}
-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"位移",@"缩放",@"旋转",@"组合",@"反转",nil];
}

-(void)tapAction: (UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self positionAnimation];
            break;
        case 1:
            [self scaleAnimation];
            break;
        case 2:
            [self rotateAnimation];
            break;
        case 3:
            [self combinationAnimation];
            break;
        case 4:
            [self invertAnimation];
            break;
        default:
            break;
    }
}

-(void)positionAnimation{
    // [ 1 0 0 1 0 0 ]  [ a b c d x y ]
    self.demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        self.demoView.transform = CGAffineTransformMakeTranslation(100, 100);
    }];
}

-(void)scaleAnimation{
    
    self.demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        self.demoView.transform = CGAffineTransformMakeScale(2, 2);
    }];
}

-(void)rotateAnimation{
    self.demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        self.demoView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

-(void)combinationAnimation{
    //仿射变换的组合使用
    self.demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
       
        CGAffineTransform transform1 = CGAffineTransformMakeRotation(M_PI);
        CGAffineTransform transform2 = CGAffineTransformScale(transform1, 0.5, 0.5);
        
        self.demoView.transform = CGAffineTransformTranslate(transform2, 100, 100);
    }];
}

-(void)invertAnimation{
    self.demoView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:1.0f animations:^{
        //矩阵反转
        self.demoView.transform = CGAffineTransformInvert(CGAffineTransformMakeScale(2, 2));
    }];
}

@end
