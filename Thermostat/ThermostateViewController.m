//
//  ViewController.m
//  Thermostat
//
//  Created by Ryan Cortez on 6/16/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "ThermostateViewController.h"

@interface ThermostateViewController ()

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UISegmentedControl *temperatureUnitSwitchSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UISlider *temperatureSliderOutlet;
@property (weak, nonatomic) IBOutlet UILabel *currentTemperatureOutsideLabel;


@end

@implementation ThermostateViewController

@synthesize locationManager;

NSInteger const celsiusUpperBound = 32;
NSInteger const celsiusLowerBound = -6;
NSInteger const fahrenheitUpperBound = 90;
NSInteger const fahrenheitLowerBound = 20;


#pragma mark - Lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
 }


- (void) viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Create the core location manager object
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    // Make sure the temperature label is updated to the current slider temperature
    int value = (int) self.temperatureSliderOutlet.value;
    self.temperatureLabel.text = [NSString stringWithFormat:@"%d", value];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.locationManager stopUpdatingLocation];
}


#pragma mark - Location Methods


// Whenever a location is detected this method will run
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // Recorded the new location values
    CLLocation *curPos = manager.location;
    NSString *latitude = [[NSNumber numberWithDouble:curPos.coordinate.latitude] stringValue];
    NSString *longitude = [[NSNumber numberWithDouble:curPos.coordinate.longitude] stringValue];
    NSLog(@"Lat: %@", latitude);
    NSLog(@"Long: %@", longitude);
    
    // Use the location coordinates to create a URL to call the Forecast.io API
    NSString *urlString = [NSString stringWithFormat:@"https://api.forecast.io/forecast/ee590865b8cf07d544c96463ae5d47c5/%@,%@", latitude, longitude];
    NSLog(@"%@", urlString);
    
    // Call the Forecast.io API
    NSURL *requestURL = [[NSURL alloc]initWithString: urlString];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc]initWithURL:requestURL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        long statusCode = httpResponse.statusCode;
        
        if (statusCode == 200) {
            NSLog(@"Data from the URL downloaded successfully");
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            NSString *string = [NSString stringWithFormat:@"%@", jsonDictionary[@"currently"][@"temperature"]];
            NSLog(@"Current temperature outside pulled from Forecast.io : %@", string);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.currentTemperatureOutsideLabel.text = [NSString stringWithFormat:@"Temperature Outside: %.0f%@", string.floatValue, @"\u00B0"];
            });
            
        }
    }];
    [task resume];
    
    [self.locationManager stopUpdatingLocation];
    
}

- (void) locationManager:(CLLocationManager *)manager
        didFailWithError:(NSError *)error
{
    NSLog(@"%@", @"Core location can't get a fix.");
}


- (void) getLocationData {
    CLLocation *curPos = locationManager.location;
    NSString *latitude = [[NSNumber numberWithDouble:curPos.coordinate.latitude] stringValue];
    NSString *longitude = [[NSNumber numberWithDouble:curPos.coordinate.longitude] stringValue];
    NSLog(@"Lat: %@", latitude);
    NSLog(@"Long: %@", longitude);
}


#pragma mark - Updatng View Methods

- (void) updateWeatherLabelWithWeather:(Weather *) weather {
    self.currentTemperatureOutsideLabel.text = [NSString stringWithFormat:@"Temperature Outside: %.0f%@", weather.temperature.floatValue, @"\u00B0"];
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
