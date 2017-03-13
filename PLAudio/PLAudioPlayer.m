//
//  PLAudioPlayer.m
//  AudioDemo
//
//  Created by coderyi on 15/6/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PLAudioPlayer.h"
#import <AudioToolbox/AudioToolbox.h>

@interface PLAudioPlayer()

@property (nonatomic, copy) AudioPlayerSuccess playSuccess;
@property (nonatomic, copy) AudioPlayerFailed playFailed;
@property (nonatomic, copy) AudioPlayerWithMeters playMeters;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSDate *startPlayDate;
@property (nonatomic) dispatch_source_t playTimer;

@end

@implementation PLAudioPlayer



- (void)dealloc{
    _player.delegate = nil;
}



- (BOOL)isPlaying {
    return [self.player isPlaying];
}


- (void)startPlayAudioFile:(NSString *)fileName
              updateMeters:(AudioPlayerWithMeters)meters
                   success:(AudioPlayerSuccess)success
                    failed:(AudioPlayerFailed)failed
{
    
    BOOL isSuccess = [self playWithFileName:fileName];
    
    //if (!isSuccess && self.playFailed) {
    if (!isSuccess || self.playFailed) {
        self.playFailed(nil);
    }
}




-(BOOL)playWithFileName:(NSString *)fileName {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:NULL];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    if (!fileName) return NO;
    
    NSData *data;
    NSURL * url = [NSURL fileURLWithPath:fileName];
    data=[NSData dataWithContentsOfURL:url];
    
    [self stopPlay];
    
    NSError *error = nil;
    
    self.player = [[AVAudioPlayer alloc] initWithData:data error:&error];
    
    if (error) {
        
        self.player = nil;
        return NO;
        
    } else {
        self.player.delegate = self;
        self.player.volume = 1.0;
        
        BOOL flag = YES;
        self.player.meteringEnabled = YES;
        [self.player prepareToPlay];
        flag = [self.player play];
        
        if (flag) {
            
            self.startPlayDate = [NSDate date];
            self.playTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
            dispatch_source_set_timer(self.playTimer, DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
            
            dispatch_source_set_event_handler(self.playTimer, ^{
                
                [_player updateMeters];
                self.playMeters([_player averagePowerForChannel:0]);
                
            });
            
            dispatch_resume(self.playTimer);
        }
        
        return flag;
    }
}

- (void)stopTimer
{
    if (self.playTimer) {
        dispatch_source_cancel(self.playTimer);
    }
    self.playTimer = NULL;
}
- (void)stopPlay{
    if (self.player) {
        [self.player stop];
        self.player.delegate = nil;
        self.player = nil;
    }
    
}


#pragma mark AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [[AVAudioSession sharedInstance] setActive:NO error:nil];
    if (self.playSuccess) {
        [self stopTimer];
        self.playSuccess();
    }
}


- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    [[AVAudioSession sharedInstance] setActive:NO error:nil];
    [self stopTimer];
    if (self.playFailed) {
        self.playFailed(error);
    }
}

@end
