//
//  VenueViewController.swift
//  GrandOpens
//
//  Created by Tony Morales on 7/21/15.
//  Copyright (c) 2015 Tony Morales. All rights reserved.
//

import Foundation
import Parse
import JSQMessagesViewController

class VenueViewController: JSQMessagesViewController {
    
    var messages: [JSQMessage] = []
    
    var venueID: String?
    
    var messageListener: MessageListener?
    
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
    
    var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.tabBarController?.tabBar.hidden = true
        
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
        if let id = venueID {
            fetchMessages(id, {
                messages in
                
                for m in messages {
                    self.messages.append(JSQMessage(senderId: m.senderID, senderDisplayName: m.senderID, date: m.date, text: m.message))
                }
                self.finishReceivingMessage()
            })
        }
        
        self.senderId = currentUser()!.id
        self.senderDisplayName = currentUser()!.name
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let frame = UIScreen.mainScreen().bounds
        segmentedControl = UISegmentedControl(items: ["Chat", "Details"])
        segmentedControl.frame = CGRectMake(frame.minX + 100, frame.minY + 70, frame.width - 200, frame.height * 0.04)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "venueSegmentedControlAction:", forControlEvents: .ValueChanged)
        segmentedControl.backgroundColor = UIColor.whiteColor()
        segmentedControl.tintColor = UIColor(red: 0x9b/255, green: 0x59/255, blue: 0xb6/255, alpha: 1.0)
        self.view.addSubview(segmentedControl)
    }
    
    override func viewWillAppear(animated: Bool) {
        if let id = venueID {
            messageListener = MessageListener(venueID: id, startDate: NSDate(), callback: {
                message in
                self.messages.append(JSQMessage(senderId: message.senderID, senderDisplayName: message.senderID, date: message.date, text: message.message))
                self.finishReceivingMessage()
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        
        messageListener?.stop()
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        
        var data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        var data = self.messages[indexPath.row]
        if data.senderId == PFUser.currentUser()!.objectId {
            return outgoingBubble
        } else {
            return incomingBubble
        }
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        let m = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        self.messages.append(m)
        
        if let id = venueID {
            saveMessage(id, Message(message: text, senderID: senderId, date: date))
        }
        
        finishSendingMessage()
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
}