
@class BCTab;
@interface UIViewController (BCTabBarController)

- (NSString *)iconTitleForURL:(NSString *) url;
- (NSString *)iconImageNameForURL:(NSString *) url;

- (NSString *)selectedIconImageNameSuffix;
- (NSString *)landscapeIconImageNameSuffix;

- (void)setTabBarButton:(BCTab*) tabBarButton forURL:(NSString *) url;
- (UIViewContentMode)imageContentModeForURL:(NSString *) url;

@end
