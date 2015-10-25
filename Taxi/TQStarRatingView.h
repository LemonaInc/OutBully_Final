//
//  TQStarRatingView.h
//  Rest
//

//  Copyright (c)Jaxon Stevens All rights reserved.
//

#import <UIKit/UIKit.h>
@class TQStarRatingView;

@protocol StarRatingViewDelegate <NSObject>

@optional
-(void)starRatingView:(TQStarRatingView *)view score:(float)score;

@end

@interface TQStarRatingView : UIView

@property (nonatomic, readonly) int numberOfStar;

@property (nonatomic, weak) id <StarRatingViewDelegate> delegate;

/**
 *  TQStarRatingView
 *
 *  @param frame  Rectangles
 *  @param number
 *
 *  @return TQStarRatingViewObject
 */
- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number;

/**
 *  @param score
 *  @param isAnimate
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate;

/**
 *  @param score
 *  @param isAnimate
 *  @param completion
 */
- (void)setScore:(float)score withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion;

@end

#define kBACKGROUND_STAR @"backgroundStar"
#define kFOREGROUND_STAR @"frontStar"