//
//  QHCTopicModel.m
//  Baisi
//
//  Created by QHC on 5/4/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCTopicModel.h"
#import "NSDate+QHCExtension.h"

@interface QHCTopicModel()

@property(nonatomic, assign) BOOL isWord;

@end

@implementation QHCTopicModel

-(NSString *)created_at
{
   // 从服务器返回的时间
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    matter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *creatAtData = [matter dateFromString:_created_at];
    
    if (creatAtData.isThisYear) {
        if (creatAtData.isToday) {
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDate *nowDate = [NSDate date];
            
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *comp = [calendar components:unit fromDate:creatAtData toDate:nowDate options:0];
            
            if (comp.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前", comp.hour];
            }else if (comp.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前", comp.minute];
            }else{
                return [NSString stringWithFormat:@"刚刚"];
            }
            
            
        }else if (creatAtData.isYesterday){
            matter.dateFormat = @"昨天 HH:mm:ss";
            return [matter stringFromDate:creatAtData];
        }else{
            matter.dateFormat = @"MM-dd HH:mm:ss";
            return [matter stringFromDate:creatAtData];
        }
        
    }else{
//        return [matter stringFromDate:creatAtData];
        return _created_at;
    }


}

- (CGFloat)cellHeight
{
    self.profileImageViewFrame = CGRectMake(10*QHCScreen_WRtio, 10*QHCScreen_HRtio, 35*QHCScreen_WRtio, 35*QHCScreen_HRtio);
    
    CGSize nameLblSize = [self.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    self.nameLblFrame = CGRectMake(CGRectGetMaxX(self.profileImageViewFrame) + 10.0*QHCScreen_WRtio, CGRectGetMinY(self.profileImageViewFrame), nameLblSize.width, nameLblSize.height);
    
    CGSize createdAtLblSize = [self.created_at sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    self.createdAtLblFrame = CGRectMake(self.nameLblFrame.origin.x, CGRectGetMaxY(self.profileImageViewFrame) - createdAtLblSize.height, createdAtLblSize.width, createdAtLblSize.height);
    
    self.moreBtnFrame = CGRectMake(screenW - 35*QHCScreen_WRtio - 10*QHCScreen_WRtio, 10*QHCScreen_HRtio, 35*QHCScreen_WRtio, 35*QHCScreen_HRtio);
    

    
    
    if (self.type != QHCtopicWord) {
        self.isWord = NO;
        
        CGFloat centerX = MarginX;
        CGFloat centerY = CGRectGetMaxY(self.profileImageViewFrame) + 10.0*QHCScreen_HRtio;
        CGFloat centerW = screenW - 2*MarginX;
        CGFloat centerH = self.height;
        if (self.height >= screenH) {
            centerH = 200*QHCScreen_HRtio;
            self.isBigPicture = YES;
        }
        self.centerFrame = CGRectMake(centerX, centerY, centerW, centerH);
        
        
    }else{
        self.isWord = YES;
        
        CGSize textLblSize = [self.text boundingRectWithSize:CGSizeMake(screenW - 20*QHCScreen_WRtio, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        self.textLblFrame = CGRectMake(10*QHCScreen_WRtio, CGRectGetMaxY(self.profileImageViewFrame) + 10.0*QHCScreen_HRtio, textLblSize.width, textLblSize.height);
    }
    
    
    if (self.top_cmt.count) {
        
        NSDictionary *dict = self.top_cmt.firstObject;
        NSString *comment = dict[@"content"];
        NSString *userName = dict[@"user"][@"username"];
        NSString *cmtText = [NSString stringWithFormat:@"%@:%@", userName, comment];
        
        CGSize topCmtSize = [@"最热评论" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        
        self.topCmtLblFrame = CGRectMake(10*QHCScreen_WRtio, self.isWord ? CGRectGetMaxY(self.textLblFrame) :CGRectGetMaxY(self.centerFrame), topCmtSize.width, topCmtSize.height);
        
        CGSize cmtLblSize = [cmtText boundingRectWithSize:CGSizeMake(screenW - 20*QHCScreen_WRtio, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
        self.cmtLbFrame = CGRectMake(10*QHCScreen_WRtio, CGRectGetMaxY(self.topCmtLblFrame), cmtLblSize.width, cmtLblSize.height);
        
    }
    
    
    CGFloat btnW = screenW/4;
    CGFloat btnH = 35*QHCScreen_HRtio;
//    CGFloat btnY = CGRectGetMaxY(self.textLblFrame) + self.topCmtLblFrame.size.height  + self.cmtLbFrame.size.height + 10*QHCScreen_HRtio;

    CGFloat btnY = (self.isWord ? CGRectGetMaxY(self.textLblFrame) : CGRectGetMaxY(self.centerFrame)) + self.topCmtLblFrame.size.height  + self.cmtLbFrame.size.height + 10*QHCScreen_HRtio;
    
    self.bottomLineFrame = CGRectMake(0, btnY, screenW, 1.0*QHCScreen_HRtio);
    
    self.dingBtnFrame = CGRectMake(0, btnY, btnW, btnH);
    self.caiBtnFrame = CGRectMake(CGRectGetMaxX(self.dingBtnFrame), btnY, btnW, btnH);
    self.repostBtnFrame = CGRectMake(CGRectGetMaxX(self.caiBtnFrame), btnY, btnW, btnH);
    self.commentBtnFrame = CGRectMake(CGRectGetMaxX(self.repostBtnFrame), btnY, btnW, btnH);
    
    
    
    
    
    CGFloat selfHeight = CGRectGetMaxY(self.commentBtnFrame) + 10*QHCScreen_HRtio;
    QHCLog(@"====++++++++%lf", selfHeight);
    return selfHeight;
    

}


@end
