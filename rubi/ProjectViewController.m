//
//  ProjectViewController.m
//  rubi
//
//  Created by David Krachler on 27.03.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Project.h"
#import "Street.h"
#import "ProjectViewController.h"
#import "CollectionView.h"
#import "ProjectStreetsTableTableViewController.h"
#import "NewStreetViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


@interface ProjectViewController ()<ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *projectNotesView;
@property (weak, nonatomic) IBOutlet UITextView *projectNotesTextView;
@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@property (nonatomic, strong) UITableView* tableView;

// ID der Person im Adressbuch
@property (nonatomic, assign) ABRecordID selPersonID;
// einfache Textview um die Daten der ausgewählten Person anzuzeigen
@property (weak, nonatomic) IBOutlet UITextView *textViewPersonendaten;
// YES = zeigt dir nach Auswahl einer Person den Addresspicker an, wird automatisch gemacht, wenn >= 2 Adressen bei der Person hinterlegt ist
@property (assign)  BOOL showAddressPicker;

@end

@implementation ProjectViewController

// Action die vom Button ausgelöst wird....
- (IBAction)openContacts:(id)sender {
 
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
	picker.peoplePickerDelegate = self;
    
    [self presentViewController: picker animated: YES completion: nil];
    
}

// Eine Person wurde ausgewählt
- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
// Name der Person wird ausgelesen
    NSString *firstName=(__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString *lastName=(__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    self.textViewPersonendaten.text = [NSString stringWithFormat: @"%@ %@", firstName, lastName];
    ABMutableMultiValueRef multi = ABRecordCopyValue(person, kABPersonEmailProperty);
    
// Adressdaten werden abgerufen und je nach Anzahl verarbeitet
    ABMutableMultiValueRef addresses = ABRecordCopyValue(person, kABPersonAddressProperty);
    
    if (ABMultiValueGetCount(addresses) > 1) {  // many addresses found, set "" and enable Button, ViewDidAppear handels PickerViewer
        self.showAddressPicker = YES;
    }
    else if (ABMultiValueGetCount(addresses) == 1 ){ // only one address, set it up!
    
        ABMutableMultiValueRef addresses = ABRecordCopyValue(person, kABPersonAddressProperty);
        
        NSString * street = [self getAddressProperty: kABPersonAddressStreetKey fromMultiValueRef:addresses atPosition:0];
        
        self.textViewPersonendaten.text = [NSString stringWithFormat: @"%@ %@", self.textViewPersonendaten.text, street];
        self.showAddressPicker = NO;
    }
    
    CFRelease(addresses);
    CFRelease(multi);
    
    
    
//  ID der Person wird gespeichert... Wichtig!
//  Nach [self dismissViewControllerAnimated:YES completion:nil] wird ViewWillAppear aufgerufen...
//  die ID wird dort weiterverarbeitet
    self.selPersonID = ABRecordGetRecordID( person );
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
        
        [self presentViewController: personController animated: YES completion: nil];
    }
}

// Adressdatensatz wurde ausgewählt
- (BOOL) personViewController:(ABPersonViewController*)personView
     shouldPerformDefaultActionForPerson: (ABRecordRef)person
                                property: (ABPropertyID)property
                              identifier: (ABMultiValueIdentifier)identifierForValue
{

    if(property == kABPersonEmailProperty){
        
        ABMutableMultiValueRef multi = ABRecordCopyValue(person, kABPersonEmailProperty);
        CFStringRef emailRef = ABMultiValueCopyValueAtIndex(multi, identifierForValue);
        NSString* emailAddress = (__bridge NSString *)emailRef;
        
        self.textViewPersonendaten.text = [NSString stringWithFormat: @"%@ /n/r %@", self.textViewPersonendaten.text, emailAddress];
        
        CFRelease(multi);
        
    }
    if(property == kABPersonAddressProperty){
        //        NSString* address = (__bridge NSString *)ABRecordCopyValue(person, property);
        
        ABMutableMultiValueRef addresses = ABRecordCopyValue(person, kABPersonAddressProperty);
        
        NSString * street = [self getAddressProperty: kABPersonAddressStreetKey fromMultiValueRef:addresses atPosition:0];
        
        self.textViewPersonendaten.text = [NSString stringWithFormat: @"%@ /n/r %@", self.textViewPersonendaten.text, street];
        
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
 //   NSLog(@"Title: %@", self.project.projectTitle);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.projectNotesView.layer.borderColor = [UIColor grayColor].CGColor;
    self.projectNotesView.layer.borderWidth = 1.0f;
    self.projectNotesView.layer.cornerRadius = 5.0f;
    
    self.projectNotesTextView.layer.backgroundColor = [UIColor clearColor].CGColor;
    
//    NSLog(@"ProjectStreets: %@", self.project.streets);
    
}

- (void)viewDidAppear:(BOOL)animated{
   
    [super viewDidAppear:animated];
    
// Aufruf des Adresspickers, wenn gewünscht
    if (self.selPersonID && self.showAddressPicker) {
        [self presentAddresspicker];
    }
    
    self.navigationItem.title = [NSString stringWithFormat:@" %@", self.project.projectTitle];
  //  NSLog(@"Title: %@", self.project.projectTitle);
    
    if(!self.project.projectNote){
        self.projectNoteTextField.text = [NSString stringWithFormat:@""];
    }else{
        self.projectNoteTextField.text = [NSString stringWithFormat:@" %@", self.project.projectNote];
    }
    
    [self.tableView reloadData];
    
}

-(void)onKeyboardHide:(NSNotification *)notification
{
    //keyboard will hide
    
    self.project.projectNote = self.projectNoteTextField.text;
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    [delegate saveContext];
    
   // NSLog(@"Save Notes");
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
  
  /*
    NSLog(@"Rows: %i", [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects]);
    
   return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
   */
    return [self.project.streets count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"streetsCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Street *street = [[self.project.streets allObjects] objectAtIndex:indexPath.row];
    
    NSString* streetTitle = [NSString stringWithFormat:@"%@", street.streetname];
    
   // NSArray *names = [self.project.streets valueForKeyPath:@"streetname"];
   // NSLog(@"Streetnames: %@", names);
    
    //cell.textLabel.text = [names objectAtIndex:indexPath.row];
    cell.textLabel.text = streetTitle;
    
    return cell;
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"addStreet"]){
        
        Project *dvcProject = self.project;
        NewStreetViewController *dvc = [segue destinationViewController];
        dvc.project = dvcProject;
        
         NSLog(@"dvc Item: %@", dvcProject);
    }
    //Project *dvcProject = self.project;
    if([segue.identifier isEqualToString:@"Streets"]){
        
        Project *dvcProject = self.project;
        ProjectStreetsTableTableViewController *dvc = [segue destinationViewController];
        dvc.project = dvcProject;
        Street *street = [[self.project.streets allObjects] objectAtIndex: self.tableView.indexPathForSelectedRow.row];
        dvc.street = street;
        
        dvc.managedObjectContext = street.managedObjectContext;
        
        NSLog(@"DVC: %@", dvcProject);
    }
    
   
    
    
}


@end
