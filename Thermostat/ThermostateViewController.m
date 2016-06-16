//
//  ViewController.m
//  Thermostat
//
//  Created by Ryan Cortez on 6/16/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "ThermostateViewController.h"

@interface ThermostateViewController ()


@property (weak, nonatomic) IBOutlet UISegmentedControl *temperatureUnitSwitchSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UISlider *temperatureSliderOutlet;

@end

@implementation ThermostateViewController

NSInteger const celsiusUpperBound = 32;
NSInteger const celsiusLowerBound = -6;
NSInteger const fahrenheitUpperBound = 90;
NSInteger const fahrenheitLowerBound = 20;

// Do this work right before the view appears
- (void) viewWillAppear:(BOOL)animated {
    
    // Make sure the temperature label is updated to the current slider temperature
    int value = (int) self.temperatureSliderOutlet.value;
    self.temperatureLabel.text = [NSString stringWithFormat:@"%d", value];
}

// When the segemented control is pressed
- (IBAction)temperatureUnitSegementedControlButton:(id)sender {
    
    // Get which segmented control is selected
    NSInteger index = self.temperatureUnitSwitchSegmentedControl.selectedSegmentIndex;
    
    // If the first is selected
    if (index == 0) {
        int currentTemperatureDisplayed = (int) self.temperatureSliderOutlet.value;
        int temperatureAfterConversion = (((currentTemperatureDisplayed - 32) * 5) / 9);
        [self.temperatureSliderOutlet setValue:temperatureAfterConversion animated:YES];
        self.temperatureLabel.text = [NSString stringWithFormat:@"%d", (int) self.temperatureSliderOutlet.value];
        
    // If the second is selected
    } else if (index == 1) {
        int currentTemperatureDisplayed = (int) self.temperatureSliderOutlet.value;
        int temperatureAfterConversion = (((currentTemperatureDisplayed * 9) / 5) + 32);
        [self.temperatureSliderOutlet setValue:temperatureAfterConversion animated:YES];
        self.temperatureLabel.text = [NSString stringWithFormat:@"%d", (int) self.temperatureSliderOutlet.value];
    }
    
}

// Everytime the user changes the slider value...
- (IBAction)temperatureSlider:(id)sender {
    
    // Update the temperature label with the sliders value
    int sliderValue = (int) self.temperatureSliderOutlet.value;
    self.temperatureLabel.text = [NSString stringWithFormat:@"%d", sliderValue];
    
    // Get which segmented control is selected
    NSInteger index = self.temperatureUnitSwitchSegmentedControl.selectedSegmentIndex;
    
    
    // If the temperature is too hot, change the background to red
    // If the temperature is too cold, change the background to blue
    if (index == 0 && sliderValue > celsiusUpperBound) {
        self.view.backgroundColor = [UIColor redColor];
    } else if (index == 0 && sliderValue < celsiusLowerBound) {
        self.view.backgroundColor = [UIColor blueColor];
    } else if (index == 1 && sliderValue > fahrenheitUpperBound) {
        self.view.backgroundColor = [UIColor redColor];
    } else if (index == 1 && sliderValue < fahrenheitLowerBound) {
        self.view.backgroundColor = [UIColor blueColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
}


@end
