//
//  ViewController.h
//  House_calls
//
//  Created by Timothy Acorda on 1/13/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialPageContentViewController.h"

@interface TutorialViewController : UIViewController

//- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

@end

