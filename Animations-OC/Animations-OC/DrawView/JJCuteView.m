//
//  JJCuteView.m
//  Animations-OC
//
//  Created by 张理想 on 2022/5/7.
//

#import "JJCuteView.h"


#define kControlMinHeight 100
@interface JJCuteView ()<UITableViewDelegate,UITableViewDataSource>

/// 模拟导航视图
@property (nonatomic, strong) UIView *navView;
/// 路径
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
/// 曲线路径控制点,为了更容易理解添加的. // 切点,用Q表示
@property (nonatomic, strong) UIView *controlView;
/// 切点位置
@property (nonatomic, assign) CGPoint controlPoint;
/// 定时器,为了做动画用
@property (nonatomic, strong) CADisplayLink *displayLink;
/// 记录当前是否在做动画
@property (nonatomic, assign) BOOL isAnimating;
/// 列表
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation JJCuteView

static NSString *const kControlPoint = @"controlPoint";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


#pragma mark - 初始化界面
- (void)setupUI{
    
    [self addObserver:self forKeyPath:kControlPoint options:NSKeyValueObservingOptionNew context:nil];
    
    // 手势
    // UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanAction:)];
    // self.userInteractionEnabled = YES;
    // [self addGestureRecognizer:pan];
    
    [self addSubview:self.tableView];
    [self.tableView.panGestureRecognizer addTarget:self action:@selector(handlePanAction:)];
    
    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kControlMinHeight)];
    [self addSubview:self.navView];
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = [UIColor colorWithRed:57/255.0 green:67/255.0 blue:89/255.0 alpha:1.0].CGColor;
    [self.navView.layer addSublayer:_shapeLayer];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(calculatePath)];
    _displayLink.paused = YES;
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    // Q点坐标
    self.controlPoint = CGPointMake(SCREEN_WIDTH/2.0, kControlMinHeight);
    _controlView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0, kControlMinHeight, 3, 3)];
    _controlView.backgroundColor = [UIColor redColor];
    [self addSubview:_controlView];
    
    _isAnimating = NO;
}

- (void)handlePanAction:(UIPanGestureRecognizer *)pan{
    if (!_isAnimating) { //动画过程中不处理事件
        if (pan.state == UIGestureRecognizerStateChanged){
            CGPoint point = [pan translationInView:self];
            // 这部分代码使Q点跟着手势走
            CGFloat controlHeight = point.y*0.7 + kControlMinHeight;
            CGFloat controlX = SCREEN_WIDTH/2.0 + point.x;
            CGFloat controlY = controlHeight > kControlMinHeight ? controlHeight : kControlMinHeight;
            self.controlPoint = CGPointMake(controlX, controlY);
            self.controlView.frame = CGRectMake(controlX, controlY, self.controlView.frame.size.width, self.controlView.frame.size.height);
        }else if (pan.state == UIGestureRecognizerStateCancelled ||
                  pan.state == UIGestureRecognizerStateEnded ||
                  pan.state == UIGestureRecognizerStateFailed){
            
            //手势结束,_shapeLayer昌盛产生弹簧效果
            _isAnimating = YES;
            _displayLink.paused = NO;           //开启displaylink,会执行方法calculatePath.
            //弹簧
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.controlView.frame = CGRectMake(SCREEN_WIDTH/2.0, kControlMinHeight, 3, 3);
            } completion:^(BOOL finished) {
                if(finished){
                    self.displayLink.paused = YES;
                    self.isAnimating = NO;
                }
            }];
            
            
        }
    }
}

/// 接收拖动代码也可以写在这里
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

//更新贝塞尔曲线图
- (void)updateShapeLayerPath {
    // 更新_shapeLayer形状
    UIBezierPath *tPath = [UIBezierPath bezierPath];
    [tPath moveToPoint:CGPointMake(0, 0)];                              // A点
    [tPath addLineToPoint:CGPointMake(SCREEN_WIDTH, 0)];               // B点
    [tPath addLineToPoint:CGPointMake(SCREEN_WIDTH,  kControlMinHeight)];  // D点
    [tPath addQuadCurveToPoint:CGPointMake(0, kControlMinHeight) controlPoint:self.controlPoint]; // C,D,Q确定的一个弧线
    [tPath closePath];
    _shapeLayer.path = tPath.CGPath;
}

//KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kControlPoint]) {
        [self updateShapeLayerPath];
    }
}

- (void)calculatePath{
    // 由于手势结束时,Q执行了一个UIView的弹簧动画,把这个过程的坐标记录下来,并相应的画出_shapeLayer形状
    CALayer *layer = self.controlView.layer.presentationLayer;
    self.controlPoint = CGPointMake(layer.position.x, layer.position.y);
}

#pragma mark -- TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

#pragma mark - lazy
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kControlMinHeight, SCREEN_WIDTH, SCREEN_HEIGHT-kControlMinHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}
@end
