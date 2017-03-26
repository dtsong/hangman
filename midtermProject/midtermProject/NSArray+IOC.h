//
//  NSArray+IOCExtension.h
//  Week03Working
//
//  Created by Abraham Avnisan on 2/6/17.
//  Copyright © 2017 Abraham Avnisan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (IOC)

/**
 * @discussion returns a random object from the array
 */
- (id)getRandomObject;

/**
 * @warning This method is only available for iOS - NOT Mac OS command line programs!
 */
+ (NSArray *)arrayWithImageFilesUsingPrefix:(NSString *)prefix
                             startingNumber:(int)startNum
                                   toNumber:(int)endNum
                              withNumDigits:(int)numDigits;

@end
