//
//  IOCAsciiArt.m
//  Week03Working
//
//  Created by Abraham Avnisan on 2/8/17.
//  Copyright © 2017 Abraham Avnisan. All rights reserved.
//

#import "IOCAsciiArt.h"
#import "IOCTextInput.h"

@interface IOCAsciiArt ()

@property (strong, nonatomic) NSArray *lines;



@end

@implementation IOCAsciiArt

- (instancetype)initWithTxtFile:(NSString *)fileName andCaptionsArray:(NSArray *)captions
{
    self = [super init];
    if (self) {

        if (captions) {
            self.captions = captions;
        }
        
        IOCTextInput *textInput = [[IOCTextInput alloc] initWithTxtFile:fileName];
        NSString *contents = [textInput getFileAsNSString];
        contents = [contents stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
        self.lines = [contents componentsSeparatedByString:@"\n"];
        
        [self widenImage];
        
        // calculate average line length
        int sum = 0;
        for (NSString *line in self.lines) {
            sum += line.length;
        }
        
        self.imageWidth = sum / [self.lines count];
        self.imageHeight = (int)[self.lines count];
    }
    return self;
}
- (void)printfToConsole
{
    for (NSString *line in self.lines) {
        const char *output = [line UTF8String];
        printf("%s\n", output);
    }
}
- (void)printfToConsoleWithWidth:(int)width
{
    NSString *emptySpace = @"";
    
    if (width < self.imageWidth) {
        NSLog(@"ERROR!! - printfToConsoleWidthWidth called with a width that is less than the IOCAsciiArt image width!");
        exit(1);
    }
    
    int marginWidth = (width - self.imageWidth) / 2;
    
    for (int i = 0; i < marginWidth; i++) {
        emptySpace = [emptySpace stringByAppendingString:@" "];
    }

    for (NSString *line in self.lines) {
        
        
        NSString *output = [emptySpace stringByAppendingString:line];
        output = [output stringByAppendingString:emptySpace];
        
        const char *outputCStr = [output UTF8String];
        printf("%s\n", outputCStr);
    }
}
- (void)widenImage
{
    NSMutableArray *newLinesArray = [[NSMutableArray alloc] initWithCapacity:[self.lines count]];
    for (NSString *line in self.lines) {
        
        NSString *newLine = @"";
        
        for (NSUInteger i = 0; i < line.length; i++) {
            
            NSString *thisChar = [line substringWithRange:NSMakeRange(i, 1)];
            newLine = [newLine stringByAppendingFormat:@"%@%@", thisChar, thisChar];
            
        }
        
        [newLinesArray addObject:newLine];
        
    }
    
    self.lines = newLinesArray;
}
- (void)printfEmptyLines:(int)numLines
{
    for (int i = 0; i < numLines; i++) {
        printf("\n");
    }
}
@end
