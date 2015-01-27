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
@property (weak, nonatomic) IBOutlet UILabel *bioText;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

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
    self.bioText.text = self.doc.bio;
    self.navItem.title = self.doc.name;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
