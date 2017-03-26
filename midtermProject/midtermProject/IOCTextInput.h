//
//  textInput.h
//  txtInputOutput
//
//  Created by Abraham Avnisan on 2/25/16.
//  Copyright © 2016 Abraham Avnisan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOCTextInput : NSObject

/**
 * @discussion  set this variable to NO in order
 *              to supress NSLog() messages. The
 *              default value for this property
 *              is YES.
 */
@property (nonatomic) BOOL isVerbose;

/**
 * @discussion  The name of the text file that the
 *              IOCTextInput object can currently 
 *              access. To read a different text file,
 *              set this property to the new file name.
 *
 * @warning The file name of the text file should NOT
 * include the file extension
 */
@property (strong, nonatomic) NSString *fileName;

- (instancetype)initWithTxtFile:(NSString *)fileName;

- (NSString *)getFileAsNSString;
- (NSArray *)getArrayOfLines;
- (NSArray *)getArrayOfWords;
- (NSArray *)getArrayOfChars;

@end
