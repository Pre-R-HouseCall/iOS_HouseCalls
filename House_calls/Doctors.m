//
//  Doctors.m
//  House_calls
//
//  Created by Timothy Acorda on 1/25/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import "Doctors.h"

@implementation Doctors
@synthesize docAvailable, docDescription, docDistance, docFirstname, docID, docImage, docLastname, docUsername;

-(id) initWithDoctorName: (NSString *) dID andUsername: (NSString *) dUsername andFirstname: (NSString *) dFirstname andLastname: (NSString *) dLastname andAvailablity: (NSString *) dAvilable andDistance: (NSString *) dDistance andImage: (NSString *) dImage andDesc: (NSString *) dDescription {
    
    self = [super init];
    if(self) {
        docUsername = dUsername;
        docLastname = dLastname;
        docID = dID;
        docAvailable = dAvilable;
        docDescription = dDescription;
        docImage = dImage;
        docFirstname = dFirstname;
        docDistance = dDistance;
    }
    
    return self;
}

-(NSString *) getFullName {
    return [[self.docFirstname stringByAppendingString:@" "] stringByAppendingString: self.docLastname];
}

@end
