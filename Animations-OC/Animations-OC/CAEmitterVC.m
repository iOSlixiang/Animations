//
//  CAEmitterVC.m
//  Animations-OC
//
//  Created by 张理想 on 2022/4/28.
//

#import "CAEmitterVC.h"

@interface CAEmitterVC ()
@property (strong ,nonatomic )CAEmitterLayer *emitterLayer;

@end

@implementation CAEmitterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"粒子动画";
}
-(void)initView{
    [super initView];
    
}
-(NSArray *)operateTitleArray{
    return @[@"大雪纷飞",@"心花怒放",@"百花争艳",@"璀璨烟花"];
}
-(CAEmitterLayer *)emitterLayer{
    if (!_emitterLayer) {
        _emitterLayer = [CAEmitterLayer layer];
        _emitterLayer.zPosition = -100;
        [self.view.layer addSublayer:_emitterLayer];
    }
    return _emitterLayer;
}

-(void)tapAction:(UIButton*)sender{
    //首先停止之前动画
    [self animationStop];
    switch (sender.tag) {
        case 0:
            [self snow];
            break;
        case 1:
            [self heart];
            break;
        case 2:
            [self flowers];
            break;
        case 3:
            [self fireworks];
            break;
            
        default:
            break;
    }
}
//大雪纷飞
-(void)snow{
    self.emitterLayer.emitterPosition = CGPointMake(self.view.frame.size.width/2, 0);//发射器中心点
    self.emitterLayer.emitterSize = CGSizeMake(self.view.frame.size.width, 0);//发射器大小，因为emitterShape设置成线性所以高度可以设置成0，
    
    self.emitterLayer.emitterShape = kCAEmitterLayerLine;//发射器形状为线性
    self.emitterLayer.emitterMode = kCAEmitterLayerOutline;//从发射器边缘发出
    
    NSMutableArray *array = [NSMutableArray array];//CAEmitterCell数组，存放不同的CAEmitterCell，我这里准备了四张不同形态的叶子图片。
    for (int i = 0; i<4; i++) {
        NSString *imageName = [NSString stringWithFormat:@"雪花%d",i%2];
        
        CAEmitterCell *snowCell = [CAEmitterCell emitterCell];
        snowCell.birthRate = 2;//粒子产生速度
        snowCell.lifetime = 20;//粒子存活时间
        
        snowCell.velocity = 10;//初始速度
        snowCell.velocityRange = 5;//初始速度的差值区间，所以初始速度为5~15，后面属性range算法相同
        
        snowCell.yAcceleration = 7;//y轴方向的加速度，落叶下飘只需要y轴正向加速度。
        
        snowCell.spin = 1.0;//粒子旋转速度
        snowCell.spinRange = 2.0;//粒子旋转速度范围
        
        snowCell.emissionRange = M_PI;//粒子发射角度范围
        
        snowCell.contents = (id)[[UIImage imageNamed:imageName] CGImage];//粒子图片
        
        snowCell.scale = 0.3;//缩放比例
        snowCell.scaleRange = 0.2;//缩放比例
        snowCell.alphaSpeed = -0.05;//透明度速度
        [array addObject:snowCell];
    }
    
    self.emitterLayer.emitterCells = array;//设置粒子组
    
}
//心花怒放
-(void)heart{
    self.emitterLayer.emitterPosition = self.view.center;//发射器中心点
    self.emitterLayer.emitterSize = CGSizeMake(20, 20);//发射器大小，因为emitterShape设置成线性所以高度可以设置成0，
    
    self.emitterLayer.emitterShape = kCAEmitterLayerSphere;//发射器形状为球型
    self.emitterLayer.emitterMode = kCAEmitterLayerVolume;//从发射器中心发出

    CAEmitterCell *heartCell = [CAEmitterCell emitterCell];
    heartCell.birthRate = 2;//粒子产生速度
    heartCell.lifetime = 30;//粒子存活时间
    
    heartCell.velocity = 15;//初始速度
    heartCell.velocityRange = 5;//初始速度的差值区间，所以初始速度为5~15，后面属性range算法相同

    heartCell.spin = 1.0;//粒子旋转速度
    heartCell.spinRange = 2.0;//粒子旋转速度范围
    
    heartCell.emissionRange = M_PI;//粒子发射角度范围
    heartCell.contents = (id)[[UIImage imageNamed:@"心"] CGImage];//粒子图片

    heartCell.scale = 0.3;//缩放比例
    heartCell.scaleRange = 0.2;//缩放比例
    heartCell.alphaRange = 0.1;//透明度比例
 
    self.emitterLayer.emitterCells = @[heartCell];//设置粒子组
}
//百花争艳
-(void)flowers{
    self.emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
    self.emitterLayer.emitterPosition = CGPointMake(0, 200);
   
    CAEmitterCell *redCell = [CAEmitterCell emitterCell];
    redCell.contents = (id)[[UIImage imageNamed:@"花"] CGImage];//粒子图片

    redCell.scale = 0.5;
    redCell.lifetime = 10;
    redCell.alphaSpeed = -0.1;
    redCell.birthRate = 10;
    redCell.velocity = 100;
    // y轴方法的加速度，模拟重力加速度
    redCell.yAcceleration = 20;
    redCell.emissionLongitude = -M_PI / 4;
    redCell.emissionRange = M_PI / 4;
    // 粒子旋转角速度，单位是弧度/秒，正值表示顺时针旋转
    redCell.spin = 2;
    // 粒子旋转角速度变化范围
    redCell.spinRange = M_PI * 2;
    
    CAEmitterCell *colorCell = [CAEmitterCell emitterCell];
    colorCell.color = [[UIColor orangeColor] CGColor];
    colorCell.contents = (id)[[UIImage imageNamed:@"彩花"] CGImage];
    
    colorCell.scale = 0.3;
    colorCell.lifetime = 20;
    colorCell.redRange = 50.f;
    colorCell.greenRange = 10.f;
    colorCell.blueRange = 70.f;
    colorCell.redSpeed = 2.f;
    colorCell.greenSpeed = -6.f;
    colorCell.blueSpeed = 5.f;
    colorCell.alphaRange = 0.2;
    colorCell.alphaSpeed = -0.05;
    colorCell.birthRate = 5;
    colorCell.velocity = 135;
    colorCell.yAcceleration = 20;
    colorCell.emissionLongitude = -M_PI / 4;
    colorCell.emissionRange = M_PI / 4;
    colorCell.spin = 0;
    colorCell.spinRange = M_PI * 2;
    [colorCell setName:@"color"];
    // 图层要发射2种粒子
    self.emitterLayer.emitterCells = @[redCell, colorCell];
    
}
//璀璨烟花
-(void)fireworks{
    // 发射源大小
    self.emitterLayer.emitterSize = CGSizeMake(self.view.frame.size.width * 0.1, 0.f);
    // 发射位置 在底部向上发射
    self.emitterLayer.emitterPosition = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height);
    // 以直线发射
    self.emitterLayer.emitterShape = kCAEmitterLayerLine;
    // 在指定位置的表面发射
    self.emitterLayer.emitterMode = kCAEmitterLayerSurface;
    // 渲染效果，叠加高亮
    self.emitterLayer.renderMode = kCAEmitterLayerAdditive;
    
    // 发射粒子效果
    CAEmitterCell * shootCell = [CAEmitterCell emitterCell];
    shootCell.name = @"shootCell";
    // 粒子产生率 1秒一个
    shootCell.birthRate = 2.f;
    // 粒子存在时间 1.02 上一个销毁了下一个再发出来
    shootCell.lifetime = 1.02f;
    
    // 粒子速度和速度范围 默认是发射模式方向的加速度⭐️
    shootCell.velocity = 600.f;
    shootCell.velocityRange = 100.f;
    // Y方向的加速度 模拟重力影响 发射会感受收到向下的阻碍
    shootCell.yAcceleration = 150.f;
    
    // 发射角度范围 看着更像是到处在放烟火🎆
    shootCell.emissionRange = M_PI_2 * 0.25;
    
    shootCell.scale = 0.05;
    shootCell.color = [[UIColor redColor] CGColor];
    shootCell.greenRange = 1.f;
    shootCell.redRange = 1.f;
    shootCell.blueRange = 1.f;
    shootCell.contents = (id)[[UIImage imageNamed:@"烟花"] CGImage];
    // 烟火在发射的过程中自转
    shootCell.spinRange = M_PI;  // 自转360度
    
    // 爆炸粒子效果
    CAEmitterCell * explodeCell = [CAEmitterCell emitterCell];
    explodeCell.name = @"explodeCell";
    explodeCell.birthRate = 1.f;
    explodeCell.lifetime = 0.5f;
    explodeCell.velocity = 0.f;
    explodeCell.scale = 2.5;
    explodeCell.redSpeed = -1.5;  //爆炸的时候变化颜色
    explodeCell.blueRange = 1.5; //爆炸的时候变化颜色
    explodeCell.greenRange = 1.f; //爆炸的时候变化颜色
    
    // 火花粒子效果
    CAEmitterCell * sparkCell = [CAEmitterCell emitterCell];
    sparkCell.name = @"sparkCell";
    sparkCell.birthRate = 400.f;
    sparkCell.lifetime = 1.5f;
    sparkCell.velocity = 125.f;
    sparkCell.yAcceleration = 75.f;  // 模拟重力影响
    sparkCell.emissionRange = M_PI * 2;  // 360度
    sparkCell.scale = 1.2f;
    sparkCell.contents = (id)[[UIImage imageNamed:@"星"] CGImage];
    sparkCell.redSpeed = 0.4;
    sparkCell.greenSpeed = -0.1;
    sparkCell.blueSpeed = -0.1;
    sparkCell.alphaSpeed = -0.25;
    sparkCell.spin = M_PI * 2;
    
    // 添加动画 每个粒子效果 都可以添加后续动画
    self.emitterLayer.emitterCells = @[shootCell];
    // ⭐️粒子添加粒子，再添加粒子，就自动完成了烟火效果
    shootCell.emitterCells = @[explodeCell];
    explodeCell.emitterCells = @[sparkCell];
    
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
    CFTimeInterval interval = [self.emitterLayer convertTime:CACurrentMediaTime() toLayer:nil];
    //设置时间偏移量,保证停留在当前位置
    self.emitterLayer.timeOffset = interval;
    //暂定动画
    self.emitterLayer.speed = 0;
}
//恢复动画
-(void)animationResume{
    //获取暂停的时间
    CFTimeInterval beginTime = CACurrentMediaTime() - self.emitterLayer.timeOffset;
    //设置偏移量
    self.emitterLayer.timeOffset = 0;
    //设置开始时间
    self.emitterLayer.beginTime = beginTime;
    //开始动画
    self.emitterLayer.speed = 1;
}
//停止动画
-(void)animationStop{
    //移除所有粒子
    self.emitterLayer.emitterCells = [NSArray array];
    self.emitterLayer = nil;
}


@end
