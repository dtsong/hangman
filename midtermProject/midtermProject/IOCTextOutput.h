//
//  IOCTextOutput.h
//
//  Created by Abraham Avnisan on 2/29/16.
//  Copyright © 2016 Abraham Avnisan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOCTextOutput : NSObject


/**
 * @discussion  set this variable to NO in order
 *              to supress NSLog() messages. The
 *              default value for this property
 *              is YES.
 */
@property (nonatomic) BOOL isVerbose;

/**
 * @discussion  this method saves a file named "fileName" to a
 *              folder on the desktop called "SavedFromObj-C." 
 *
 * @warning It will only work with UTF-8 Encoding.
 *
 * @param string the contents of the text file in the form of a single NSString *
 * @param fileName specifies what the file should be called 
 */
- (void)outputString:(NSString *)string toTextFile:(NSString *)fileName;

@end
