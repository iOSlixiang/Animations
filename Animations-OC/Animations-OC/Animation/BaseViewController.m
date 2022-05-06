//
//  BaseViewController.m
//  Animations-OC
//
//  Created by 张理想 on 2022/4/27.
//

#import "BaseViewController.h"
 
@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
     
    [self initView];
    [self initData];
}

-(void)initData{
    self.titleArray = [self titleArray];
    [self.tableView reloadData];
}

-(void)initView{
    [self.view addSubview:self.tableView];
}

-(void)setupOperateUI{
    
    NSArray *rightNames = @[@"暂停",@"恢复",@"停止"];
    
    for (int i = 0; i < rightNames.count; i++) {
        UIButton *aniButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aniButton.tag = 100 + i;
        [aniButton setTitle:rightNames[i] forState:UIControlStateNormal];
        aniButton.exclusiveTouch = YES;
        aniButton.frame = CGRectMake(30 + 90 * i, SCREEN_HEIGHT- 150, 80, 30);
        aniButton.backgroundColor = [UIColor orangeColor];
        [aniButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:aniButton];
    }
    
}
#pragma mark - tableView
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 120, SCREEN_HEIGHT- 180) style:(UITableViewStylePlain)];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
 
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
    
}
 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self titleClick:indexPath.row];
}

-(void)titleClick:(NSInteger)index{
    
}
-(void)rightClick:(UIButton *)btn{
    [self operateClick:btn.tag];
}
-(void)operateClick:(NSInteger)index{
    
}

@end
