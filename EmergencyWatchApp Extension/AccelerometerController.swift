//
//  AccelerometerController.swift
//  PebbleEmergencyApp
//
//  Created by Jasper Davey on 4/3/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

import Foundation
import WatchKit
import CoreMotion

class AccelerometerInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var labelX: WKInterfaceLabel!
    @IBOutlet weak var labelY: WKInterfaceLabel!
    @IBOutlet var logo: WKInterfaceImage!
    
    
    let motionManager = CMMotionManager()
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        motionManager.accelerometerUpdateInterval = 0.1
    }
    
    override func willActivate() {
        super.willActivate()
        
        var count = 0
        var avgArray: NSMutableArray = [ ]
        
        if motionManager.accelerometerAvailable {
            let handler:CMAccelerometerHandler = {(data: CMAccelerometerData?, error: NSError?) -> Void in
                self.labelX.setText( "Status: " )
                self.labelY.setText( "Safe" )
                self.labelY.setTextColor( UIColor.greenColor() )
                self.logo.setImageNamed("LogoScopic")
                //self.labelX.setText(String(format: "%.2f", data!.acceleration.x))
                //self.labelY.setText(String(format: "%.2f", data!.acceleration.y))
                //self.labelZ.setText(String(format: "%.2f", data!.acceleration.z))
                if ( count < 4 )
                {
                    avgArray.addObject( Double( data!.acceleration.z ) );
                    count += count + 1
                }
                else
                {
                    count = 0
                    self.coordinateAverage( avgArray )
                    avgArray.removeAllObjects()
                    
                }
            }
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: handler)
        }
        else
        {
            labelX.setText("not available")
            labelY.setText("not available")

        }
    }
    
    func coordinateAverage( varArray: NSMutableArray )
    {
        var sum = 0.0;
        for var i = 0; i < varArray.count; i = i + 1
        {
            sum += varArray.objectAtIndex( i ).doubleValue
        }
        let average = sum / Double( varArray.count )
        
        for var y = 0; y < varArray.count; y = y + 1
        {
            if ( abs(abs(varArray.objectAtIndex( y ).doubleValue) - abs(average)) > 0.2 )
            {
            WKInterfaceController.reloadRootControllersWithNames( [ "dangerController" ] , contexts: nil )
                self.labelX.setText( "Status: " )
                self.labelY.setText( "Danger" )
                self.labelY.setTextColor( UIColor.redColor() )
                print( abs(abs(varArray.objectAtIndex( y ).doubleValue ) - abs(average) ) )
                print( abs(varArray.objectAtIndex( y ).doubleValue ))
                print( abs(average ) )
                print( "TRIGGER" )
            }
        }
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        
        motionManager.stopAccelerometerUpdates()
    }
}