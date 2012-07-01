void (^blockConfirmar) ();

- (void) selecionaData:(UILabel *)data title:(NSString *) t {    
    blockConfirmar = ^ void (){
        data.text = [dateFormatter stringFromDate:datePicker.date];
        [dialog dismissWithClickedButtonIndex:0 animated:YES];
    };

    UIButton *confirmar = [[UIButton alloc] init];
    [confirmar addTarget:blockConfirmar action:@selector(invoke) forControlEvents:UIControlEventTouchDown];
}