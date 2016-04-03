//
//  ContactsViewController.m
//  PebbleEmergencyApp
//
//  Created by Jasper Davey on 4/2/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

#import "ContactsViewController.h"
#import "CustomCell.h"
#import "CustomContactCell.h"
#import "PEUser.h"
#import "PEDatabase.h"
#import "PEFileManager.h"

@interface ContactsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *doctorViewObject;
@property (weak, nonatomic) IBOutlet UITableView *contactViewObject;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;


@end

@implementation ContactsViewController
{
    PEUser *currentUser;
    PEDatabase *database;
    PEFileManager *fileManager;
    PEAllUsers *allUsers;
    NSArray *tableData;
    NSArray *contactData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // load user's contact information
    
    tableData = [ NSArray arrayWithObjects: @"Dr. Fiore DeVito", nil ];
    contactData = [ NSArray arrayWithObjects: @"Lucia Zapata", @"Daryl Davey", nil ];

    
}

- (IBAction)addButtonPressed:(id)sender
{
    [ self performSegueWithIdentifier:@"AddContactSegue" sender: self ];
}


- ( NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( tableView == _doctorViewObject )
    {
        return [ tableData count ];
    }
    else
    {
        return [ contactData count ];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 80;
}

- ( UITableViewCell * ) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( tableView == _doctorViewObject )
    {
        static NSString *simpleTableIdentifier = @"CustomCell";
        CustomCell *cell = ( CustomCell * )[ tableView dequeueReusableCellWithIdentifier: simpleTableIdentifier ];
        
        if ( cell == nil )
        {
            NSArray *nibArray = [ [ NSBundle mainBundle ] loadNibNamed: @"CustomCell" owner: self options: nil] ;
            
            cell = [ nibArray objectAtIndex: 0 ];
        }
        cell.doctorLabel.text = @"Primary Doctor";
        cell.doctorName.text = [ tableData objectAtIndex: indexPath.row ];
        cell.doctorImage.image = [ UIImage imageNamed:@"medicine" ];
        cell.doctorImage.layer.cornerRadius = cell.doctorImage.frame.size.height /2;
        cell.doctorImage.layer.masksToBounds = YES;
        cell.doctorImage.layer.borderWidth = 0;
        cell.doctorImage.frame = CGRectOffset(cell.frame, 10, 10);
        
        return cell;
    }
    else
    {
        static NSString *simpleTableIdentifier = @"CustomContactCell";
        CustomContactCell *cell = ( CustomContactCell * )[ tableView dequeueReusableCellWithIdentifier: simpleTableIdentifier ];
        if ( cell == nil )
        {
            NSArray *nibArray = [ [ NSBundle mainBundle ] loadNibNamed: @"CustomContactCell" owner: self options:nil ];
            cell = [ nibArray objectAtIndex: 0 ];
        }
        cell.contactName.text = [ contactData objectAtIndex: indexPath.row ];
        cell.contactImage.image = [ UIImage imageNamed:@"family" ];
        cell.contactImage.layer.cornerRadius = cell.contactImage.frame.size.height /2;
        cell.contactImage.layer.masksToBounds = YES;
        cell.contactImage.layer.borderWidth = 0;
        
        return cell;
    }
    
    
}


@end
