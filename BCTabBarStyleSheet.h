// Style
#import "Three20Style/TTStyleSheet.h"

@interface BCTabBarStyleSheet : TTDefaultStyleSheet

@property (nonatomic, readonly) TTStyle *connectionBanner;
@property (nonatomic, readonly) UIColor	*connectionBarTextColor;
@property (nonatomic, readonly) UIFont	*connectionBarTextFont;

@property (nonatomic, readonly) UIColor	*navBarBackColor;
@property (nonatomic, readonly) UIColor	*navBarBorderColor;
@property (nonatomic, readonly) UIFont *navBarTextFont;
@property (nonatomic, readonly) UIFont *navBarSubtitleTextFont;
@property (nonatomic, readonly) UIColor	*navBarTextColor;
@property (nonatomic, readonly) UIColor	*navBarSubtitleTextColor;

@property (nonatomic, readonly) UIColor	*tabBarBackColor;
@property (nonatomic, readonly) UIColor	*tabBarBorderColor;
@property (nonatomic, readonly) UIColor	*tabBarHighlightedColor;
@property (nonatomic, readonly) UIFont *tabBarTextFont;
@property (nonatomic, readonly) UIColor	*tabBarTextColor;
@property (nonatomic, readonly) UIColor	*tabBarTextHighlightedColor;
@property (nonatomic, readonly) UIColor	*tabBarTextShadowColor;
@property (nonatomic, readonly) CGSize	tabBarTextShadowOffset;
@property (nonatomic, readonly) UILineBreakMode	tabBarTextLineBreakMode;
@property (nonatomic, readonly) UIEdgeInsets tabBarTextEdgeInsets;
@property (nonatomic, readonly) UITextAlignment tabBarTextAlignment;
@property (nonatomic, readonly) UIControlContentVerticalAlignment tabBarTextVAlignment;

@property (nonatomic, readonly) UIColor*  tabTintColor;

@property (nonatomic, readonly) UIColor*  themeColor;
@end
