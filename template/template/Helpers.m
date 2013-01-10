#import <Foundation/Foundation.h>

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

/*
 * We want the game directory in writeable storage, so that Python bytecode can be saved to disk.
 * So we're going to run the game code from the Library folder. If this copy needs to be done,
 * this function does it. If the copy has already been done, it does nothing.
 */
const char * RENIOS_CopyGameDirectoryToLibraryIfNecessary()
{
    NSArray *libraryPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [libraryPaths objectAtIndex:0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Check for existence of our 'copy-is-complete' file.
    
    BOOL copyAlreadyDone = [fileManager fileExistsAtPath:[libraryDirectory stringByAppendingPathComponent:@"RENIOS.copycomplete"]];
    if (copyAlreadyDone ) {
        NSLog(@"CopyGame: Found completion flag.");
        return [[libraryDirectory stringByAppendingPathComponent:@"scripts"]
                cStringUsingEncoding:NSUTF8StringEncoding];
    }
    
    // If we reach here, then the copy has not already been done.
    // So we need to do it.
    
    NSString *scriptsResourceDirectory = [[[NSBundle mainBundle] bundlePath]
                                          stringByAppendingPathComponent:@"scripts"];
    
    NSError *error;
    
    BOOL copySucceeded = [fileManager copyItemAtPath:scriptsResourceDirectory
                                              toPath:[libraryDirectory stringByAppendingPathComponent:@"scripts"]
                                               error:&error];
    
    if (copySucceeded) {
        NSLog(@"CopyGame: Copy succeded. Writing completion flag.");
        [fileManager createFileAtPath:[libraryDirectory stringByAppendingPathComponent:@"RENIOS.copycomplete"] contents:[NSData data] attributes:nil];
        return [[libraryDirectory stringByAppendingPathComponent:@"scripts"]
                cStringUsingEncoding:NSUTF8StringEncoding];
    } else {
        NSLog(@"CopyGame: Error copying: %@", [error localizedDescription]);
        return NULL;
    }
}
