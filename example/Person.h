//
//  Person.h
//
//  Created by Michael Mayo on 12/16/09.
//

#import "NSObject+MMValidation.h"

@class Address;

@interface Person : NSObject {
	NSString *firstName;
	NSString *lastName;	
	NSString *password;
	NSString *passwordConfirmation;
	NSString *favoriteColor;
	Address *address;
}

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *passwordConfirmation;
@property (nonatomic, retain) NSString *favoriteColor;
@property (nonatomic, retain) Address *address;

@end
