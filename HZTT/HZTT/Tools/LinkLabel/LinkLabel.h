//
//  LinkLabel.h
//  LinkLabel
//
//  Created by 王旭 on 2017/1/5.
//  Copyright © 2017年 PittWong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, LinkLabelRegularType) {
    LinkLabelRegularTypeNone      = 0,
    LinkLabelRegularTypeAboat     = 1 << 0,//@类型
    LinkLabelRegularTypeTopic     = 1 << 1,//##类型  话题
    LinkLabelRegularTypeUrl       = 1 << 2,//url类型
};

@class LinkLabel;
@class LinkLabelModel;
@protocol LinkLabelDelegate <NSObject>

//model图片被点击
- (void)labelImageClickLinkInfo:(LinkLabelModel *)linkInfo;

//http链接点击   model内设置链接的对应点击
- (void)labelLinkClickLinkInfo:(LinkLabelModel *)linkInfo linkUrl:(NSString *)linkUrl;

//http链接点击   model内设置链接的对应长按
- (void)labelLinkLongPressLinkInfo:(LinkLabelModel *)linkInfo linkUrl:(NSString *)linkUrl;

//正则文字点击
- (void)labelRegularLinkClickWithclickedString:(NSString *)clickedString;

//label自身被点击
- (void)labelClickedWithExtend:(id)extend;
@end




@interface LinkLabel : UILabel

@property (nonatomic ,strong) NSArray<LinkLabelModel *> *messageModels;
@property (nonatomic ,assign) LinkLabelRegularType regularType;

@property (nonatomic ,strong) UIColor *linkTextColor;
@property (nonatomic ,strong) UIColor *selectedBackgroudColor;
@property (nonatomic , weak ) id delegate;
@property (nonatomic ,strong) id extend;                //扩展参数提供传递任意类型属性

//model图片被点击
@property (nonatomic, copy) void (^imageClickBlock)(LinkLabelModel *linkInfo);
//http链接点击   model内设置链接的对应点击
@property (nonatomic, copy) void (^linkClickBlock)(LinkLabelModel *linkInfo, NSString *linkUrl);
//http链接长按   model内设置链接的对应长按
@property (nonatomic, copy) void (^linkLongPressBlock)(LinkLabelModel *linkInfo, NSString *linkUrl);
//正则文字点击
@property (nonatomic, copy) void (^regularLinkClickBlock)(NSString *clickedString);

@property (nonatomic, copy) void (^labelClickedBlock)(id extend);


//添加正则表达式规则
- (void)addRegularString:(NSString *)regularString;

@end



@interface LinkLabelModel : NSObject

@property (nonatomic , copy ) NSString *message;        //显示的文字

//用于添加图片
@property (nonatomic ,strong) UIImage *image;           //富文本图片
@property (nonatomic , copy ) NSString *imageName;      //富文本图片名称
@property (nonatomic ,assign) CGSize imageShowSize;    //富文本图片要显示的大小  默认17*17
@property (nonatomic , copy ) NSString *imageClickBackStr;           //图片点击反馈字符串


@property (nonatomic ,strong) id extend;                //扩展参数提供传递任意类型属性
- (void)replaceUrlWithString:(NSString *)string;        //替换网络链接为指定文案

@end

