#import <UIKit/UIKit.h>

extern const NSTimeInterval kGHRevealSidebarDefaultAnimationDuration;
extern const CGFloat kGHRevealSidebarWidth;

@interface GHRevealViewController : UIViewController {
@private
	UIView *_sidebarView;
	UIView *_contentView;
	UITapGestureRecognizer *_tapRecog;
    UIView * _gestureView;
    UIImageView * _icon;
}

@property (nonatomic, readonly, getter = isSidebarShowing) BOOL sidebarShowing;
@property (nonatomic, readonly, getter = isSearching) BOOL searching;
@property (strong, nonatomic) UIViewController *sidebarViewController;
@property (strong, nonatomic) UIViewController *contentViewController;

@property (assign, nonatomic) BOOL isShowIcon;

- (void)dragContentView:(UIPanGestureRecognizer *)panGesture;
- (void)toggleSidebar:(BOOL)show duration:(NSTimeInterval)duration;
- (void)toggleSidebar:(BOOL)show duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;
- (void)toggleSearch:(BOOL)showSearch withSearchView:(UIView *)searchView duration:(NSTimeInterval)duration;
- (void)toggleSearch:(BOOL)showSearch withSearchView:(UIView *)searchView duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

@end
