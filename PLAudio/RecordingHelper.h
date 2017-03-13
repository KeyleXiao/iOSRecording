//
//  NSObject+RecordingHelper.h
//  PLAudio
//
//  Created by keyle on 2/27/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PLAudioPlayer.h"
#import "PLAudioRecorder.h"
@interface RecordingHelper : NSObject

@property PLAudioPlayer* player;
@property PLAudioRecorder* recorder;
@property NSFileManager* fileManager;

+ (RecordingHelper*) ShareInstance;

- (NSString*) GetDeviceAudio:(NSString*) directory;
- (void) DeleteDeviceAudio:(NSString*) audioFullName;
- (void) StopRecording;
- (void) StartRecording:(NSString *) fullPath;
- (void) PlayRecording:(NSString *) fullPath;
- (void) StopPlay;
@end

