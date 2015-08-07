//
//  RootViewController.m
//  Blako
//
//  Copyright (c) 2015 Hugo. All rights reserved.
//

#import "RootViewController.h"
#import "MapaViewController.h"
#import "MenuViewController.h"

@interface RootViewController () <MapaViewControllerDelegate,MenuViewControllerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rigthContainer;

@property MenuViewController *menuVC;
//@property FotosViewController *fotosVC;
@property MapaViewController *mapaVC;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)drawerIsOpen
{
    if (self.leftContainer.constant == 0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


#pragma mark - TopDelegate

- (void)topRevealButtonTapped
{
    [self.view layoutIfNeeded];
    
    if ([self drawerIsOpen]) // Hide menu
    {
        self.leftContainer.constant = 0;
        self.rigthContainer.constant = 0;
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    else // Show menu
    {
        self.leftContainer.constant = 200;
        self.rigthContainer.constant = -200;
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma mark - Delegates
-(void)soporteButtonTapped{
    [self hideMenu];
}
-(void)invitarButtonTapped{
    [self hideMenu];
}

-(void)cuponesButtonTapped{
    [self hideMenu];
}

-(void)metPagoButtonTapped{
    [self hideMenu];
}

-(void)miPerfilButtonTapped{
    [self hideMenu];
}

-(void)historialButtonTapped{
    [self hideMenu];
}

-(void)Button1Tapped{
    [self hideMenu];
}
-(void)Button2Tapped{
    [self hideMenu];
}



#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"mapSegue"]) {
        UINavigationController *navController = segue.destinationViewController;
        self.mapaVC  = [navController.childViewControllers objectAtIndex:0];
        if (self.pointGMS) {
            self.mapaVC.pointGMS = self.pointGMS;
        }
        self.mapaVC.delegate = self;
    }else if ([segue.identifier isEqualToString:@"menuSegue"]){
        self.menuVC = segue.destinationViewController;
        self.menuVC.delegate = self;
    }
}


-(void) hideMenu{
    self.leftContainer.constant = 0;
    self.rigthContainer.constant = 0;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
