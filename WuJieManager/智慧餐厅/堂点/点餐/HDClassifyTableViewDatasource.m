//
//  HDClassifyTableViewDatasource.m
//  HDClassifyTable
//
//  Created by Joyinter on 2017/2/10.
//  Copyright © 2017年 Joyinter. All rights reserved.
//

#import "HDClassifyTableViewDatasource.h"
#import "HDClassifyLeftTableViewModel.h"
#import "OrderFoodListModel.h"
@interface HDClassifyTableViewDatasource ()

@end
@implementation HDClassifyTableViewDatasource

#pragma mark - getters and setters


- (NSArray *)dataSource
{

//    if (_dataSource == nil) {
//
//        _dataSource = [NSArray array];
//
//                _dataSource = @[
//                                    @{
//                    kHDClassifyLeftTableViewModelSelected:@NO,
//                    kHDClassifyLeftTableViewModelDataKeyName:@"时尚粤菜",
//                    kHDClassifyLeftTableViewModelDataKeyChildNode:@[
//                                                            @{
//                                                                kHDClassifyLeftTableViewModelDataKeyName:@"• 精品凉菜",
//                                                                kHDClassifyLeftTableViewModelDataKeyChildNode:@[
//                                                                        @"第一组第一元素1",
//                                                                        @"第一组第一元素2",
//                                                                        ]
//                                                                },
//                                                            @{
//                                                                kHDClassifyLeftTableViewModelDataKeyName:@"• 特色海鲜",
//                                                                kHDClassifyLeftTableViewModelDataKeyChildNode:@[
//                                                                        @"第一组第二元素1",
//                                                                        @"第一组第二元素2",
//                                                                        @"第一组第二元素3",
//                                                                        @"第一组第二元素4",]
//                                                                },
//                                                            @{
//                                                                kHDClassifyLeftTableViewModelDataKeyName:@"• 特辣川菜",
//                                                                kHDClassifyLeftTableViewModelDataKeyChildNode:@[
//
//                                                                        ]
//                                                                }
//                                                            ]
//                                                    }.mutableCopy,
//                                                @{kHDClassifyLeftTableViewModelSelected:@NO,
//                                                  kHDClassifyLeftTableViewModelDataKeyName:@"主食面食",
//                                                  kHDClassifyLeftTableViewModelDataKeyChildNode:@[
//                                                          @{
//                                                              kHDClassifyLeftTableViewModelDataKeyName:@"• 兰州拉面",
//                                                              kHDClassifyLeftTableViewModelDataKeyChildNode:@[
//                                                                      @"第二组第一元素1",
//                                                                      @"第二组第一元素2",
//                                                                      @"第二组第一元素3",
//                                                                      @"第二组第一元素4",
//                                                                      @"第二组第一元素5",
//
//
//                                                                      ]
//                                                              },
//                                                          @{
//                                                              kHDClassifyLeftTableViewModelDataKeyName:@"• 美玲拉面",
//                                                              kHDClassifyLeftTableViewModelDataKeyChildNode:@[
//                                                                      @"第二组第二元素1",
//                                                                      @"第二组第二元素2",
//                                                                      @"第二组第二元素3",
//                                                                      @"第二组第二元素4",
//                                                                      @"第二组第二元素5",
//                                                                      @"第二组第二元素6",
//                                                                      @"第二组第二元素7",
//                                                                      @"第二组第二元素8",
//                                                                      @"第二组第二元素9",
//                                                                      @"第二组第二元素10",
//
//                                                                      ]
//                                                              }
//                                                          ]
//                                                  }.mutableCopy,
//
//                                    @{
//                                        kHDClassifyLeftTableViewModelSelected:@NO,
//                                        kHDClassifyLeftTableViewModelDataKeyName:@"劲辣川菜",
//                                        kHDClassifyLeftTableViewModelDataKeyChildNode:@[
//                                                @{
//                                                    kHDClassifyLeftTableViewModelDataKeyName:@"• 精品凉菜",
//                                                    kHDClassifyLeftTableViewModelDataKeyChildNode:@[
//                                                            @"第一组第一元素1",
//                                                            @"第一组第一元素2",
//                                                            @"第一组第一元素3",
//                                                            @"第一组第一元素4",
//                                                            @"第一组第一元素5",
//                                                            @"第一组第一元素6",
//
//                                                            ]
//                                                    },
//                                                @{
//                                                    kHDClassifyLeftTableViewModelDataKeyName:@"• 特色海鲜",
//                                                    kHDClassifyLeftTableViewModelDataKeyChildNode:@[
//                                                            @"第一组第二元素1",
//                                                            @"第一组第二元素2",
//                                                            @"第一组第二元素3",
//                                                            @"第一组第二元素4",
//                                                            @"第一组第二元素5",
//                                                            @"第一组第二元素6",
//                                                            @"第一组第二元素7",
//                                                            ]
//                                                    }
//                                                ]
//                                        }.mutableCopy
//                                    ];
//
//            }
//            return _dataSource;
    
        
       _dataSource = [NSArray array];
    NSMutableArray *arr=[NSMutableArray array];
        OrderFoodListModel *model=[[OrderFoodListModel alloc]init];
        model.channel=@"1";
        [model OrderFoodListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {

            OrderFoodListModel *model= ( OrderFoodListModel *)data;
            if (model.data>0) {
                for (  OrderFoodListModel *submodel in model.data) {
                    NSDictionary *para=@{ kHDClassifyLeftTableViewModelSelected:@NO,  kHDClassifyLeftTableViewModelDataKeyName:submodel.name,
                                          kHDClassifyLeftTableViewModelDataKeyChildNode:@[
                                                  @{
                                                      kHDClassifyLeftTableViewModelDataKeyName:@"• 精品凉菜",
                                                      kHDClassifyLeftTableViewModelDataKeyChildNode:@[
                                                              @"第一组第一元素1",
                                                              @"第一组第一元素2",
                                                              ]
                                                      },
                                                  @{
                                                      kHDClassifyLeftTableViewModelDataKeyName:@"• 特色海鲜",
                                                      kHDClassifyLeftTableViewModelDataKeyChildNode:@[
                                                              @"第一组第二元素1",
                                                              @"第一组第二元素2",
                                                              @"第一组第二元素3",
                                                              @"第一组第二元素4",]
                                                      },
                                                  @{
                                                      kHDClassifyLeftTableViewModelDataKeyName:@"• 特辣川菜",
                                                      kHDClassifyLeftTableViewModelDataKeyChildNode:@[

                                                              ]
                                                      }
                                                  ]
                                          }.mutableCopy;
                    [arr addObject:para];

                }

            }
            NSLog(@"AAAA %@",_dataSource);

        } andFailure:^(NSError * _Nonnull error) {

        }];
    
    return _dataSource=[NSArray arrayWithArray:arr];
    }


