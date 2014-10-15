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
    
    let countdownCountdown = CountdownCalculator()
    var defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.glastometer.com")
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateDetail: UILabel!
    
    
    
    override func viewDidLoad() {
        // Get the target date from NSUserDefaults
        var targetDateString = defaults.objectForKey("targetDate") as? String!
        
        if (targetDateString == nil) {
            targetDateString = "2014-10-14 12:34"
        }
        
        var targetDate = countdownCountdown.DateFromString(targetDateString!)
        
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
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        //datePickerCell.clipsToBounds = true
        
        if (indexPath.section == 0 && indexPath.row == 1)
        {
            if (editTargetDate)
            {
                return self.tableView.rowHeight
            } else
            {
                return 0.0
            }
        }
        return self.tableView.rowHeight
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if (indexPath.section == 0 && indexPath.row == 0)
        {
            var datePickerCell = NSIndexPath(forRow: 1, inSection: 0)
            var customCell = self.tableView.cellForRowAtIndexPath(datePickerCell)
            
            if (editTargetDate)
            {
                //customCell? = editTargetDate
                editTargetDate = false
            }
            else
            {
                editTargetDate = true
            }
            self.tableView.reloadData()
        }
    }

    
}
