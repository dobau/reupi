-- recupera quantida de dias no mês
NSCalendar *cal = [NSCalendar currentCalendar];
NSRange rng = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
NSUInteger numberOfDaysInMonth = rng.length;