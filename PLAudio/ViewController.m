//
//  ViewController.m
//  AudioDemo
//
//  Created by coderyi on 15/5/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "RecordingHelper.h"

@interface ViewController (){
    
    RecordingHelper* helper;
    UILabel *label;
    
}

@end

@implementation ViewController

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
    endRecordBt.frame=CGRectMake(50, 165, 100, 40);
    [endRecordBt setTitle:@"结束录音" forState:UIControlStateNormal];
    [endRecordBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [endRecordBt addTarget:self action:@selector(endRecordBtAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *startPlayBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:startPlayBt];
    startPlayBt.frame=CGRectMake(50, 210, 100, 40);
    [startPlayBt setTitle:@"播放" forState:UIControlStateNormal];
    [startPlayBt addTarget:self action:@selector(startPlayBtAction) forControlEvents:UIControlEventTouchUpInside];
    startPlayBt.backgroundColor=[UIColor colorWithRed:0.37 green:0.75 blue:0.38 alpha:1];
    [startPlayBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    UIButton *endPlayBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:endPlayBt];
    endPlayBt.frame=CGRectMake(50, 260, 100, 40);
    [endPlayBt setTitle:@"停止播放" forState:UIControlStateNormal];
    [endPlayBt addTarget:self action:@selector(stopPlayBtAction) forControlEvents:UIControlEventTouchUpInside];
    endPlayBt.backgroundColor=[UIColor colorWithRed:0.37 green:0.75 blue:0.38 alpha:1];
    [endPlayBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    UIButton *checkFileBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:checkFileBt];
    checkFileBt.frame=CGRectMake(50, 310, 100, 40);
    [checkFileBt setTitle:@"检查文件" forState:UIControlStateNormal];
    [checkFileBt addTarget:self action:@selector(checkFilesBtAction) forControlEvents:UIControlEventTouchUpInside];
    checkFileBt.backgroundColor=[UIColor colorWithRed:0.37 green:0.75 blue:0.38 alpha:1];
    [checkFileBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    self.input.text =path;
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
