//
//  AnsprechpartnerCDTVC.m
//  rubi
//
//  Created by Markus Kroisenbrunner on 17.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "AnsprechpartnerTVC.h"
#import "Contact.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface AnsprechpartnerTVC () <ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UILabel *strasse;
@property (nonatomic, strong) IBOutlet UILabel *adresse;

@property (nonatomic, strong) IBOutlet UIButton *search;

// ID der Person im Adressbuch
@property (nonatomic, assign) ABRecordID selPersonID;
@property (assign)  BOOL showAddressPicker;

@end

@implementation AnsprechpartnerTVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

-(void)setupView {
    

    if (!self.contact) {
        
        self.name.text = @"";
        
        self.strasse.text = @"";
        
        self.adresse.text = @"";
        
    }
    else {
        
        self.name.text = [NSString stringWithFormat: @"%@ %@ %@", self.contact.title, self.contact.firstname, self.contact.lastname];
        
        self.strasse.text = [NSString stringWithFormat: @"%@", self.contact.street];
        
        self.adresse.text = [NSString stringWithFormat: @"%@ %@", self.contact.zip, self.contact.place];
    }
}

// Action die vom Button ausgelöst wird....
- (IBAction)openContacts:(id)sender {
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
	picker.peoplePickerDelegate = self;
    picker.modalPresentationStyle = UIModalPresentationFormSheet;
    
    
    [self presentViewController: picker animated: YES completion: nil];
    
}


