//
//  SUIUtilities.m
//  SUIToolKitDemo
//
//  Created by zzZ on 15/11/25.
//  Copyright © 2015年 SUIO~. All rights reserved.
//

#import "SUIUtilities.h"

NSString *const sui_everLaunched = @"sui_everLaunched";
NSString *const sui_everVersion = @"sui_everVersion";


@interface SUIUtilities ()

@property (nonatomic,assign) SUILaunchedType launchedType;


@end


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Launched
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

@implementation SUIUtilities (SUILaunch)

- (void)updateVersion
{
    if (gUserDefaultsBoolForKey(sui_everLaunched))
    {
        NSString *cVersion = kVersion;
        NSString *eVersion = [self previousVersion];
        
        if ([eVersion isEqualToString:cVersion]) {
            self.launchedType = SUILaunchedTypeLatestVersion;
            uLogInfo(@"ever launched latest-version CurrVersion ⤭ %@ ⤪", cVersion);
        }
        else
        {
            [gUserDefaults setObject:cVersion forKey:sui_everVersion];
            [gUserDefaults synchronize];
            
            self.launchedType = SUILaunchedTypeUpdateVersion;
            uLogInfo(@"ever launched update-version EverVersion ⤭ %@ ⤪  CurrVersion ⤭ %@ ⤪", eVersion, cVersion);
        }
    }
    else
    {
        [gUserDefaults setBool:YES forKey:sui_everLaunched];
        [gUserDefaults setObject:kVersion forKey:sui_everVersion];
        [gUserDefaults synchronize];
        
        self.launchedType = SUILaunchedTypeFirstLaunched;
        uLogInfo(@"first launched CurrVersion ⤭ %@ ⤪", kVersion);
    }
}

- (NSString *)previousVersion
{
    return gUserDefaultsObjForKey(sui_everVersion);
}

@end


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Utilities
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

@implementation SUIUtilities


#pragma mark - Init

+ (instancetype)sharedInstance
{
    static SUIUtilities *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[self alloc] init];
        [sharedSingleton commonInit];
    });
    
    return sharedSingleton;
}

- (void)commonInit
{
    [self updateVersion];
}


#pragma mark - Launched

+ (SUILaunchedType)sui_launchedType
{
    return [[self sharedInstance] launchedType];
}

+ (nullable NSString *)sui_previousVersion
{
    return [[self sharedInstance] previousVersion];
}


#pragma mark - File manager

+ (BOOL)sui_fileCreateDirectory:(NSString *)filePath
{
    if (![self sui_fileExist:filePath])
    {
        NSError *anyError = nil;
        BOOL ret = [[NSFileManager defaultManager]
                    createDirectoryAtPath:filePath
                    withIntermediateDirectories:YES
                    attributes:nil
                    error:&anyError];
        if (ret) {
            uLogInfo(@"file create director succeed At ⤭ %@ ⤪", filePath);
        } else {
            uLogError(@"file create director Error ⤭ %@ ⤪  At ⤭ %@ ⤪", anyError, filePath);
        }
        return ret;
    }
    return YES;
}

+ (BOOL)sui_fileExist:(NSString *)filePath
{
    BOOL ret = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    return ret;
}

+ (BOOL)sui_fileWrite:(NSData *)data toPath:(NSString *)filePath
{
    NSError *anyError = nil;
    BOOL ret = [data writeToFile:filePath
                         options:NSDataWritingAtomic
                           error:&anyError];
    if (ret) {
        uLogInfo(@"file write succeed To ⤭ %@ ⤪", filePath);
    } else {
        uLogError(@"file write Error ⤭ %@ ⤪  To ⤭ %@ ⤪", anyError, filePath);
    }
    return ret;
}

+ (BOOL)sui_fileMove:(NSString *)sourcePath toPath:(NSString *)filePath
{
    NSError *anyError = nil;
    BOOL ret = [[NSFileManager defaultManager]
                moveItemAtPath:sourcePath
                toPath:filePath
                error:&anyError];
    if (ret) {
        uLogInfo(@"file move succeed Source ⤭ %@ ⤪  To ⤭ %@ ⤪", sourcePath, filePath);
    } else {
        uLogError(@"file move Error ⤭ %@ ⤪  Source ⤭ %@ ⤪  To ⤭ %@ ⤪", anyError, sourcePath, filePath);
    }
    return ret;
}

+ (BOOL)sui_fileCopy:(NSString *)sourcePath toPath:(NSString *)filePath
{
    NSError *anyError = nil;
    BOOL ret = [[NSFileManager defaultManager]
                copyItemAtPath:sourcePath
                toPath:filePath
                error:&anyError];
    if (ret) {
        uLogInfo(@"file copy succeed Source ⤭ %@ ⤪  To ⤭ %@ ⤪", sourcePath, filePath);
    } else {
        uLogError(@"file copy Error ⤭ %@ ⤪  Source ⤭ %@ ⤪  To ⤭ %@ ⤪", anyError, sourcePath, filePath);
    }
    return ret;
}

