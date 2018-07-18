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
    CGFloat  itemWidth =screenWidth/viewControllers.count;
    for (int i= 0; i<viewControllers.count; i++) {
        CYXTabBarItem * item = [[CYXTabBarItem alloc] init];
        item.maxImageSize = self.maxImageSize;
        item.minImageSize = self.minImageSize;
        item.titleColor = self.titleColor;
        item.selectedTitleColor = self.selectedTitleColor;
        UIViewController * viewController = viewControllers[i];
        item.title = [viewController.tabBarItem.title length]?viewController.tabBarItem.title:viewController.title;
        item.selectedImage = viewController.tabBarItem.selectedImage;
        item.image = viewController.tabBarItem.image;
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(itemWidth);
            make.height.equalTo(self);
            make.top.equalTo(self);
            make.left.mas_equalTo(i*itemWidth);
        }];
        
        [self.items addObject:item];
        __weak __typeof(self) _self = self;
        item.selectBlock = ^{
            _self.selectIndex = i;
            if (_self.selectBlock) {
                _self.selectBlock(_self.selectIndex);
            }
        };
        [item updateImageAndTitle];
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
