//
//  ViewController.m
//  House_calls
//
//  Created by Timothy Acorda on 1/13/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import "LoginViewController.h"
#define userCheckURL @"http://54.191.98.90/api/ios_connect/check.php"

@interface LoginViewController () 
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextField *userNameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UILabel *handler;

@end


@implementation LoginViewController
- (IBAction)pressedCheck:(id)sender {
    [self createConnection];
    //self.handler.text = [[NSString alloc] initWithData:self.responseData encoding:NSASCIIStringEncoding];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(User*)user {
    if(!_user) {
        _user = [[User alloc] init];
    }
    return _user;
}

-(NSMutableDictionary *)jsonArray {
    if(!(_jsonArray)) {
        _jsonArray = [[NSMutableDictionary alloc]init];
    }
    return _jsonArray;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"loggedIn"]) {
        self.user.login = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSLog(@"Entered this function");
    [_responseData appendData:data];
    NSString* output = [[NSString alloc] initWithData:self.responseData encoding:NSASCIIStringEncoding];
    if([output isEqualToString:@"No Such User Found"]) {
        self.handler.text = @"User does not exist!";
    } else {
        self.jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSLog(@"%lu\n", (unsigned long)[self.jsonArray count]);
        NSString* ID = [self.jsonArray objectForKey:@"UserId"];
        NSString * Firstname = [self.jsonArray objectForKey:@"FirstName"];
        NSString * Lastname = [self.jsonArray objectForKey:@"LastName"];
        NSString * Email = [self.jsonArray objectForKey:@"Email"];
        NSString * Password= [self.jsonArray objectForKey:@"Password"];
        NSString * Phonenumber= [self.jsonArray objectForKey:@"PhoneNumber"];
        NSString * Username = [self.jsonArray objectForKey:@"Username"];
        [defaults setObject:ID forKey:@"ID"];
        [defaults setObject:Firstname forKey:@"Firstname"];
        [defaults setObject:Lastname forKey:@"Lastname"];
        [defaults setObject:Username forKey:@"Username"];
        [defaults setObject:Email forKey:@"Email"];
        [defaults setObject:Password forKey:@"Password"];
        [defaults setObject:Phonenumber forKey:@"Phonenumber"];
        [defaults synchronize];
        self.handler.text = @"Successful login!";
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

-(void)createConnection {
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:userCheckURL]];
    
    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";
    
    // This is how we set header fields
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Convert your data and set your request's HTTPBody property
    NSString *stringData = [NSString stringWithFormat: @"Username=%@&Password=%@", self.userNameField.text, self.passwordField.text];
    NSLog(@"%@", stringData);
    NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = requestBodyData;
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}
@end
