//
//  IOCCommandLineInputOutput.m
//  IntroToObjCLibrary
//
//  Created by Abraham Avnisan on 1/31/17.
//  Copyright © 2017 Abraham Avnisan. All rights reserved.
//

#import "IOCCommandLineInputOutput.h"

@implementation IOCCommandLineInputOutput


- (NSString *)getStringFromConsoleUsingPrompt:(NSString *)prompt
{
    // turn the prompt passed in by the user to a C String
    const char *promptCStr = [prompt UTF8String];
    
    // create a c string to store the user's response
    char responseCStr[256];
    
    // prompt the user
    printf("%s ", promptCStr);
    
    // get the user's response
    scanf ("%[^\n]%*c", responseCStr);
    
    // turn the response into an NSStrin *
    NSString *response = [NSString stringWithCString:responseCStr encoding:NSASCIIStringEncoding];
    
    return response;
    
}
- (int)getIntFromConsoleUsingPrompt:(NSString *)prompt
{
    // turn the prompt passed in by the user to a C String
    const char *promptCStr = [prompt UTF8String];
    
    // create an int to store the user's response.  Default
    // ('error') value is -1
    int i = -1;
    
    // prompt the user
    printf("%s ", promptCStr);
    
    // get the user's response
    scanf ("%d",&i);
    
    return i;
}
- (float)getFloatFromConsoleUsingPrompt:(NSString *)prompt
{
    // turn the prompt passed in by the user to a C String
    const char *promptCStr = [prompt UTF8String];
    
    // create an int to store the user's response.  Default
    // ('error') value is -1
    float f = -1.0;
    
    // prompt the user
    printf("%s ", promptCStr);
    
    // get the user's response
    scanf ("%f",&f);
    
    return f;
}
- (void)printfToConsoleWithString:(NSString *)string
{
    const char *output = [string UTF8String];
    printf("%s", output);
}

@end
