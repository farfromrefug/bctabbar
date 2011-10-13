#import "BCTabBarController.h"
#import "BCTabBar.h"
#import "BCTab.h"
#import "BCTabBar+UIViewController+iconImage.h"
#import "BCTabBarView.h"

#define kUINavigationControllerPushPopAnimationDuration     0.35
#define kTabBarHeight     50

@interface BCTabBarController ()

- (void)loadTabs;

@property (nonatomic, retain) UIImageView *selectedTab;

@end


@implementation BCTabBarController
@synthesize viewControllers, viewURLs, tabBar, selectedTab, selectedViewController, tabBarView;
@synthesize surrogateParent;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController*)rootControllerForController:(UIViewController*)controller 
{
	if ([controller canContainControllers]) {
		return controller;
		
	} else {
		TTNavigationController* navController = [[[TTNavigationController alloc] init] autorelease];
		[navController pushViewController:controller animated:NO];
		return navController;
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)canContainControllers {
	return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController*)topSubcontroller {
	return self.selectedViewController;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addSubcontroller:(UIViewController*)controller animated:(BOOL)animated
transition:(UIViewAnimationTransition)transition {
	self.selectedViewController = controller;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)bringControllerToFront:(UIViewController*)controller animated:(BOOL)animated {
	self.selectedViewController = controller;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)keyForSubcontroller:(UIViewController*)controller {
	return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController*)subcontrollerForKey:(NSString*)key {
	return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)persistNavigationPath:(NSMutableArray*)path {
	UIViewController* controller = self.selectedViewController;
	[[TTNavigator navigator] persistController:controller path:path];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTabURLs:(NSArray*)URLs {
	NSMutableArray* controllers = [NSMutableArray array];
	NSMutableArray* viewURLS = [NSMutableArray array];
	for (NSString* URL in URLs) {
		UIViewController* controller = [[TTNavigator navigator] viewControllerForURL:URL];
		if (controller) {
			UIViewController* tabController = [self rootControllerForController:controller];
			[tabController setSuperController:self];
			[controllers addObject:tabController];
			[viewURLS addObject:URL];
            
		}
	}
    self.viewURLs = viewURLS;
	self.viewControllers = controllers;
}

- (void)loadView {
	self.tabBarView = [[[BCTabBarView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
	self.view = self.tabBarView;
	self.view.backgroundColor = [UIColor clearColor];

	self.tabBar = [[[BCTabBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height 
                                                              - kTabBarHeight, 
															  self.view.frame.size.width
                                                              , kTabBarHeight)]
				   autorelease];
	self.tabBar.delegate = self;
	
	self.tabBarView.tabBar = self.tabBar;
	[self loadTabs];
	
	UIViewController *tmp = selectedViewController;
	selectedViewController = nil;
	[self setSelectedViewController:tmp];
}

- (void)tabBar:(BCTabBar *)aTabBar didSelectTabAtIndex:(NSInteger)index {
	UIViewController *vc = [self.viewControllers objectAtIndex:index];
//	if (self.selectedViewController == vc) {
//		if ([[self.selectedViewController class] isSubclassOfClass:[UINavigationController class]]) {
//			[(UINavigationController *)self.selectedViewController popViewControllerAnimated:YES];
////			[[[self topSubcontroller] topSubcontroller].navigationController popViewControllerAnimated:YES];
//		}
//	} else {
//		self.selectedViewController = vc;
//	}
//	
    self.selectedViewController = vc;
    TTOpenURL([self.viewURLs objectAtIndex:index]);
}

- (void)setSelectedViewController:(UIViewController *)vc {
	UIViewController *oldVC = selectedViewController;
	if (selectedViewController != vc) {
		[selectedViewController release];
		selectedViewController = [vc retain];
		if (visible) {
			[oldVC viewWillDisappear:NO];
            [selectedViewController view];  // let the view load itself, in case the view is didUnload
			[selectedViewController viewWillAppear:NO];
		}
		self.tabBarView.contentView = vc.view;
		if (visible) {
			[oldVC viewDidDisappear:NO];
			[selectedViewController viewDidAppear:NO];
		}
		if ([self.tabBar.tabs count] > self.selectedIndex)
		{
			[self.tabBar setSelectedTab:[self.tabBar.tabs objectAtIndex:self.selectedIndex] animated:(oldVC != nil)];
		}
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.surrogateParent viewWillAppear:animated];
    [self.selectedViewController view];  // let the view load itself, in case the view is didUnload
	[self.selectedViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.surrogateParent viewDidAppear:animated];
	[self.selectedViewController viewDidAppear:animated];
	visible = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.surrogateParent viewWillDisappear:animated];
	[self.selectedViewController viewWillDisappear:animated];	
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[self.surrogateParent viewDidDisappear:animated];
	[self.selectedViewController viewDidDisappear:animated];
	visible = NO;
}



- (NSUInteger)selectedIndex {
	return [self.viewControllers indexOfObject:self.selectedViewController];
}

- (void)setSelectedIndex:(NSUInteger)aSelectedIndex {
	if (self.viewControllers.count > aSelectedIndex)
		self.selectedViewController = [self.viewControllers objectAtIndex:aSelectedIndex];
}

- (void)loadTabs {
	NSMutableArray *tabs = [NSMutableArray arrayWithCapacity:self.viewControllers.count];
    
    int i = 0;
    for (UIViewController *vc in self.viewControllers) {
        NSString *url = [self.viewURLs objectAtIndex:i];
        if ([[vc class] isSubclassOfClass:[UINavigationController class]]) {
            ((UINavigationController *)vc).delegate = self;
        }

		BCTab* button = [[[BCTab alloc] 
						  initWithIconImageName:[vc iconImageNameForURL:url] 
						  selectedImageNameSuffix:[vc selectedIconImageNameSuffix] 
						  landscapeImageNameSuffix:[vc landscapeIconImageNameSuffix]
						 title:[vc iconTitleForURL:url]]
						 autorelease];
        button.imageView.contentMode = [vc imageContentModeForURL:[self.viewURLs objectAtIndex:i]];
		[vc setTabBarButton:button forURL:url];
        [tabs addObject:button];
        i++;
	}

	self.tabBar.tabs = tabs;
	if ([self.tabBar.tabs count] > self.selectedIndex)
	{
		[self.tabBar setSelectedTab:[self.tabBar.tabs objectAtIndex:self.selectedIndex] animated:NO];
	}
}

- (void)adjustTabsToOrientation {
    for (BCTab *tab in self.tabBar.tabs) {
        [tab adjustImageForOrientation];
    }
}

- (void)viewDidUnload {
	self.tabBar = nil;
	self.selectedTab = nil;
    [super viewDidUnload];
}

- (void)setViewControllers:(NSArray *)array {
	if (array != viewControllers) {
		[viewControllers release];
		viewControllers = [array retain];
		
		if (viewControllers != nil) {
			[self loadTabs];
		}
	}
	
	self.selectedIndex = 0;
}

- (void)dealloc {
	self.viewControllers = nil;
	self.tabBar = nil;
	self.selectedTab = nil;
	self.tabBarView = nil;
	[super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return [self.selectedViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[self.selectedViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[self.selectedViewController willAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
	[self.selectedViewController willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
}

- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration {
	[self.selectedViewController willAnimateSecondHalfOfRotationFromInterfaceOrientation:fromInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self.selectedViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self adjustTabsToOrientation];
}

- (void)hideTabBar:(BOOL)animated isPush:(BOOL)isPush {
    if (tabBar.isInvisible) {
        return;
    }
    tabBar.isInvisible = YES;
	CGRect f = self.tabBarView.contentView.frame;
    f.size.height = self.tabBarView.bounds.size.height;
	self.tabBarView.contentView.frame = f;
    
    NSTimeInterval duration = 0.0;
    if (animated) {
        duration = kUINavigationControllerPushPopAnimationDuration;
    }
    CGFloat magicNumber = - 1.0;
    if (!isPush) {
        magicNumber = 2.0;
    }
    self.tabBar.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:duration
                     animations:^{self.tabBar.transform = CGAffineTransformMakeTranslation(self.tabBar.bounds.size.width * magicNumber, 0.0);}
                     completion:^(BOOL finished){
                         self.tabBar.hidden = YES;
                         self.tabBar.transform = CGAffineTransformIdentity;
                     }];
    [self.tabBarView setNeedsLayout];
}

- (void)showTabBar:(BOOL)animated isPush:(BOOL)isPush {
    if (!tabBar.isInvisible) {
        return;
    }
    
    NSTimeInterval duration = 0.0;
    if (animated) {
        duration = kUINavigationControllerPushPopAnimationDuration;
    }
    CGFloat magicNumber = 2.0;
    if (!isPush) {
        magicNumber = - 1.0;
    }
    self.tabBar.transform = CGAffineTransformMakeTranslation(self.tabBar.bounds.size.width * magicNumber, 0.0);
    self.tabBar.hidden = NO;
    [UIView animateWithDuration:duration
                     animations:^{self.tabBar.transform = CGAffineTransformIdentity;}
                     completion:^(BOOL finished){
                         tabBar.isInvisible = NO;
                         [self.tabBarView setNeedsLayout];
                     }];
}

#pragma - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isPush = YES;
    UINavigationItem *newTopItem = navigationController.topViewController.navigationItem;
    if ([newTopItem isEqual:navigationController.navigationBar.topItem] && !animated) {
        // do nothing;
        return;
    } else {
        for (UINavigationItem *item in navigationController.navigationBar.items) {
            if ([item isEqual:newTopItem]) {
                isPush = NO;
                break;
            }
        }
    }
    if (viewController.hidesBottomBarWhenPushed) {
        [self hideTabBar:animated isPush:isPush];
    } else {
        [self showTabBar:animated isPush:isPush];
    }
}

/*
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}
*/

@end
