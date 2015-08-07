//
//  SearchAddressViewController.h
//  Blako
//
//  Copyright (c) 2015 Hugo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPGooglePlacesAutocompleteQuery;

@interface SearchAddressViewController : UIViewController <UISearchBarDelegate,UISearchResultsUpdating>

@property (strong,nonatomic) UISearchController *searchController;

@property (strong,nonatomic) NSArray *searchResults;

@property BOOL shouldBeginEditing;

@property SPGooglePlacesAutocompleteQuery *searchQuery;

@end
