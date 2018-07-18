//
//  CYXBarView.h
//  CYXCustomTabBarController
//
//  Created by 超级腕电商 on 2018/7/17.
//  Copyright © 2018年 超级腕电商. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYXBarView : UIView

/*初始化按钮*/
-(void)initButtonWithViewControllers:(NSArray<UIViewController *> * )viewControllers;
/*最大图片尺寸*/
@property (nonatomic,assign) CGSize maxImageSize;
/*最小图片尺寸*/
@property (nonatomic,assign) CGSize minImageSize;
/*文字颜色*/
@property (nonatomic,strong) UIColor *titleColor;
/*选中的文字颜色*/
@property (nonatomic,strong) UIColor *selectedTitleColor;
/*点击*/
@property (nonatomic,strong) void(^selectBlock)(NSInteger index);
@property (nonatomic, assign) NSInteger selectIndex;
@end
