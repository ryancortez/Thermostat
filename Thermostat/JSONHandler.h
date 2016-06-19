//
//  JSONHandler.h
//  Thermostat
//
//  Created by Ryan on 6/19/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONHandler : NSObject

@property (nonatomic, strong) NSDictionary *json;

- (void) pullJSONFromURL: (NSURL *)url;


@end
