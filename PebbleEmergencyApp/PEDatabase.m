//
//  PEDatabase.m
//  PebbleEmergencyApp
//
//  Created by Jasper Davey on 4/2/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

#import "PEDatabase.h"
#import "SSConstants.h"
#import "PEFileManager.h"

@implementation PEDatabase

- ( void ) initializeDatabase
{
    PEFileManager *fileManager = [ [ PEFileManager alloc ] init ];
    NSString *pathToDatabseFile = [ fileManager getFilePath: kPathToDabaseFile ];
    
    if ( [ fileManager fileExists: kPathToDabaseFile ] == NO )
    {
        NSLog( @"File %@ does not exist", pathToDatabseFile );
        NSLog( @"Creating file %@", pathToDatabseFile );
        [ fileManager createFile: kPathToDabaseFile ];
    }
    else
    {
        NSLog( @"File %@ exists", pathToDatabseFile );
    }
    
    [ self queryUser ];
}

- ( PEUser * ) queryUser
{
    PEFileManager *fileManager = [ [ PEFileManager alloc ] init ];
    PEAllUsers *users = [ fileManager loadFromFileUsers ];
    PEUser *currentUser = [ [ PEUser alloc ] init ];
    NSString *loginUser = @"random@email.com";
    BOOL foundUser = NO;
    
    for ( PEUser *desiredUser in users.users )
    {
        NSLog( @"%@", desiredUser.email );
        if ( [ desiredUser.email isEqualToString: loginUser ] )
        {
            foundUser = YES;
            currentUser = desiredUser;
            break;
        }
    }
    

    
    return currentUser;
}

- ( BOOL ) updateUser: ( PEUser * ) userToSave
{
    PEFileManager *fileManager = [ [ PEFileManager alloc ] init ];
    PEAllUsers *users = [ fileManager loadFromFileUsers ];
    
    for ( PEUser *desiredUser in users.users )
    {
        if ( [ desiredUser.email isEqualToString: userToSave.email ] )
        {
            desiredUser.contacts = userToSave.contacts;
            break;
        }
    }
    
    [ fileManager saveToFileUsers: users ];
    
    return true;
}

@end
