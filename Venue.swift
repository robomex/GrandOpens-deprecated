//
//  Venue.swift
//  GrandOpens
//
//  Created by Tony Morales on 6/18/15.
//  Copyright (c) 2015 Tony Morales. All rights reserved.
//

import Foundation
import Parse

struct Venue {
    let id: String
    let name: String
    let neighborhood: String
}

func fetchVenues (callback: ([Venue]) -> ()) {
    
    let date = NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitDay, value: -33, toDate: NSDate(), options: nil)!
    
    PFQuery(className: "Venue")
        .whereKey("openingDate", greaterThanOrEqualTo: date)
        .findObjectsInBackgroundWithBlock({
            objects, error in
            
            if let venues = objects as? [PFObject] {
                let fetchedVenues = venues.map({
                    (object: PFObject) -> (venueId: String, venueName: String, venueNeighborhood: String) in
                    (object.objectId! as String, object.objectForKey("name") as! String, object.objectForKey("neighborhood") as! String)
                })
                
                var v: [Venue] = []
                for (index, venue) in enumerate(fetchedVenues) {
                    v.append(Venue(id: fetchedVenues[index].venueId, name: fetchedVenues[index].venueName, neighborhood: fetchedVenues[index].venueNeighborhood))
                }
                callback(v)
            }
        })
}