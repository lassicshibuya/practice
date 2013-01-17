//
//  ViewController.m
//  RecordTest
//
//  Created by Matsuzaki on 12/06/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize recStart, recStop, play;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.recStart.hidden = NO;
    self.recStop.hidden = YES;
    self.play.hidden = NO;
    
}



- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    //    [player release];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (IBAction)recStart:(id)sender {
    self.recStart.hidden = YES;
    self.recStop.hidden = NO;
    self.play.hidden = YES;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    // 使用している機種が録音に対応しているか
    if ([audioSession inputIsAvailable]) {
        [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    }
    if(error){
        NSLog(@"audioSession: %@ %d %@", [error domain], [error code], [[error userInfo] description]);
    }
    // 録音機能をアクティブにする
    [audioSession setActive:YES error:&error];
    if(error){
        NSLog(@"audioSession: %@ %d %@", [error domain], [error code], [[error userInfo] description]);
    }
    
    // 録音ファイルパス
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask,YES);
    NSString *documentDir = [filePaths objectAtIndex:0];
    NSString *path = [documentDir stringByAppendingPathComponent:@"rec.caf"];
    NSURL *recordingURL = [NSURL fileURLWithPath:path];
    
    /*
     
     NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
     [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
     [NSNumber numberWithInt: kAudioFormatLinearPCM], AVFormatIDKey,
     [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
     [NSNumber numberWithInt:16], AVLinearPCMBitDepthKey,
     [NSNumber numberWithBool:NO], AVLinearPCMIsBigEndianKey,
     [NSNumber numberWithBool:NO], AVLinearPCMIsFloatKey,
     nil];
     
     AvRecorder = [[AVAudioRecorder alloc] initWithURL:recordingURL settings:settings error:&error];
     */
    
    // 録音中に音量をとる場合はYES
    avRecorder.meteringEnabled = YES;
    
    avRecorder = [[AVAudioRecorder alloc] initWithURL:recordingURL settings:nil error:&error];
    
    if(error){
        NSLog(@"error = %@",error);
        return;
    }
    avRecorder.delegate=self;
    //    ５秒録音して終了
    //    [avRecorder recordForDuration: 5.0];
    
    [avRecorder record];
    
    
    
}

// 録音が終わったら呼ばれるメソッド

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    /*
     NSURL *recordingURL = recorder.url;
     player = [[AVAudioPlayer alloc]initWithContentsOfURL:recordingURL error:nil];
     player.delegate = self;
     //    player.volume=1.0;
     [player play];
     */
}

- (IBAction)resStop:(id)sender {
    self.recStart.hidden = NO;
    self.recStop.hidden = YES;
    self.play.hidden = NO;
    
    [avRecorder stop];
    [avPlayer stop];
    
}

- (IBAction)play:(id)sender {
    self.recStart.hidden = YES;
    self.recStop.hidden = NO;
    self.play.hidden = NO;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    
    // 録音ファイルパス
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask,YES);
    NSString *documentDir = [filePaths objectAtIndex:0];
    NSString *path = [documentDir stringByAppendingPathComponent:@"rec.caf"];
    NSURL *recordingURL = [NSURL fileURLWithPath:path];
    
    avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:recordingURL error:nil];
    avPlayer.delegate = self;
    avPlayer.volume=1.0;
    [avPlayer play];
    
}




@end
