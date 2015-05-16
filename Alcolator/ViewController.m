//
//  ViewController.m
//  Alcolator
//
//  Created by Trevor Vieweg on 5/13/15.
//  Copyright (c) 2015 Trevor Vieweg. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UIGestureRecognizer *hideKeyboardTapGestureRecognizer;
@property (assign, nonatomic) CGFloat fontSize;

@end

@implementation ViewController

const int defaultFontSize = 10;
const int defaultScreenWidth = 320;
const int relativeHeightPadding = 30; 

- (void)loadView {
    
    //allocate and initialize the view.
    self.view = [[UIView alloc] init];
    
    //allocate and initialize each of the views and gesture recognizer
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *percentLabel = [[UILabel alloc] init];
    UILabel *numberLabel = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    //Add each view and the gesture recognizer as the view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:percentLabel];
    [self.view addSubview:numberLabel];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    //Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = percentLabel;
    self.numberOfBeersLabel = numberLabel;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
    
    //set font size based on device screen size.

    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set primary view's background color to lightGrayColor
    self.view.backgroundColor = [UIColor colorWithRed:(82/255.0) green:(180/255.0) blue:(180/255.0) alpha:1.0];
    
    //Tells the text field that 'self', this instance of ViewController should be treated as the text field's delegate.
    self.beerPercentTextField.delegate = self;
    self.beerPercentTextField.backgroundColor = [UIColor whiteColor];
    
    //Set the placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder");
    
    //Tells 'self.beerCountSlider' that when its value changes, it should call '[self sliderValueDidChange:]'.
    //This is equivalent to connecting th IBAction in our previous checkpoint.
    [self.beerCountSlider addTarget:self action:@selector(sliderDidChange:) forControlEvents:UIControlEventValueChanged];
    
    //Set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    //Tells 'self.calculateButton' that when a finger is lifted from the button while still inside its bounds, to call '[self -buttonPressed:]'
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //Set the title of the button
    [self.calculateButton setTitle: NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    
    //Tells the tap gesture recognizer to call '[self -tapGestureDidFire:]' when it detects a tap.
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    //Gets rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    _fontSize = defaultFontSize * self.view.frame.size.height / defaultScreenWidth;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    //set parameters for views based on iPhone 4 and 5 screen sizes.
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat padding = self.view.frame.size.height / 30;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = self.view.frame.size.height / 10;
    
    self.beerPercentTextField.frame = CGRectMake(padding, padding * 3, itemWidth, 16 * 2);
    self.beerPercentTextField.font = [UIFont fontWithName:@"Arial" size: _fontSize];
    self.beerPercentTextField.textAlignment = NSTextAlignmentCenter;
    self.beerPercentTextField.layer.cornerRadius = 7;
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.numberOfBeersLabel.frame = CGRectMake(padding, bottomOfTextField + padding * 3, itemWidth, itemHeight);
    self.numberOfBeersLabel.font = [UIFont fontWithName:@"Arial" size:_fontSize];
    self.numberOfBeersLabel.textColor = [UIColor whiteColor];
    self.numberOfBeersLabel.textAlignment = NSTextAlignmentCenter;
    
    
    CGFloat bottomOfBeersLabel = CGRectGetMaxY(self.numberOfBeersLabel.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfBeersLabel + padding, itemWidth, itemHeight);

    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight * 3);
    self.resultLabel.font = [UIFont fontWithName:@"Arial" size:_fontSize];
    self.resultLabel.textColor = [UIColor whiteColor];
    self.resultLabel.textAlignment = NSTextAlignmentCenter;


    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
    self.calculateButton.backgroundColor = [UIColor whiteColor];
    self.calculateButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:_fontSize];
    self.calculateButton.layer.cornerRadius = 7;

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(UITextField *)sender {
    
    NSString *enteredText = sender.text;
    
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        sender.text = nil;
    }
    
}

- (void)sliderDidChange:(UISlider *)sender {
    NSLog(@"Value of slider changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    [self calcAndUpdateAlcolator]; 
    
}


- (void)buttonPressed:(id)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    [self calcAndUpdateAlcolator];
    

}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

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
        wineText = NSLocalizedString(@"glass", @"singular of glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    //update labels
    self.numberOfBeersLabel.text = [NSString stringWithFormat:@"%d %@", numberOfBeers, beerText];
    
    //if no alcohol percentage has been entered, keep instructions in results label.
    if (alcoholPercentageOfBeer != 0) {
        NSString *resultText = [NSString stringWithFormat:@"%d %@ contains as much alcohol as %.1f %@ of wine", numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
        
        self.resultLabel.text = resultText;
    }
}

@end
