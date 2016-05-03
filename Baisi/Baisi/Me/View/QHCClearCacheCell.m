//
//  QHCClearCacheCell.m
//  Baisi
//
//  Created by QHC on 5/3/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCClearCacheCell.h"
#import "NSString+QHCFileSize.h"
@implementation QHCClearCacheCell


+(instancetype)cellWith:(UITableView *)tableView
{
    NSString *ID = @"clearCache";
    QHCClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[QHCClearCacheCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.text = @"清除缓存";
        self.userInteractionEnabled = NO;
        UIActivityIndicatorView  *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.accessoryView = activityView;
        
        [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
            
//            [NSThread sleepForTimeInterval:2.0];
            
            double unit = 1000.0;
            NSString *fileSizeText = nil;
            unsigned long long fileSize = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"default"].fileSize;
            if (fileSize >= pow(unit, 3)) {
                fileSizeText = [NSString stringWithFormat:@"%.2fGB", fileSize / pow(unit, 3)];
            }else if (fileSize >= pow(unit, 2)){
                fileSizeText = [NSString stringWithFormat:@"%.2fMB", fileSize / pow(unit, 2)];
            }else{
                fileSizeText = [NSString stringWithFormat:@"%.2fKB", fileSize / pow(unit, 1)];
            }
            
            NSString *fullText = [NSString stringWithFormat:@"清除缓存(%@)", fileSizeText];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                self.textLabel.text = fullText;
                self.accessoryView = nil;
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                self.userInteractionEnabled = YES;
                
            }];
            
            
        }];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearClick)]];
        
        
        
    }
    return self;
}

- (void)clearClick
{
    [SVProgressHUD showWithStatus:@"正在清除缓存..."];
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        
        [[NSFileManager defaultManager] removeItemAtPath:[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"default"] error:nil];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            self.textLabel.text = @"清除缓存(0B)";
            
            [SVProgressHUD dismiss];

        }];
        
    }];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 当cell显示的时候, 要重新开始chrysant菊花
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)self.accessoryView;
    [activityView startAnimating];
}




@end
