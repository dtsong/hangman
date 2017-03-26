//
//  TextPlay.m
//  Week7Demo
//
//  Created by Abraham Avnisan on 3/14/16.
//  Copyright © 2016 Abraham Avnisan. All rights reserved.
//

#import "IOCTextPlay.h"

@implementation IOCTextPlay

- (instancetype)initWithString:(NSString *)string
{
    self = [super init];
    
    if (self) {
        
        self.string = string;
        
    }
    return self;
    
}

- (NSArray *)breakIntoLinesWithWidth:(int)width
{
    // create a local copy of teh string property
    NSString *baseString = self.string;
    
    // strip out any extant new line characters
    baseString = [baseString stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    
    // make sure target width is greater than self.string's length
    NSUInteger lastIndex = [baseString length] - 1;
    if (lastIndex < width) {
        NSLog(@"ERROR! Width of target line is less than number of chars in self.string!");
        exit(1);
    }
    
    // calculate number of lines
    float stringLength = (float)[baseString length];
    float targetWidth = (float)width;
    NSUInteger numLines = (NSUInteger)ceilf(stringLength / targetWidth);
    
    // create an empty array to collect our lines
    NSMutableArray *lines = [[NSMutableArray alloc] init];
    
    // iterate once for every line we want to create
    for (NSUInteger i = 1; i <= numLines; i++) {
        
        // calculate first and last indices in line
        NSUInteger firstIndexInLine = (i * width) - width;
        NSUInteger lastIndexInLine = i * width - 1;
        
        // adjust lastIndexInLine for the last line so
        // we don't go out of range
        if (lastIndexInLine > lastIndex) {
            lastIndexInLine = lastIndex;
            width = (int)(lastIndexInLine - firstIndexInLine);
        }
        
        // create an NSRange for this line
        NSRange range = NSMakeRange(firstIndexInLine, width);
        
        // grab this line from baseString
        NSString *thisLine = [baseString substringWithRange:range];
        
        [lines addObject:thisLine];
        
    }
    return lines;
}

- (NSString *)repeatStringUntilItIsNCharsLong:(int)targetLength
{
    
    NSString *string = [self.string stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    
    // make sure target length is longer than length of string
    if (targetLength < [string length]) {
        NSLog(@"ERROR! targetLength must be longer than length of stringToRepeat!");
        exit(1);
    }
    
    // create an output var that begins as a copy of string
    NSString *output = [NSString stringWithString:string];
    
    // calculate the number of times the string will need to be repeated
    int numTimesToRepeat = ceilf((float)targetLength / (float)[string length]);
    
    // create a loop to repeat the string
    for (int i = 0; i < numTimesToRepeat; i++) {
        output = [output stringByAppendingString:string];
    }
    
    // if needed, trim the output to the specified length
    if ([output length] > targetLength) {
        output = [output substringToIndex:targetLength];
    }
    
    return output;
}

- (NSString *)getStringRepeatedForNLines:(int)targetNumLines
                           withLineWidth:(int)lineWidth
{
    // calculate number of chars the output should be
    int outputLength = targetNumLines * lineWidth;
    
    // create a repeated string with target outputLength
    NSString *outputWithoutLines = [self repeatStringUntilItIsNCharsLong:outputLength];
    
    // create an empty string to store our output
    NSString *outputWithLines = @"";
    
    // create a loop to iterate once for every line to be created
    for (NSUInteger i = 0; i < targetNumLines; i++) {
        
        // calculate range for this line
        NSRange range = NSMakeRange(i * lineWidth, lineWidth);
        NSString *thisLine = [outputWithoutLines substringWithRange:range];
        
        if (i != targetNumLines - 1) {
            // if this is not the last line, add this line followed by a new line char
            outputWithLines = [outputWithLines stringByAppendingString:[NSString stringWithFormat:@"%@\n", thisLine]];
        } else {
            // if this is the last line to add, add just the line without the new line char
            outputWithLines = [outputWithLines stringByAppendingString:thisLine];
        }
    }
    
    return outputWithLines;
}

- (NSArray *)getArrayRepeatedForNLines:(int)targetNumLines
                         withLineWidth:(int)lineWidth
{
    
    NSString *stringRepeated = [self getStringRepeatedForNLines:targetNumLines withLineWidth:lineWidth];
    NSArray *lines = [stringRepeated componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    return lines;
}


@end