// Eine Person wurde ausgewählt
- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    
    //  ID der Person wird gespeichert... Wichtig!
    //  Nach [self dismissViewControllerAnimated:YES completion:nil] wird ViewWillAppear aufgerufen...
    //  die ID wird dort weiterverarbeitet
    self.selPersonID = ABRecordGetRecordID( person );
    
    // Alle bisherigen Daten zurücksetzen
    self.name.text = @"";
    self.strasse.text = @"";
    self.adresse.text = @"";
    
    
    // Name der Person wird ausgelesen
    NSString *title = (__bridge NSString *)ABRecordCopyValue(person, kABPersonJobTitleProperty);
    
    if (!title) {
        title = @"";
    }
    else {
        title = [NSString stringWithFormat:@"%@ ", title];
    }
    
    NSString *firstName=(__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    
    if (!firstName) {
        firstName = @"";
    }
    else {
        firstName = [NSString stringWithFormat:@"%@ ", firstName];
    }
    
    NSString *lastName=(__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    if (!lastName) {
        lastName = @"";
    }
    
    if (!self.contact) {
        
        self.contact = [NSEntityDescription insertNewObjectForEntityForName: @"Contact"
                                                     inManagedObjectContext: self.managedObjectContext];

        [self.project addContactsObject: self.contact];
        
    }
    else {
//      Zürucksetzen der bisher gespeicherten Daten
        self.contact.title = @"";
        self.contact.firstname = @"";
        self.contact.lastname = @"";
        self.contact.street = @"";
        self.contact.zip = nil;
        self.contact.place = @"";
        
        NSError *error = nil;
        [self.managedObjectContext save: &error];
    }
    
    self.contact.title = title;
    self.contact.firstname = firstName;
    self.contact.lastname = lastName;
    
    
    NSError *error = nil;
    [self.managedObjectContext save: &error];
    
    self.name.text = [NSString stringWithFormat: @"%@%@%@", title, firstName, lastName];
    ABMutableMultiValueRef multi = ABRecordCopyValue(person, kABPersonEmailProperty);
    
    // Adressdaten werden abgerufen und je nach Anzahl verarbeitet
    ABMutableMultiValueRef addresses = ABRecordCopyValue(person, kABPersonAddressProperty);
    
    if (ABMultiValueGetCount(addresses) > 1) {  // many addresses found, set "" and enable Button, ViewDidAppear handels PickerViewer
        self.showAddressPicker = YES;
        
    }
    else if (ABMultiValueGetCount(addresses) == 1 ){ // only one address, set it up!
        
        ABMutableMultiValueRef addresses = ABRecordCopyValue(person, kABPersonAddressProperty);
        
        NSString * street = [self getAddressProperty: kABPersonAddressStreetKey fromMultiValueRef:addresses atPosition:0];
        NSString * zip = [self getAddressProperty: kABPersonAddressZIPKey fromMultiValueRef:addresses atPosition:0];
        NSString * place = [self getAddressProperty: kABPersonAddressCityKey fromMultiValueRef:addresses atPosition:0];
        
        
        self.strasse.text = [NSString stringWithFormat: @"%@", street];
        self.adresse.text = [NSString stringWithFormat: @"%@ %@", zip, place];
        
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * zipNumber = [f numberFromString: zip];
        
        self.contact.street = street;
        self.contact.zip = zipNumber;
        self.contact.place = place;
        
        self.showAddressPicker = NO;
    }
    
    CFRelease(addresses);
    CFRelease(multi);
    
    
    
    
    error = nil;
    [self.managedObjectContext save: &error];
    
    
    [self dismissViewControllerAnimated:YES completion: ^{
        
        // Aufruf des Adresspickers, wenn gewünscht
        if (self.selPersonID && self.showAddressPicker) {
            [self presentAddresspicker];
        }
        
    }];
    
    return NO;
}

// Ein Picker nur mit den Adressen der Person wird aufgerufen
-(void)presentAddresspicker {
    if( self.selPersonID ) {
        ABPersonViewController * personController = [[ABPersonViewController alloc] init];
        ABRecordRef person = ABAddressBookGetPersonWithRecordID(ABAddressBookCreateWithOptions(NULL, NULL), self.selPersonID);
        
        [personController setDisplayedPerson: person];
        [personController setPersonViewDelegate: self];
        personController.displayedProperties = @[[NSNumber numberWithInt: kABPersonAddressProperty]];
        [personController setAllowsEditing: NO];
        personController.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [self presentViewController: personController animated: YES completion: nil];
    }
}

// Adressdatensatz wurde ausgewählt
- (BOOL) personViewController:(ABPersonViewController*)personView
shouldPerformDefaultActionForPerson: (ABRecordRef)person
                     property: (ABPropertyID)property
                   identifier: (ABMultiValueIdentifier)identifierForValue
{
    
    if(property == kABPersonAddressProperty){
        //        NSString* address = (__bridge NSString *)ABRecordCopyValue(person, property);
        
        ABMutableMultiValueRef addresses = ABRecordCopyValue(person, kABPersonAddressProperty);
        
        NSString * street = [self getAddressProperty: kABPersonAddressStreetKey fromMultiValueRef:addresses atPosition: identifierForValue];
        NSString * zip = [self getAddressProperty: kABPersonAddressZIPKey fromMultiValueRef:addresses atPosition: identifierForValue];
        NSString * place = [self getAddressProperty: kABPersonAddressCityKey fromMultiValueRef:addresses atPosition: identifierForValue];
        
        
        self.strasse.text = [NSString stringWithFormat: @"%@", street];
        self.adresse.text = [NSString stringWithFormat: @"%@ %@", zip, place];
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * zipNumber = [f numberFromString: zip];
        
        self.contact.street = street;
        self.contact.zip = zipNumber;
        self.contact.place = place;
        
        NSError *error = nil;
        [self.managedObjectContext save: &error];
        
        CFRelease(addresses);
        self.showAddressPicker = NO;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

// Nachdem wir nur eine Person haben wollen, keine weitere Action...
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    [self dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

// Cancel, eh klar ;)
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    // assigning control back to the main controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(NSString *) getAddressProperty: (CFStringRef)property fromMultiValueRef: (ABMutableMultiValueRef) multi atPosition: (int) position {
    
    CFDictionaryRef dict = ABMultiValueCopyValueAtIndex(multi, position);
    CFStringRef typeTmp = ABMultiValueCopyLabelAtIndex(multi, position);
    
    NSString * returnString = (NSString *)CFDictionaryGetValue(dict, property);
    
    CFRelease(dict);
    CFRelease(typeTmp);
    
    return returnString;
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
