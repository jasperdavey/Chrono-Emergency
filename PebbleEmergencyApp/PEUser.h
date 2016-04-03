//
//  PEUser.h
//  PebbleEmergencyApp
//
//  Created by Jasper Davey on 4/2/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PEContacts : NSObject < NSCoding >
{
    NSString *cfirstname;
    NSString *clastname;
    NSString *cphonenumber;
    NSString *type;
}
@property NSString *cfirstname;
@property NSString *clastname;
@property NSString *cphonenumber;
@property NSString *type;

@end

@interface PEUser : NSObject < NSCoding >
{
    NSString *firstname;
    NSString *lastname;
    NSString *email;
    NSString *password;
    NSString *phonenumber;
    NSString *gender;
    NSMutableArray< PEContacts * > *contacts;
}
@property NSString *firstname;
@property NSString *lastname;
@property NSString *email;
@property NSString *password;
@property NSString *phonenumber;
@property NSString *gender;
@property NSMutableArray< PEContacts * > *contacts;

@end

@interface PEAllUsers : NSObject < NSCoding >
{
    NSMutableArray< PEUser * > *users;
}
@property NSMutableArray< PEUser * > *users;

@end
