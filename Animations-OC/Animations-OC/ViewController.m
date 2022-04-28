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

#import "OtherCaseVC.h"

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
}

#pragma mark ---Getter
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView  =[[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellId];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}
-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@"UIView动画:UIAnimationVC",
                     @"UIView动画:UITransformVC",
                     @"UIImageView动画:序列帧",
                     @"基础动画:CABasicAnimation",
                     @"关键帧动画:CAAKeyframe",
                     @"转场动画:CATransition",
                     @"粒子动画:CAEmitterLayer",
                     @"综合案例"];
    }
    return _dataArr;
}


#pragma mark --UITableViewDelegate,UITableViewDataSource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
            animaVC = [[OtherCaseVC alloc]init];
            break;
            
        default:
            break;
    }
  
    [self.navigationController pushViewController:animaVC animated:YES];
}

@end
