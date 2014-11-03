//
//  SettingsViewController.swift
//  Glastometer
//
//  Created by Joe on 14/10/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class SettingsViewController : UITableViewController, UITextFieldDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate
{
    var editTargetDate:Bool = false;
    var showIconBadge: Bool!
    
    //Constants
    let SECTION_FOR_DATE = 1
    let ROW_FOR_DATE = 0
    let ROW_FOR_DATE_PICKER = 1
    let SECTION_FOR_RESET = 3
    let SECTION_FOR_EMAIL = 4
    
    let thisCountdown = CountdownCalculator()
    let iconBadge = IconBadge()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateDetail: UILabel!
    @IBOutlet weak var iconBadgeSwitch: UISwitch!
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var shareMessageTextField: UITextField!
    
    
    override func viewDidLoad() {
        
        eventNameTextField.delegate = self //this is required so the keyboard can be dismissed
        shareMessageTextField.delegate = self
        
        // Get the icon badge switch state from NSUserDefaults
        showIconBadge = SavedSettings().showIconBadge
        iconBadgeSwitch.setOn(showIconBadge!, animated: true)
        
        // Get the target date from NSUserDefaults
        var targetDateString = SavedSettings().targetDate
        var targetDate = thisCountdown.DateFromString(targetDateString)
        
        //Set the target date in the countdown object
        thisCountdown.Config(targetDateString)
        
        //Set the date in the datePicker
        datePicker.setDate(targetDate, animated: true)
        
        //Set the date in the change date cell
        var dateFmt = NSDateFormatter()
        dateFmt.timeZone = NSTimeZone.defaultTimeZone()
        dateFmt.dateFormat = "dd MMM yy HH:mm"
        dateDetail.text = dateFmt.stringFromDate(targetDate)
        
        //Add a target to be called when the date picker changes date.
        datePicker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        //Set the eventName and shareMessage text fields
        eventNameTextField.text = SavedSettings().eventName
        shareMessageTextField.text = SavedSettings().sharingMessage
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.translucent = false;
    }
    
    
    func datePickerChanged(datePicker:UIDatePicker)
    {
        var dateFmt = NSDateFormatter()
        dateFmt.timeZone = NSTimeZone.defaultTimeZone()
        dateFmt.dateFormat = "dd MMM yy HH:mm"
       
        var dateStringDisplay = dateFmt.stringFromDate(datePicker.date)
        NSLog(dateStringDisplay)
        dateDetail.text = dateStringDisplay
        
        dateFmt.dateFormat = "yyyy-MM-dd HH:mm"
        var dateStringToSave = dateFmt.stringFromDate(datePicker.date)
        NSLog(dateStringToSave)
        
        SavedSettings().targetDate = dateStringToSave
        
        //Set the target date in the countdown object
        thisCountdown.Config(dateStringToSave)
        
        showHideIconBadge()
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if (indexPath.section == SECTION_FOR_DATE && indexPath.row == ROW_FOR_DATE_PICKER)
        {
            if (editTargetDate) {
                return self.tableView.rowHeight
            }
            else{
                return 0.0
            }
        }
        return self.tableView.rowHeight
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if (indexPath.section == SECTION_FOR_DATE && indexPath.row == ROW_FOR_DATE)
        {   //The Date row was clicked, toggle the display bit and call reloadData, this then run the above function
            editTargetDate = !editTargetDate
            self.tableView.reloadData()
        }
       
        if (indexPath.section == SECTION_FOR_RESET)
        {
            resetAllSettings()
        }
        
        if (indexPath.section == SECTION_FOR_EMAIL)
        {
            sendEmailButtonTapped()
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    func resetAllSettings()
    {
        let alertController = UIAlertController(title: "Reset Custom Settings?", message: "All settings will revert to Glastonbury Festival 2015", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            NSLog("Cancel Pressed")
            //Nothing to do, cancel pressed.
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            NSLog("Ok Pressed")
           
            SavedSettings().ResetAllSettings()
            self.viewDidLoad()
            
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            // Nothing to do here... maybe deselect this row?
        }
    }
    
    
    @IBAction func iconBadgeSwitchPressed(sender: AnyObject)
    {
        showIconBadge = !showIconBadge
        
        SavedSettings().showIconBadge = showIconBadge
        
        showHideIconBadge()
    }
    
    
    func showHideIconBadge()
    {
        iconBadge.setBadge()
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        NSLog("textFieldDidEndEditing")
        
        textField.resignFirstResponder()
        
        if textField == eventNameTextField
        {
            NSLog("event Name text field")
            SavedSettings().eventName = textField.text
        }
        
        if textField == shareMessageTextField
        {
            NSLog("share message text field")
            SavedSettings().sharingMessage = textField.text
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        NSLog("textFieldShouldReturn")
        textField.resignFirstResponder()

        return true
    }

// Send email - the following function are required as well as 
// import MessageUI &
// MFMailComposeViewControllerDelegate protocol in class decleration.
    func sendEmailButtonTapped()
    {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController
    {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["support@Glastometer.com"])
        mailComposerVC.setSubject("Support")
        //mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert()
    {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email",
                                            message: "Your device could not send e-mail.  Please check e-mail configuration and try again.",
                                            delegate: self,
                                            cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!)
    {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
//End of send email stuff

    
    @IBAction func doneButton(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
