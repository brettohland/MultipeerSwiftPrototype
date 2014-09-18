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
    @IBOutlet var myPeerIDLabel : UILabel!
    @IBOutlet var theirPeerIDLabel : UILabel!
    @IBOutlet var theirCounterLabel : UILabel!
    @IBOutlet var counterButton : UIButton!
    
    // Constants
    let HotColdServiceType = "hotcold-service"
    
    // Optionals
    var localSession: MCSession?
    var advertiser: MCNearbyServiceAdvertiser?
    var browser: MCNearbyServiceBrowser?
    var localPeerID: MCPeerID?
    
    // Set properties
    var connectedPeers: [MCPeerID] = []
    var buttonCounter = 0
   
    override func viewDidLoad() {
        myPeerIDLabel.text = ""
        theirPeerIDLabel.text = ""
        theirCounterLabel.text = ""
        counterButton.enabled = false
        
        localPeerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        browser = MCNearbyServiceBrowser(peer: localPeerID!, serviceType: HotColdServiceType)
        browser!.delegate = self
        
        // Advertiser
        advertiser = MCNearbyServiceAdvertiser(peer: localPeerID!, discoveryInfo: nil, serviceType: HotColdServiceType)
        advertiser!.delegate = self
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        myPeerIDLabel.text = localPeerID!.displayName
        
        browser!.startBrowsingForPeers()
        advertiser!.startAdvertisingPeer()
        
        super.viewWillAppear(animated)
    }
    
    func setupSession() -> Void {
        println("Setting up session")
        localSession = MCSession(peer: localPeerID!, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.None)
        localSession!.delegate = self
    }
    
    func enableServices(enable: Bool) -> Void {
        if(enable){
            advertiser!.startAdvertisingPeer()
            browser!.startBrowsingForPeers()
        } else {
            advertiser!.stopAdvertisingPeer()
            browser!.stopBrowsingForPeers()
        }
    }
    
    // MCNearbyServiceAdvertiserDelegate
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!) {
        println("Received invitation from \(peerID.displayName)")
        
        
        if (localSession == nil) {
            localSession = MCSession(peer: localPeerID!, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.None)
            localSession!.delegate = self
            invitationHandler(true, self.localSession)
            
            enableServices(false)
        }
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didNotStartAdvertisingPeer error: NSError!) {
        // Handle this error more gracefully
        println("Didn't start advertiser")
    }
    
    // MCNearbyServiceBrowserDelegate

    func browser(browser: MCNearbyServiceBrowser!, foundPeer peerID: MCPeerID!, withDiscoveryInfo info: [NSObject : AnyObject]!) {
        println("Found Peer! \(peerID.displayName)")
        
        if (localSession == nil) {
            setupSession()
            browser.invitePeer(peerID, toSession: localSession, withContext: nil, timeout: 5)
            
            enableServices(false)
        }

    }
    
    func browser(browser: MCNearbyServiceBrowser!, lostPeer peerID: MCPeerID!) {
        localSession = nil
        
        enableServices(true);
    }
    
    // MCSessionDelegate
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        println("State Changed to \(state.toRaw())")
        if(state == MCSessionState.Connected){
            println("Connected to \(peerID.displayName)")
            connectedPeers.append(peerID)
            dispatch_async(dispatch_get_main_queue(), {
                self.theirPeerIDLabel.text = peerID.displayName
                self.counterButton.enabled = true
            })
        }
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        let message = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("Message received \(message)")
        dispatch_async(dispatch_get_main_queue(), {
            self.theirCounterLabel.text = message
        })
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
    }
    
    @IBAction func incrementCounterAndSend(sender : UIButton) {
        buttonCounter++
        let data = "\(buttonCounter) times".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        var error: NSError? = nil
        
        if (!localSession!.sendData(data, toPeers: connectedPeers, withMode: MCSessionSendDataMode.Reliable, error: &error)){
            println("ERROR \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

