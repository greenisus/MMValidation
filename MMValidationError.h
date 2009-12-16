//
//  MMValidationError.h
//
//  Created by Michael Mayo on 12/16/09.
//

#import <Foundation/Foundation.h>

@class MMValidation;

@interface MMValidationError : NSObject {
	NSString *member;
	NSString *message;
}

@property (nonatomic, retain) NSString *member;
@property (nonatomic, retain) NSString *message;

-(id)initWithValidation:(MMValidation *)validation;

@end
