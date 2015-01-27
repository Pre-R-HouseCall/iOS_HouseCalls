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
@interface DoctorTableViewController ()
@property (nonatomic) NSMutableArray* doctors;
@property (nonatomic) User* user;
@end

@implementation DoctorTableViewController

-(NSMutableArray *)doctors {
    if(!(_doctors)) {
        _doctors = [[NSMutableArray alloc]init];
    }
    return _doctors;
}

-(User*)user {
    if(!_user) {
        _user = [[User alloc]init];
    }
    return _user;
}
- (void)viewDidLoad {
    Doctors *doc1 = [[Doctors alloc]init];
    doc1.name = @"Robert Bobby";
    doc1.bio = @"He is a great man and no one can stop him!";
    doc1.availability = 2;
    Doctors* doc2 = [[Doctors alloc]init];
    doc2.name = @"Michae Johnson";
    doc2.bio = @"Nicest Doctor in the world";
    doc2.availability = 1;
    [self user];
    
    [super viewDidLoad];
    [self.doctors addObject: doc1];
    [self.doctors addObject: doc2];
    
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
    return [self.doctors count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DoctorCell *doctorCell = [tableView dequeueReusableCellWithIdentifier:@"doctorCell"];
    Doctors* tempdoc = [self.doctors objectAtIndex:indexPath.row];
    if (tempdoc.name) {
        doctorCell.doctorName.text  = tempdoc.name;
    }
    doctorCell.buttonToBio.tag = indexPath.row;
    doctorCell.buttonToForm.tag = indexPath.row;
    [doctorCell.buttonToForm addTarget:self action:@selector(formButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [doctorCell.buttonToBio addTarget:self action:@selector(bioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return doctorCell;
}

-(void) formButtonClicked:(UIButton*)sender {
    if(self.user.login) {
        [self performSegueWithIdentifier:@"segueForm" sender: sender];
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
        [controller setDoc: self.doctors[[sender tag]]];
        //[self.navigationController pushViewController:controller animated:YES];
    } else if ([[segue identifier] isEqualToString:@"segueForm"]) {
        FormViewController* controller = (FormViewController*) [segue destinationViewController];
        [controller setDoc: self.doctors[[sender tag]]];
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

@end
