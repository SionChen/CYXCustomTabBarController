//
//  CYXTabBar.m
//  CYXCustomTabBarController
//
//  Created by 超级腕电商 on 2018/7/17.
//  Copyright © 2018年 超级腕电商. All rights reserved.
//

#import "CYXTabBar.h"
#import "CYXBarView.h"
#import "Masonry.h"
@interface CYXTabBar ()

@end
@implementation CYXTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tabBarView];
        [self.tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.right.and.left.and.bottom.equalTo(self);
        }];
        
    }
    
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 把tabBarView带到最前面，覆盖tabBar的内容
    [self bringSubviewToFront:self.tabBarView];
    /*隐藏原来的*/
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            view.hidden = YES;
        }
    }
    
}
// 重写hitTest方法，让超出tabBar部分也能响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    // 如果事件发生在tabbar里面直接返回
    if (result) {
        return result;
    }
    // 这里遍历那些超出的部分就可以了，不过这么写比较通用。
    for (UIView *subview in self.tabBarView.subviews) {
        // 把这个坐标从tabbar的坐标系转为subview的坐标系
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        // 如果事件发生在subView里就返回
        if (result) {
            return result;
        }
    }
    return nil;
}
#pragma mark ---G
-(CYXBarView*)tabBarView{
    if(!_tabBarView){
        _tabBarView = [[CYXBarView alloc] init];
    }
    return _tabBarView;
}
@end
