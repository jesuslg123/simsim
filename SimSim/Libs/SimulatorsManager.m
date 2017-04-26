//
//  SimulatorsManager.m
//  SimSim
//
//  Created by Jesus Lopez on 26/04/2017.
//  Copyright © 2017 DaniilSmelov. All rights reserved.
//

#import "SimulatorsManager.h"
#import "FileManager.h"

#define SIMULATORS_PATH_ROOT @"/Users/jesus/Library/Developer/CoreSimulator/Devices"
#define FILE_TYPE_DIRECTORY @"NSFileTypeDirectory"

@implementation SimulatorsManager

+ (NSArray *)availableSimulatorsPath {
    
    NSArray *files = [FileManager getSortedFilesFromFolder:SIMULATORS_PATH_ROOT];
    files = [[self class] filter:files byType:FILE_TYPE_DIRECTORY];
    return [[self class] convertToArrayOfString:files];
    
}

+ (NSArray *)filter:(NSArray *)allFiles byType:(NSString *)aType {
    NSPredicate *filtered = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"self.fileType ENDSWITH '%@'", aType]];
    return [allFiles filteredArrayUsingPredicate:filtered];
}

+ (NSArray *)convertToArrayOfString:(NSArray *)files {
    NSMutableArray *filesString = [NSMutableArray new];
    for (NSDictionary * file in files) {
        [filesString addObject:[NSString stringWithFormat:@"%@/%@/",SIMULATORS_PATH_ROOT, file[@"file"]]];
    }
    return filesString.copy;
}

@end
