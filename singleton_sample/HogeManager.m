//
//  HogeManager.m
//  singletonTest
//
//  Created by 山口 徹 on 2015/06/18.
//  Copyright (c) 2015年 山口 徹. All rights reserved.
//

#import "HogeManager.h"

@interface HogeManager()

// サウンドオブジェクトのコンテナ
@property (nonatomic, strong)NSMutableDictionary *players;

@end

@implementation HogeManager


#pragma mark - Public Methods

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (AVAudioPlayer *)createPlayerWithURL:(NSURL *)url forKey:(NSString *)key
{
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    // コンテナにセット
    if (key) {
        self.players[key] = player;
    }
    
    return player;
}

- (AVAudioPlayer *)createPlayerWithURLString:(NSString *)urlString forKey:(NSString *)key
{
    NSURL *url = [NSURL fileURLWithPath:urlString];
    return [self createPlayerWithURL:url forKey:key];
}

- (AVAudioPlayer *)playerWithKey:(NSString *)key
{
    if (!key) {
        return nil;
    }
    
    return self.players[key];
}

- (void)deletePlayerWithKey:(NSString *)key
{
    if (!key) {
        return;
    }
    
    // サウンドを停止する
    AVAudioPlayer *player = self.players[key];
    if ([player isPlaying]) {
        [player stop];
    }
    
    [self.players removeObjectForKey:key];
}

- (void)deleteAllPlayer
{
    // すべてのサウンドを停止する
    for (AVAudioPlayer *player in self.players) {
        if ([player isPlaying]) {
            [player stop];
        }
    }
    
    [self.players removeAllObjects];
}

#pragma mark - Private Methods

// playerコンテナの取得
- (NSMutableDictionary *)players
{
    if (!_players) {
        _players = [@{} mutableCopy];
    }
    return _players;
}

@end
