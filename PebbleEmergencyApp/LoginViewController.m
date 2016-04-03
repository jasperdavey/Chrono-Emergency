//
//  LoginViewController.m
//  PebbleEmergencyApp
//
//  Created by Jasper Davey on 4/2/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

#import "LoginViewController.h"
#import <AWSLambda/AWSLambda.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- ( IBAction )loginButtonPressed: ( id )sender
{
    NSDictionary *dictionary = @{@"email": _emailTextField.text, @"password": _passwordTextField.text };
    NSData *json = [ NSJSONSerialization dataWithJSONObject: dictionary options: 0 error:nil ];
    // send data
    
    
    [ self performSegueWithIdentifier: @"LoginToDashboardSegue" sender:self ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- ( void ) sendLambda: ( NSData * ) json
{
    AWSLambdaInvoker *lambdaInvoker = [ AWSLambdaInvoker defaultLambdaInvoker ];
    [ [ lambdaInvoker invokeFunction: @"myUserAdd" JSONObject: json ] continueWithBlock: ^id( AWSTask *task )
     {
         if ( task.error )
         {
             NSLog( @"Error: %@", task.error );
             if ( [ task.error.domain isEqualToString: AWSLambdaInvokerErrorDomain ]
                 && task.error.code == AWSLambdaInvokerErrorTypeFunctionError )
             {
                 NSLog( @"Function error: %@", task.error.userInfo[ AWSLambdaInvokerFunctionErrorKey ] );
             }
         }
         if ( task.exception )
         {
             NSLog( @"Exception: %@", task.exception );
         }
         if ( task.result )
         {
             NSLog( @"Result: %@", task.result );
             NSDictionary *JSONObject = task.result;
             NSLog( @"result: %@", JSONObject[ @"resultKey" ] );
         }
         return nil;
     }];
}

@end
