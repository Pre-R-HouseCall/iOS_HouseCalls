//
//  DoctorTableViewController.h
//  House_calls
//
//  Created by Timothy Acorda on 1/14/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray * jsonArray;
@property (nonatomic, strong) NSMutableArray * doctorArray;

#pragma mark -
#pragma mark Class Methods

-(void) retrieveData;

@end
