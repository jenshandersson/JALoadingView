//
//  JALoadingView.m
//
//  Created by Jens Andersson on 2013-05-16.
//  Copyright (c) 2013 Jens Andersson. All rights reserved.
//

#import "JALoadingView.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat side = 40;

@implementation JALoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init {
    self = [super initWithFrame:CGRectMake(0, 0, side, side)];
    
    if (self) {
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        self.indicator.center = CGPointMake(side / 2, side / 2);
        self.autoresizingMask =   UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        self.indicator.hidesWhenStopped = YES;
        [self.indicator startAnimating];
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.4];
        
        [self addSubview:self.indicator];
    }
    return self;
}

+ (JALoadingView *)shared {
    static JALoadingView *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    
    return _shared;
}
+ (void)startAnimating {
    [[JALoadingView shared] startAnimating];
}
+ (void)stopAnimating {
    [[JALoadingView shared] stopAnimating];
}

- (void)startAnimating {
    [self startAnimatingInView:[self containerView]];
}

- (void)startAnimatingInView:(UIView *)parentView {
    [parentView addSubview:self];
    self.center = CGPointMake(parentView.bounds.size.width / 2,parentView.bounds.size.height / 2);
    [self.indicator startAnimating];
    [self performSelector:@selector(stopAnimating) withObject:nil afterDelay:20];
}

- (void)stopAnimating {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self removeFromSuperview];
    // Fix to be able to call stopAnimating more oftan than startAnimating
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

- (UIView*)containerView {
    return [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
}

@end

@implementation UIView (JALoadingView)

- (void)startLoadingWithStyle:(JALoadingViewStyle)style {
    JALoadingView *loader = [JALoadingView new];
    loader.backgroundColor = [UIColor clearColor];
    
    if (style == JALoadingViewStyleGrey)
       loader.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    else if (style == JALoadingViewStyleWhite)
        loader.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [loader startAnimatingInView:self];
}

- (void)stopLoading {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[JALoadingView class]])
            [subView removeFromSuperview];
    }
}

@end
