# 关于
本来要写一个wav录音功能，在github上找到 PLAudio 这个项目。但是我不需要转码部分，所有修改并精简了 源码。

# 致谢
感谢原作者的付出。
 

#### PLAudioPlayer类的使用

PLAudioPlayer类是音频播放的类，首先需要初始化。

```
	audioRecorder = [[PLAudioRecorder alloc] init];
```

PLAudioPlayer类提供播放音频和停止播放的方法，

```
    // 播放音频
	
    - (void)startPlayAudioFile:(NSString *)fileName
	updateMeters:(AudioPlayerWithMeters)meters
                   success:(AudioPlayerSuccess)success
                    failed:(AudioPlayerFailed)failed ;

	// 停止播放
	- (void)stopPlay;
```


startPlayAudioFile使用如下
```
 
    [audioPlayer startPlayAudioFile:[PLAudioPath recordPathOriginToAMR]
                       updateMeters:^(float meters){
                           //实时返回播放时声音的平均功率
                       }
                                 success:^{
                                     // 播放成功
                                 } failed:^(NSError *error) {
                                     // 播放失败
                                 } ];


```                                     
   
   
   
#### PLAudioPlayer类的使用

```
PLAudioPlayer类是音频录制的类，首先需要初始化，初始化时，默认在录制为WAV格式。

    audioPlayer = [[PLAudioPlayer alloc] init];
 
    
PLAudioPlayer类提供开始录音和结束录音的方法，

    - (void)startRecordWithFilePath:(NSString *)path
                   updateMeters:(RecordWithMeters)meters
                        success:(RecordSuccess)success
                         failed:(RecordFailed)failed;//开始录音

    - (void)stopRecord;//结束录音


```

startRecordWithFilePath使用如下

```
    [audioRecorder startRecordWithFilePath:[PLAudioPath recordPathOrigin]
                                   updateMeters:^(float meters){
                                       //实时返回录制时声音的平均功率
                                   }
                                        success:^(NSData *recordData){
                                            //录音成功
                                        }
                                         failed:^(NSError *error){
                                                  //录音失败
                                         }];
                                        

```
