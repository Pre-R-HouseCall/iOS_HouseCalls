//
//  RegistrationViewController.h
//  House_calls
//
//  Created by Timothy Acorda on 3/8/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface RegistrationViewController : UIViewController<NSURLConnectionDelegate>
@property NSMutableData* responseData;
@property (nonatomic, strong) NSMutableDictionary* jsonArray;
@end
