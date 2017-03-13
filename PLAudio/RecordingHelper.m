//
//  NSObject+RecordingHelper.m
//  PLAudio
//
//  Created by keyle on 2/27/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import "PLAudioPath.h"
#import "RecordingHelper.h"
#import "PLAudioPlayer.h"
#import "PLAudioRecorder.h"
#import <Foundation/Foundation.h>

@implementation RecordingHelper


static RecordingHelper* instance;

+ (RecordingHelper *)ShareInstance
{
    if (instance == nil) {
        instance = [[RecordingHelper alloc]init];
        
        instance.player = [[PLAudioPlayer alloc] init];
        instance.recorder = [[PLAudioRecorder alloc] init];
        instance.fileManager = [[NSFileManager alloc]init];

    }
    
    return instance;
}

- (void) PlayRecording:(NSString *) fullPath
{
    [self.player startPlayAudioFile:fullPath success:^{
        
    } failed:^(NSError *error) {
        
    }];
}

- (void) PauseRecording
{
    [self.recorder pauseRecord];
}

- (void) ResumeRecording
{
    [self.recorder resumeRecord];
}

- (void) StartRecording:(NSString *) fullPath
{
    [self.recorder
     startRecordWithFilePath:fullPath
     success:^(NSData *recordData){
         NSLog(@"录音成功");
     }
     failed:^(NSError *error){
         NSLog(@"录音失败");
     }];
}


-(void)updateVolumeUI:(float )meters{

}

- (void) StopPlay
{
    [self.player stopPlay];
}

- (void) PausePlay
{
    [self.player pausePlay];
}

- (void) ResumePlay
{
    [self.player resumePlay];
}

- (void) StopRecording
{
    [self.recorder stopRecord];
}

- (void) PlayAudio:(NSString *) path
{
    [self.player
     startPlayAudioFile:[PLAudioPath recordPathOrigin:path]
     success:^
     {
         NSLog(@"播放成功");
     }
     failed:^(NSError *error)
     {
         NSLog(@"播放失败");
     }];
}

- (void) StopAudio
{
    [self.player stopPlay];
}

- (NSString*) GetDeviceAudio:(NSString*) directory
{
    NSArray* files = [self.fileManager contentsOfDirectoryAtPath:directory error:NULL];
    
    NSString* fileInfo = [[NSString alloc]init];
    
    for (int i = 0; i < files.count; i++) {
        
        fileInfo = [fileInfo stringByAppendingString:[files objectAtIndex:i]];
        
        
        if (files.count > 1 && i < files.count-1) {
            fileInfo = [fileInfo stringByAppendingString:@"%"];
        }
    }

    
    return fileInfo;
}

- (void) DeleteDeviceAudio:(NSString*) audioFullName
{
    [self.fileManager removeItemAtPath:audioFullName error:NULL];
}

@end

//因为要在Unity3d中使用 所以增加如下代码
bool isRecording;


void StartRecording(void *p)
{
    if (isRecording){
        return;
    }
    
    NSLog(@"%@", [NSString stringWithUTF8String:p]);
    
    [[RecordingHelper ShareInstance] StartRecording: [NSString stringWithUTF8String:p]];
    isRecording = true;
}

void StopRecording()
{
    if (!isRecording) {
        return;
    }
    [[RecordingHelper ShareInstance] StopRecording];
}

const char* GetDeviceAudio (void*p)
{
    return [[[RecordingHelper ShareInstance] GetDeviceAudio:[NSString stringWithUTF8String:p]] UTF8String];
}

void DeleteDeviceAudio(void*p)
{
    [[RecordingHelper ShareInstance] DeleteDeviceAudio:[NSString stringWithUTF8String:p]];
}





