#import "BCTabBar.h"

@class BCTabBarView;

@interface BCTabBarController : UIViewController <BCTabBarDelegate, UINavigationControllerDelegate> {
	NSArray *viewControllers;
	NSArray *viewURLs;
	UIViewController *selectedViewController;
	BCTabBar *tabBar;
	BCTabBarView *tabBarView;
	BOOL visible;
    UIViewController* surrogateParent;
}

@property (nonatomic, retain) NSArray *viewControllers;
@property (nonatomic, retain) NSArray *viewURLs;
@property (nonatomic, retain) BCTabBar *tabBar;
@property (nonatomic, retain) UIViewController *selectedViewController;
@property (nonatomic, retain) BCTabBarView *tabBarView;
@property (nonatomic) NSUInteger selectedIndex;

@property (nonatomic, assign) UIViewController *surrogateParent;
- (UIViewController*)rootControllerForController:(UIViewController*)controller;
- (void)setTabURLs:(NSArray*)URLs;

@end
