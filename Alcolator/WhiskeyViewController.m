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

- (void) calcAndUpdateAlcolator {
    
    //Alcohol constants
    const int ouncesInBeerGlass = 12;
    const float ouncesInOneWhiskeyGlass = 5;
    const float alcoholPercentageOfWhiskey = 0.13;
    
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
    
    NSString *WhiskeyText;
    
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
        WhiskeyText = NSLocalizedString(@"shot", @"singular of shot");
    } else {
        WhiskeyText = NSLocalizedString(@"shots", @"plural of shot");
    }
    
    //update labels
    self.numberOfBeersLabel.text = [NSString stringWithFormat:@"%d %@", numberOfBeers, beerText];
    
    //if no alcohol percentage has been entered, keep instructions in results label.
    if (alcoholPercentageOfBeer != 0) {
        NSString *resultText = [NSString stringWithFormat:@"%d %@ contains as much alcohol as %.1f %@ of whiskey", numberOfBeers, beerText, numberOfWhiskeyGlassesForEquivalentAlcoholAmount, WhiskeyText];
        
        self.resultLabel.text = resultText;
    }
}

@end
