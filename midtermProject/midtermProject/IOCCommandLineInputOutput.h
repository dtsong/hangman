//
//  IOCCommandLineInputOutput.h
//  IntroToObjCLibrary
//
//  Created by Abraham Avnisan on 1/31/17.
//  Copyright © 2017 Abraham Avnisan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @class IOCCommandLineInputOutput
 * @discussion This class, which only works for command line programs,
 *             provides some helper functions to get user input from the
 *             console.
 */
@interface IOCCommandLineInputOutput : NSObject

/**
 * @discussion prompts the user for an string value to be entered
 *             on the command line, and returns an NSString *.
 */
- (NSString *)getStringFromConsoleUsingPrompt:(NSString *)prompt;

/**
 * @discussion prompts the user for an integer value to be entered
 *             on the command line, and returns an integer value.
 *             If an error occurs, the value -1 will be returned.
 */
- (int)getIntFromConsoleUsingPrompt:(NSString *)prompt;

/**
 * @discussion prompts the user for an integer value to be entered
 *             on the command line, and returns an integer value.
 *             If an error occurs, the value -1 will be returned.
 */
- (float)getFloatFromConsoleUsingPrompt:(NSString *)prompt;

/**
 * @discussion prints an NSString * to the console using printf()
 */
- (void)printfToConsoleWithString:(NSString *)string;

@end
