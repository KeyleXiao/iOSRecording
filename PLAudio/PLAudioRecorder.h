//
//  PLAudioRecorder.h
//  AudioDemo
//
//  Created by coderyi on 15/6/5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^RecordFailed)(NSError *error);//录音失败的回调block
typedef void (^RecordSuccess)(NSData *recordData);//录音成功的回调block
typedef void (^RecordWithMeters)(float meters);//实时返回当前录音的平均功率

extern NSString * const RecordErrorStart;//开始录音的时候失败NSError的domain
extern NSString * const RecordErrorPermissionDenied;//用户禁用麦克风的NSError的domain

@interface PLAudioRecorder : NSObject


- (void)startRecordWithFilePath:(NSString *)path success:(RecordSuccess)success failed:(RecordFailed)failed;//开始录音

- (void)stopRecord;//结束录音
@end
