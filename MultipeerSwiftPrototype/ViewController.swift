//
//  ViewController.swift
//  MultipeerSwiftPrototype
//
//  Created by brett ohland on 2014-06-09.
//  Copyright (c) 2014 ampersandsoftworks. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate, MCSessionDelegate {
    @IBOutlet var myPeerIDLabel : UILabel
    @IBOutlet var theirPeerIDLabel : UILabel
    @IBOutlet var theirCounterLabel : UILabel
    @IBOutlet var counterButton : UIButton
    
    // Constants
    let HotColdServiceType = "hotcold-service"
    
    // Optionals
    var session: MCSession?
    var advertiser: MCNearbyServiceAdvertiser?
    var browser: MCNearbyServiceBrowser?
    var localPeerID: MCPeerID?
    
    // Set properties
    var connectedPeers = []
    var buttonCounter = 0

//        - (void)viewDidLoad {
//    
//    // Browser for others
//    self.browser = [[MCNearbyServiceBrowser alloc] initWithPeer:self.localPeerID
//    serviceType:HotColdServiceType];
//    self.browser.delegate = self;
//    
//    // Advertise to others
//    self.advertiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:self.localPeerID
//    discoveryInfo:nil
//    serviceType:HotColdServiceType];
//    self.advertiser.delegate = self;
//    
//    }

    
    override func viewDidLoad() {
        
        myPeerIDLabel.text = ""
        theirPeerIDLabel.text = ""
        theirCounterLabel.text = ""
        counterButton.enabled = false
        
        //self.localPeerID = [[MCPeerID alloc] initWithDisplayName:[[UIDevice currentDevice] name]];
        
        
        
//        if let deviceName = UIDevice.currentDevice().name {
//            localPeerID! = MCPeerID(displayName: deviceName)
//        }
//        
//        // Browser
//        browser! = MCNearbyServiceBrowser(peer: localPeerID , serviceType: HotColdServiceType)
//        browser!.delegate = self

        //let myTableView: UITableView = UITableView(frame: CGRectZero, style: .Grouped)
        
        
        // Advertiser
        
        super.viewDidLoad()
    }
    
    // MCNearbyServiceAdvertiserDelegate
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!) {
        
    }

    // MCNearbyServiceBrowserDelegate
    
    func browser(browser: MCNearbyServiceBrowser!, foundPeer peerID: MCPeerID!, withDiscoveryInfo info: NSDictionary!) {
    }
    
    func browser(browser: MCNearbyServiceBrowser!, lostPeer peerID: MCPeerID!) {
    
    }
    
    // MCSessionDelegate
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
    
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
    
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
    
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
    
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
    
    }
    
    @IBAction func incrementCounterAndSend(sender : UIButton) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

