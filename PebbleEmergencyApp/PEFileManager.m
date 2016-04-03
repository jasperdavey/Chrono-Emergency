//
//  PEFileManager.m
//  PebbleEmergencyApp
//
//  Created by Jasper Davey on 4/2/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

#import "PEFileManager.h"
#import "SSConstants.h"

@implementation PEFileManager

- ( BOOL ) fileExists: ( NSString * ) file
{
    BOOL fileExistsAtPath;
    
    fileExistsAtPath = [ [ NSFileManager defaultManager ] fileExistsAtPath: [ self getFilePath: file ] ];
    
    return fileExistsAtPath;
}

- ( BOOL ) createFile: ( NSString * ) file
{
    NSData *currentUser = [ [ NSData alloc ] init ];
    
    return [ [ NSFileManager defaultManager ] createFileAtPath: [ self getFilePath: file ] contents: currentUser attributes: nil ];
}

- ( NSString * ) getFilePath: ( NSString * ) file
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *pathString = [ [ pathArray objectAtIndex: 0 ] stringByAppendingPathComponent: file ];
    
    return pathString;
}

- ( BOOL ) saveToFileUsers: ( PEAllUsers * ) currentUser
{
    NSMutableData *pData = [ [ NSMutableData alloc ]init ];
    NSString *path = [ self getFilePath: kPathToDabaseFile ];
    
    NSKeyedArchiver *archiver = [ [ NSKeyedArchiver alloc ] initForWritingWithMutableData: pData ];
    [ currentUser encodeWithCoder: archiver ];
    [ archiver finishEncoding ];
    
    return [ pData writeToFile: path atomically: YES ];
}

- ( PEAllUsers * ) loadFromFileUsers
{
    NSString *path = [ self getFilePath: kPathToDabaseFile ];
    NSMutableData *pData = [ [ NSMutableData alloc ] initWithContentsOfFile: path ];
    NSKeyedUnarchiver *unArchiver = [ [ NSKeyedUnarchiver alloc ] initForReadingWithData: pData ];
    PEAllUsers *data = [ [ PEAllUsers alloc ] initWithCoder: unArchiver ];
    [ unArchiver finishDecoding ];
    
    return data;
}

@end
