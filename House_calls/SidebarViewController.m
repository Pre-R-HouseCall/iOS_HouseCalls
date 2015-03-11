//
//  SidebarViewController.m
//  House_calls
//
//  Created by Marek Zhang on 3/8/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import "SidebarViewController.h"

@interface SidebarViewController()
@property UIRefreshControl* refreshControl;
@end

@implementation SidebarViewController

-(void)viewDidLoad {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadSettings)
                  forControlEvents:UIControlEventValueChanged];}

-(void)reloadSettings {
    
}
@end
