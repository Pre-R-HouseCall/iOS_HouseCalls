//
//  Doctors.h
//  House_calls
//
//  Created by Timothy Acorda on 1/25/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Doctors : NSObject
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* bio;
@property (nonatomic) NSInteger* availability;
@property (nonatomic, strong) UIImage* photo;

@end
