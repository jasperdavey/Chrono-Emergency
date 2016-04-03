//
//  DashboardViewController.m
//  PebbleEmergencyApp
//
//  Created by Jasper Davey on 4/2/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

#import "DashboardViewController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface DashboardViewController ( ) < WCSessionDelegate >
@property (weak, nonatomic) IBOutlet UIImageView *connectivityStatusImage;
@property (strong, nonatomic) IBOutlet UILabel *connectivityMessage;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

@end

@implementation DashboardViewController

- ( void ) checkDeviceConnectivity
{
    if ( [ WCSession isSupported ] )
    {
        WCSession *session = [ WCSession defaultSession ];
        session.delegate = self;
        [ session activateSession ];
        
        if ( [ session isPaired ] )
        {
            // Show positive message
            
            _connectivityStatusImage.image = [ UIImage imageNamed:@"checkmark" ];
            _connectivityMessage.text = @"Your Apple Watch is connected!";
        }
        else
        {
            // Show user that device is not paired
            _connectivityStatusImage.image = [ UIImage imageNamed:@"crossmark" ];
            _connectivityMessage.text = @"Your Apple Watch is not paired";
        }
    }
    else
    {
        // print that phone is not supported
        _connectivityStatusImage.image = [ UIImage imageNamed:@"crossmark" ];
        _connectivityMessage.text = @"Your iPhone is not compatible with the Apple Watch";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // We should query for data here from either local or cloud db.
    // We should get back a dictionary for simplicity
    NSDictionary *user = [ self getUserInfo ];
    _connectivityMessage.text = @"Searching for Apple Watch";
    _welcomeLabel.text = [ NSString stringWithFormat:@"Welcome, %@", [ user valueForKey:@"firstname" ] ];
    [ self checkDeviceConnectivity ];
    
}

- ( NSDictionary * ) getUserInfo
{
    NSDictionary *info = @{ @"firstname" : @"Jasper" };
    return info;
}

@end
