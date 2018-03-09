//
//  ScheduleController.m
//  JdfMonitorIOS
//
//  Created by guyunlong on 3/8/18.
//  Copyright © 2018 jdf. All rights reserved.
//
#import "TableHeaderSelectView.h"
#import "JobsController.h"
#import "EquipmentMonitorController.h"
#import "VidController.h"
#import "ComputerRoomInspectController.h"
#import "ScheduleController.h"
#import "UIView+Common.h"
#import "Masonry.h"
@interface JobsController()<TableHeaderSelectViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (strong, nonatomic) TableHeaderSelectView* headerView;//
@property (nonatomic, strong) UIPageViewController * pageController;
@property (nonatomic,strong) NSArray *tabBarItemTitles;
@property (nonatomic,strong) EquipmentMonitorController *equipmentMonitorController;
@property (nonatomic,strong) VidController *vidController;
@property (nonatomic,strong) ComputerRoomInspectController *computerRoomInspectController;
@property (nonatomic,strong) ScheduleController *scheduleController;
@property (nonatomic,assign) NSInteger selectIndex;
@end

@implementation JobsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initValue];
    [self initView];
}
-(void)initValue{
    _tabBarItemTitles = @[@"设备监控",@"视频监控",@"机房巡检",@"排班计划"];
}
-(void)initView{
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    /**********************************************************************/
    _headerView = [[TableHeaderSelectView alloc] initWithFrame:CGRectMake(0, 0, FFScreenWith, 40)];
    [_headerView setMatch:false];
    [_headerView setDelegate:self];
    [_headerView setData:_tabBarItemTitles];
    [self.view addSubview:_headerView];
    
    
    /**********************************************************************/
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    UIViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    
    
    
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
    [self.pageController didMoveToParentViewController:self];
    [_pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(40, 0, 0, 0));
    }];
    /*********************************************************************/
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.tabBarItemTitles count] == 0) || (index >= [self.tabBarItemTitles count])) {
        return nil;
    }
    if(0 == index){
        return [self equipmentMonitorController];
    }
    else if(1 == index){
        return [self vidController];
    }
    else if(2 == index){
        return [self computerRoomInspectController];
    }
    else if(3 == index){
        return [self scheduleController];
    }
    else{
        return nil;
    }
    
}
-(EquipmentMonitorController*)equipmentMonitorController{
    if (!_equipmentMonitorController) {
        _equipmentMonitorController =  [EquipmentMonitorController new];
    }
    return _equipmentMonitorController;
}

-(VidController*)vidController{
    if (!_vidController) {
        _vidController =  [VidController new];
    }
    return _vidController;
}
-(ComputerRoomInspectController*)computerRoomInspectController{
    if (!_computerRoomInspectController) {
        _computerRoomInspectController =  [ComputerRoomInspectController new];
    }
    return _computerRoomInspectController;
}

-(ScheduleController*)scheduleController{
    if (!_scheduleController) {
        _scheduleController =  [ScheduleController new];
    }
    return _scheduleController;
}

#pragma mark - Page View Controller Data Source
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    if ([viewController isKindOfClass:[VidController class]]) {

        return [self viewControllerAtIndex:0];
    }
    else if ([viewController isKindOfClass:[ComputerRoomInspectController class]]) {

        return [self viewControllerAtIndex:1];
    }
    else if ([viewController isKindOfClass:[ScheduleController class]]) {
        
        return [self viewControllerAtIndex:2];
    }
    else{
        return nil;
    }
    
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[EquipmentMonitorController class]]) {
        
        return [self viewControllerAtIndex:1];
    }
    if ([viewController isKindOfClass:[VidController class]]) {
        
        return [self viewControllerAtIndex:2];
    }
    else if ([viewController isKindOfClass:[ComputerRoomInspectController class]]) {
        
        return [self viewControllerAtIndex:3];
    }
    else{
        return nil;
    }
}
#pragma mark - Page View Controller Delegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    UIViewController *viewController = [self.pageController.viewControllers lastObject];
    if ([viewController isKindOfClass:[EquipmentMonitorController class]]) {
        _selectIndex = 0;
    }
    else if([viewController isKindOfClass:[VidController class]]){
       _selectIndex = 1;
    }
    else if([viewController isKindOfClass:[ComputerRoomInspectController class]]){
        _selectIndex = 2;
    }
    else if([viewController isKindOfClass:[ScheduleController class]]){
        _selectIndex = 3;
    }
     [_headerView tran2Index:_selectIndex];
}
#pragma mark - CircleTableHeaderViewDelegate
- (void)selectedIndex:(NSInteger)index{
    if(index != _selectIndex){
        _selectIndex = index;
        
        
        UIViewController *startingViewController = [self viewControllerAtIndex:index];
        NSArray *viewControllers = @[startingViewController];
        [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}


@end
