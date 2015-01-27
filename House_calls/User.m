//
//  User.m
//  House_calls
//
//  Created by Timothy Acorda on 1/26/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype)init {
    self = [super init];
    if(self) {
        self.login = false;
    }
    return self;
}


@end
