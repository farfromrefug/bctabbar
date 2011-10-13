#import <Foundation/Foundation.h>

@class BCTab;
@interface UINavigationController (BCTabBarController)

- (NSString *)iconTitleForURL:(NSString *) url;
- (NSString *)iconImageNameForURL:(NSString *) url;

- (NSString *)selectedIconImageNameSuffix;
- (NSString *)landscapeIconImageNameSuffix;

- (void)setTabBarButton:(BCTab*) tabBarButton forURL:(NSString *) url;
- (UIViewContentMode)imageContentModeForURL:(NSString *) url;
@end
