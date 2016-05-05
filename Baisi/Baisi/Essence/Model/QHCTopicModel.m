//
//  QHCTopicModel.m
//  Baisi
//
//  Created by QHC on 5/4/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCTopicModel.h"
#import "NSDate+QHCExtension.h"
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

@end
