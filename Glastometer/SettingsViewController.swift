//
//  SettingsViewController.swift
//  Glastometer
//
//  Created by Joe on 14/10/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UITableViewController
{
    var editTargetDate:Bool = false;
    var defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.glastometer.com")!
    var showIconBadge: Bool!
    var sharingMessage: String!
    
    
    //Constants
    let SECTION_FOR_DATE = 1
    let ROW_FOR_DATE = 0
    let ROW_FOR_DATE_PICKER = 1
    
    let thisCountdown = CountdownCalculator()
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateDetail: UILabel!
    @IBOutlet weak var iconBadgeSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        
        // Get the icon badge switch state from NSUserDefaults
        showIconBadge = defaults.objectForKey("showIconBadge") as? Bool
        if (showIconBadge == nil) {
            showIconBadge = true
        }
        iconBadgeSwitch.setOn(showIconBadge!, animated: true)
        
        
        // Get the sharing message from NSUserDefaults
        sharingMessage = defaults.objectForKey("sharingMessage") as? String
        if (sharingMessage == nil) {
            sharingMessage = "to Glastonbury Festival 2015"
        }
        
        // Get the target date from NSUserDefaults
        var targetDateString = defaults.objectForKey("targetDate") as? String!
        
        if (targetDateString! == nil) {
            targetDateString = "2014-12-25 12:34"
        }
        
        var targetDate = thisCountdown.DateFromString(targetDateString!)
        
        //Set the target date in the countdown object
        thisCountdown.Config(targetDateString!)
        
        //Set the date in the datePicker
        datePicker.setDate(targetDate, animated: true)
        
        //Set the date in the change date cell
        var dateFmt = NSDateFormatter()
        dateFmt.timeZone = NSTimeZone.defaultTimeZone()
        dateFmt.dateFormat = "dd MMM yy HH:mm"
        dateDetail.text = dateFmt.stringFromDate(targetDate)
        
        //Add a target to be called when the date picker changes date.
        datePicker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
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
        
        defaults.setObject(dateStringToSave, forKey: "targetDate")
        defaults.synchronize()
        
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
    }

    
    @IBAction func iconBadgeSwitchPressed(sender: AnyObject)
    {
        showIconBadge = !showIconBadge
        
        defaults.setObject(showIconBadge, forKey: "showIconBadge")
        defaults.synchronize()
     
        showHideIconBadge()
    }
    
    
    func showHideIconBadge()
    {
        var application = UIApplication.sharedApplication()
        if (showIconBadge!){
            NSLog("Set icon badge to: \(thisCountdown.RemainingDays())")
            application.applicationIconBadgeNumber = thisCountdown.RemainingDays().days
        }
        else {
            NSLog("Hide icon badge")
            application.applicationIconBadgeNumber = 0
        }
    }
    
}
