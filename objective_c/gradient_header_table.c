- (CAGradientLayer *) darkGradient {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.startPoint = CGPointMake(0.5, 0.0);
    gradient.endPoint = CGPointMake(0.5, 1.0);
    
    UIColor *color1 = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    
    [gradient setColors:[NSArray arrayWithObjects:(id)color1.CGColor, (id)color2.CGColor, nil]];
    return gradient;
}


- (CAGradientLayer *) greyGradient {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.startPoint = CGPointMake(0.5, 0.0);
    gradient.endPoint = CGPointMake(0.5, 1.0);
    
    UIColor *color1 = [UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0];
    
    [gradient setColors:[NSArray arrayWithObjects:(id)color1.CGColor, (id)color2.CGColor, nil]];
    return gradient;
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.bounds.size.width,tableView.sectionHeaderHeight)];
    container.layer.borderColor = [UIColor grayColor].CGColor;
    container.layer.borderWidth = 1.0f;
    CAGradientLayer *gradient = [self darkGradient];
    gradient.frame = container.bounds;
    [container.layer addSublayer:gradient];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,0,tableView.bounds.size.width,tableView.sectionHeaderHeight)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font= [UIFont boldSystemFontOfSize:19.0f];
    headerLabel.shadowOffset = CGSizeMake(1, 1);
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.shadowColor = [UIColor darkGrayColor];
    headerLabel.text = NSLocalizedString(@"Mais exemplos...", "");
    
    [container addSubview:headerLabel];
    
    return container;
}