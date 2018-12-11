//
//  CYXBarView.m
//  CYXCustomTabBarController
//
//  Created by 超级腕电商 on 2018/7/17.
//  Copyright © 2018年 超级腕电商. All rights reserved.
//

#import "CYXBarView.h"
#import "CYXTabBarItem.h"
#import "Masonry.h"
#import "UIView+Size.h"
#define screenWidth      [UIScreen mainScreen].bounds.size.width
#define screenHeight     [UIScreen mainScreen].bounds.size.height
@interface CYXBarView()


@property (nonatomic,strong) NSMutableArray<CYXTabBarItem *> *items;
@end
@implementation CYXBarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.maxImageSize = CGSizeMake(40, 40);
        self.minImageSize = CGSizeMake(20, 20);
        self.titleColor = [UIColor grayColor];
        self.selectedTitleColor = [UIColor redColor];
        self.items = [NSMutableArray new];
    }
    
    return self;
}

-(void)initButtonWithViewControllers:(NSArray<UIViewController *> * )viewControllers{
    [self.items removeAllObjects];
    
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    NSMutableArray *temp = [NSMutableArray arrayWithArray:viewControllers];
    if (self.haveCenterButton&&[viewControllers count]>1&&[viewControllers count]%2==0) {//个数大于1而且是偶数
        [temp insertObject:@"centerButton" atIndex:[viewControllers count]/2];
    }
    CGFloat  itemWidth =screenWidth/temp.count;
    for (int i= 0; i<temp.count; i++) {
        
        id obj = temp[i];
        __weak __typeof(self) _self = self;
        if ([obj isKindOfClass:[UIViewController class]]) {//u普通
            CYXTabBarItem * item = [[CYXTabBarItem alloc] init];
            item.maxImageSize = self.maxImageSize;
            item.minImageSize = self.minImageSize;
            item.titleColor = self.titleColor;
            item.selectedTitleColor = self.selectedTitleColor;
            UIViewController * viewController = temp[i];
            item.title = [viewController.tabBarItem.title length]?viewController.tabBarItem.title:viewController.title;
            item.selectedImage = viewController.tabBarItem.selectedImage;
            item.image = viewController.tabBarItem.image;
            item.selectBlock = ^{
                _self.selectIndex = [viewControllers indexOfObject:viewController];
                if (_self.selectBlock) {
                    _self.selectBlock(_self.selectIndex);
                }
            };
            [self.items addObject:item];
            [self addSubview:item];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(itemWidth);
                make.height.equalTo(self);
                make.top.equalTo(self);
                make.left.mas_equalTo(i*itemWidth);
            }];
            
            
            
            [item updateImageAndTitle];
        }else if ([obj isKindOfClass:[NSString class]]){
            if ([obj isEqualToString:@"centerButton"]) {//中间按钮
                UIImageView  * centerImageView = [[UIImageView alloc] initWithImage:self.centerImage];
                centerImageView.userInteractionEnabled = YES;
                [centerImageView setTapActionWithBlock:^{
                    if (_self.selectCenterBlock) {
                        _self.selectCenterBlock();
                    }
                }];
                [self addSubview:centerImageView];
                [centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(50);
                    make.height.mas_equalTo(50);
                    make.top.equalTo(self).offset(-10);
                    make.left.mas_equalTo(i*itemWidth+(itemWidth-50)/2);
                }];
            }
            
        }
        
        
        
    }
    self.selectIndex = 0;
}
- (void)setSelectIndex:(NSInteger)selectIndex
{
    if (![self.items count]||selectIndex>=[self.items count]) {return;}
    // 先把上次选择的item设置为可用
    CYXTabBarItem *lastItem = self.items[_selectIndex];
    lastItem.selected = NO;
    // 再把这次选择的item设置为不可用
    CYXTabBarItem *item = self.items[selectIndex];
    item.selected = YES;
    _selectIndex = selectIndex;
    [lastItem updateImageAndTitle];
    [item updateImageAndTitle];
}
@end
