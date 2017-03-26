//
//  IOCAsciiArt.h
//  Week03Working
//
//  Created by Abraham Avnisan on 2/8/17.
//  Copyright © 2017 Abraham Avnisan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOCAsciiArt : NSObject

@property (strong, nonatomic) NSArray *captions;
@property (nonatomic) int imageWidth;
@property (nonatomic) int imageHeight;

- (instancetype)initWithTxtFile:(NSString *)fileName andCaptionsArray:(NSArray *)captions;

- (void)printfToConsole;
- (void)printfToConsoleWithWidth:(int)width;
- (void)printfEmptyLines:(int)numLines;

@end
