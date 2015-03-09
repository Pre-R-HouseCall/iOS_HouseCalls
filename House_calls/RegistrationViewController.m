//
//  RegistrationViewController.m
//  House_calls
//
//  Created by Timothy Acorda on 3/8/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import "RegistrationViewController.h"

#define sendformURL @"http://54.191.98.90/api/1.0/addUser/"
@interface RegistrationViewController ()
@property (strong, nonatomic, retain) IBOutlet UITextField *NameTextField;
@property (strong, nonatomic, retain) IBOutlet UITextField *EmailTextField;
@property (strong, nonatomic, retain) IBOutlet UITextField *PasswordTextField;
@property (strong, nonatomic, retain) IBOutlet UITextField *PhoneNumberTextField;
@property (strong, nonatomic, retain) IBOutlet UITextField *AddressTextField;
@property (strong, nonatomic, retain) IBOutlet UITextField *CityTextField;
@property (strong, nonatomic, retain) IBOutlet UITextField *StateTextField;
@property (strong, nonatomic, retain) IBOutlet UITextField *ZipTextField;
@property (strong, nonatomic, retain) IBOutlet UIButton *HIPPAButton;
@property (strong, nonatomic) IBOutlet UIButton *SubmitButton;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UITextField *LastNameTextField;
@end


@implementation RegistrationViewController

-(NSMutableDictionary *)jsonArray {
    if(!(_jsonArray)) {
        _jsonArray = [[NSMutableDictionary alloc]init];
    }
    return _jsonArray;
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.LastNameTextField.layer.borderColor = [[UIColor colorWithRed:191.0f/255.0f green:49.0f/255.0f blue:58.0f/255.0f alpha:1.0] CGColor];
    self.LastNameTextField.layer.borderWidth = 1.0;
    self.LastNameTextField.layer.cornerRadius = 8.0;
    self.LastNameTextField.clipsToBounds = YES;
    [self.LastNameTextField.layer setMasksToBounds:YES];
    
   self.NameTextField.layer.borderColor = [[UIColor colorWithRed:191.0f/255.0f green:49.0f/255.0f blue:58.0f/255.0f alpha:1.0] CGColor];
   self.NameTextField.layer.borderWidth = 1.0;
   self.NameTextField.layer.cornerRadius = 8.0;
   self.NameTextField.clipsToBounds = YES;
   [self.NameTextField.layer setMasksToBounds:YES];
    
    self.EmailTextField.layer.borderColor = [[UIColor colorWithRed:191.0f/255.0f green:49.0f/255.0f blue:58.0f/255.0f alpha:1.0] CGColor];
    self.EmailTextField.layer.borderWidth = 1.0;
    self.EmailTextField.layer.cornerRadius = 8.0;
    self.EmailTextField.clipsToBounds = YES;
    [self.EmailTextField.layer setMasksToBounds:YES];

    
    self.PasswordTextField.layer.borderColor = [[UIColor colorWithRed:191.0f/255.0f green:49.0f/255.0f blue:58.0f/255.0f alpha:1.0] CGColor];
    self.PasswordTextField.layer.borderWidth = 1.0;
    self.PasswordTextField.layer.cornerRadius = 8.0;
    self.PasswordTextField.clipsToBounds = YES;
    [self.PasswordTextField.layer setMasksToBounds:YES];

    
    self.PhoneNumberTextField.layer.borderColor = [[UIColor colorWithRed:191.0f/255.0f green:49.0f/255.0f blue:58.0f/255.0f alpha:1.0] CGColor];
    self.PhoneNumberTextField.layer.borderWidth = 1.0;
    self.PhoneNumberTextField.layer.cornerRadius = 8.0;
    self.PhoneNumberTextField.clipsToBounds = YES;
    [self.PhoneNumberTextField.layer setMasksToBounds:YES];

    
    self.AddressTextField.layer.borderColor = [[UIColor colorWithRed:191.0f/255.0f green:49.0f/255.0f blue:58.0f/255.0f alpha:1.0] CGColor];
    self.AddressTextField.layer.borderWidth = 1.0;
    self.AddressTextField.layer.cornerRadius = 8.0;
    self.AddressTextField.clipsToBounds = YES;
    [self.AddressTextField.layer setMasksToBounds:YES];

    
    self.CityTextField.layer.borderColor = [[UIColor colorWithRed:191.0f/255.0f green:49.0f/255.0f blue:58.0f/255.0f alpha:1.0] CGColor];
    self.CityTextField.layer.borderWidth = 1.0;
    self.CityTextField.layer.cornerRadius = 8.0;
    self.CityTextField.clipsToBounds = YES;
    [self.CityTextField.layer setMasksToBounds:YES];

    
    self.StateTextField.layer.borderColor = [[UIColor colorWithRed:191.0f/255.0f green:49.0f/255.0f blue:58.0f/255.0f alpha:1.0] CGColor];
    self.StateTextField.layer.borderWidth = 1.0;
    self.StateTextField.layer.cornerRadius = 8.0;
    self.StateTextField.clipsToBounds = YES;
    [self.StateTextField.layer setMasksToBounds:YES];

    
    self.ZipTextField.layer.borderColor = [[UIColor colorWithRed:191.0f/255.0f green:49.0f/255.0f blue:58.0f/255.0f alpha:1.0] CGColor];
    self.ZipTextField.layer.borderWidth = 1.0;
    self.ZipTextField.layer.cornerRadius = 8.0;
    self.ZipTextField.clipsToBounds = YES;
    [self.ZipTextField.layer setMasksToBounds:YES];

    self.SubmitButton.layer.cornerRadius = 6.0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [_responseData appendData:data];
    NSString * output = [[NSString alloc] initWithData:self.responseData encoding:NSASCIIStringEncoding];
    if([output isEqualToString:@"User Exists"]) {
        self.emailLabel.text = @"email exists already!";
        self.emailLabel.textColor = [UIColor redColor];
    } else {
        self.jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSString *ID = [self.jsonArray objectForKey:@"UserId"];
        [defaults setObject:ID forKey:@"ID"];
        [defaults setObject:self.NameTextField.text forKey:@"Firstname"];
        [defaults setObject:self.LastNameTextField.text forKey:@"Lastname"];
        [defaults setObject:self.EmailTextField.text forKey:@"Email"];
        [defaults setObject:self.PhoneNumberTextField.text forKey:@"Phonenumber"];
        [defaults synchronize];
        [self.navigationController popToRootViewControllerAnimated:YES];

    }
}
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

- (IBAction)signupButtonPressed:(id)sender {
    [self createConnection];
}

-(void)createConnection {
    if([self.NameTextField hasText] && [self.EmailTextField hasText] && [self.PasswordTextField hasText] && [self.PhoneNumberTextField hasText]) {
        
        NSString *newURL = [NSString stringWithFormat:@"%@%@/%@/%@/%@/%@/NULL/NULL/NULL/NULL", sendformURL, self.NameTextField.text, self.LastNameTextField.text , self.EmailTextField.text, self.PasswordTextField.text, self.PhoneNumberTextField.text];
        
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:newURL]];
        
        //request.HTTPMethod = @"POST";
        //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
}




@end
