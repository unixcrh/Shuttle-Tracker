//
//  EtaWrapper.h
//  Shuttle-Tracker
//
//  Created by Brendon Justin on 2/20/11.
//  Copyright 2011 Brendon Justin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EtaWrapper : NSObject {
    NSString *shuttleId;
    NSString *stopId;
    NSDate *eta;
    NSInteger route;
    
    NSString *stopName;
}

@property (nonatomic, retain) NSString *shuttleId;
@property (nonatomic, retain) NSString *stopId;
@property (nonatomic, retain) NSDate *eta;
@property (nonatomic) NSInteger route;
@property (nonatomic, retain) NSString *stopName;

@end