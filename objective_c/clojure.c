void (^blockConfirmar) ();
blockConfirmar = ^ void (){
    data.text = [dateFormatter stringFromDate:datePicker.date];
    [dialog dismissWithClickedButtonIndex:0 animated:YES];
};