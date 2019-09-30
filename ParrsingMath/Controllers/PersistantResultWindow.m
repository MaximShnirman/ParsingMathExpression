//
//  PersistantResultWindow.m
//  ParrsingMath
//
//  Created by Maxim Shnirman on 05/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import "PersistantResultWindow.h"

@interface PersistantResultWindow() <NSTableViewDelegate, NSTableViewDataSource>
@property (weak) IBOutlet NSTableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;
@end

@implementation PersistantResultWindow

- (instancetype)initWithDataSource:(NSArray *)dataSource {
    if(!(self = [super initWithWindowNibName:@"PersistantResultWindow" owner:self])) {
        return nil;
    }
    
    self.dataSource = dataSource;
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.dataSource.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTableCellView *cell = [tableView makeViewWithIdentifier:@"cell" owner:self];
    cell.textField.stringValue = self.dataSource[row];
    return cell;
}

@end
