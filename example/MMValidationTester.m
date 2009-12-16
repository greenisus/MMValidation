//
//  MMValidationTester.m
//
//  Created by Michael Mayo on 12/16/09.
//

#import "MMValidationTester.h"
#import "Person.h"
#import "Address.h"
#import "MMValidationError.h"

@implementation MMValidationTester

+ (void)outputErrors:(NSMutableArray *)errors {
	NSLog(@"Errors: %i", [errors count]);
	for (int i = 0; i < [errors count]; i++) {
		MMValidationError *error = [errors objectAtIndex:i];
		NSLog(@"%@ %@", error.member, error.message);
	}		
}

+ (void)testValidations {
	Person *mike = [[Person alloc] init];
	mike.firstName = @"Mike";
	mike.lastName = @"Mayo";
	mike.password = @"secret";
	mike.passwordConfirmation = @"secret";
	mike.address = [[Address alloc] init];
	mike.address.city = @"San Francisco";
	mike.address.state = @"California";
	mike.favoriteColor = @"green";
	
	NSMutableArray *errors = nil;
	
	if ([mike valid:&errors]) {
		NSLog(@"validation with valid object: PASS");
	} else {
		NSLog(@"validation with valid object: FAIL");		
	}
	
	errors = nil;
	mike.firstName = nil;
	if (![mike valid:&errors]) {
		NSLog(@"presence validation with invalid object: PASS");
		[self outputErrors:errors];
	} else {
		NSLog(@"presence validation with invalid object: FAIL");
	}
	
	errors = nil;
	mike.firstName = @"Mike";
	mike.passwordConfirmation = @"something different";
	if (![mike valid:&errors]) {
		NSLog(@"confirmation validation with invalid object: PASS");
		[self outputErrors:errors];
	} else {
		NSLog(@"confirmation validation with invalid object: FAIL");
	}
	
	errors = nil;
	mike.passwordConfirmation = @"secret";
	mike.address.city = nil;
	mike.address.state = nil;
	if (![mike valid:&errors]) {
		NSLog(@"association validation with invalid object: PASS");
		[self outputErrors:errors];
	} else {
		NSLog(@"association validation with invalid object: FAIL");
	}
	
	
	errors = nil;
	mike.address.city = @"Memphis";
	mike.address.state = @"Tennessee";
	mike.favoriteColor = @"cyan";
	if (![mike valid:&errors]) {
		NSLog(@"inclusion/exclusion validation with invalid object: PASS");
		[self outputErrors:errors];
	} else {
		NSLog(@"inclusion/exclusion validation with invalid object: FAIL");
	}
	
	
}

@end
