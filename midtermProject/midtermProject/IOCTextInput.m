//
//  textInput.m
//  txtInputOutput
//
//  Created by Abraham Avnisan on 2/25/16.
//  Copyright © 2016 Abraham Avnisan. All rights reserved.
//

#import "IOCTextInput.h"

@interface IOCTextInput ()

@property (strong, nonatomic) NSString *pathToFile;
@property (strong, nonatomic) NSBundle *bundle;

@end

@implementation IOCTextInput

#pragma mark - lazy instantiation
- (NSBundle *)bundle
{
    if (!_bundle) {
        _bundle = [NSBundle mainBundle];
    }
    return _bundle;
}

- (void)setFileName:(NSString *)fileName
{
    if (!_fileName || ![_fileName isEqualToString:fileName]) {
        
        NSString *path = [self.bundle pathForResource:fileName ofType:@"txt"];
        if (path) {
            if (self.isVerbose)
                NSLog(@"file path for '%@' successfully retrieved", fileName);
            self.pathToFile = path;
        } else {
            if (self.isVerbose)
                NSLog(@"path for resource '%@' failed", fileName);
        }
    }
    _fileName = fileName;
}
// designated initializer
- (instancetype)init
{
    self = [super init];
    if (self) {
        _isVerbose = YES;
    }
    return self;
}
- (instancetype)initWithTxtFile:(NSString *)fileName
{
    self = [self init];
    if (self) {
        self.fileName = fileName;
    }
    return self;
}

- (NSString *)getFileAsNSString
{
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:self.pathToFile encoding:NSUTF8StringEncoding error:&error];
    if (!fileContents) {
        NSLog(@"%@", [error localizedDescription]);
        exit(1);
    }
    return fileContents;
}

- (NSArray *)getArrayOfLines
{
    NSString *contents = [self getFileAsNSString];
    NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    if (!lines) {
        NSLog(@"An error has occurred.  The lines could not be extracted from the file.  Make sure the file has more than one line");
        exit(1);
    }
    return lines;
}

- (NSArray *)getArrayOfWords
{
    NSString *contents = [self getFileAsNSString];
    NSArray *words = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!words) {
        NSLog(@"An error has occurred.  The words could not be extracted from the file.  Make sure the file contains words.");
        exit(1);
    }
    return words;
}
- (NSArray *)getArrayOfChars
{
    NSString *contents = [self getFileAsNSString];
    
    NSMutableArray *charArray = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < [contents length]; i++) {
        
        NSString *thisChar = [contents substringWithRange:NSMakeRange(i, 1)];
        
        [charArray addObject:thisChar];
        
    }
    
    return charArray;
}

@end











