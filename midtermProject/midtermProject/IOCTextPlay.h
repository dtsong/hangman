//
//  TextPlay.h
//  Week7Demo
//
//  Created by Abraham Avnisan on 3/14/16.
//  Copyright © 2016 Abraham Avnisan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOCTextPlay : NSObject

@property (nonatomic, strong) NSString *string;

- (instancetype)initWithString:(NSString *)string;

// a method to take a long string and break it up into lines
// target width must be greater than self.string
- (NSArray *)breakIntoLinesWithWidth:(int)width;

// a method to repeat self.string until it is a certain number of
// characters long. Target length must be longer than length of
// self.string!
- (NSString *)repeatStringUntilItIsNCharsLong:(int)targetLength;

// a method to take a string and repeat it for a certain number of
// lines with a specified line width. Returns a single string with
// "\n" for the lines
- (NSString *)getStringRepeatedForNLines:(int)targetNumLines
                           withLineWidth:(int)lineWidth;

// a method to take a string and repeat it for a certain number of
// lines with a specified line width. Returns an array containing
// each line as an NSString *object
- (NSArray *)getArrayRepeatedForNLines:(int)targetNumLines
                         withLineWidth:(int)lineWidth;


@end
