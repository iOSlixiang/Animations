//
//  BaseViewController.m
//  Animations-OC
//
//  Created by 张理想 on 2022/4/27.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic , strong) NSArray *operateTitleArray;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self initData];
    [self initView];
}

-(void)initData{
    _operateTitleArray = [self operateTitleArray];
}
-(BOOL)isShowRight{
    return YES;
}
-(void)initView{
     
    if(!self.operateTitleArray&&self.operateTitleArray.count == 0){
        
        return;
    }
    for (int i = 0; i < _operateTitleArray.count; i++) {
        UIButton *aniButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aniButton.tag = i;
        [aniButton setTitle:self.operateTitleArray[i] forState:UIControlStateNormal];
        aniButton.exclusiveTouch = YES;
        aniButton.frame = CGRectMake(10, 30 + 50 * i, 100, 40);
        aniButton.backgroundColor = [UIColor blueColor];
        [aniButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:aniButton];
    }
    
    if ([self isShowRight]) {
        NSArray *rightNames = @[@"暂停",@"恢复",@"停止"];
        
        for (int i = 0; i < rightNames.count; i++) {
            UIButton *aniButton = [UIButton buttonWithType:UIButtonTypeCustom];
            aniButton.tag = 100 + i;
            [aniButton setTitle:rightNames[i] forState:UIControlStateNormal];
            aniButton.exclusiveTouch = YES;
            aniButton.frame = CGRectMake(300, 50 + 60 * i, 80, 50);
            aniButton.backgroundColor = [UIColor orangeColor];
            [aniButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:aniButton];
        }
    }

    
}
-(void)tapAction:(UIButton *)btn{
    
}
-(void)rightClick:(UIButton *)btn{
    
}
@end
