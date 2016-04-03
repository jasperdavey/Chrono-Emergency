//
//  AddContactViewController.m
//  PebbleEmergencyApp
//
//  Created by Jasper Davey on 4/2/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

#import "AddContactViewController.h"
#import "PEUser.h"
#import "PEDatabase.h"
#import "PEFileManager.h"

@interface AddContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phonenumberTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UISwitch *primaryDocToggle;

@end

@implementation AddContactViewController

NSString *switchIsOn = @"yes";
PEUser * currentUser;
PEDatabase *database;
PEFileManager *fileManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- ( IBAction )primarydocToggleWasToggled: ( id )sender
{
    UISwitch *mySwitch = (UISwitch *)sender;
    if ([mySwitch isOn]) {
        switchIsOn = @"yes";
    } else {
        switchIsOn = @"no";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- ( IBAction )saveButtonPressed: ( id )sender
{
    fileManager = [ [ PEFileManager alloc ] init ];
    currentUser = [ database queryUser ];
    PEContacts *contact = [ [ PEContacts alloc ] init ];
    contact.cfirstname = _firstnameTextField.text;
    contact.clastname = _lastnameTextField.text;
    contact.cphonenumber = _phonenumberTextField.text;
    contact.type = switchIsOn;
    [ currentUser.contacts addObject: contact ];
    [ database updateUser: currentUser ];

    NSDictionary *dictionary = @{ @"cfirstname" : _firstnameTextField.text, @"clastname" : _lastnameTextField.text, @"cphonenumber" : _phonenumberTextField.text, @"email" : @"something", @"type" : switchIsOn }; // fix
    NSError *error;
    NSData *json = [ NSJSONSerialization dataWithJSONObject: dictionary options: 0 error:&error ];
    if ( error )
    {
        NSLog( @"Error: %@", error );
    }
    [ self sendJSON: json ];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- ( void ) sendJSON: ( NSData * ) json
{
    NSString *jsonAsNSString = [ [ NSString alloc ] initWithData: json encoding: NSUTF8StringEncoding ];
    NSString *post = [ NSString stringWithFormat:@"%@", jsonAsNSString ];
    NSData *postData = [ post dataUsingEncoding: NSASCIIStringEncoding allowLossyConversion: YES ];
    NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] init ];
    [ request setURL: [ NSURL URLWithString:@"https://lamlctt2g8.execute-api.us-west-2.amazonaws.com/prod/addUserContacts" ] ];
    [ request setHTTPMethod: @"POST" ];
    [ request setValue: @"application/json" forHTTPHeaderField: @"Content-Type" ];
    [ request setHTTPBody: postData ];
    NSURLConnection *connection = [ [ NSURLConnection alloc ] initWithRequest: request delegate: self ];
    
    if ( connection )
    {
        NSLog( @"JSON Sent: %@", jsonAsNSString );
    }
    else
    {
        NSLog( @"JSON Sent: %@", jsonAsNSString );
    }
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
