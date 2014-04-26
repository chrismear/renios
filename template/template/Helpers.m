/*
 * Copyright 2012, 2013 Chris Mear <chris@feedmechocolate.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to permit
 * persons to whom the Software is furnished to do so, subject to the
 * following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
 * NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
 * USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

int RENIOS_SetSaveDirectoryEnv()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Only one Documents folder on iOS

    NSString *saveDirectory = [documentsDirectory stringByAppendingPathComponent:@"saves"];

    // Make directory if it doesn't exist yet
    if (![[NSFileManager defaultManager] fileExistsAtPath:saveDirectory]){

        NSError* error;
        if([[NSFileManager defaultManager] createDirectoryAtPath:saveDirectory withIntermediateDirectories:NO attributes:nil error:&error])
            ; // success
        else
        {
            NSLog(@"Couldn't create saves directory");
        }
    }

    setenv("RENIOS_SAVE_DIRECTORY", [saveDirectory cStringUsingEncoding:NSUTF8StringEncoding], 1);

    return 1;
}

const char * RENIOS_ScriptsPath()
{
    NSString *scriptsResourceDirectory = [[[NSBundle mainBundle] bundlePath]
                                          stringByAppendingPathComponent:@"scripts"];
    return [scriptsResourceDirectory cStringUsingEncoding:NSUTF8StringEncoding];

}

const char * RENIOS_ScreenVariant()
{
    UIUserInterfaceIdiom userInterfaceIdiom = [[UIDevice currentDevice] userInterfaceIdiom];
    if (userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        NSLog(@"Setting variant: medium tablet touch");
        return "medium tablet touch";
    } else {
        NSLog(@"Setting variant: small phone touch");
        return "small phone touch";
    }
}
