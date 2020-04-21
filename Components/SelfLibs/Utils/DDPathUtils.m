//
//  DDPathUtils.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/27.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDPathUtils.h"

@implementation DDPathUtils

+ (NSString *)getFileDocumentPath:(NSString *)fileName{
    if (nil == fileName){
        return nil;
    }
    NSString *documentDirectory = [self.class getDocumentPath];
    NSString *fileFullPath = [documentDirectory stringByAppendingPathComponent:fileName];
    return fileFullPath;
}

+ (NSString *)getFileCachePath:(NSString *)fileName{
    if (nil == fileName){
        return nil;
    }
    NSString *cacheDirectory = [self.class getCachePath];
    NSString *fileFullPath = [cacheDirectory stringByAppendingPathComponent:fileName];
    return fileFullPath;
}

+ (NSString *)getFileResourcePath:(NSString *)fileName{
    if ([NSString isEmpty:fileName]){
        return nil;
    }
    // 获取资源目录路径
    NSString *resourceDir = [[NSBundle mainBundle] resourcePath];
    return [resourceDir stringByAppendingPathComponent:fileName];
}

+ (BOOL)isExistFileInDocument:(NSString *)fileName{
    if ([NSString isEmpty:fileName]){
        return NO;
    }
    
    NSString *filePath = [self.class getFileDocumentPath:fileName];
    if (nil == filePath){
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

+ (BOOL)isExistFileInCache:(NSString *)fileName{
    if (nil == fileName || [fileName length] == 0){
        return NO;
    }
    NSString *filePath = [self.class getFileCachePath:fileName];
    if (nil == filePath){
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

+ (BOOL)removeFolderInDocumet:(NSString *)aFolderNameInDoc{
    if ([NSString isEmpty:aFolderNameInDoc]){
        return YES ;
    }
    NSString *filePath = [self.class getFileDocumentPath:aFolderNameInDoc];
    if (nil == filePath){
        return YES;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:filePath error:nil];
}

+ (BOOL)removeFolderInCahe:(NSString *)aFolderNameInCahe{
    if ([NSString isEmpty:aFolderNameInCahe]){
        return YES ;
    }
    
    if (![self.class isExistFileInCache:aFolderNameInCahe]) {
        return YES;
    }
    
    NSString *filePath = [self.class getFileCachePath:aFolderNameInCahe];
    if (nil == filePath){
        return YES;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:filePath error:nil];
}


// 判断一个文件是否存在于resource目录下
+ (BOOL)isExistFileInResource:(NSString *)fileName{
    if ([NSString isEmpty:fileName]){
        return NO;
    }
    NSString *filePath = [self.class getFileResourcePath:fileName];
    if (nil == filePath){
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

+ (BOOL)isExistFile:(NSString *)aFilePath{
    if ([NSString isEmpty:aFilePath]){
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:aFilePath];
}

+ (BOOL)copyResourceFile2DocumentPath:(NSString *)resourceName{
    if ([NSString isEmpty:resourceName]){
        return NO;
    }
    //获取资源文件的存放目录进行
    NSString *resourcePath = [self.class getFileResourcePath:resourceName];
    NSString *documentPath = [self.class getFileDocumentPath:resourceName];
    if (nil == resourcePath || nil == documentPath){
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([self.class isExistFile:documentPath]){
        // 如果文件已存在， 那么先删除原来的
        [self.class deleteFileAtPath:documentPath];
    }
    
    BOOL succ = [fileManager copyItemAtPath:resourcePath toPath:documentPath error:nil];
    return succ;
}

+ (BOOL)deleteFileAtPath:(NSString *)filePath{
    if ([NSString isEmpty:filePath]){
        return NO;
    }
    // 判断文件是否存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]){
        return [fileManager removeItemAtPath:filePath error:nil];
    }
    return NO;
}

+ (NSDictionary *)getFileAttributsAtPath:(NSString *)filePath{
    if ([NSString isEmpty:filePath]){
        return nil;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath] == NO){
        return nil;
    }
    return [fileManager attributesOfItemAtPath:filePath error:nil];
}

+ (BOOL)createDirectoryAtDocument:(NSString *)dirName{
    if (nil == dirName){
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [self.class getFileDocumentPath:dirName];
    if ([fileManager fileExistsAtPath:dirPath]){
        return YES;
    }
    
    BOOL succ = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    return succ;
}

+ (BOOL)createDirectoryAtCache:(NSString *)dirName{
    if (nil == dirName)
    {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [self.class getFileCachePath:dirName];
    if ([fileManager fileExistsAtPath:dirPath]){
        return YES;
    }
    
    BOOL succ = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    return succ;
}

+ (BOOL)createDirectoryAtTemporary:(NSString *)dirName{
    if (nil == dirName){
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *tempPath = [self.class getTemporaryPath];
    NSString *dirPath = [NSString stringWithFormat:@"%@/%@", tempPath, dirName];
    if ([fileManager fileExistsAtPath:dirPath]){
        return YES;
    }
    
    BOOL succ = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    return succ;
}

+ (BOOL)createDirectoryWithPath:(NSString *)dirPath{
    if (nil == dirPath)
    {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:dirPath]){
        return YES;
    }
    BOOL succ = [fileManager createDirectoryAtPath:dirPath
                       withIntermediateDirectories:YES
                                        attributes:nil
                                             error:nil];
    return succ;
}

// 获取文档目录路径
+ (NSString *)getDocumentPath{
    // 获取文档目录路径
    NSArray *userPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [userPaths objectAtIndex:0];
}

// 获取cache目录路径
+ (NSString *)getCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)getTemporaryPath{
    return NSTemporaryDirectory();
}

+ (long long)getFreeSpaceOfDisk{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *freeSpace = [fattributes objectForKey:NSFileSystemFreeSize];
    long long space = [freeSpace longLongValue];
    return space;
}

+ (long long)getFileSize:(NSString *)filePath{
    NSDictionary *fileAttributes = [self getFileAttributsAtPath:filePath];
    if (fileAttributes){
        NSNumber *fileSize = (NSNumber*)[fileAttributes objectForKey: NSFileSize];
        if (fileSize){
            return [fileSize longLongValue];
        }
    }
    return 0;
}

+ (BOOL)copySourceFile:(NSString *)sourceFile toDesPath:(NSString *)desPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 读取文件的信息
    NSData *sourceData = [NSData dataWithContentsOfFile:sourceFile];
    BOOL e = NO;
    if (sourceData){
        e = [fileManager createFileAtPath:desPath contents:sourceData attributes:nil];
    }
    if (e){
        NSLog(@"copySourceFile成功");
    }
    else{
        NSLog(@"copySourceFile失败");
    }
    return YES;
}

+ (BOOL)moveSourceFile:(NSString *)sourceFile toDesPath:(NSString *)desPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager moveItemAtPath:sourceFile toPath:desPath error:&error];
    if (error){
        return NO;
    }
    return YES;
}

// 如果应用程序覆盖安装后，其document目录会发生变化，该函数用于替换就的document路径
+ (NSString *)reCorrentPathWithPath:(NSString *)path{
    if (nil == path){
        return nil;
    }
    NSString *docPath = [self.class getDocumentPath];
    NSRange range = [path rangeOfString:docPath];
    // 没找到正确的document路径
    if (range.length <= 0){
        NSRange docRange = [path rangeOfString:@"Documents/"];
        if (docRange.length > 0){
            NSString *relPath = [path substringFromIndex:docRange.location + docRange.length];
            NSString *newPath = [self.class getFileDocumentPath:relPath];
            return newPath;
        }
    }
    return path;
}

+ (unsigned long long int)folderSize:(NSString *)folderPath{
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSArray *filesArray = [mgr subpathsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *filesEnumerator = [filesArray objectEnumerator];
    NSString *fileName;
    unsigned long long int fileSize = 0;
    
    while (fileName = [filesEnumerator nextObject]) {
        NSDictionary *fileDictionary = [mgr attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:fileName] error:nil];
        fileSize += [fileDictionary fileSize];
    }
    
    return fileSize;
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL{
    if (![[NSFileManager defaultManager] fileExistsAtPath: [URL path]]){
        return NO;
    }
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue:[NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    
    return success;
    
}

+ (NSString *)imageCachePath{
    return [self.class getTemporaryPath];
}

+ (NSString *)getCRMRecordAudioPath{
    NSString *path = @"CRM/RecordAudio";
    [self createDirectoryAtCache:path];
    return [self getFileCachePath:path];
}


/**
 获取显示文件的大小
 */
+ (NSString *)getShowFileSize:(long long)totalSize{
    NSString *unit = @"B";
    double size = 0;
    if (totalSize >= 1024 * 1024 * 1024) {
        size = totalSize / (1024.0f * 1024.0f * 1024.0f);
        unit = @"G";
    }else if (totalSize >= 1024 * 1024) {
        size = totalSize / (1024.0f * 1024.0f);
        unit = @"M";
    }else if (totalSize >= 1024){
        size = totalSize / 1024.0f;
        unit = @"K";
    }else {
        size = totalSize;
    }
    
    int isize = size * 100;
    if (isize % 100 == 0) {
        return [NSString stringWithFormat:@"%.f%@", size, unit];
    }else if (isize % 10 == 0) {
        return[NSString stringWithFormat:@"%.1f%@", size, unit];
    }else {
        size = (size * 10 + 1) / 10;
        return [NSString stringWithFormat:@"%.1f%@", size, unit];
    }
}

/**
 文件目录下的所有文件
 @param dirPath 文件目录
 @return NSMutableArray
 */
+ (NSMutableArray<NSString *> *)allFilesAtPath:(NSString *)dirPath{
    NSMutableArray<NSString *> *pathArray = [NSMutableArray array];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *directoryEnum = [fileManager enumeratorAtPath:dirPath];
    NSString *fileName;
    while (fileName = [directoryEnum nextObject]) {
        BOOL flag = YES;
        NSString *fullPath = [dirPath stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:fullPath isDirectory:&flag]) {
            if (!flag) {
                // ignore .DS_Store
                if (![[fileName substringToIndex:1] isEqualToString:@"."]) {
                    [pathArray addObject:fullPath];
                }
            }
        }
    }
    return pathArray;
}

@end
