//
//  IOCTextOutput.m
//
//  Created by Abraham Avnisan on 2/29/16.
//  Copyright © 2016 Abraham Avnisan. All rights reserved.
//

#import "IOCTextOutput.h"

@implementation IOCTextOutput


#pragma mark - designated initializer
- (instancetype)init
{
    self = [super init];
    if (self) {
        _isVerbose = YES;
    }
    return self;
}

- (void)outputString:(NSString *)string toTextFile:(NSString *)fileName
{
    // ADD .TXT EXTENSION IF FILENAME DOESN'T ALREADY CONTAIN IT
    if (![fileName containsString:@".txt"]) {
        fileName = [fileName stringByAppendingString:@".txt"];
    }
    
    
    // SANITIZE STRING TO SAVE BY FORCING IT TO UTF-8 ENCODING
    const char *stringAsCharArray = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSString *stringToOutput = [NSString stringWithUTF8String:stringAsCharArray];
    
    // SET OUTPUT DIR
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    NSString *desktopDirectory = [paths objectAtIndex:0];
    NSString *outputDirectory = @"SavedFromObj-C";
    NSString *outputDirPath = [NSString stringWithFormat:@"%@/%@", desktopDirectory, outputDirectory];
    
    // CREATE OUTPUT DIR IF IT DOESN'T EXITS
    BOOL isDir;
    NSFileManager *fileManager= [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:outputDirPath isDirectory:&isDir])
        if(![fileManager createDirectoryAtPath:outputDirPath withIntermediateDirectories:YES attributes:nil error:NULL]) {
            NSLog(@"Error: Failed to create folder at %@", outputDirPath);
            exit(1);
        }
    
    // MAKE A FILE PATH TO WRITE THE FILE TO
    NSString *filePath = [NSString stringWithFormat:@"%@/%@/%@", desktopDirectory, outputDirectory, fileName];
    
    if (self.isVerbose)
        NSLog(@"attempting to output file to %@", filePath);
    
    
    // ATTEMPT TO WRITE OUR FILE TO OUR FILEPATH
    NSError *error;
    BOOL success = [stringToOutput writeToFile:filePath
                            atomically:NO
                              encoding:NSUTF8StringEncoding
                                 error:&error];
    if (self.isVerbose) {        
        if (!success) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            NSLog(@"file output successfully");
        }
    }
}

@end
