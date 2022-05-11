//
//  CADisplayLinkVC.m
//  Animations-OC
//
//  Created by 张理想 on 2022/5/11.
//

#import "CADisplayLinkVC.h"

@interface CADisplayLinkVC ()
@property(nonatomic,strong)CADisplayLink *displayLink;

@property (nonatomic, weak) UIView *bgView;
@end

@implementation CADisplayLinkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(30, 150, 100, 100);
    bgView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:bgView];
    self.bgView = bgView;
    
    [self setupDisplay];
}
-(void)setupDisplay{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTextColor:)];
    self.displayLink.paused = YES;
//    self.displayLink.frameInterval = 60.0;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)updateTextColor:(CADisplayLink *)displayLink{
    NSLog(@"%f",displayLink.timestamp);
    self.bgView.backgroundColor = RandomColor;
}
- (void)startAnimation{
    self.displayLink.paused = NO;
}
- (void)stopAnimation{
    self.displayLink.paused = YES;
    [self.displayLink invalidate];
    self.displayLink = nil;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self startAnimation];
}

@end
