//
//  PEFileManager.h
//  PebbleEmergencyApp
//
//  Created by Jasper Davey on 4/2/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PEUser.h"

@interface PEFileManager : NSObject

- ( BOOL ) fileExists: ( NSString * ) file;

- ( BOOL ) createFile: ( NSString * ) file;

- ( NSString * ) getFilePath: ( NSString * ) file;

- ( PEAllUsers * ) loadFromFileUsers;

- ( BOOL ) saveToFileUsers: ( PEAllUsers * ) currentUser;

- ( BOOL ) saveToFileSearch: ( NSDictionary * ) symbols;

- ( NSDictionary * ) loadFromFileSearch;

@end
