//
//  SearchAddressViewController.m
//  Blako
//
//  Copyright (c) 2015 Hugo. All rights reserved.
//

#import "SearchAddressViewController.h"
#import "SPGooglePlacesAutocompletePlace.h"
#import "SPGooglePlacesAutocompleteQuery.h"
#import "MapaViewController.h"
#import "RootViewController.h"

@interface SearchAddressViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) NSArray *array;
@property (weak, nonatomic) IBOutlet UIButton *confirmarButton;

@end

@implementation SearchAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchQuery = [[SPGooglePlacesAutocompleteQuery alloc] initWithApiKey:@"AIzaSyAhzlT1llzPWVM-Er-7ElXUuQVOhW_eWac"];
    
    self.searchQuery.radius = 100.0;
    self.shouldBeginEditing = YES;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    
    self.searchController.searchBar.placeholder = @"Holaaaa";
    
    self.definesPresentationContext = YES;
    
    self.searchResults = [[NSArray alloc] init];
    
    [self.confirmarButton setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
    
    self.confirmarButton.layer.borderColor = [UIColor greenColor].CGColor;
//    self.confirmarButton.backgroundColor = [UIColor lightGrayColor];
    self.confirmarButton.layer.cornerRadius = 5.0;
    
    
    [self.searchController.searchBar becomeFirstResponder];
}

#pragma mark UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.searchResults count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SPGooglePlacesAutocompleteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.font = [UIFont fontWithName:@"GillSans" size:16.0];
    cell.textLabel.text = [self placeAtIndexPath:indexPath].name;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SPGooglePlacesAutocompletePlace *place = [self placeAtIndexPath:indexPath];
    [place resolveToPlacemark:^(CLPlacemark *placemark, NSString *addressString, NSError *error) {
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No se pudo ubicar el lugar" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        } else if(placemark) {
            
              //ViewController *vc = [[ViewController alloc] init];
                UIStoryboard *storyBoard = [self storyboard];
                RootViewController *rootVC = [storyBoard instantiateViewControllerWithIdentifier:@"RootViewController"];
            //UINavigationController *navC = [rootVC.childViewControllers objectAtIndex:0];
               // MapaViewController *mainVC

//                UINavigationController *navC = [storyBoard instantiateViewControllerWithIdentifier:@"UINavigationMapaController"];
//
//                MapaViewController *mainVC = [navC.childViewControllers objectAtIndex:0];
                GMSMarker *point = [[GMSMarker alloc] init];
                point.position = placemark.location.coordinate;
                rootVC.pointGMS = point;

            
                [self presentViewController:rootVC animated:NO completion:nil];
            
                //[self]
                //[self dismissViewControllerAnimated:NO completion:nil];
        }
    }];
}


- (SPGooglePlacesAutocompletePlace *)placeAtIndexPath:(NSIndexPath *)indexPath {
    return [self.searchResults objectAtIndex:indexPath.row];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}

#pragma mark -
#pragma mark UISearchDisplayDelegate

- (void)handleSearchForSearchString:(NSString *)searchString {
    CLLocationCoordinate2D coord;
    
    coord.latitude = 19.351651;//
    
    coord.longitude = -99.079643;//

    
    self.searchQuery.location = coord;//   self.mapView.userLocation.coordinate;
    self.searchQuery.input = searchString;
    [self.searchQuery fetchPlaces:^(NSArray *places, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            //SPPresentAlertViewWithErrorAndTitle(error, @"Could not fetch Places");
        } else {
            NSLog(@"hay datos");
            
           self.searchResults = places;
          [self.searchDisplayController.searchResultsTableView reloadData];
        }
    }];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self handleSearchForSearchString:searchString];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark -
#pragma mark UISearchBar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    if (![searchBar isFirstResponder]) {
        self.shouldBeginEditing = NO;
        [self.searchController setActive:NO];
        //mover punto del mapa
        //[self.mapView removeAnnotation:selectedPlaceAnnotation];
    }
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{

    
    if (self.shouldBeginEditing) {
        //Animar la tabla
     //   NSTimeInterval animationDuration = 0.3;
     //   [UIView beginAnimations:nil context:NULL];
      //  [UIView setAnimationDuration:animationDuration];
        
      //  [UIView commitAnimations];
        
        //[self.searchController.searchBar setShowsCancelButton:YES animated:YES];
//        if (self.searchController.searchResultsController) {
//            UINavigationController *navController = (UINavigationController *)self.searchController.searchResultsController;
//            
//            SearchResultsTableViewController *vc = (SearchResultsTableViewController *)navController.topViewController;
//            vc.searchResults = self.searchResults;
//            [vc.tableView reloadData];
//        }
        
    }
    
    BOOL boolToReturn = self.shouldBeginEditing;
    self.shouldBeginEditing = YES;
    return boolToReturn;
}

@end
