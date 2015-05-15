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
    
    //Beer calculation
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInBeerGlass = 12;
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = alcoholPercentageOfBeer * ouncesInBeerGlass;
    float ouncesOfAlcoholTotal = numberOfBeers * ouncesOfAlcoholPerBeer;
    
    //Wine calculation
    float ouncesInOneWineGlass = 5;
    float alcoholPercentageOfWine = 0.13;
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    //Decide to use plural or singluar
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular of beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"shot", @"singular of shot");
    } else {
        wineText = NSLocalizedString(@"shots", @"plural of shot");
    }
    
    //update labels
    self.numberOfBeersLabel.text = [NSString stringWithFormat:@"%d %@", numberOfBeers, beerText];
    
    //if no alcohol percentage has been entered, keep instructions in results label.
    if (alcoholPercentageOfBeer != 0) {
        NSString *resultText = [NSString stringWithFormat:@"%d %@ contains as much alcohol as %.1f %@ of whiskey", numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
        
        self.resultLabel.text = resultText;
    }
}

@end
