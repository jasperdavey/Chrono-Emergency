//
//  SignupViewController.m
//  PebbleEmergencyApp
//
//  Created by Jasper Davey on 4/2/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

#import "SignupViewController.h"
#import <AWSLambda/AWSLambda.h>
#import "PEUser.h"
#import "PEFileManager.h"

@interface SignupViewController ()
@property (weak, nonatomic) IBOutlet UILabel *signupLabel;
@property (weak, nonatomic) IBOutlet UITextField *firstnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UITextField *phonenumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;

@end

@implementation SignupViewController
{
    PEUser *currentUser;
}

- (IBAction)signupButtonPressed:(id)sender
{
    // Check if passwords match
    if ( _passwordTextField.text != _confirmPasswordTextField.text )
    {
        _signupLabel.text = @"Your passwords did not match";
    }
    else
    {
        currentUser.firstname = _firstnameTextField.text;
        currentUser.lastname = _lastnameTextField.text;
        currentUser.email = _emailTextField.text;
        currentUser.password = _passwordTextField.text;
        currentUser.phonenumber = _phonenumberTextField.text;
        currentUser.gender = _genderTextField.text;
        currentUser.contacts = NULL;
        NSDictionary *dictionary = @{ @"firstname" : _firstnameTextField.text, @"lastname" : _lastnameTextField.text, @"email" : _emailTextField.text, @"phonenumber" : _phonenumberTextField.text, @"password" : _passwordTextField.text, @"gender": _genderTextField.text };
        NSError *error;
        NSData *json = [ NSJSONSerialization dataWithJSONObject: dictionary options: 0 error:&error ];
        if ( error )
        {
            NSLog( @"Error: %@", error );
        }
        [ self sendJSON: json ];
        PEAllUsers *allUsers = [ [ PEAllUsers alloc ] init ];
        [ allUsers.users addObject: currentUser ];
        PEFileManager *fileManager = [ [ PEFileManager alloc ] init ];
        [ fileManager saveToFileUsers: allUsers ];
        [ self performSegueWithIdentifier: @"SignupToDashboardSegue" sender:self ];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _signupLabel.text = @"Create your profile";
}

- ( void ) sendJSON: ( NSData * ) json
{
    NSString *jsonAsNSString = [ [ NSString alloc ] initWithData: json encoding: NSUTF8StringEncoding ];
    NSString *post = [ NSString stringWithFormat:@"%@", jsonAsNSString ];
    NSData *postData = [ post dataUsingEncoding: NSASCIIStringEncoding allowLossyConversion: YES ];
    NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] init ];
    [ request setURL: [ NSURL URLWithString:@"https://lamlctt2g8.execute-api.us-west-2.amazonaws.com/prod/userAdd" ] ];
    [ request setHTTPMethod: @"POST" ];
    [ request setValue: @"application/json" forHTTPHeaderField: @"Content-Type" ];
    [ request setHTTPBody: postData ];
    NSURLConnection *connection = [ [ NSURLConnection alloc ] initWithRequest: request delegate: self ];
    
    if ( connection )
    {
        _signupLabel.text = @"Connection Successful";
        NSLog( @"JSON Sent: %@", jsonAsNSString );
    }
    else
    {
        _signupLabel.text = @"Connection Failed";
        NSLog( @"JSON Sent: %@", jsonAsNSString );
    }
}

@end
