//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by Trevor Vieweg on 5/14/15.
//  Copyright (c) 2015 Trevor Vieweg. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

@end

@implementation WhiskeyViewController

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.title = NSLocalizedString(@"Whiskey", nil);
        
        // Since we don't have icons, move the title to the middle of the tab bar
        [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
    }
    
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
}

- (void) calcAndUpdateAlcolator {
    
    //Alcohol constants
    const int ouncesInBeerGlass = 12;
    const float ouncesInOneWhiskeyGlass = 1;
    const float alcoholPercentageOfWhiskey = 0.4;
    
    //Beer calculation
    int numberOfBeers = self.beerCountSlider.value;

    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = alcoholPercentageOfBeer * ouncesInBeerGlass;
    float ouncesOfAlcoholTotal = numberOfBeers * ouncesOfAlcoholPerBeer;
    
    //Whiskey calculation
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
    
    //Decide to use plural or singluar
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular of beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *whiskeyText;
    
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
        whiskeyText = NSLocalizedString(@"shot", @"singular of shot");
    } else {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shot");
    }
    
    //update labels
    self.numberOfBeersLabel.text = [NSString stringWithFormat:@"%d %@", numberOfBeers, beerText];
    
    //if no alcohol percentage has been entered, keep instructions in results label.
    if (alcoholPercentageOfBeer != 0) {
        NSString *resultText = [NSString stringWithFormat:@"%d %@ contains as much alcohol as %.1f %@ of whiskey", numberOfBeers, beerText, numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
        
        self.resultLabel.text = resultText;
        
        self.title = [NSString stringWithFormat:@"Wine (%.1f %@)", numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];

    }
}

@end
