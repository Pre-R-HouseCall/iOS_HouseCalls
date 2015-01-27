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

@property (strong, nonatomic) NSString * docID;
@property (strong, nonatomic) NSString * docUsername;
@property (strong, nonatomic) NSString * docFirstname;
@property (strong, nonatomic) NSString * docLastname;
@property (strong, nonatomic) NSString * docAvailable;
@property (strong, nonatomic) NSString * docDistance;
@property (strong, nonatomic) NSString * docImage;
@property (strong, nonatomic) NSString * docDescription;

-(id) initWithDoctorName: (NSString *) docID andUsername: (NSString *) docUsername andFirstname: (NSString *) docFirstname andLastname: (NSString *) docLastname andAvailablity: (NSString *) docAvilable andDistance: (NSString *) docDistance andImage: (NSString *) docImage andDesc: (NSString *) docDescription;

-(NSString *) getFullName;

@end
