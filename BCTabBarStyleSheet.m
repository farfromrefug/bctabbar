
#import "BCTabBarStyleSheet.h"
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BCTabBarStyleSheet


///////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)connectionBanner {
	return
    [TTSolidFillStyle styleWithColor:[self themeColor] next:
	 [TTFourBorderStyle styleWithTop:nil right:nil bottom:RGBCOLOR(155, 155, 155) left: nil width:2 next:nil
	  ]];
}

- (UIColor *) connectionBarTextColor
{
	return RGBCOLOR(139, 139, 139);
}

- (UIFont *) connectionBarTextFont
{
	return [UIFont boldSystemFontOfSize:11];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (UIColor *) tabBarBackColor
{
	return RGBCOLOR(32, 32, 32);
}

- (UIColor *) tabBarBorderColor
{
	return RGBCOLOR(155, 155, 155);
}

- (UIColor *) tabBarHighlightedColor
{
	return [self themeColor];
}


- (UIFont *) tabBarTextFont
{
	return [UIFont systemFontOfSize:11];
}

- (UIColor *) tabBarTextColor
{
	return RGBCOLOR(139, 139, 139);
}

- (UIColor *) tabBarTextHighlightedColor
{
	return [self themeColor];
}

- (UIColor*) tabBarTextShadowColor
{
	return [UIColor clearColor];
	
}
- (CGSize) tabBarTextShadowOffset
{
	return CGSizeMake(0.0, 0.0);
}
- (UILineBreakMode) tabBarTextLineBreakMode
{
	return UILineBreakModeTailTruncation;
}

- (UIEdgeInsets) tabBarTextEdgeInsets
{
	return UIEdgeInsetsMake(0.0, 0.0, -20.0, 0.0);
}

- (UITextAlignment) tabBarTextAlignment
{
	return UITextAlignmentCenter;
}

- (UIControlContentVerticalAlignment) tabBarTextVAlignment
{
	return UIControlContentVerticalAlignmentTop;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)tabTintColor {
    return RGBCOLOR(150, 150, 150);
}

- (UIColor*)themeColor {
    return RGBCOLOR(0, 108, 255);
}

@end
