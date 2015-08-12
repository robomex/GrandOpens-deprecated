//
//  VenueDetailsViewController.swift
//  GrandOpens
//
//  Created by Tony Morales on 7/29/15.
//  Copyright (c) 2015 Tony Morales. All rights reserved.
//

import UIKit

class VenueDetailsViewController: UIViewController {

    @IBOutlet weak var venueDetailsLabel: UILabel!
    
    var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let frame = UIScreen.mainScreen().bounds
        segmentedControl = UISegmentedControl(items: ["Chat", "Details"])
        segmentedControl.frame = CGRectMake(frame.minX + 100, frame.minY + 70, frame.width - 200, frame.height * 0.04)
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.addTarget(self, action: "venueSegmentedControlAction:", forControlEvents: .ValueChanged)
        segmentedControl.backgroundColor = UIColor.whiteColor()
        segmentedControl.tintColor = UIColor(red: 0x9b/255, green: 0x59/255, blue: 0xb6/255, alpha: 1.0)
        self.view.addSubview(segmentedControl)
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

    func venueSegmentedControlAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            let vc = VenueDetailsViewController()
            vc.title = "test"
            navigationController?.pushViewController(vc, animated: false)
        default:
            return
        }
    }
}
