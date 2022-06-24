//
//  ViewController.m
//  Animations-OC
//
//  Created by 张理想 on 2022/4/27.
//

#import "ViewController.h"

#import "UIAnimationVC.h"
#import "UITransformVC.h"
#import "UIAnimationImagesVC.h"

#import "CAAnimationVC.h"
#import "CAAKeyframeVC.h"
#import "CATransitionVC.h"
#import "CAEmitterVC.h"
#import "CASpringVC.h"
#import "CADisplayLinkVC.h"

#import "UIBezierPathVC.h"
#import "CAShapeLayerVC.h"
#import "DrawLineVC.h"
#import "DrawCatVC.h"
#import "CGContextVC.h"

#import "OtherCaseVC.h"
#import "BrushDrawVC.h"

NSString *const CellId = @"cellId";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) UITableView *tableView;

@property(strong,nonatomic) NSArray *dataArr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动画";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
    [self configData];
}

#pragma mark ---Getter
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-100) style:(UITableViewStylePlain)];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellId];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}
-(void)configData{
    NSArray *array_1 = @[@"UIView动画:UIAnimationVC",
                         @"UIView动画:UITransformVC",
                         @"UIImageView动画:序列帧",
                         @"基础动画:CABasicAnimation",
                         @"关键帧动画:CAAKeyframe",
                         @"转场动画:CATransition",
                         @"粒子动画:CAEmitterLayer",
                         @"弹簧动画:CASpringAnimation",
                         @"Time动画:CADisplayLink"];
    NSMutableDictionary *dic_1 = [NSMutableDictionary dictionaryWithObject:array_1 forKey:@"value"];
    [dic_1 setValue:@"动画" forKey:@"title"];
     
    NSArray *array_2 = @[@"UIBezierPath",
                         @"CAShapeLayer",
                         @"绘制线:DrawLine",
                         @"绘制猫:DrawCat",
                         @"CGContextRef"];
    NSMutableDictionary *dic_2 = [NSMutableDictionary dictionaryWithObject:array_2 forKey:@"value"];
    [dic_2 setValue:@"绘图" forKey:@"title"];
    
    NSArray *array_3 = @[@"钉钉--点赞--贝塞尔曲线",
                         @"画笔"];
    NSMutableDictionary *dic_3 = [NSMutableDictionary dictionaryWithObject:array_3 forKey:@"value"];
    [dic_3 setValue:@"综合案例" forKey:@"title"];
     
    
    
    self.dataArr = @[dic_1,dic_2,dic_3];
    
    [_tableView reloadData];
    
}
 

#pragma mark --UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = _dataArr[section];
    NSArray *array = dic[@"value"];
    return array.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dic = _dataArr[section];
    return dic[@"title"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    cell.textLabel.text = _dataArr[indexPath.section][@"value"][indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - click
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
        [self selectAnimation:indexPath];
    }
    else if (indexPath.section == 1){
        [self selectDrawView:indexPath];
    }
    else if (indexPath.section == 2){
        [self selectOtherCaseView:indexPath];
    }
}
-(void)selectAnimation:(NSIndexPath *)indexPath{
    
    UIViewController * animaVC;
    switch (indexPath.row) {
        case 0:
            animaVC = [[UIAnimationVC alloc]init];
            break;
        case  1:
            animaVC = [[UITransformVC alloc]init];
            break;
        case  2:
            animaVC = [[UIAnimationImagesVC alloc]init];
            
            break;
        case 3:
            animaVC = [[CAAnimationVC alloc]init];
            break;
            
        case 4:
            animaVC = [[CAAKeyframeVC alloc]init];
            break;
        case 5:
            animaVC = [[CATransitionVC alloc]init];
            break;
        case 6:
            animaVC = [[CAEmitterVC alloc]init];
            break;
        case 7:
            animaVC = [[CASpringVC alloc]init];
            break;
        case 8:
            animaVC = [[CADisplayLinkVC alloc]init];
            break;
            
        default:
            break;
    }
    // 转场效果
    if (indexPath.row == 5) {
        CATransition *transtion = [CATransition animation];
        transtion.duration = 2;
        transtion.type = @"cube";
        transtion.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:transtion forKey:nil];
    }
  
    [self.navigationController pushViewController:animaVC animated:YES];
}
-(void)selectDrawView:(NSIndexPath *)indexPath{
    UIViewController * drawVC;
    switch (indexPath.row) {
        case 0:
            drawVC =  [[UIBezierPathVC alloc]init];
            break;
        case 1:
            drawVC =  [[CAShapeLayerVC alloc]init];
            break;
        case 2:
            drawVC = [[DrawLineVC alloc]init];
            break;
        case 3:
            drawVC = [[DrawCatVC alloc]init];
            break;
        case 4:
            drawVC = [[CGContextVC alloc]init];
            break;
            
        default:
            break;
    }
 
    [self.navigationController pushViewController:drawVC animated:YES];
    
}

-(void)selectOtherCaseView:(NSIndexPath *)indexPath{
    UIViewController * drawVC;
    switch (indexPath.row) {
        case 0:
            drawVC =  [[OtherCaseVC alloc]init];
            break;
        case 1:
            drawVC =  [[BrushDrawVC alloc]init];
            break;
 
            
        default:
            break;
    }
 
    [self.navigationController pushViewController:drawVC animated:YES];
    
}
 
@end
