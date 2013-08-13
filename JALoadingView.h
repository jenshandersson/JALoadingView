//
//  JALoadingView.h
//
//  Created by Jens Andersson on 2013-05-16.
//  Copyright (c) 2013 Jens Andersson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JALoadingViewStyle) {
    // Gray background with white indicatio, default
    JALoadingViewStyleWhiteGrayBackground,
    // White indicator
    JALoadingViewStyleWhite,
    // Gray indicator
    JALoadingViewStyleGrey
};

@interface JALoadingView : UIView

@property (nonatomic, retain) UIActivityIndicatorView *indicator;

+ (JALoadingView *)shared;
+ (void)stopAnimating;
+ (void)startAnimating;

- (void)stopAnimating;
- (void)startAnimating;
- (void)startAnimatingInView:(UIView *)parentView;

@end

@interface UIView (JALoadingView)

- (void)startLoadingWithStyle:(JALoadingViewStyle)style;
- (void)stopLoading;

@end
