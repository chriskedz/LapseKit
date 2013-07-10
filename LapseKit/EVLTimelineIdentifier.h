//
//  EVLTimelineIdentifier.h
//  LapseKit
//
//  Created by Caleb Davenport on 7/10/13.
//  Copyright (c) 2013 Seesaw. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *EVLFeaturedTimelineIdentifier(void);

NSString *EVLLikesTimelineIdentifierForUserWithID(NSUInteger userID);

NSString *EVLOwnedClipsTimelineIdentifierForUserWithID(NSUInteger userID);

NSString *EVLContributedClipsTimelineIdentifierForUserWithID(NSUInteger userID);

NSString *EVLFriendsTimelineIdentifierForUserWithID(NSUInteger userID);
