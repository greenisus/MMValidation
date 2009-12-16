//
//  MMValidation.h
//
//  Created by Michael Mayo on 12/16/09.
//

#import <Foundation/Foundation.h>

#define kPresenceOf 0
#define kAssociated 1
#define kConfirmationOf 2
#define kExclusionOf 3
#define kInclusionOf 4

@class MMValidationError;

@interface MMValidation : NSObject {
	NSInteger type;
	Class klass;
	NSString *member;
	NSString *message;
	
	NSString *confirmationMember;
	NSArray *values;
}

@property (nonatomic) NSInteger type;
@property (nonatomic) Class klass;
@property (nonatomic, retain) NSString *member;
@property (nonatomic, retain) NSString *message;

@property (nonatomic, retain) NSString *confirmationMember;
@property (nonatomic, retain) NSArray *values;

-(BOOL)validate:(NSObject *)object error:(MMValidationError **)error;

@end
