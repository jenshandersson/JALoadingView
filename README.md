JALoadingView
=============

An easy to use loading indicator for iOS.

![JALoadingView Screen Shot](https://github.com/jenshandersson/JALoadingView/raw/master/Screen%20Shot.png "Shows the JALoadingView in center")

### Installation

Easiest was, as always, is to add this to your Podfile:

    "pod 'JALoadingView', :git => 'https://github.com/jenshandersson/JALoadingView.git"

### Usage

All you need to do is call -startAnimating and -stopAnimating.

    [JALoadingView startAnimating];
    ...
    Do crazy stuff
    ...
    [JALoadingView stopAnimating];
