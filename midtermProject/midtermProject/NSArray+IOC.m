//
//  NSArray+IOCExtension.m
//  Week03Working
//
//  Created by Abraham Avnisan on 2/6/17.
//  Copyright © 2017 Abraham Avnisan. All rights reserved.
//

#import "NSArray+IOC.h"
#import "IOCMath.h"

#if TARGET_OS_IPHONE
// iOS code
@import UIKit;
#else
// OSX code
#endif


@implementation NSArray (IOC)

- (id)getRandomObject
{
    IOCMath *mathHelper = [[IOCMath alloc] init];
    
    int upperBound = (int)[self count] - 1;
    NSUInteger randomIndex = (NSUInteger)[mathHelper getRandomIntWithMinOutput:0 maxOutput:upperBound];
    return [self objectAtIndex:randomIndex];
}

#if TARGET_OS_IPHONE
// iOS code
+ (NSArray *)arrayWithImageFilesUsingPrefix:(NSString *)prefix
                             startingNumber:(int)startNum
                                   toNumber:(int)endNum
                              withNumDigits:(int)numDigits
{
    
    NSString *imageNamePrefix = prefix ? prefix : @"";
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    
    for (int i = startNum; i < endNum - startNum + 2; i++) {
        
        NSString *imageName = [imageNamePrefix stringByAppendingFormat:@"%03d", i];
        UIImage *image = [UIImage imageNamed:imageName];
        
        if (!image) {
            NSLog(@"ERROR! Image with name '%@' not found in the Assets.xcassets folder!", imageName);
            exit(EXIT_FAILURE);
        }
        
        [mutableArray addObject:image];
        
    }
    
    return [NSArray arrayWithArray:mutableArray];
}
#endif

@end
