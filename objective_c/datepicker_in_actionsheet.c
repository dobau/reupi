void (^blockConfirmar) ();
void (^blockCancelar) ();

- (void) selecionaData:(UILabel *)data title:(NSString *) t {
    UIActionSheet* dialog = [[UIActionSheet alloc] initWithTitle:t
                                                        delegate:self
                                               cancelButtonTitle:nil
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:nil];

    UIDatePicker* datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 40.0, 320.0, 240.0)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    blockConfirmar = ^ void (){
        data.text = [dateFormatter stringFromDate:datePicker.date];
        [dialog dismissWithClickedButtonIndex:0 animated:YES];
    };

    blockCancelar = ^ void (){
        [dialog dismissWithClickedButtonIndex:0 animated:YES];
    };
    
    UIButton *confirmar = [[UIButton alloc] init];
    [confirmar setFrame:CGRectMake(10, 280.0, 135, 43)];
    [confirmar setTitle:@"Confirmar" forState:UIControlStateNormal];
    UIImage *greenImage = [UIImage imageNamed:@"green.png"];
    [confirmar setBackgroundImage:[greenImage stretchableImageWithLeftCapWidth:greenImage.size.width/2 topCapHeight:greenImage.size.height/2] forState:UIControlStateNormal];
    [confirmar addTarget:blockConfirmar action:@selector(invoke) forControlEvents:UIControlEventTouchDown];
    
    UIButton *cancelar = [[UIButton alloc] init];
    [cancelar setFrame:CGRectMake(175, 280.0, 135, 43)];
    [cancelar setTitle:@"Cancelar" forState:UIControlStateNormal];
    UIImage *redImage = [UIImage imageNamed:@"red.png"];
    [cancelar setBackgroundImage:[redImage stretchableImageWithLeftCapWidth:redImage.size.width/2 topCapHeight:redImage.size.height/2] forState:UIControlStateNormal];
    [cancelar addTarget:blockCancelar action:@selector(invoke) forControlEvents:UIControlEventTouchDown];

    [dialog showInView:self.view];
    
    [dialog addSubview:datePicker];
    [dialog addSubview:cancelar];
    [dialog addSubview:confirmar];

    [dialog setBounds:CGRectMake(0,0,320, 650)];
    
}