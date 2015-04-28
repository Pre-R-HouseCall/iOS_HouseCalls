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
@property (weak, nonatomic) IBOutlet UILabel *doctorDistance;
@property (strong, nonatomic) IBOutlet UIImageView *availImage;
@property (strong, nonatomic) IBOutlet UIButton *seeButton;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *waitRoomLabel;

-(instancetype)initWithIdentifier:(NSString*)identifier;

@end
