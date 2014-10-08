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
    
    let thisCountdown = CountdownCalculator()
    let CHANGE_BACKGROUND_TIME:Int = 5 //Seconds - this does not work in the NSTimer.scheduledTimerWithTimeInterval parameters?!?
    
    
    //Load the images into an array
    var backgroundImages: [UIImage] = [
        UIImage(named: "Bg1.png"), UIImage(named: "Bg2.png"), UIImage(named: "Bg3.png"), UIImage(named: "Bg4.png"),
        UIImage(named: "Bg5.png"), UIImage(named: "Bg6.png"), UIImage(named: "Bg8.png"), UIImage(named: "Bg9.png"),
        UIImage(named: "Bg11.png")]
    
    var photoCount:Int = 0
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        backgroundImageView.image = backgroundImages[0];
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true;
        
        //Start Change image timer
        var timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("changeImage"), userInfo: nil, repeats: true)
        thisCountdown.Config("2014-12-25 08:00")
        
        remainingDaysLabel.text = String(thisCountdown.RemainingDays())
        remainingUnitsLabel.text = String(thisCountdown.RemainingDaysLabel())
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

