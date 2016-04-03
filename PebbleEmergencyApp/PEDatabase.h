//
//  PEDatabase.h
//  PebbleEmergencyApp
//
//  Created by Jasper Davey on 4/2/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PEUser.h"

@interface PEDatabase : NSObject

- ( void ) initializeDatabase;

- ( PEUser * ) queryUser;

- ( PEContacts * ) queryContacts;

- ( void ) resetDatabase;

- ( BOOL ) updateUser: ( PEUser * ) userToSave;

@end