+ (NSData *)sui_fileRead:(NSString *)filePath
{
    NSError *anyError = nil;
    NSData *readData = [NSData dataWithContentsOfFile:filePath
                                              options:NSDataReadingMappedIfSafe
                                                error:&anyError];
    if (anyError) {
        uLogError(@"file read Error ⤭ %@ ⤪  At ⤭ %@ ⤪", anyError, filePath);
    } else {
        uLogInfo(@"file read succeed Length ⤭ %zd ⤪  At ⤭ %@ ⤪", readData.length, filePath);
    }
    return readData;
}

+ (NSUInteger)sui_fileSize:(NSString *)filePath
{
    if ([self sui_fileExist:filePath])
    {
        NSError *anyError = nil;
        NSDictionary *attributes = [[NSFileManager defaultManager]
                                    attributesOfItemAtPath:filePath
                                    error:&anyError];
        if (!anyError) {
            NSInteger fSize = [[attributes objectForKey:NSFileSize] integerValue];
            uLogInfo(@"file size succeed Size ⤭ %zd ⤪  At ⤭ %@ ⤪", fSize, filePath);
            return fSize;
        } else {
            uLogError(@"file size Error ⤭ %@ ⤪  At ⤭ %@ ⤪", anyError, filePath);
        }
    }
    return 0;
}

+ (BOOL)sui_fileDelete:(NSString *)filePath
{
    if ([self sui_fileExist:filePath])
    {
        NSError *anyError = nil;
        BOOL ret = [[NSFileManager defaultManager]
                    removeItemAtPath:filePath
                    error:&anyError];
        if (ret) {
            uLogInfo(@"file delete succeed At ⤭ %@ ⤪", filePath);
        } else {
            uLogError(@"file delete Error ⤭ %@ ⤪  At ⤭ %@ ⤪", anyError, filePath);
        }
        return ret;
    }
    return YES;
}


#pragma mark - Unique identifier

+ (NSString *)sui_uuidString
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    NSString *curUUID = (__bridge_transfer NSString*)
    CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    NSString *currUUID = [[curUUID lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    uLogInfo(@"uuid ⤭ %@ ⤪", currUUID);
    return currUUID;
}

+ (NSString *)sui_idfvString
{
    NSString *curIdfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *currIdfv = [[curIdfv lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    uLogInfo(@"idfv ⤭ %@ ⤪", currIdfv);
    return currIdfv;
}


#pragma mark - Camera & PhotoLibrary

+ (BOOL)sui_cameraAvailable
{
    BOOL ret = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (ret) {
        uLogInfo(@"camera available");
    } else {
        uLogInfo(@"cameta unavailable");
    }
    return ret;
}

+ (BOOL)sui_cameraRearAvailable
{
    BOOL ret = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (ret) {
        uLogInfo(@"camera rear available");
    } else {
        uLogInfo(@"cameta rear unavailable");
    }
    return ret;
}

+ (BOOL)sui_cameraFrontAvailable
{
    BOOL ret = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    if (ret) {
        uLogInfo(@"camera front available");
    } else {
        uLogInfo(@"cameta front unavailable");
    }
    return ret;
}

+ (BOOL)sui_photoLibraryAvailable
{
    BOOL ret = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    if (ret) {
        uLogInfo(@"photo library available");
    } else {
        uLogInfo(@"photo library unavailable");
    }
    return ret;
}


#pragma mark - Others

+ (BOOL)sui_toAppStore:(NSString *)appId
{
    NSString *curURL = gFormat(@"itms-apps://itunes.apple.com/app/id%@", appId);
    BOOL ret = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:curURL]];
    if (ret) {
        uLogInfo(@"go to app store succeed AppId ⤭ %@ ⤪", appId);
    } else {
        uLogError(@"go to app store failed AppId ⤭ %@ ⤪", appId);
    }
    return ret;
}

+ (SUIUtilitiesDelayTask)sui_delay:(NSTimeInterval)delay cb:(void (^)(void))completion;
{
    __block dispatch_block_t closure = completion;
    __block SUIUtilitiesDelayTask currTask = nil;
    
    SUIUtilitiesDelayTask delayedBlock = ^(BOOL cancel) {
        if (cancel == NO) {
            dispatch_async(dispatch_get_main_queue(), closure);
        }
        closure = nil;
        currTask = nil;
    };
    
    currTask = delayedBlock;
    
    [self sui_delayExecutive:delay cb:^{
        if (currTask) currTask(NO);
    }];
    return currTask;
}

+ (void)sui_cancelDelayTask:(SUIUtilitiesDelayTask)cTask
{
    if (cTask) cTask(YES);
}

+ (void)sui_delayExecutive:(NSTimeInterval)delayInSeconds cb:(void (^)(void))completionBlock
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), completionBlock);
}

@end
