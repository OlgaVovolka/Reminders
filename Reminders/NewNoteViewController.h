#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MyCell.h"

@interface NewNoteViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *textField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel2;
@property (strong, nonatomic) UIDatePicker *datePick;
@property (strong, nonatomic) UIView *datePickerView;
@property (strong) NSManagedObject *note;

- (IBAction)saveBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;


@end
