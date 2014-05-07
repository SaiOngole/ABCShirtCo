//
//  ShopViewController.m
//  ABC Shirt Co
//


#import "ShopViewController.h"

#import "ShopItemCell.h"
#import "DetailViewController.h"
#import "DataManager.h"

@interface ShopViewController ()



@end

@implementation ShopViewController

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // Tell the collection view how many items we have
    return [[DataManager sharedInstance] getNumItems];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Set up cell initialization for display
    ShopItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopItemCell" forIndexPath:indexPath];
    
    NSDictionary *itemDictionary = [[DataManager sharedInstance] getItemAtIndex:(int)indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:[itemDictionary objectForKey:@"imagePath"]];
    cell.titleLabel.text = [itemDictionary objectForKey:@"name"];
    cell.costLabel.text = [itemDictionary objectForKey:@"price"];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Handle tapping a cell to move to product detail page
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.collectionView indexPathsForSelectedItems][0];

        [(DetailViewController*)[segue destinationViewController] initViewWithItem:[[DataManager sharedInstance] getItemAtIndex:(int)indexPath.row] withIndex:(int)indexPath.row];
    }
}

@end