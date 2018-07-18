//
//  CYXTabBarViewController.m
//  CYXCustomTabBarController
//
//  Created by 超级腕电商 on 2018/7/17.
//  Copyright © 2018年 超级腕电商. All rights reserved.
//

#import "CYXTabBarViewController.h"
#import "CYXTabBar.h"
#import "CYXBarView.h"
@interface CYXTabBarViewController ()
@property (nonatomic,strong) CYXTabBar *customTabBar;
@end

@implementation CYXTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setValue:self.customTabBar forKey:@"tabBar"];
    
    [self initViewControllers];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.selectedIndex = 3;
    });
}
-(void)initViewControllers{
    NSMutableArray * viewControllers = [NSMutableArray new];
    UIViewController *homeVC = [[UIViewController alloc] init];
    homeVC.view.backgroundColor = [UIColor redColor];
    [viewControllers addObject:[self addChildViewController:homeVC title:@"首页" imageNamed:@"tabBar_home"]];
    
    UIViewController *expoVC = [[UIViewController alloc] init];
    expoVC.view.backgroundColor = [UIColor yellowColor];
    [viewControllers addObject:[self addChildViewController:expoVC title:@"家博会" imageNamed:@"tabBar_activity"]];
    
    UIViewController *activityVC = [[UIViewController alloc] init];
    activityVC.view.backgroundColor = [UIColor yellowColor];
    [viewControllers addObject:[self addChildViewController:activityVC title:@"" imageNamed:@"tabBar_activity"]];
    
    UIViewController *findVC = [[UIViewController alloc] init];
    findVC.view.backgroundColor = [UIColor blueColor];
    [viewControllers addObject:[self addChildViewController:findVC title:@"发现" imageNamed:@"tabBar_find"]];
    
    UIViewController *mineVC = [[UIViewController alloc] init];
    mineVC.view.backgroundColor = [UIColor greenColor];
    [viewControllers addObject:[self addChildViewController:mineVC title:@"我的" imageNamed:@"tabBar_mine"]];
    
    self.viewControllers = viewControllers;
}
// 添加某个 childViewController
- (UINavigationController *)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
    vc.navigationItem.title = title;
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageNamed];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:@"jmtIconBg"];
    return nav;
}

-(void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    [super setViewControllers:viewControllers];
    [self.customTabBar.tabBarView initButtonWithViewControllers:viewControllers];
}
-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    self.customTabBar.tabBarView.selectIndex = selectedIndex;
}
#pragma mark ---G
-(CYXTabBar*)customTabBar{
    if(!_customTabBar){
        _customTabBar = [[CYXTabBar alloc] init];
        __weak __typeof(self) _self = self;
        _customTabBar.tabBarView.selectBlock = ^(NSInteger index) {
             _self.selectedIndex = index;
        };
    }
    return _customTabBar;
}

@end
