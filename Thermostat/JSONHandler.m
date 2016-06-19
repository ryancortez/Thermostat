//
//  JSONHandler.m
//  Thermostat
//
//  Created by Ryan on 6/19/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "JSONHandler.h"

@implementation JSONHandler

- (void) pullJSONFromURL: (NSURL *)url {

    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc]initWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        long statusCode = httpResponse.statusCode;
        
        if (statusCode == 200) {
            NSLog(@"Data from the URL downloaded successfully");
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            self.json = jsonDictionary;
            NSLog(@"Attempting to save JSON recieved to self.json: %@",  self.json);
        }
    }];
    [task resume];
}

@end
