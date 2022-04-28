//
//  UIAnimationImagesVC.m
//  Animations-OC
//
//  Created by 张理想 on 2022/4/28.
//

#import "UIAnimationImagesVC.h"

@interface UIAnimationImagesVC ()
@property (strong,nonatomic) UIImageView *imgV;

@end

@implementation UIAnimationImagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"序列帧动画";
    [self.view addSubview:self.imgV];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 300, 50, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}
-(void)startClick{
    //首先判断视图是否在动画，如果在动画，关闭动画
    if ([self.imgV isAnimating]) {
        [self clearAinimationImageMemory];
    }else{
        //设置视图的动画属性
        //设置UIImageViews 动画图片数组
        self.imgV.animationImages = [self imageArr];
        //设置动画时长
        [self.imgV setAnimationDuration:26/10.0];
        //设置动画次数
        [self.imgV setAnimationRepeatCount:1];
        //开始动画
        [self.imgV startAnimating];
        
        [self performSelector:@selector(clearAinimationImageMemory) withObject:nil afterDelay:3.f];// 此处我在执行完序列帧以后我执行了一个清除内存的操作
    }
}
// 清除animationImages所占用内存
- (void)clearAinimationImageMemory {
    [self.imgV stopAnimating];
    self.imgV.animationImages = nil;
}
-(UIImageView *)imgV{
    if (!_imgV) {
        _imgV = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _imgV.image = [UIImage imageNamed:@"cat_angry0000.jpg"];
    }
    return _imgV;
}
-(NSMutableArray *)imageArr{
    NSMutableArray *imageArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 26; i++) {
        NSString *imageFile = [NSString stringWithFormat:@"cat_angry%04ld.jpg", (long)i];
        //imageNamed带有缓存，通过它创建的图片会放到缓存中
        //UIImage *image = [UIImage imageNamed:imageFile];
        //imageWithContentsOfFile这种方式不带缓存，不会使内存占用率飙升
        NSString *path = [[NSBundle mainBundle] pathForResource:imageFile ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [imageArr addObject:image];
        
    }
    return imageArr;
}
 

@end
