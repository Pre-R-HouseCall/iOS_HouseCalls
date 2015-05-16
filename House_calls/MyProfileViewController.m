//
//  MyProfileViewController.m
//  House_calls
//
//  Created by Marek Zhang on 5/14/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import "MyProfileViewController.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

@synthesize image = _image;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults objectForKey:@"ID"] != NULL) {
    } else {
    }
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://s3-us-west-2.amazonaws.com/prer-doctor/Sam_Profile_Cropped.png"]];
    UIImage *pic = [UIImage imageWithData:data];
    self.image.image = pic;
    
    self.image.frame = CGRectMake(self.image.frame.origin.x, self.image.frame.origin.y, 150.0, 150.0);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goHome:(id)sender {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"homepagecontroller"];
    [self presentViewController:vc animated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
