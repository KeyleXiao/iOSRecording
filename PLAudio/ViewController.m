//
//  ViewController.m
//  AudioDemo
//
//  Created by coderyi on 15/5/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "RecordingHelper.h"
#import "PLAudioPath.h"

@interface ViewController (){
    
    RecordingHelper* helper;
    UILabel *label;
    
}

@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    helper = [RecordingHelper ShareInstance];
    
    UIButton *startRecordBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:startRecordBt];
    startRecordBt.backgroundColor=[UIColor redColor];
    startRecordBt.frame=CGRectMake(50, 120, 100, 40);
    [startRecordBt setTitle:@"录音" forState:UIControlStateNormal];
    [startRecordBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startRecordBt addTarget:self action:@selector(startRecordBtAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *endRecordBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:endRecordBt];
    endRecordBt.backgroundColor=[UIColor redColor];
    endRecordBt.frame=CGRectMake(160, 120, 100, 40);
    [endRecordBt setTitle:@"结束录音" forState:UIControlStateNormal];
    [endRecordBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [endRecordBt addTarget:self action:@selector(endRecordBtAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *startPlayBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:startPlayBt];
    startPlayBt.frame=CGRectMake(50, 180, 100, 40);
    [startPlayBt setTitle:@"播放" forState:UIControlStateNormal];
    [startPlayBt addTarget:self action:@selector(startPlayBtAction) forControlEvents:UIControlEventTouchUpInside];
    startPlayBt.backgroundColor=[UIColor colorWithRed:0.37 green:0.75 blue:0.38 alpha:1];
    [startPlayBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    UIButton *endPlayBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:endPlayBt];
    endPlayBt.frame=CGRectMake(160, 180, 100, 40);
    [endPlayBt setTitle:@"停止播放" forState:UIControlStateNormal];
    [endPlayBt addTarget:self action:@selector(stopPlayBtAction) forControlEvents:UIControlEventTouchUpInside];
    endPlayBt.backgroundColor=[UIColor colorWithRed:0.37 green:0.75 blue:0.38 alpha:1];
    [endPlayBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    
    UIButton *checkFileBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:checkFileBt];
    checkFileBt.frame=CGRectMake(50, 240, 100, 40);
    [checkFileBt setTitle:@"检查文件" forState:UIControlStateNormal];
    [checkFileBt addTarget:self action:@selector(checkFilesBtAction) forControlEvents:UIControlEventTouchUpInside];
    checkFileBt.backgroundColor=[UIColor colorWithRed:0.37 green:0.75 blue:0.38 alpha:1];
    [checkFileBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    self.input.text =path;
    
    UIButton *pauseBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:pauseBt];
    pauseBt.frame=CGRectMake(160, 240, 100, 40);
    [pauseBt setTitle:@"暂停播放" forState:UIControlStateNormal];
    [pauseBt addTarget:self action:@selector(PauseBtAction) forControlEvents:UIControlEventTouchUpInside];
    pauseBt.backgroundColor=[UIColor colorWithRed:0.37 green:0.75 blue:0.38 alpha:1];
    [pauseBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    UIButton *resume=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:resume];
    resume.frame=CGRectMake(50, 300, 100, 40);
    [resume setTitle:@"恢复播放" forState:UIControlStateNormal];
    [resume addTarget:self action:@selector(ResumeBtAction) forControlEvents:UIControlEventTouchUpInside];
    resume.backgroundColor=[UIColor colorWithRed:0.37 green:0.75 blue:0.38 alpha:1];
    [resume setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *pauseRecord=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:pauseRecord];
    pauseRecord.frame=CGRectMake(160, 300, 100, 40);
    [pauseRecord setTitle:@"暂停录制" forState:UIControlStateNormal];
    [pauseRecord addTarget:self action:@selector(PauseRecording) forControlEvents:UIControlEventTouchUpInside];
    pauseRecord.backgroundColor=[UIColor colorWithRed:0.37 green:0.75 blue:0.38 alpha:1];
    [pauseRecord setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton* resumeRecord=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:resumeRecord];
    resumeRecord.frame=CGRectMake(50, 360, 100, 40);
    [resumeRecord setTitle:@"恢复录制" forState:UIControlStateNormal];
    [resumeRecord addTarget:self action:@selector(ResumeRecording) forControlEvents:UIControlEventTouchUpInside];
    resumeRecord.backgroundColor=[UIColor colorWithRed:0.37 green:0.75 blue:0.38 alpha:1];
    [resumeRecord setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)PauseRecording
{
    self.display.text = @"暂停录音。。。。";
    [helper PauseRecording];
}
-(void)ResumeRecording
{
    self.display.text = @"恢复录音。。。。";
    [helper ResumeRecording];
}

-(void)PauseBtAction
{
    self.display.text = @"暂停播放。。。。";
    [helper PausePlay];
}
-(void)ResumeBtAction
{
    self.display.text = @"恢复播放。。。。";
    [helper ResumePlay];
}


-(void)checkFilesBtAction
{
    self.display.text = [helper GetDeviceAudio:self.input.text];
}

-(void)startRecordBtAction{
    
    self.display.text = @"开始录音。。。。";
    [helper StartRecording:[PLAudioPath recordPathOrigin:self.input.text]];
}


-(void)endRecordBtAction{
    self.display.text = @"结束录音。。。。";
    [helper StopRecording];
}

-(void)startPlayBtAction{
    self.display.text = @"开始播放。。。。";
    [helper PlayRecording:[PLAudioPath recordPathOrigin:self.input.text]];
}

-(void)stopPlayBtAction{
    self.display.text = @"停止播放。。。。";
    [helper StopPlay];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
