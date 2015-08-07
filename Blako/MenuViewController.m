//
//  MenuViewController.m
//  Blako
//
//  Copyright (c) 2015 Hugo. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSArray *opcionesMenu;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.opcionesMenu = [[NSArray alloc] initWithObjects:@"Mi Perfil",@"Metodo de Pago",@"Invitar a un Amigo",@"Cupones",@"Historial Envíos",@"Soporte" ,nil];
}



#pragma marc TableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.opcionesMenu objectAtIndex:indexPath.row];

    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate soporteButtonTapped];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.opcionesMenu.count;
}

@end
