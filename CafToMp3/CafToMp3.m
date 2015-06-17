//
//  CafToMp3.m
//
//  Created by 小宸宸Dad on 15/6/12.
//  Copyright (c) 2015年 fj. All rights reserved.
//

#import "CafToMp3.h"

@implementation CafToMp3



#pragma mark - caf文件转换成MP3格式
/**
 *
 *  @param cafPath caf文件地址
 *  @param mp3Path mp3文件存放地址
 */

+ (void)cafToMp3:(NSString *)cafPath toMp3Path:(NSString *)mp3Path{
    
    @try {
        int write,read;
        
        FILE *pcm = fopen([cafPath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);   
        FILE *mp3 = fopen([mp3Path cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        NSLog(@"%@",cafPath);
        NSLog(@"%@",mp3Path);
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 44100);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = (int)fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        
        NSLog(@"MP3生成成功: %@",mp3Path);
        
    }
    
    
}


@end
