//
//  PEUser.m
//  PebbleEmergencyApp
//
//  Created by Jasper Davey on 4/2/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

#import "PEUser.h"

@implementation PEContacts : NSObject
@synthesize cfirstname, clastname, cphonenumber;

- ( void ) encodeWithCoder:(NSCoder *) encoder
{
    [ encoder encodeObject: cfirstname forKey:@"cfirstname" ];
    [ encoder encodeObject: clastname forKey:@"clastname" ];
    [ encoder encodeObject: cphonenumber forKey:@"cphonenumber" ];
}

- ( id ) initWithCoder:(NSCoder *) decoder
{
    cfirstname = [ decoder decodeObjectForKey:@"cfirstname" ];
    clastname = [ decoder decodeObjectForKey:@"clastname" ];
    cphonenumber = [ decoder decodeObjectForKey:@"cphonenumber" ];
    return self;
}

@end

@implementation PEUser : NSObject
@synthesize firstname, lastname, email, password, phonenumber, gender, contacts;

- ( void ) encodeWithCoder:( NSCoder * ) encoder
{
    [ encoder encodeObject: firstname forKey:@"firstname" ];
    [ encoder encodeObject: lastname forKey:@"lastname" ];
    [ encoder encodeObject: email forKey:@"email" ];
    [ encoder encodeObject: password forKey:@"password" ];
    [ encoder encodeObject: phonenumber forKey:@"phonenumber" ];
    [ encoder encodeObject: gender forKey:@"gender" ];
    [ encoder encodeObject: contacts forKey:@"contacts" ];
}

- ( id ) initWithCoder:(NSCoder *) decoder
{
    firstname = [ decoder decodeObjectForKey:@"firstname" ];
    lastname = [ decoder decodeObjectForKey:@"lastname" ];
    email = [ decoder decodeObjectForKey:@"email" ];
    password = [ decoder decodeObjectForKey:@"password" ];
    phonenumber = [ decoder decodeObjectForKey:@"phonenumber" ];
    gender = [ decoder decodeObjectForKey:@"gender" ];
    contacts = [ decoder decodeObjectForKey:@"contacts" ];
    return self;
}

@end

@implementation PEAllUsers : NSObject
@synthesize users;

- ( void ) encodeWithCoder:(NSCoder *) encoder
{
    [ encoder encodeObject: users forKey:@"users" ];
}

- ( id ) initWithCoder:(NSCoder *) decoder
{
    users = [ decoder decodeObjectForKey:@"users" ];
    return self;
}

@end
