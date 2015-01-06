//
//  TodayViewController.swift
//  Glastometer Widget
//
//  Created by Joe on 11/10/2014.
//  Copyright (c) 2014 Joe. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var mainLabel: UILabel!
    
    let thisCountdown = CountdownCalculator()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        super.preferredContentSize = CGSizeMake(0, 50);
        
        var targetDate = SavedSettings().targetDate
        thisCountdown.Config(targetDate)
        var rt = thisCountdown.RemainingSleeps()
        
        var numbers:String = rt.sleeps.description
        var description:String = " \(rt.sleepsStr) " + SavedSettings().sharingMessage
        
        //Initialize the mutable strings
        var numbersMutableString = NSMutableAttributedString(string: numbers, attributes: [NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 36.0)!])
        numbersMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: NSRange(location: 0, length: countElements(numbers)))
        
        var descriptionMutableString = NSMutableAttributedString(string: description, attributes: [NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 12.0)!])

        numbersMutableString.appendAttributedString(descriptionMutableString)
        mainLabel.attributedText = numbersMutableString
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!)
    {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(0, 48, 0, 0) // Top, Left, Bottom, Right
    }
    
    
}
