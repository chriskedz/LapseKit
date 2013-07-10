//
//  EVLTimelineIdentifier.h
//  LapseKit
//
//  Created by Caleb Davenport on 7/10/13.
//  Copyright (c) 2013 Seesaw. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Identifier for the featured clip timeline.
 */
NSString *EVLFeaturedTimelineIdentifier(void);

/**
 Timeline identifier for clips that the given user has liked.
 */
NSString *EVLLikesTimelineIdentifierForUserWithID(NSUInteger userID);

/**
 Timeline identifier for clips that were created by the given user.
 */
NSString *EVLOwnedClipsTimelineIdentifierForUserWithID(NSUInteger userID);

/**
 Timeline identifier for clips that the given user has contributed to.
 */
NSString *EVLContributedClipsTimelineIdentifierForUserWithID(NSUInteger userID);

/**
 Timeline ideitifier for clips that the given user is following.
 */
NSString *EVLFriendsTimelineIdentifierForUserWithID(NSUInteger userID);
