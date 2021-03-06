//
//  ProductBase.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-12.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ProductBase.h"
#import "ProductType.h"
#import "DataAdapter.h"


@implementation ProductBase

@dynamic allowCustomizeFlag;
@dynamic createTime;
@dynamic effDate;
@dynamic expDate;
@dynamic orgId;
@dynamic pricingTypeId;
@dynamic priority;
@dynamic productDetail;
@dynamic productId;
@dynamic productName;
@dynamic productState;
@dynamic productType;
@dynamic productPrice;

@synthesize productTypes;
@synthesize productAmount;
@synthesize productAttrs;
@synthesize productPics;
@synthesize productPricings;
@synthesize org, dicImages;

- (void)show
{
    NSLog(@"product id=%@, name=%@, detail=%@, state=%@, type=%@ priority=%@, orgid=%@, flag=%@, effdate=%@, expDate=%@, createdate=%@, pricingId=%@, pric=%@", self.productId, self.productName, self.productDetail, self.productState, self.productType, self.priority, self.orgId, self.allowCustomizeFlag, self.effDate, self.expDate, self.createTime, self.pricingTypeId, self.productPrice);
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.productAttrs = [[NSMutableArray alloc]init];
        self.productPics = [[NSMutableArray alloc]init];
        self.productTypes = [[NSMutableArray alloc]init];
        self.productPricings = [[NSMutableArray alloc]init];
        self.dicImages = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)initExt
{
    self.productAttrs = [[NSMutableArray alloc]init];
    self.productPics = [[NSMutableArray alloc]init];
    self.productTypes = [[NSMutableArray alloc]init];
    self.productPricings = [[NSMutableArray alloc]init];
    self.dicImages = [[NSMutableDictionary alloc]init];

}


- (BOOL)isType:(ProductType *)type
{
    return [self isTypeByTypeId:type.productType];
}

- (BOOL)isTypeByTypeId:(NSString *)typeId
{
    for (ProductType* type in self.productTypes)
    {
        if ([typeId isEqualToString:type.productType])
        {
            return YES;
        }
    }
    return NO;
}

- (void)dropProductTypeById:(NSString *)typeId
{
    NSArray* array = [NSArray arrayWithArray:self.productTypes];
    for (ProductType* type in array)
    {
        if ([typeId isEqualToString:type.productType])
        {
            NSArray* childs = [[DataAdapter shareInstance]productTypeForParent:typeId];
            [self dropProductTypeArray:childs];
            [self.productTypes removeObject:type];
        }
    }
}

- (void)dropProductTypeArray:(NSArray *)types
{
    for (ProductType* type in types)
    {
        [self dropProductType:type];
    }
}

- (void)dropProductType:(ProductType *)type
{
    [self dropProductTypeById:type.productType];
}

- (void)appendProductType:(ProductType *)type
{
    for (ProductType* t in self.productTypes)
    {
        if ([type.productType isEqualToString:t.productType])
        {
            return;
        }
    }
    [self.productTypes addObject:type];
    if (nil != type.parentType)
    {
        [self appendProductType:type.parentType];
    }
}

@end
