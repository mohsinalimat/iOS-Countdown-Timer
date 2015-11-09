//
//  ViewController.swift
//  Glastometer
//
//  Created by Joe on 06/10/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var remainingDaysLabel: UILabel!
    @IBOutlet weak var remainingUnitsLabel: UILabel!
    
//Constants *******************************************************************
    let thisCountdown = CountdownCalculator()
    let savedSettings = SavedSettings()
    let distanceCalculator = DistanceCalculator()
    
    let CHANGE_BACKGROUND_TIME:Int = 20  //Seconds - Time between image changes
    let IMAGE_FADE_TIME:Int = 2         //Seconds - Animation time (to change images)
    
    let numberOfDisplays:Int = 4
    
    let METERS_PER_MILE:Double = 1609.344
    
    //Variables *******************************************************************
    var currentDisplay = 1
    var backgroundImageNames: [String] = ["Bg1", "Bg2", "Bg3", "Bg4", "Bg5", "Bg6", "Bg8", "Bg9", "Bg11" ]
    var photoCount:Int = 0
    var sharingText:String = ""
    
//Code *******************************************************************
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //backgroundImageView.image = backgroundImages[0];

        //Start Change image timer
        _ = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(CHANGE_BACKGROUND_TIME), target: self, selector: Selector("changeImage"), userInfo: nil, repeats: true)
        
        setTheTargetDate()
        updateDisplay()
        
        //Start the display update timer (1 second)
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateDisplay"), userInfo: nil, repeats: true)
    }

    
    override func viewWillAppear(animated: Bool) {
        //self.navigationController?.navigationBar.translucent = true;
        
        // Put code here to set the target date... it may have just been changed in the settings TVC.
        setTheTargetDate()
    }

    
    func setTheTargetDate() {
        
        // Get the target date from NSUserDefaults
        thisCountdown.Config(savedSettings.targetDate)
    }
    
    
    func changeImage() {
        
        //This is a dirty fix for the ipad version (the date does not change when exiting the settings popover as ViewDidLoad is not called
        setTheTargetDate()
        
        if (photoCount < backgroundImageNames.count - 1)
        {
            photoCount++
        } else {
            photoCount = 0
        }
        
        //This uses an array of images, all images get loaded into memory and apps foot print increases to ~180MB
        //let toImage = backgroundImages[photoCount]

        //uses UIImage(named: Stirng) function, this has the same effect as using the array of images above.
        //let toImage = UIImage(named: backgroundImageNames[photoCount])
        
        //using UIImage(contentsOfFile: String) function, images are not cached, keeping memory foot print much lower, ~50MB
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource(backgroundImageNames[photoCount], ofType: "png") //backgroundImageNames is an array of String of the images names ie Bg1, Bg2 etc
        let toImage = UIImage(contentsOfFile: String(path!))
        
        UIView.transitionWithView(self.backgroundImageView,
            duration:NSTimeInterval(IMAGE_FADE_TIME),
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations: { self.backgroundImageView.image = toImage },
            completion: nil)
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
    
    
    //Update Display and Sharing message string.
    func updateDisplay(){
        
        if (currentDisplay == 1)    // Display remaining Days
        {
            let rt = thisCountdown.RemainingSleeps()
            
            remainingDaysLabel.text = String(rt.sleeps)
            remainingUnitsLabel.text = rt.sleepsStr
            
            sharingText = "\(rt.sleeps) \(rt.sleepsStr)"
        }
        
        if (currentDisplay == 2)    // Display weeks and days
        {
            let weeksObj = thisCountdown.RemainingWeeks()
            let labelObj = thisCountdown.RemainingWeeksLabels()
            
            remainingDaysLabel.text = String(weeksObj.weeks)
            remainingUnitsLabel.text = labelObj.weeksLbl + "\r" + String(weeksObj.days) + " " + labelObj.daysLbl
            
            //Mess around a bit with this string so it says "3 Weeks to xxx" rather than "3 Weeks, 0 Days to xxx"
            sharingText = "\(weeksObj.weeks) \(labelObj.weeksLbl)"
            if weeksObj.days > 0
            {
                sharingText += ", \(weeksObj.days) \(labelObj.daysLbl)"
            }
        }
        
        if (currentDisplay == 3)    // Display Days, Hours and Minutes
        {
            remainingDaysLabel.text = String(thisCountdown.RemainingDays().days)
            let rt = thisCountdown.RemainingDaysHoursMinutes()
            
            var unitsString: String = rt.daysStr + "\n"
            unitsString += String(rt.hours) + " " + rt.hoursStr + "\n"
            unitsString += String(rt.minutes) + " " + rt.minutesStr
            
            remainingUnitsLabel.text = unitsString
            
            sharingText = "\(rt.days) \(rt.daysStr), \(rt.hours) \(rt.hoursStr), \(rt.minutes) \(rt.minutesStr)"
        }
        
        if (currentDisplay == 4)
        {
            if (distanceCalculator.locationServicesEnabled())
            {
                distanceCalculator.startGettingCurrentLocation()
                let distance:String = NSString(format: "%.1f", (distanceCalculator.getRemainingDistance() / METERS_PER_MILE)) as String
                remainingDaysLabel.text = distance
                remainingUnitsLabel.text = "Miles"
                
                sharingText = "\(distance) Miles"
            }
            else
            {
                currentDisplay = 1
                updateDisplay()
            }
        }
        else //Turn off location services when not in this view
        {
            if distanceCalculator.locationServicesRunning
            {
                distanceCalculator.stopGettingCurrentLocation()
            }
        }
    }
    
    
    @IBAction func ShowActionSheetButton(sender: AnyObject) {
        //var rt = thisCountdown.RemainingDaysHoursMinutes()
        
        let sharingMessageEnd = savedSettings.sharingMessage
        
        //Load sharing view controller with above string
        let activityViewController = UIActivityViewController(activityItems: ["\(sharingText) \(sharingMessageEnd)"], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender as? UIView //required by iPad - so the popover has somewhere to anchor to.
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

