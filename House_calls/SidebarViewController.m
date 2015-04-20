//
//  SidebarViewController.m
//  House_calls
//
//  Created by Marek Zhang on 3/8/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import "SidebarViewController.h"

@interface SidebarViewController()
@property (weak, nonatomic) IBOutlet UIButton *signInOut;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *waitState;
@property UIRefreshControl* refreshControl;
@end

@implementation SidebarViewController

-(void)viewDidLoad {
    NSLog(@"View Did Load");
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadSettings)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"View did appear.");
    [self.view setNeedsDisplay];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"ID"] != NULL) { /*user is logged in*/
        self.userName.text = [NSString stringWithFormat:@"%@", [defaults objectForKey:@"Name"]];
        [_signInOut setTitle:@"Sign Out" forState:UIControlStateNormal];
        self.waitState.text = @"(2) People Ahead";
        
    } else {
        self.userName.text = @"Not Logged In";
        [_signInOut setTitle:@"Sign In" forState:UIControlStateNormal];
        self.waitState.text = @"No form submitted";
    }
}


-(void)reloadSettings {
    NSLog(@"Reload Settings");
}

- (IBAction)ChangeUserState:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self.view setNeedsDisplay];
    if([defaults objectForKey:@"ID"] != NULL) {
        self.userName.text = @"Not Logged In";
        [_signInOut setTitle:@"Sign In" forState:UIControlStateNormal];
        [defaults removeObjectForKey:@"Phonenumber"];
        [defaults removeObjectForKey:@"Password"];
        [defaults removeObjectForKey:@"Email"];
        [defaults removeObjectForKey:@"Firstname"];
        [defaults removeObjectForKey:@"ID"];
        [defaults removeObjectForKey:@"FormActive"];
        [self.view setNeedsDisplay];
        self.waitState.text = @"No form submitted";
    } else {
    }
}
@end





