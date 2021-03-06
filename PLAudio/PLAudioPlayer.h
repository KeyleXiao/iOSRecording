//
//  PLAudioPlayer.h
//  AudioDemo
//
//  Created by coderyi on 15/6/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void (^AudioPlayerFailed)(NSError *error);
typedef void (^AudioPlayerSuccess)();
typedef void (^AudioPlayerWithMeters)(float meters);//实时返回当前音频的平均功率

@interface PLAudioPlayer : NSObject<AVAudioPlayerDelegate>


// 播放音频
- (void)startPlayAudioFile:(NSString *)fileName success: (AudioPlayerSuccess)success failed:(AudioPlayerFailed)failed ;

// 停止播放
- (void)stopPlay;

- (void)pausePlay;

- (void)resumePlay;


@end
