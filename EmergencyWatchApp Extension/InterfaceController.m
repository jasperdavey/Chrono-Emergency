//
//  InterfaceController.m
//  EmergencyWatchApp Extension
//
//  Created by Jasper Davey on 4/2/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
{
    CMMotionManager *motionManager;
}
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *labelX;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *labelY;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *labelZ;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *button;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    motionManager.accelerometerUpdateInterval = 0.1;
    // Configure interface objects here.
    
}
- (IBAction)buttonPressed
{
    [ _labelX setText: @"Working" ];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSOperationQueue* accelerometerQueue = [[NSOperationQueue alloc] init];
    if ( [ motionManager isAccelerometerAvailable ] == YES )
    {
        NSLog( @"HERE" );
        CMAccelerometerHandler handler = ^( CMAccelerometerData *accelerometerData, NSError *error )
        {
            [ _labelX setText: [ NSString stringWithFormat: @"%.2f", accelerometerData.acceleration.x ] ];
            [ _labelY setText: [ NSString stringWithFormat: @"%.2f", accelerometerData.acceleration.y ] ];
            [ _labelZ setText: [ NSString stringWithFormat: @"%.2f", accelerometerData.acceleration.z ] ];
        };
        [ motionManager startAccelerometerUpdatesToQueue: accelerometerQueue withHandler:[ handler copy ] ];
    }
    else
    {
        [ _labelX setText: @"Accelerometer not available" ];
        [ _labelY setText: @"Accelerometer not available" ];
        [ _labelZ setText: @"Accelerometer not available" ];
    }
}


- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



