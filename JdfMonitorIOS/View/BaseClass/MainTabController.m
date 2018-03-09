//
//  MainTabController.m
//  JdfMonitorIOS
//
//  Created by guyunlong on 3/7/18.
//  Copyright © 2018 jdf. All rights reserved.
//

#import "MainTabController.h"
#import "InformationController.h"
#import "StoreKeeperController.h"
#import "TaskController.h"
#import "JobsController.h"
#import "HomePageController.h"
@interface MainTabController ()

@end

@implementation MainTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINavigationController *homepageNavCtl = ({
        HomePageController *homeController = [[HomePageController alloc] init];
        UIImage * image = [UIImage imageNamed:@"bar_circle"];
        UIImage * selectimage = [UIImage imageNamed:@"bar_circle_select"];
        homeController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:image selectedImage:selectimage];
        [[UINavigationController alloc] initWithRootViewController:homeController];
    });
    UINavigationController *jobsNavCtl = ({
        JobsController *controller = [[JobsController alloc] init];
        UIImage * image = [UIImage imageNamed:@"bar_circle"];
        UIImage * selectimage = [UIImage imageNamed:@"bar_circle_select"];
        controller.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"工作" image:image selectedImage:selectimage];
        [[UINavigationController alloc] initWithRootViewController:controller];
    });
    UINavigationController *taskNavCtl = ({
        TaskController *controller = [[TaskController alloc] init];
        UIImage * image = [UIImage imageNamed:@"bar_circle"];
        UIImage * selectimage = [UIImage imageNamed:@"bar_circle_select"];
        controller.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"任务" image:image selectedImage:selectimage];
        [[UINavigationController alloc] initWithRootViewController:controller];
    });
    UINavigationController *storeKeeperNavCtl = ({
        StoreKeeperController *controller = [[StoreKeeperController alloc] init];
        UIImage * image = [UIImage imageNamed:@"bar_circle"];
        UIImage * selectimage = [UIImage imageNamed:@"bar_circle_select"];
        controller.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"仓管" image:image selectedImage:selectimage];
        [[UINavigationController alloc] initWithRootViewController:controller];
    });
    UINavigationController *informationNavCtl = ({
        InformationController *controller = [[InformationController alloc] init];
        UIImage * image = [UIImage imageNamed:@"bar_circle"];
        UIImage * selectimage = [UIImage imageNamed:@"bar_circle_select"];
        controller.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"资讯" image:image selectedImage:selectimage];
        [[UINavigationController alloc] initWithRootViewController:controller];
    });
    self.viewControllers = @[ homepageNavCtl, jobsNavCtl, taskNavCtl, storeKeeperNavCtl,informationNavCtl ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
