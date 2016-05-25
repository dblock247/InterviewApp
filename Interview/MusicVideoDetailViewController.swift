//
//  MusicVideoDetailViewController.swift
//  Interview
//
//  Created by Londre Blocker on 4/25/16.
//  Copyright © 2016 Londre Blocker. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import LocalAuthentication

class MusicVideoDetailViewController: UIViewController {

    var videos: Videos!
    
    var securitySwitch: Bool = false
    
    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    @IBOutlet weak var vRights: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(preferredFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)

        title = videos.vArtist
        vName.text = videos.vName
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights
        vGenre.text = videos.vGenre
        
        if videos.vImageData != nil {
            videoImage.image = UIImage(data: videos.vImageData!)
        } else {
            videoImage.image = UIImage(named: "imageNotAvailable")
        }
    }
    
    @IBAction func socialMedia(sender: UIBarButtonItem)
    {
        securitySwitch = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        switch securitySwitch {
        case true:
            touchIdCheck()
        default:
            shareMedia()
        }
    }
    
    func touchIdCheck()
    {
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "continue", style: UIAlertActionStyle.Cancel, handler: nil))
        
        let context = LAContext()
        var touchIDError: NSError?
        let reasonString = "Touch-Id authentication is needed to share info on Socail Media"
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &touchIDError) {
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) -> Void in
                if success {
                    dispatch_async(dispatch_get_main_queue()) {
                        [unowned self] in
                        self.shareMedia()
                    }
                } else {
                    alert.title = "Unsuccessful!"
                    
                    switch LAError(rawValue: policyError!.code)! {
                    case .AppCancel:
                        alert.message = "Authentication was cancelled by application"
                    case .AuthenticationFailed:
                        alert.message = "The user failed to provide valid credentials"
                    case .PasscodeNotSet:
                        alert.message = "Passcode is not set on the device"
                    case .SystemCancel:
                        alert.message = "Authentication was cancelled by the system"
                    case .TouchIDLockout:
                        alert.message = "Too many failed attempts"
                    case .UserCancel:
                        alert.message = "You cancelled the request"
                    case .UserFallback:
                        alert.message = "Password not accepted, must use Touch-ID"
                    default:
                        alert.message = "Unable to Authenticate!"
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        [unowned self] in
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
            })
        } else {
            alert.title = "Error"
            
            switch LAError(rawValue: touchIDError!.code)! {
            case .TouchIDNotEnrolled:
                alert.message = "TouchID is not enrolled"
            case .TouchIDNotAvailable:
                alert.message = "TouchID is not available on the device"
            case .PasscodeNotSet:
                alert.message = "Passcode has not been set"
            case .InvalidContext:
                alert.message = "The context is invalid"
            default:
                alert.message = "Local Authentication not available"
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                [unowned self] in
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    func shareMedia()
    {
        let activity1 = "Have you had the oppurtunity to see the Music Video?"
        let activity2 = "\(videos.vName) by \(videos.vArtist)"
        let activity3 = "Watch it and tell me what you think?"
        let activity4 = videos.vLinkToiTunes
        let activity5 = "(Shared with the Music Video App - Setp It UP!"
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems:
            [activity1, activity2, activity3, activity4, activity5], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            
            if activity == UIActivityTypeMail {
                print("email selected")
            }
        }
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func playVideo(sender: UIBarButtonItem)
    {
        let url = NSURL(string: videos.vVideoUrl)!
        
        let player = AVPlayer(URL: url)
        let playerViewController = AVPlayerViewController()
        
        playerViewController.player = player
        
        self.presentViewController(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
    
    func preferredFontChange()
    {
        print("The preferred Font has changed")
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
}
