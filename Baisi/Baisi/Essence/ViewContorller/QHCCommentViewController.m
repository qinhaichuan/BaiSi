//
//  QHCCommentViewController.m
//  Baisi
//
//  Created by QHC on 5/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCCommentViewController.h"

@interface QHCCommentViewController()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak) UIImageView *bottomView;

@end

@implementation QHCCommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = QHCRandom_Color
    self.navigationItem.title = @"评论";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self setView];
    
}

- (void)setView
{
    UITableView *tableV = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.backgroundColor = QHCRandom_Color
//    [self.view addSubview:tableV];
    
    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, screenH - 44*QHCScreen_HRtio, screenW, 44*QHCScreen_HRtio)];
    self.bottomView = bottomView;
    bottomView.image = [UIImage imageNamed:@"comment-bar-bg"];
    bottomView.userInteractionEnabled = YES;
    [self.view addSubview:bottomView];

    UIImageView *commentVoiceV = [[UIImageView alloc] init];
    commentVoiceV.image = [UIImage imageNamed:@"comment-bar-voice"];
    commentVoiceV.frame = CGRectMake(2*QHCScreen_WRtio, 2*QHCScreen_HRtio, 40 * QHCScreen_HRtio, 40*QHCScreen_WRtio);
    [bottomView addSubview:commentVoiceV];
    
    UIImageView *commentAtV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comment_bar_at_icon"]];
    commentAtV.frame = CGRectMake(bottomView.width - 44*QHCScreen_WRtio, 2, 40*QHCScreen_WRtio, 40*QHCScreen_HRtio);
    [bottomView addSubview:commentAtV];
    
    UITextField *commnetTextF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(commentVoiceV.frame) + 5*QHCScreen_WRtio, 5*QHCScreen_HRtio, bottomView.width - commentVoiceV.width - commentAtV.width - 16*QHCScreen_WRtio, bottomView.height - 10*QHCScreen_HRtio)];
    [commnetTextF setPlaceholder:@"写评论..."];
    commnetTextF.borderStyle = UITextBorderStyleRoundedRect;
    [bottomView addSubview:commnetTextF];
}

- (void)keyboardChangeFrame:(NSNotification *)note
{
    CGRect keyBoardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    QHCLog(@"%f", keyBoardY.origin.y);
    self.bottomView.y = keyBoardY.origin.y - 44*QHCScreen_HRtio;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark ----- UITableViewDateSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
