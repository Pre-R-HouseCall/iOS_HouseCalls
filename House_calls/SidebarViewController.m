
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
        NSLog(@"Reached if");
        self.userName.text = [NSString stringWithFormat:@"%@ %@", [defaults objectForKey:@"Firstname"], [defaults objectForKey:@"Lastname"]];
    } else {
        self.userName.text = @"Not Logged In";
    }

}

- (IBAction)resetErthing:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:0 forKey:@"FormActive"];
    [defaults setObject:nil forKey:@"ID"];
    [defaults setObject:nil forKey:@"Firstname"];
    [defaults setObject:nil forKey:@"Lastname"];
    [defaults setObject:nil forKey:@"Email"];
    [defaults setObject:nil forKey:@"Phonenumber"];
    [defaults synchronize];
}

-(void)reloadSettings {
    
}
@end
