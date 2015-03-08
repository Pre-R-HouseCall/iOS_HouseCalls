//
//  ViewController.h
//  House_calls
//
//  Created by Timothy Acorda on 1/13/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface LoginViewController : UIViewController<NSURLConnectionDelegate>
@property (nonatomic)User* user;
@property NSMutableData* responseData;
@property (nonatomic, strong) NSMutableDictionary* jsonArray;
@end

