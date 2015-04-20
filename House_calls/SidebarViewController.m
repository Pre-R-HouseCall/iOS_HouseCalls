//
//  SidebarViewController.m
//  House_calls
//
//  Created by Marek Zhang on 3/8/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import "SidebarViewController.h"

@interface SidebarViewController()
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property UIRefreshControl* refreshControl;
@property (weak, nonatomic) IBOutlet UIButton *signInOut;
@end

@implementation SidebarViewController

-(void)viewDidLoad {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadSettings)
                  forControlEvents:UIControlEventValueChanged];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults objectForKey:@"ID"] != NULL) {
        self.userName.text = [NSString stringWithFormat:@"%@ %@", [defaults objectForKey:@"Firstname"], [defaults objectForKey:@"Lastname"]];
        [self.signInOut setTitle:@"Sign Out" forState:UIControlStateNormal];
    } else {
        self.userName.text = @"Not Logged In";
        [self.signInOut setTitle:@"Sign In" forState:UIControlStateNormal];
    }

}

-(void)reloadSettings {
    
}
@end
