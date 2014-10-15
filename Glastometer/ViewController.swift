//
//  ViewController.swift
//  Glastometer
//
//  Created by Joe on 06/10/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var remainingDaysLabel: UILabel!
    @IBOutlet weak var remainingUnitsLabel: UILabel!
    
//Constants ******************************************************************* this is a test
    let thisCountdown = CountdownCalculator()
    let CHANGE_BACKGROUND_TIME:Int = 5 //Seconds - this does not work in the NSTimer.scheduledTimerWithTimeInterval parameters?!?
    
    let numberOfDisplays:Int = 2 //There are currently 2 types of display, Remaining Days OR Remaining Weeks and Days
    
    
//Variables *******************************************************************
    var currentDisplay = 1
    
    //Load the images into an array (could this array be a let?)
    var backgroundImages: [UIImage] = [
        UIImage(named: "Bg1.png"), UIImage(named: "Bg2.png"), UIImage(named: "Bg3.png"), UIImage(named: "Bg4.png"),
        UIImage(named: "Bg5.png"), UIImage(named: "Bg6.png"), UIImage(named: "Bg8.png"), UIImage(named: "Bg9.png"),
        UIImage(named: "Bg11.png")]
    
    var photoCount:Int = 0
    
    var defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.glastometer.com")
    
    
//Code *******************************************************************
    override func viewDidLoad(){
        super.viewDidLoad()
        
        backgroundImageView.image = backgroundImages[0];
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true;
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        //Start Change image timer
        var backgroundTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("changeImage"), userInfo: nil, repeats: true)
        
        // Get the target date from NSUserDefaults
        var targetDateString = defaults.objectForKey("targetDate") as? String!
        
        if (targetDateString == nil) {
            targetDateString = "2014-10-14 12:34"
        }

        thisCountdown.Config(targetDateString!)
        
        //Save the target date in NSUserDefaults
        defaults.setObject(targetDateString, forKey: "targetDate")
        defaults.synchronize()
        
        
        updateDisplay()
        
        //Start the display update timer (1 second)
        var displayTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateDisplay"), userInfo: nil, repeats: true)
    }

    
    override func viewWillAppear(animated: Bool) {
        NSLog("this just happened!")
        
        // Put code here to set the target date... it may have just been changed in the settings TVC.
        
    }

    
    func changeImage() {
        
        if (photoCount < backgroundImages.count - 1)
        {
            photoCount++
        } else {
            photoCount = 0
        }
        
        //let toImage = UIImage(named: "Bg2.png")  
        //let toImage = UIImage(contentsOfFile: "/Users/Joe/Desktop/Projects/Glastometer/Glastometer/Bg2.png")  // This is the one I want to use but need to figure out the path when running on a device
        
        let toImage = backgroundImages[photoCount]
        UIView.transitionWithView(self.backgroundImageView,
            duration:2,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations: { self.backgroundImageView.image = toImage },
            completion: nil)
        //NSLog("Image changed")
    }
    
    @IBAction func ChangeDisplay(sender: AnyObject) {
        //Change the currentDisplay int everytime the button is pressed
        currentDisplay++
        if (currentDisplay > numberOfDisplays)
        {
            currentDisplay = 1
        }
        //NSLog(" \(currentDisplay) ")
        updateDisplay()
    }
    
    func updateDisplay()
    {
        if (currentDisplay == 1)    // Display remaining Days

        {
            remainingDaysLabel.text = String(thisCountdown.RemainingDays())
            remainingUnitsLabel.text = String(thisCountdown.RemainingDaysLabel())
        }
        if (currentDisplay == 2)    // Display weeks and days
        {
            var weeksObj = thisCountdown.RemainingWeeks()
            var labelObj = thisCountdown.RemainingWeeksLabels()
            
            remainingDaysLabel.text = String(weeksObj.weeks)
            remainingUnitsLabel.text = labelObj.weeksLbl + "\r" + String(weeksObj.days) + " " + labelObj.daysLbl
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

