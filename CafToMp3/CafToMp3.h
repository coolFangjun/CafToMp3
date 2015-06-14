//
//  CafToMp3.h
//
//  Created by 小宸宸Dad on 15/6/12.
//  Copyright (c) 2015年 fj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "lame.h"

@interface CafToMp3 : NSObject



#pragma mark - caf文件转换成MP3格式
/**
 *
 *  @param cafPath caf文件地址
 *  @param mp3Path mp3文件存放地址
 */
+ (void)cafToMp3:(NSString *)cafPath toMp3Path:(NSString *)mp3Path;



@end
