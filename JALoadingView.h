//
//  JALoadingView.h
//
//  Created by Jens Andersson on 2013-05-16.
//  Copyright (c) 2013 Jens Andersson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JALoadingView : UIView

@property (nonatomic) UIActivityIndicatorView *indicator;

+ (void)stopAnimating;
+ (void)startAnimating;

@end
