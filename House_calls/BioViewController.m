//
//  BioViewController.m
//  House_calls
//
//  Created by Timothy Acorda on 1/26/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import "BioViewController.h"
#import "Doctors.h"
@interface BioViewController ()
@property (weak, nonatomic) IBOutlet UILabel *statusText;
@property (weak, nonatomic) IBOutlet UITextView *bioText;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UILabel *doctorName;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation BioViewController

- (Doctors*)doc {
    if (!_doc) {
        _doc = [[Doctors alloc]init];
    }
    return _doc;
}

- (IBAction)backButtonPressed:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLabels];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setLabels {
    self.bioText.text = self.doc.docDescription;
    self.navItem.title = @"Pre-R";
    self.statusText.text = self.doc.docAvailable;
    self.doctorName.text = [NSString stringWithFormat:@"%@ %@", self.doc.docFirstname, self.doc.docLastname];
    self.distanceLabel.text = self.doc.docDistance;
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
