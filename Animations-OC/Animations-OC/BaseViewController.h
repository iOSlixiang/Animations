//
//  BaseViewController.h
//  Animations-OC
//
//  Created by 张理想 on 2022/4/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController


-(void)initView;

/// 是否显示右侧按钮
-(BOOL)isShowRight;
 /// 操作数组
-(NSArray *)operateTitleArray;
/// 每个按钮的点击时间
-(void)tapAction:(UIButton *)btn;
/// 右侧按钮
-(void)rightClick:(UIButton *)btn;

@end

NS_ASSUME_NONNULL_END
