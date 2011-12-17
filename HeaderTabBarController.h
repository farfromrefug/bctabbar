#import <Three20/Three20.h>
#import "BCTabBarController.h"
//#import "CustomTabBarViewController.h"

@class ConnectionActivityLabel;
@interface HeaderTabBarController : UIViewController {
    ConnectionActivityLabel* _connectionlabel;
    
    BCTabBarController* _tabBarController;
//    CustomTabBarViewController* _tabBarController;
    
    BOOL _headerVisible;
}
@property (nonatomic) BOOL headerVisible;

- (void)setDisconnectedHeader;

- (void)setTabURLs:(NSArray*)URLs;
- (void)showHeader;
- (void)hideHeader;
@end
