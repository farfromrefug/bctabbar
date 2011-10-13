#import "BCTabBar+UINavigationController+icons.h"
#import "BCTabBar+UIViewController+iconImage.h"

@implementation UINavigationController (BCTabBarController)

- (NSString *)iconTitleForURL:(NSString *) url {
	return [[self.viewControllers objectAtIndex:0] iconTitleForURL:url];
}

- (NSString *)iconImageNameForURL:(NSString *) url {
	return [[self.viewControllers objectAtIndex:0] iconImageNameForURL:url];
}

- (NSString *)selectedIconImageNameSuffix {
	return [[self.viewControllers objectAtIndex:0] selectedIconImageNameSuffix];
}

- (NSString *)landscapeIconImageNameSuffix {
	return [[self.viewControllers objectAtIndex:0] landscapeIconImageNameSuffix];
}

- (void)setTabBarButton:(BCTab*) tabBarButton forURL:(NSString *) url
{
	[[self.viewControllers objectAtIndex:0] setTabBarButton:tabBarButton forURL:url];
}

- (UIViewContentMode)imageContentModeForURL:(NSString *) url
{
	return [[self.viewControllers objectAtIndex:0] imageContentModeForURL:url];
}
@end
