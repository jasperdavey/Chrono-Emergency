//
//  dangerController.swift
//  PebbleEmergencyApp
//
//  Created by Jasper Davey on 4/3/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

import Foundation
import WatchKit

class dangerInterfaceController : WKInterfaceController
{
    @IBOutlet weak var labelX: WKInterfaceLabel!
    @IBOutlet weak var labelY: WKInterfaceLabel!
    @IBOutlet var dismissDanger: WKInterfaceButton!
    
    @IBOutlet var callForHelp: WKInterfaceButton!
    
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        
    }
    
    @IBAction func callForHelpPressed()
    {
        // call for help
        WKInterfaceController.reloadRootControllersWithNames( [ "home" ] , contexts: nil )
    }

    
    @IBAction func dismissDangerPressed()
    {
        WKInterfaceController.reloadRootControllersWithNames( [ "home" ] , contexts: nil )
    }
    
    
    override func willActivate()
    {
        super.willActivate()
        
        self.labelX.setText( "Status: " )
        self.labelY.setText( "Danger" )
        self.labelY.setTextColor( UIColor.redColor() )

        
    }
    
    
}