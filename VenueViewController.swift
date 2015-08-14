//
//  VenueViewController.swift
//  GrandOpens
//
//  Created by Tony Morales on 8/11/15.
//  Copyright (c) 2015 Tony Morales. All rights reserved.
//

import UIKit
import JSQMessagesViewController

//let pageController = ViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)

class VenueViewController: UIPageViewController, UIPageViewControllerDataSource {

    var venueID: String?
    
    let chatVC = VenueChatViewController()
    
    let detailsVC = VenueDetailsViewController()
    
    var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.whiteColor()
        dataSource = self
        setViewControllers([chatVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        
        let frame = UIScreen.mainScreen().bounds
        segmentedControl = UISegmentedControl(items: ["Chat", "Details"])
        segmentedControl.frame = CGRectMake(frame.minX + 100, frame.minY + 70, frame.width - 200, frame.height * 0.04)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "venueSegmentedControlAction:", forControlEvents: .ValueChanged)
        segmentedControl.backgroundColor = UIColor.whiteColor()
        segmentedControl.tintColor = UIColor(red: 0x9b/255, green: 0x59/255, blue: 0xb6/255, alpha: 1.0)
        self.view.addSubview(segmentedControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToNextVC() {
        let nextVC = pageViewController(self, viewControllerAfterViewController: viewControllers[0] as! UIViewController)!
        setViewControllers([nextVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }
    
    func goToPreviousVC() {
        let previousVC = pageViewController(self, viewControllerBeforeViewController: viewControllers[0] as! UIViewController)!
        setViewControllers([previousVC], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
    }
    
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
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        switch viewController {
        case detailsVC: return chatVC
        default: return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        switch viewController {
        case chatVC: return detailsVC
        default: return nil
        }
    }
}