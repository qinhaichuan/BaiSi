//
//  NSString+QHCFileSize.m
//  Baisi
//
//  Created by QHC on 5/3/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "NSString+QHCFileSize.h"

@implementation NSString (QHCFileSize)
-(unsigned long long)fileSize
{
    NSFileManager *manag = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL exists = [manag fileExistsAtPath:self isDirectory:&isDirectory];
    if (!exists) return 0;
    if (isDirectory) {
        
        unsigned long long fileSize = 0;
        
        NSDirectoryEnumerator *enumer = [manag enumeratorAtPath:self];
        for (NSString *subPath in enumer) {
            
            NSString *fullPath = [self stringByAppendingPathComponent:subPath];
            fileSize += [manag attributesOfItemAtPath:fullPath error:nil].fileSize;
            
        }
        
        return fileSize;
    }
    
    return [manag attributesOfItemAtPath:self error:nil].fileSize;
}
@end
