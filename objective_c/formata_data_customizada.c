NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
[dateFormatter setDateFormat:@"dd/MM/yyyy"];
data.text = [dateFormatter stringFromDate:datePicker.date];