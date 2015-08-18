//
//  VenueDetailsViewController.swift
//  GrandOpens
//
//  Created by Tony Morales on 7/29/15.
//  Copyright (c) 2015 Tony Morales. All rights reserved.
//

import UIKit

class VenueDetailsViewController: UIViewController {

    var venueID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        view.backgroundColor = UIColor.blueColor()
        
        var venueDetailsLabel = UILabel(frame: CGRectMake(0, 0, 200, 21))
        venueDetailsLabel.center = CGPointMake(160, 284)
        venueDetailsLabel.text = venueID
        self.view.addSubview(venueDetailsLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}