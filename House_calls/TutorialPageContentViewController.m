//
//  TutorialPageContentViewController.m
//  House_calls
//
//  Created by Marek Zhang on 1/14/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import "TutorialPageContentViewController.h"

@interface TutorialPageContentViewController ()

@end

@implementation TutorialPageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    self.titleLabel.text = self.titleText;
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
