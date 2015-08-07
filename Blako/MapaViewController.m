//
//  ViewController.m
//  Blako
//
//  Copyright (c) 2015 Hugo. All rights reserved.
//

#import "MapaViewController.h"
#import "SearchAddressViewController.h"

@interface MapaViewController () <CLLocationManagerDelegate,GMSMapViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *addressMapText;
@property (weak, nonatomic) IBOutlet UILabel *destinoLabel;

@property BOOL flag;

@property CLLocationManager *locationManager;

@end

@implementation MapaViewController

//GMSMapView *mapView_;

- (void)viewDidLoad {
    
    self.mapView.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    
    UILabel *lupa = [[UILabel alloc] init];
    [lupa setText:[[NSString alloc] initWithUTF8String:"\xF0\x9F\x94\x8D"]];
    [lupa sizeToFit];
    
    [self.addressMapText setLeftView:lupa];
    [self.addressMapText setLeftViewMode:UITextFieldViewModeAlways];

    
}

- (IBAction) menuButtonTapped:(id) sender{

    [self.delegate topRevealButtonTapped];
}


-(void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position{
    [self reverseGeocodeCoordinate: position.target];
}

-(void) reverseGeocodeCoordinate:(CLLocationCoordinate2D )location{
    GMSGeocoder *geocoder = [GMSGeocoder new];
    
    [geocoder reverseGeocodeCoordinate:location completionHandler:^(GMSReverseGeocodeResponse *response, NSError *error) {
        GMSAddress *address = [response firstResult];
        NSString *calle = [address.lines objectAtIndex:0];
        NSString *colonia = [address.lines objectAtIndex:1];
        NSLog(@"%@",colonia);
        NSLog(@"%@",calle);
        
        self.addressMapText.text = [NSString stringWithFormat:@"%@, %@",calle,colonia];
        
//        for (GMSAddress *addressObj in [response results]) {
//            NSLog(@"coordinate.latitude=%f", addressObj.coordinate.latitude);
//            NSLog(@"coordinate.longitude=%f", addressObj.coordinate.longitude);
//            NSLog(@"thoroughfare=%@", addressObj.thoroughfare);
//            NSLog(@"locality=%@", addressObj.locality);
//            NSLog(@"subLocality=%@", addressObj.subLocality);
//            NSLog(@"administrativeArea=%@", addressObj.administrativeArea);
//            NSLog(@"postalCode=%@", addressObj.postalCode);
//            NSLog(@"country=%@", addressObj.country);
//            NSLog(@"lines=%@", addressObj.lines);
//        }
    }];

}



- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if ( status == kCLAuthorizationStatusAuthorizedWhenInUse ) {
        [self.locationManager startUpdatingLocation];
        
        self.mapView.myLocationEnabled = YES;

        self.mapView.settings.myLocationButton = YES;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations objectAtIndex:0];
    if (self.pointGMS) {NSLog(@"Otros C %f, %f",self.pointGMS.position.latitude, self.pointGMS.position.longitude);
        if (self.flag) {
            self.mapView.camera = [GMSCameraPosition cameraWithTarget:self.pointGMS.position zoom:17 bearing:0 viewingAngle:0];
            self.flag = NO;
        }else{
            self.mapView.camera = [GMSCameraPosition cameraWithTarget:self.pointGMS.position zoom:15 bearing:0 viewingAngle:0];
            
        }
        [self.locationManager stopUpdatingLocation];
        
    }else if (location) { NSLog(@"Coords %f, %f",location.coordinate.latitude,location.coordinate.longitude);
        self.mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate zoom:15 bearing:0 viewingAngle:0];
        
        [self.locationManager stopUpdatingLocation];
    }
    
}
- (IBAction)selectAddress:(UITapGestureRecognizer *)sender {
    NSLog(@"start");
    self.flag = YES;
    [self.locationManager startUpdatingLocation];
    CLLocation *loc = [self.locationManager location];
    if (self.pointGMS) {
        self.mapView.camera = [GMSCameraPosition cameraWithTarget:self.pointGMS.position zoom:17 bearing:0 viewingAngle:0];
    }else{
        self.mapView.camera = [GMSCameraPosition cameraWithTarget:loc.coordinate zoom:17 bearing:0 viewingAngle:0];
    }
    
    [self.locationManager stopUpdatingLocation];
    
    self.destinoLabel.text = @"Confirma número interior, piso, etc.";
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
   // [self performSegueWithIdentifier:@"searchAddress" sender:self];
    UIStoryboard *storyBoard = [self storyboard];
    SearchAddressViewController *srchVC = [storyBoard instantiateViewControllerWithIdentifier:@"SearchAddressViewController"];
    
    [self presentViewController:srchVC animated:NO completion:nil];
    
}




@end
