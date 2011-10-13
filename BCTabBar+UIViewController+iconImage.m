#import "BCTabBar+UIViewController+iconImage.h"


@implementation UIViewController (BCTabBarController)

- (NSString *)iconTitleForURL:(NSString *) url {
	return @"";
}


- (NSString *)iconImageNameForURL:(NSString *) url {
	return @"";
}

- (NSString *)selectedIconImageNameSuffix {
	return @"";
}

- (NSString *)landscapeIconImageNameSuffix {
	return @"";
}

- (void)setTabBarButton:(BCTab*) tabBarButton forURL:(NSString *) url
{
	
}

- (UIViewContentMode)imageContentModeForURL:(NSString *) url
{
    return UIViewContentModeScaleAspectFit;
}

@end
