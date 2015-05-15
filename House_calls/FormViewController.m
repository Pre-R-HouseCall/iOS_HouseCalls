//
//  FormViewController.m
//  House_calls
//
//  Created by Timothy Acorda on 1/26/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import "FormViewController.h"
#import "DoctorTableViewController.h"
#import <MapKit/MapKit.h>

#define kOFFSET_FOR_KEYBOARD 80.0
#define sendformURL @"http://54.191.98.90/api/1.0/addForm/"

@interface FormViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailAddressField;
@property (strong, nonatomic) IBOutlet UIButton *currentLocationButton;
@property (strong, nonatomic) IBOutlet UITextView *symptomstextField;
@property (strong, nonatomic) IBOutlet UITextField *streetAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *cityTextField;
@property (strong, nonatomic) IBOutlet UITextField *stateTextField;
@property (strong, nonatomic) IBOutlet UILabel *streetLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *checkedImage;
@property (strong, nonatomic) IBOutlet MKMapView *mapview;
@property BOOL pressed;
@property NSInteger lat;
@property NSInteger longitude;
@end

@implementation FormViewController

@synthesize symptomstextField = _symptomstextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.mapview.delegate = self;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.navItem.title= [NSString stringWithFormat:@"Form for Dr. %@", [self.doc getFullName]];
    self.firstNameTextField.text = [defaults objectForKey:@"Firstname"];
    self.lastNameTextField.text = [defaults objectForKey:@"Lastname"];
    self.phoneNumberTextField.text = [defaults objectForKey:@"Phonenumber"];
    self.emailAddressField.text = [defaults objectForKey:@"Email"];
    self.pressed = NO;
    self.firstNameTextField.layer.cornerRadius = 8.0;
    self.firstNameTextField.layer.borderWidth = 0.00001;
    self.firstNameTextField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0];
    self.firstNameTextField.layer.borderColor = [[UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:0.001] CGColor];
    
    self.phoneNumberTextField.layer.cornerRadius = 8.0;
    self.phoneNumberTextField.layer.borderWidth = 0.00001;
    self.phoneNumberTextField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0];
    self.phoneNumberTextField.layer.borderColor = [[UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:0.001] CGColor];
    
    self.lastNameTextField.layer.cornerRadius = 8.0;
    self.lastNameTextField.layer.borderWidth = 0.0001;
    self.lastNameTextField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0];
        self.lastNameTextField.layer.borderColor = [[UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0] CGColor];
    
    self.emailAddressField.layer.cornerRadius = 8.0;
    self.emailAddressField.layer.borderWidth = 0.0001;
    self.emailAddressField.layer.borderColor = [[UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0] CGColor];
    self.emailAddressField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0];
    
    self.streetAddressTextField.layer.cornerRadius = 8.0;
    self.streetAddressTextField.layer.borderWidth = 0.00001;
    self.streetAddressTextField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0];
    self.streetAddressTextField.layer.borderColor = [[UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0] CGColor];
    
    self.cityTextField.layer.cornerRadius = 8.0;
    self.cityTextField.layer.borderWidth = 0.00001;
    self.cityTextField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0];
    self.cityTextField.layer.borderColor = [[UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0] CGColor];
    
    self.stateTextField.layer.cornerRadius = 8.0;
    self.stateTextField.layer.borderWidth = 0.00001;
    self.stateTextField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0];

    self.symptomstextField.layer.cornerRadius = 8.0;
    self.symptomstextField.layer.borderWidth = 0.01;
    self.symptomstextField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0];
    // Do any additional setup after loading the view.

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapview setRegion:[self.mapview regionThatFits:region] animated:YES];
}

- (IBAction)locationPressed:(id)sender {
    if(self.pressed == YES) {
        [self.locationManager stopUpdatingLocation];
        self.streetLabel.hidden = NO;
        self.streetAddressTextField.hidden = NO;
        self.cityTextField.hidden = NO;
        self.cityLabel.hidden = NO;
        self.stateTextField.hidden = NO;
        self.stateLabel.hidden = NO;
        self.pressed = NO;
        self.checkedImage.hidden = YES;
        self.mapview.hidden = YES;
        
    } else {
        [self.locationManager startUpdatingLocation];
        self.mapview.hidden = NO;
        CLLocationCoordinate2D coordinate = self.locationManager.location.coordinate;
        self.lat = self.locationManager.location.coordinate.latitude;
        self.longitude = self.locationManager.location.coordinate.longitude;
        MKCoordinateRegion extentsRegion = MKCoordinateRegionMakeWithDistance(coordinate, 800, 800);
        [self.mapview setRegion:extentsRegion animated:YES];
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = self.locationManager.location.coordinate;
        point.title = @"Where am I?";
        point.subtitle = @"I'm here!!!";
        self.mapview.hidden = NO;
        self.streetLabel.hidden = YES;
        self.streetAddressTextField.hidden = YES;
        self.cityTextField.hidden = YES;
        self.cityLabel.hidden = YES;
        self.stateTextField.hidden = YES;
        self.stateLabel.hidden = YES;
        self.pressed = YES;
        self.checkedImage.hidden = NO;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonPressed:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)submitButtonPressed:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *id = [defaults objectForKey:@"ID"];
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd%20HH:mm:ss"];
    NSString *sqlDate = [dateFormatter stringFromDate: date];
    NSLog(@"%@\n", sqlDate);
    NSString *newURL;
    if([self.firstNameTextField hasText] && [self.lastNameTextField hasText] && [self.emailAddressField hasText] ){
        if(self.pressed) {
            
            newURL = [NSString stringWithFormat:@"%@%@/%@/%@/%@/%@/%@/%@/%f/%f/NULL/NULL/NULL/%@", sendformURL, self.doc.docID, id, self.firstNameTextField.text, self.lastNameTextField.text, self.emailAddressField.text, self.phoneNumberTextField.text, self.symptomstextField.text, (double)self.lat, (double)self.longitude, sqlDate];
            NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:newURL]];
            NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [conn description];
            NSLog(@"%@\n", newURL);
        } else {
        newURL = [NSString stringWithFormat:@"%@%@/%@/%@/%@/%@/%@/%@/NULL/NULL/%@/%@/%@/%@", sendformURL, self.doc.docID, id, self.firstNameTextField.text, self.lastNameTextField.text, self.emailAddressField.text, self.phoneNumberTextField.text, self.symptomstextField.text, self.streetAddressTextField.text, self.cityTextField.text, self.stateTextField.text, sqlDate];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:newURL]];
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [conn description];
        NSLog(@"%@\n", newURL);
     }
    [defaults setInteger:1 forKey:@"FormActive"];
    [self performSegueWithIdentifier:@"submitedSegue" sender:sender];
    }
    
}


/* Move Keyboard */


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
