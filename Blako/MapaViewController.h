//
//  ViewController.h
//  Blako
//
//  Copyright (c) 2015 Hugo. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMaps;

//
//@protocol ViewControllerDelegate <NSObject>
//
//- (void)topRevealButtonTapped;
////- (void)screenEdgePanDetected:(UIGestureRecognizer *)sender;
//
//@end
//
//
//@interface FotosViewController : UIViewController
//
//@property id<FotosViewControllerDelegate> delete;
//
//@end

@protocol MapaViewControllerDelegate <NSObject>

- (void) topRevealButtonTapped;
////- (void)screenEdgePanDetected:(UIGestureRecognizer *)sender;
@end


@interface MapaViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *mapPinCenter;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) GMSMarker *pointGMS;

@property id<MapaViewControllerDelegate> delegate;

@end

