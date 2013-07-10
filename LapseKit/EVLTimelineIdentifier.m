//
//  EVLTimelineIdentifier.m
//  LapseKit
//
//  Created by Caleb Davenport on 7/10/13.
//  Copyright (c) 2013 Seesaw. All rights reserved.
//

#import "EVLTimelineIdentifier.h"

NSString *EVLFeaturedTimelineIdentifier(void) {
    return @"timelines/featured";
}


NSString *EVLLikesTimelineIdentifierForUserWithID(NSUInteger userID) {
    return [NSString stringWithFormat:@"users/%@/timelines/liked", @(userID)];
}


NSString *EVLOwnedClipsTimelineIdentifierForUserWithID(NSUInteger userID) {
    return [NSString stringWithFormat:@"users/%@/timelines/user", @(userID)];
}


NSString *EVLContributedClipsTimelineIdentifierForUserWithID(NSUInteger userID) {
    return [NSString stringWithFormat:@"users/%@/timelines/contributed", @(userID)];
}


NSString *EVLFriendsTimelineIdentifierForUserWithID(NSUInteger userID) {
    return [NSString stringWithFormat:@"users/%@/timelines/home", @(userID)];
}
