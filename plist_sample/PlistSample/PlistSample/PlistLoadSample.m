//
//  PlistLoadSample.m
//  PlistSample
//
//  Created by 山口 徹 on 2015/06/24.
//  Copyright (c) 2015年 山口 徹. All rights reserved.
//

#import "PlistLoadSample.h"

@implementation PlistLoadSample

+ (void)loadPlist
{
    // plistをロードする
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDPreloadingAudioFiles" ofType:@"plist"];
    NSArray *plists = [NSArray arrayWithContentsOfFile:path];
    
    // plistの中身を表示
    for (NSDictionary *audioInfo in plists) {
        // 音声ファイル名
        NSString *fileName = audioInfo[@"FileName"];
        // key名
        NSString *key = audioInfo[@"key"];
    
        // TODO: ここでSDAudioPlayerManagerで音声ファイルをロードする
//        [[SDAudioPlayerManager sharedInstance] createPlayerWithFileName:fileName forKey:key];
        NSLog(@"-----------------------------------");
        NSLog(@"fileName : %@",fileName);
        NSLog(@"key : %@",key);
    }
}

@end
