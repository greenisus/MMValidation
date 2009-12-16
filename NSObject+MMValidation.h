//
//  NSObject+MMValidation.h
//
//  Created by Michael Mayo on 12/16/09.
//

#import <Foundation/Foundation.h>

@interface NSObject (MMValidation)

// Runs validations against your object.  Optionally pass an errors array to get 
// detailed messages on which validations failed.  All validations should be declared
// in +(void)initialize
-(BOOL)valid;
-(BOOL)valid:(NSMutableArray **)errors;

// Validates that member is present.  If member is an NSString, also validates != @""
// Example: [Person validatesPresenceOf:@"firstName"];
// Default message is "can't be blank"
+(void)validatesPresenceOf:(NSString *)member;
+(void)validatesPresenceOf:(NSString *)member message:(NSString *)message;

// Validates an associated object.  Beware of circular dependencies.
// Example: [Person validatesAssociated:@"address"];
// Default message is "is invalid"
+(void)validatesAssociated:(NSString *)member;
+(void)validatesAssociated:(NSString *)member message:(NSString *)message;

// Encapsulates the pattern of wanting to validate a password or email address field with a confirmation.
// Example: [User validatesConfirmationOf:@"password" with:@"passwordConfirmation"];
// Default message is "should match confirmation"
+(void)validatesConfirmationOf:(NSString *)member withConfirmation:(NSString *)confirmationMember;
+(void)validatesConfirmationOf:(NSString *)member withConfirmation:(NSString *)confirmationMember message:(NSString *)message;

// Validates that the value of member is not in the array
// Example: [Person validatesExclusionOf:@"favoriteColor" inValues:[NSArray arrayWithObjects:@"cyan", @"magenta", @"yellow", @"black", nil]];
// Default message is "is reserved"
+(void)validatesExclusionOf:(NSString *)member inValues:(NSArray *)values;
+(void)validatesExclusionOf:(NSString *)member inValues:(NSArray *)values message:(NSString *)message;

// Validates that the value of member is in the array
// Example: [Person validatesInclusionOf:@"favoriteColor" inValues:[NSArray arrayWithObjects:@"red", @"green", @"blue", nil]];
// Default message is "is not included in the list"
+(void)validatesInclusionOf:(NSString *)member inValues:(NSArray *)values;
+(void)validatesInclusionOf:(NSString *)member inValues:(NSArray *)values message:(NSString *)message;

// To be implemented:
// +(void)validatesFormatOf
// +(void)validatesEach
// +(void)validatesLengthOf
// +(void)validatesNumericalityOf

@end
