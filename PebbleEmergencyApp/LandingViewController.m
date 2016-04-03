//
//  LandingViewController.m
//  PebbleEmergencyApp
//
//  Created by Jasper Davey on 4/2/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

#import "LandingViewController.h"

@interface LandingViewController ()

@property ( weak, nonatomic ) IBOutlet UILabel *headerLogo;
@property ( weak, nonatomic ) IBOutlet UIImageView *appLogo;
@property ( weak, nonatomic ) IBOutlet UILabel *appDescription;
@property ( weak, nonatomic ) IBOutlet UIButton *signupButton;
@property ( weak, nonatomic ) IBOutlet UIButton *loginButton;

@end

@implementation LandingViewController

- ( IBAction )signupButtonPressed: ( id )sender
{
    [ self performSegueWithIdentifier: @"SignupSegue" sender: self ];
}

- ( IBAction )loginButtonPressed: ( id )sender
{
    [ self performSegueWithIdentifier: @"LoginSegue" sender: self ];
}

- ( void ) viewDidLoad
{
    [ super viewDidLoad ];
    _headerLogo.text = @"Chrono | Emergency";
    _appDescription.text = @"Wear your freedom";
    _appLogo.image = [ UIImage imageNamed:@"LogoScopic" ];
    
}





@end
