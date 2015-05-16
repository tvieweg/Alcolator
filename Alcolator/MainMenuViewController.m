//
//  MainMenuViewController.m
//  Alcolator
//
//  Created by Trevor Vieweg on 5/16/15.
//  Copyright (c) 2015 Trevor Vieweg. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ViewController.h"
#import "WhiskeyViewController.h"

@interface MainMenuViewController ()

@property (nonatomic, strong) UIButton *wineButton;
@property (nonatomic, strong) UIButton *whiskeyButton;

@end

@implementation MainMenuViewController

- (void)loadView {
    
    //setup buttons and add to view
    self.wineButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.whiskeyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.wineButton setTitle:NSLocalizedString(@"Wine", @"Wine")  forState:UIControlStateNormal];
    [self.whiskeyButton setTitle:NSLocalizedString(@"Whiskey", @"Whiskey") forState:UIControlStateNormal];
    
    self.view = [[UIView alloc] init];
    
    [self.view addSubview:self.wineButton];
    [self.view addSubview:self.whiskeyButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set view background color
    self.view.backgroundColor = [UIColor colorWithRed:(82/255.0) green:(180/255.0) blue:(180/255.0) alpha:1.0];
    
    //set button titles and font color
    UIFont *bigFont = [UIFont boldSystemFontOfSize:20];
    
    [self.wineButton.titleLabel setFont:bigFont];
    [self.whiskeyButton.titleLabel setFont:bigFont];
    
    self.wineButton.titleLabel.textColor = [UIColor whiteColor];
    self.whiskeyButton.titleLabel.textColor = [UIColor whiteColor];

    //Add targets for buttons
    [self.wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside]; 
    
    //set navigation title
    self.title = NSLocalizedString(@"Select Alcolator", @"Select Alcolator");
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    //Create divisions for wine and whiskey buttons - split screen in half.
    CGRect wineButtonFrame, whiskeyButtonFrame;
    CGRectDivide(self.view.bounds, &wineButtonFrame, &whiskeyButtonFrame, CGRectGetWidth(self.view.bounds) / 2, CGRectMinXEdge);
    
    self.wineButton.frame = wineButtonFrame;
    self.whiskeyButton.frame = whiskeyButtonFrame;
    
}

- (void)winePressed: (UIButton *) sender {
    ViewController *wineVC = [[ViewController alloc] init];
    [self.navigationController pushViewController:wineVC animated:YES];
}

- (void)whiskeyPressed: (UIButton *) sender {
    WhiskeyViewController *whiskeyVC = [[WhiskeyViewController alloc] init];
    [self.navigationController pushViewController:whiskeyVC animated:YES]; 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
