//
//  MenuViewController.h
//  Blako
//
//  Copyright (c) 2015 Hugo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewControllerDelegate <NSObject>

-(void) miPerfilButtonTapped;
-(void) metPagoButtonTapped;
-(void) invitarButtonTapped;
-(void) cuponesButtonTapped;
-(void) historialButtonTapped;
-(void) soporteButtonTapped;

@end

@interface MenuViewController : UIViewController

@property id<MenuViewControllerDelegate> delegate;

@end


/*

 
 @"Mi Perfil",@"Metodo de Pago",@"Invitar a un Amigo",@"Cupones",@"Historial Envíos",@"Soporte" ,nil];

 
 
 @protocol BMenuViewControllerDelegate <NSObject>
 
 - (void)Button1Tapped;
 - (void)Button2Tapped;
 
 @end
 
 @interface BMenuViewController : UIViewController
 
 @property id<BMenuViewControllerDelegate> delegate;
 
 @end
*/