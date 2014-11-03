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
    let CHANGE_BACKGROUND_TIME:Int = 5  //Seconds - Time between image changes
    let IMAGE_FADE_TIME:Int = 2         //Seconds - Animation time (to change images)
    
    let numberOfDisplays:Int = 3
    
    
//Variables *******************************************************************
    var currentDisplay = 1
    
    //Load the images into an array (could this array be a let?)
    //var backgroundImages: [UIImage] = [
    //    UIImage(named: "Bg1.png")!, UIImage(named: "Bg2.png")!, UIImage(named: "Bg3.png")!, UIImage(named: "Bg4.png")!,
    //    UIImage(named: "Bg5.png")!, UIImage(named: "Bg6.png")!, UIImage(named: "Bg8.png")!, UIImage(named: "Bg9.png")!,
    //    UIImage(named: "Bg11.png")!]
    
    var backgroundImageNames: [String] = ["Bg1", "Bg2", "Bg3", "Bg4", "Bg5", "Bg6", "Bg8", "Bg9", "Bg11" ]
    
    var photoCount:Int = 0
    
    //var defaults: NSUserDefaults = NSUserDefaults(suiteName: "group.glastometer.com")!
    
    
//Code *******************************************************************
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //backgroundImageView.image = backgroundImages[0];

        
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        //self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        //Start Change image timer
        var backgroundTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(CHANGE_BACKGROUND_TIME), target: self, selector: Selector("changeImage"), userInfo: nil, repeats: true)
        
        setTheTargetDate()
        updateDisplay()
        
        //Start the display update timer (1 second)
        var displayTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateDisplay"), userInfo: nil, repeats: true)
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
        
        if (photoCount < backgroundImageNames.count - 1)
        {
            photoCount++
        } else {
            photoCount = 0
        }
        
        //This uses an array of images (defined at the top, now commented out)... all images get loaded into memory and apps foot print increases to ~180MB
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
    
    
    func updateDisplay(){
        
        if (currentDisplay == 1)    // Display remaining Days
        {
            remainingDaysLabel.text = String(thisCountdown.RemainingDays().days)
            remainingUnitsLabel.text = String(thisCountdown.RemainingDaysLabel())
        }
        
        if (currentDisplay == 2)    // Display weeks and days
        {
            var weeksObj = thisCountdown.RemainingWeeks()
            var labelObj = thisCountdown.RemainingWeeksLabels()
            
            remainingDaysLabel.text = String(weeksObj.weeks)
            remainingUnitsLabel.text = labelObj.weeksLbl + "\r" + String(weeksObj.days) + " " + labelObj.daysLbl
        }
        
        if (currentDisplay == 3)    // Display Days, Hours and Minutes
        {
            remainingDaysLabel.text = String(thisCountdown.RemainingDays().days)
            var rt = thisCountdown.RemainingDaysHoursMinutes()
            
            var unitsString: String = rt.daysStr + "\n"
            unitsString += String(rt.hours) + " " + rt.hoursStr + "\n"
            unitsString += String(rt.minutes) + " " + rt.minutesStr
            
            remainingUnitsLabel.text = unitsString
        }
    }
    
    
    @IBAction func ShowActionSheetButton(sender: AnyObject) {
        var rt = thisCountdown.RemainingDaysHoursMinutes()
        
        var sharingMessageEnd = savedSettings.sharingMessage
        
        //Construct sharing string
        let sharingText:String = "\(rt.days) \(rt.daysStr), \(rt.hours) \(rt.hoursStr), \(rt.minutes) \(rt.minutesStr) \(sharingMessageEnd)"
        
        //Load sharing view controller with above string
        let activityViewController = UIActivityViewController(activityItems: [sharingText], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender as UIView //required by iPad - so the popover hase somewhere to anchor to.
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

