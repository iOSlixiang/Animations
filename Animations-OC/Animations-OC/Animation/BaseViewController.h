//
//  BaseViewController.h
//  Animations-OC
//
//  Created by 张理想 on 2022/4/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
 
@property (nonatomic, strong) UITableView *tableView;

-(void)initView;
-(void)setupOperateUI;

-(NSArray *)titleArray;


-(void)titleClick:(NSInteger)index;
-(void)operateClick:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
