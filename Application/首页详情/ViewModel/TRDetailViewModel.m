//
//  TRDetailViewModel.m
//  DaDaCook
//
//  Created by tarena on 16/8/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRDetailViewModel.h"

@implementation TRDetailViewModel
- (instancetype)initWithKitchenId:(NSInteger)kitchenId{
    if (self = [super init]) {
        _kitchenId = kitchenId;
    }
    return self;
}

- (void)getDataWithMode:(RequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{
    __block int totoal = 2;
    [TRNetManager getUKitchenDishList:_kitchenId completionHandler:^(TRDishListModel *model, NSError *error) {
        totoal--;
        if (!error) {
            self.dishListModel = model;
        }
        if (totoal == 0) {
            !completionHandler ?: completionHandler(error);
        }
    }];
    
    [TRNetManager getUKitchenDetailTags:_kitchenId completionHandler:^(TRDetailTagsModel *model, NSError *error) {
        totoal--;
        if (!error) {
            _detailTagsModel = model;
        }
        if (totoal == 0) {
            !completionHandler ?: completionHandler(error);
        }
    }];
}
- (NSInteger)dishNumber{
    return self.dishListModel.data.common_dishes.count;
}

- (TRDishListDataRecommendsModel *)dishModelForRow:(NSInteger)row{
    return self.dishListModel.data.common_dishes[row];
}

- (NSURL *)dishIconURLForRow:(NSInteger)row{
    return [self dishModelForRow:row].thumbnail_image_url.yx_URL;
}
- (NSString *)dishTitleForRow:(NSInteger)row{
    return [self dishModelForRow:row].name;
}
- (NSString *)dishDetailForRow:(NSInteger)row{
    return [NSString stringWithFormat:@"还有%ld份, %ld人品尝过", [self dishModelForRow:row].stock, [self dishModelForRow:row].eat_num];
}
- (NSString *)dishPriceForRow:(NSInteger)row{
    return [NSString stringWithFormat:@"¥%ld",[self dishModelForRow:row].price];
}


- (TRDishListDataRecommendsModel *)recommendModelForRow:(NSInteger)row{
    return self.dishListModel.data.recommends[row];
}

- (NSInteger)recommendNumber{
    return self.dishListModel.data.recommends.count;
}
- (NSURL *)recommendIconURLForRow:(NSInteger)row{
    return [self recommendModelForRow:row].thumbnail_image_url.yx_URL;
}
- (NSString *)recommendTitleForRow:(NSInteger)row{
    return [self recommendModelForRow:row].name;
}
- (NSString *)recommendDetailForRow:(NSInteger)row{
    return [NSString stringWithFormat:@"还有%ld份, %ld人品尝过", [self recommendModelForRow:row].stock, [self recommendModelForRow:row].eat_num];
}
- (NSString *)recommendPriceForRow:(NSInteger)row{
    return [NSString stringWithFormat:@"¥%ld",[self recommendModelForRow:row].price];
}
- (NSString *)recommendDescForRow:(NSInteger)row{
    return [self recommendModelForRow:row].desc;
}

- (NSInteger)commentTagNumber{
    return self.detailTagsModel.data.comment_tag.count;
}

- (NSString *)commentTagForRow:(NSInteger)row{
    return self.detailTagsModel.data.comment_tag[row].tag_name;
}

- (NSInteger)totalCommentNumber{
    return self.detailTagsModel.data.comment_num;
}

@end





