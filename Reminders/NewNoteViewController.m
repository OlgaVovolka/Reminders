#import "NewNoteViewController.h"


@implementation NewNoteViewController
@synthesize note;

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    self.dateLabel2.hidden = YES;
    [self changeNotes];
    [self datePickerViewCreate];
}

-(void)changeNotes
{
    if(self.note)
    {
        self.datePick.date = [self.note valueForKey:@"date"];
        NSDateFormatter *dateFormater = [NSDateFormatter new];
        [dateFormater setDateFormat:@"dd MMM yyyy"];
        [self.titleField setText:[self.note valueForKey:@"title"]];
        [self.textField setText:[self.note valueForKey:@"text"]];
        self.dateLabel2.text = [dateFormater stringFromDate:[self.note valueForKey:@"date"]];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Actions
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (IBAction)saveBtn:(id)sender
{
    NSManagedObjectContext *context = [self managedObjectContext];
    if (self.note)
    {
        [self.note setValue:self.titleField.text forKey:@"title"];
        [self.note setValue:self.textField.text forKey:@"text"];
        [self.note setValue:self.datePick.date forKey:@"date"];
    }
    else
    {
        NSManagedObject *newNote = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];
        [newNote setValue:self.titleField.text forKey:@"title"];
        [newNote setValue:self.textField.text forKey:@"text"];
        [newNote setValue:self.datePick.date forKey:@"date"];
    }
    NSError *error = nil;
 
    if (![context save:&error])
    {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Date Picker

- (void)datePickerViewCreate
{
    self.datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0, 550, 320, 274)];
    self.datePickerView.backgroundColor = [UIColor grayColor];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"Done"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(showSelectedDate)];
    self.datePick = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, 320, 200)];
    self.datePick.datePickerMode = UIDatePickerModeDate;
    [toolbar setItems:[NSArray arrayWithObject:doneBtn]];
    [self.datePickerView addSubview:toolbar];
    [self.datePickerView addSubview:self.datePick];
    [self.view addSubview:self.datePickerView];
}

- (void) showWithAnimation
{
    [UIView animateWithDuration:1 animations:^{
        self.datePickerView.frame = CGRectMake(0, 220, 320, 274);
    }];
}

- (void) hideWithAnimation
{
    [UIView animateWithDuration:1 animations:^{
        self.datePickerView.frame = CGRectMake(0, 550, 320, 274);
    }];
}

- (void) showSelectedDate
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd MMM yyyy"];
    self.dateLabel2.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:self.datePick.date]];
    self.dateLabel2.hidden = NO;
    [self hideWithAnimation];
}

- (IBAction)cancelBtn:(id)sender
    {
    [self dismissViewControllerAnimated:YES completion:nil];
    }
    
@end
