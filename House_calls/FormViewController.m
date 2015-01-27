//
//  FormViewController.m
//  House_calls
//
//  Created by Timothy Acorda on 1/26/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import "FormViewController.h"
#import "DoctorTableViewController.h"

@interface FormViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navItem.title= [NSString stringWithFormat:@"Form for Dr. %@", self.doc.name];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonPressed:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
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
