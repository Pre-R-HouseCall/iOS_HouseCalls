//
//  DoctorCell.h
//  House_calls
//
//  Created by Timothy Acorda on 1/25/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *buttonToBio;
@property (weak, nonatomic) IBOutlet UIButton *buttonToForm;
@property (weak, nonatomic) IBOutlet UILabel *doctorName;
@property (strong, nonatomic) IBOutlet UIImageView *availImage;
@property (strong, nonatomic) IBOutlet UIButton *seeButton;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

-(instancetype)initWithIdentifier:(NSString*)identifier;

@end
