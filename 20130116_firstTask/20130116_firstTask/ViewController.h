//
//  ViewController.h
//  20130116_firstTask
//
//  Created by 澁谷 円 on 2013/01/16.
//  Copyright (c) 2013年 澁谷 円. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVAudioRecorderDelegate,AVAudioPlayerDelegate>{
    
    AVAudioRecorder *avRecorder;
    AVAudioPlayer *avPlayer;
    IBOutlet UIButton *recStart;
    IBOutlet UIButton *recStop;
    IBOutlet UIButton *play;
    
}
@property(nonatomic,retain)UIButton *recStart;
@property(nonatomic,retain)UIButton *recStop;
@property(nonatomic,retain)UIButton *play;

- (IBAction)recStart:(id)sender;
- (IBAction)resStop:(id)sender;
- (IBAction)play:(id)sender;

@end
