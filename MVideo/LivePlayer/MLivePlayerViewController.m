//
//  MLivePlayerViewController.m
//  MVideo
//
//  Created by LHL on 2017/6/16.
//  Copyright © 2017年 SohuVideo. All rights reserved.
//

#import "MLivePlayerViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MLivePlayerViewController ()

@property (nonatomic, strong) AVPlayerView *playerView;
@property (nonatomic, strong) AVAsset *currentAsset;

@end

@implementation MLivePlayerViewController

- (void)viewWillDisappear{
    [super viewWillDisappear];
    [self back:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.playerView = [[AVPlayerView alloc] initWithFrame:self.view.bounds];
    self.playerView.controlsStyle = AVCaptureViewControlsStyleFloating;
    AVPlayer *player = [[AVPlayer alloc] init];
    self.playerView.player = player;
    [self.view addSubview:self.playerView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(play:) name:@"MLivePlayerViewToPlay" object:nil];
}

- (void)play:(NSNotification *)notification{
    
    self.model = notification.object;
    
    AVPlayer *player =  self.playerView.player;
    [player pause];
    
    [player replaceCurrentItemWithPlayerItem:nil];
    
    [self.currentAsset cancelLoading];
    self.currentAsset = nil;
    
    AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:self.model.url]];
    self.currentAsset = asset;
    
    __weak typeof(self) mySelf = self;
    __weak typeof(AVPlayer *)myPlayer = player;
    __block AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:mySelf.currentAsset automaticallyLoadedAssetKeys:nil];

    [asset loadValuesAsynchronouslyForKeys:@[@"duration"] completionHandler:^{
        dispatch_async( dispatch_get_main_queue(), ^{
            [myPlayer replaceCurrentItemWithPlayerItem:playerItem];
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(play) object:nil];
            [myPlayer performSelector:@selector(play) withObject:nil afterDelay:0.3];
        });
    }];
}


- (void)back:(id)sender {
    [self.playerView.player pause];
    [self.playerView removeFromSuperview];
    self.playerView = nil;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
