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
    JALoadingView *view = [JALoadingView shared];
    UIView *parentView = [self containerView];
    [parentView addSubview:view];
    view.center = parentView.center;
    [view.indicator startAnimating];
    [JALoadingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:20];
}

+ (void)stopAnimating {
    [NSObject cancelPreviousPerformRequestsWithTarget:[JALoadingView shared]];
    [[JALoadingView shared] removeFromSuperview];
    BOOL isIgnoring = [[UIApplication sharedApplication] isIgnoringInteractionEvents];
    if (isIgnoring)
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

+ (UIView*)containerView {
    return [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
}

@end