//-(NSArray *)getData
//{
//    _dataSource=[NSMutableArray array];
//    OrderFoodListModel *model=[[OrderFoodListModel alloc]init];
//    model.channel=@"1";
//    [model OrderFoodListModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
//        OrderFoodListModel *model= ( OrderFoodListModel *)data;
//        if (model.data>0) {
//            for (  OrderFoodListModel *submodel in model.data) {
//                NSDictionary *para=@{ kHDClassifyLeftTableViewModelSelected:@NO,  kHDClassifyLeftTableViewModelDataKeyName:submodel.name,
//                                      kHDClassifyLeftTableViewModelDataKeyChildNode:@[
//                                              @{
//                                                  kHDClassifyLeftTableViewModelDataKeyName:@"• 精品凉菜",
//                                                  kHDClassifyLeftTableViewModelDataKeyChildNode:@[
//                                                          @"第一组第一元素1",
//                                                          @"第一组第一元素2",
//                                                          ]
//                                                  },
//                                              @{
//                                                  kHDClassifyLeftTableViewModelDataKeyName:@"• 特色海鲜",
//                                                  kHDClassifyLeftTableViewModelDataKeyChildNode:@[
//                                                          @"第一组第二元素1",
//                                                          @"第一组第二元素2",
//                                                          @"第一组第二元素3",
//                                                          @"第一组第二元素4",]
//                                                  },
//                                              @{
//                                                  kHDClassifyLeftTableViewModelDataKeyName:@"• 特辣川菜",
//                                                  kHDClassifyLeftTableViewModelDataKeyChildNode:@[
//
//                                                          ]
//                                                  }
//                                              ]
//                                      }.mutableCopy;
//                [_dataSource addObject:para];
//
//            }
//
//        }
//    } andFailure:^(NSError * _Nonnull error) {
//
//    }];
//    return _dataSource;
//}
@end
