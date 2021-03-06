//
//  DoctorTableViewController.m
//  House_calls
//
//  Created by Timothy Acorda on 1/14/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

#import "DoctorTableViewController.h"
#import "DoctorCell.h"
#import "Doctors.h"
#import "BioViewController.h"
#import "FormViewController.h"
#import "LoginViewController.h"
#import "User.h"
#import "SWRevealViewController.h"

#define getDataURL @"http://54.191.98.90/api/ios_connect/getAllDoctors.php"


@interface DoctorTableViewController ()
@property (nonatomic) User* user;
@end

@implementation DoctorTableViewController

-(NSMutableArray *)doctorArray {
    if(!(_doctorArray)) {
        _doctorArray = [[NSMutableArray alloc]init];
    }
    return _doctorArray;
}

-(NSMutableArray *)jsonArray {
    if(!(_jsonArray)) {
        _jsonArray = [[NSMutableArray alloc]init];
    }
    return _jsonArray;
}

-(User*)user {
    if(!_user) {
        _user = [[User alloc]init];
    }
    return _user;
}
-(void)reload2 {
    
    
}
- (void)viewDidLoad {
    [self user];
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        [revealViewController viewDidLoad];

    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Avenir" size:30],
      NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    self.selectedIndex = -1;
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor orangeColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(retrieveData)
                  forControlEvents:UIControlEventValueChanged];
    [self retrieveData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.doctorArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DoctorCell *doctorCell = [tableView dequeueReusableCellWithIdentifier:@"doctorCell"];
    Doctors* tempdoc = [self.doctorArray objectAtIndex:indexPath.row];
   
    if (tempdoc) {
        doctorCell.doctorName.text  = [tempdoc getFullName];
        doctorCell.doctorDistance.text = tempdoc.docDistance;
    }
    if([tempdoc.docAvailable isEqualToString:@"Available"]) {
        doctorCell.availImage.image = [UIImage imageNamed:@"indicator_available"];
    } else {
                doctorCell.availImage.image = [UIImage imageNamed:@"indicator_unavailable"];
    }
    doctorCell.descriptionLabel.text = tempdoc.docDescription;
    doctorCell.seeButton.tag = indexPath.row;
    doctorCell.buttonToBio.tag = indexPath.row;
    doctorCell.buttonToForm.tag = indexPath.row;
    [doctorCell.buttonToForm addTarget:self action:@selector(formButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [doctorCell.seeButton addTarget:self action:@selector(bioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [doctorCell.buttonToBio addTarget:self action:@selector(bioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return doctorCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.selectedIndex == indexPath.row) {
        return 300;
    } else {
        return 75;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.selectedIndex == indexPath.row) {
        self.selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        DoctorCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.buttonToBio.hidden = YES;
        cell.buttonToForm.hidden = YES;
        cell.seeButton.hidden = YES;
        cell.descriptionLabel.hidden = YES;
        return;
        
    } else if(self.selectedIndex != -1) {
        NSIndexPath *prevpath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
        self.selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prevpath] withRowAnimation:UITableViewRowAnimationFade];
        
        DoctorCell* cell = [tableView cellForRowAtIndexPath:prevpath];
        cell.buttonToBio.hidden = YES;
        cell.buttonToForm.hidden = YES;
        cell.seeButton.hidden = YES;
        cell.descriptionLabel.hidden = YES;
        
    }
    self.selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    DoctorCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.buttonToBio.hidden = NO;
    cell.buttonToForm.hidden = NO;
    cell.seeButton.hidden = NO;
    cell.descriptionLabel.hidden = NO;
}

-(void) formButtonClicked:(UIButton*)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if([defaults objectForKey:@"ID"] != NULL && ![defaults integerForKey:@"FormActive"]) {
        [self performSegueWithIdentifier:@"segueForm" sender: sender];
    }
    else if([defaults integerForKey:@"FormActive"]) {
        [self performSegueWithIdentifier:@"waitingRoom" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"segueLogin" sender:sender];
    }
}

-(void)bioButtonClicked:(UIButton*)sender {
    [self performSegueWithIdentifier:@"segueBio" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segueBio" ]) {
        BioViewController* controller = (BioViewController*)[segue destinationViewController];
        [controller setDoc: self.doctorArray[[sender tag]]];
        //[self.navigationController pushViewController:controller animated:YES];
    } else if ([[segue identifier] isEqualToString:@"segueForm"]) {
        FormViewController* controller = (FormViewController*) [segue destinationViewController];
        [controller setDoc: self.doctorArray[[sender tag]]];
        //[self.navigationController pushViewController:controller animated:YES];

    }
}

-(IBAction) unwindToList:(UIStoryboardSegue *)segue {
    if([[segue identifier]isEqualToString:@"loggedIn"]) {
        LoginViewController* controller = (LoginViewController*)[segue sourceViewController];
        [self setUser: controller.user];
        
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark Class Methods

-(void) retrieveData {
    NSURL * url = [NSURL URLWithString:getDataURL];
    NSData * data = [NSData dataWithContentsOfURL:url];
    self.jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    self.doctorArray = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < self.jsonArray.count; i++) {
        NSString * dID = [[self.jsonArray objectAtIndex:i] objectForKey:@"DoctorId"];
        NSString * dFirstname = [[self.jsonArray objectAtIndex:i] objectForKey:@"FirstName"];
        NSString * dLastname = [[self.jsonArray objectAtIndex:i] objectForKey:@"LastName"];
        NSString * dUsername = [[self.jsonArray objectAtIndex:i] objectForKey:@"Email"];
        NSString * dAvailable = [[self.jsonArray objectAtIndex:i] objectForKey:@"Availability"];
        NSString * dDistance = [[self.jsonArray objectAtIndex:i] objectForKey:@"Distance"];
        NSString * dDescription = [[self.jsonArray objectAtIndex:i] objectForKey:@"Description"];
        NSString * dImage = [[self.jsonArray objectAtIndex:i] objectForKey:@"ProfileImage"];
        
        
        [self.doctorArray addObject:[[Doctors alloc] initWithDoctorName: dID andUsername:dUsername andFirstname:dFirstname andLastname:dLastname andAvailablity:dAvailable andDistance:dDistance andImage:dImage andDesc:dDescription]];
        
    }
    if (self.refreshControl) {
        [self.refreshControl endRefreshing];
    }
    [self.tableView reloadData];
    
    
}



@end
