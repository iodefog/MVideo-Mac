//
//  NameCellView.m
//  MVideo
//
//  Created by LiHongli on 2017/4/28.
//  Copyright © 2017年 lihongli. All rights reserved.
//

#import "NameCellView.h"
#import "MMovieModel.h"
#import <AVFoundation/AVFoundation.h>

@implementation NameCellView

- (void)setObject:(MMovieModel *)object{
    self.textField.cell.title = [NSString stringWithFormat:@"%@\n%@",object.title, object.url];
    [self.textField.cell setLineBreakMode:NSLineBreakByCharWrapping];
    
    [self.textField.cell setTruncatesLastVisibleLine:YES];
    
    
}

@end
