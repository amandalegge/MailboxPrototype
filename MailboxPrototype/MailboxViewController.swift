//
//  MailboxViewController.swift
//  MailboxPrototype
//
//  Created by Amanda Legge on 11/11/15.
//  Copyright © 2015 Amanda Legge. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    
    @IBOutlet weak var hamburgerMenuView: UIView!
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var mailboxScrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var archiveIconView: UIImageView!
    @IBOutlet weak var deleteIconView: UIImageView!
    @IBOutlet weak var listIconView: UIImageView!
    @IBOutlet weak var laterIconView: UIImageView!
    @IBOutlet weak var laterOverlayImageView: UIImageView!
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    var messageOriginalCenter: CGPoint!
    var messageLeftOffset: CGFloat!
    var messageRightOffset: CGFloat!
    var messageOffset: CGFloat!
    var messageLeft: CGPoint!
    var messageRight: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults.setBool(false, forKey: "viewed_laterscreen")
        defaults.setBool(false, forKey: "viewed_listscreen")
        archiveIconView.alpha = 0
        deleteIconView.alpha = 0
        listIconView.alpha = 0
        laterIconView.alpha = 0
        leftView.backgroundColor = UIColor.greenColor()
        rightView.backgroundColor = UIColor.yellowColor()
        leftView.hidden = true
        rightView.hidden = true
        
        
        mailboxScrollView.contentSize = CGSize(width: 320, height: 1450)
        
        messageOffset = 40
        messageLeft = messageImageView.center
        messageRight = CGPoint(x: messageImageView.center.x, y: messageImageView.center.y)
        
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self,
            action: "didSlideToRevealMenu:")
        screenEdgeRecognizer.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapHamburgerMenu(sender: UITapGestureRecognizer) {
        
        print("tapped but nothing got called")
    
        if sender.state == UIGestureRecognizerState.Began{
            
            print("tapped but the function doesn't work")
            if hamburgerMenuView.frame.origin.x >= 260{
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    self.mailboxScrollView.transform = CGAffineTransformMakeTranslation(0, 0)
                    
                })
                
            }
        
        }else if sender.state == UIGestureRecognizerState.Changed{
            
        }else if sender.state == UIGestureRecognizerState.Ended{
 
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if defaults.boolForKey("viewed_laterscreen"){
            print("nsuserdefaults got called!")
            completedMessage()
        }else if defaults.boolForKey("viewed_listscreen"){
            completedMessage()
        }
        
    }
    
    
    @IBAction func didSlideToRevealMenu(sender: UIScreenEdgePanGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.Began{
            
            
        }else if sender.state == UIGestureRecognizerState.Changed{
            
            
        }else if sender.state == UIGestureRecognizerState.Ended{
            
            if mailboxScrollView.frame.origin.x > 0 || mailboxScrollView.frame.origin.x < 280{
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    self.mailboxScrollView.transform = CGAffineTransformMakeTranslation(280, 0)
                    
                })
                
            }
            
        }
        
    }
    
    
    func completedMessage(){
        
        UIView.animateWithDuration(0.4) { () -> Void in
            self.messageImageView.hidden = true
            self.feedImageView.frame.origin.y = 140
        }
    }
    
    
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        if sender.state == UIGestureRecognizerState.Began {
            self.messageOriginalCenter = messageImageView.center
            
        }else if sender.state == UIGestureRecognizerState.Changed {
            print("UI Gesture has changed")
            
            self.archiveIconView.frame.origin.x = translation.x - 40
            
            if translation.x >= -40 && translation.x > -260{
                print("translation less than -40: \(translation.x)")
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    self.rightView.hidden = true
                    self.rightView.alpha = translation.x/80
                    self.laterIconView.alpha = 0
                    self.listIconView.alpha = 0
                    self.rightView.backgroundColor = UIColor.yellowColor()
                    
                })
            }else if translation.x < -40 && translation.x > -260{
                print("translation greater than -40: \(translation.x)")
                
                self.laterIconView.frame.origin.x = 340 + translation.x
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    self.rightView.hidden = false
                    self.rightView.alpha = 1
                    self.rightView.backgroundColor = UIColor.yellowColor()
                    self.listIconView.alpha = 0
                    self.laterIconView.alpha = 1
                    
                })
                
            }else if translation.x < -260{
                print("translation greater than -260: \(translation.x)")
                
                self.listIconView.frame.origin.x = 340 + translation.x
                
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    
                    self.rightView.backgroundColor = UIColor.brownColor()
                    self.laterIconView.alpha = 0
                    self.listIconView.alpha = 1
                })
            }
            
            if translation.x >= 40 && translation.x < 260{
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    self.leftView.hidden = false
                    self.leftView.alpha = translation.x/80
                    self.archiveIconView.alpha = 1
                    self.deleteIconView.alpha = 0
                    self.leftView.backgroundColor = UIColor.greenColor()
                    
                })
                
            }else if translation.x < 40{
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    self.leftView.hidden = true
                    self.archiveIconView.alpha = 0
                    self.deleteIconView.alpha = 0
                })
                
            }else if translation.x > 260{
                
                self.deleteIconView.frame.origin.x = translation.x - 40
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    self.leftView.backgroundColor = UIColor.redColor()
                    self.deleteIconView.alpha = 1
                    self.archiveIconView.alpha = 0
                    
                })
            }
            
            
            self.messageImageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
        }else if sender.state == UIGestureRecognizerState.Ended {
            let velocity = sender.velocityInView(view)
            print("\(velocity)")
            
            
            if velocity.x > 0 && translation.x < 40{
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 20, options: [], animations: { () -> Void in
                    self.messageImageView.center = self.messageRight
                    }, completion: { (Bool) -> Void in
                        self.archiveIconView.alpha = 0
                        self.deleteIconView.alpha = 0
                        self.listIconView.alpha = 0
                        self.laterIconView.alpha = 0
                        self.leftView.backgroundColor = UIColor.greenColor()
                        self.rightView.backgroundColor = UIColor.yellowColor()
                        self.leftView.hidden = true
                        self.rightView.hidden = true
                })
                
            }else if translation.x < 40 && translation.x > 0{
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 20, options: [], animations: { () -> Void in
                    self.messageImageView.center = self.messageLeft
                    }, completion: { (Bool) -> Void in
                        self.archiveIconView.alpha = 0
                        self.deleteIconView.alpha = 0
                        self.listIconView.alpha = 0
                        self.laterIconView.alpha = 0
                        self.leftView.backgroundColor = UIColor.greenColor()
                        self.rightView.backgroundColor = UIColor.yellowColor()
                        self.leftView.hidden = true
                        self.rightView.hidden = true
                        
                })
            }else if translation.x > 40 && translation.x < 260{
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    
                    self.leftView.hidden = false
                    self.leftView.alpha = translation.x/80
                    self.archiveIconView.alpha = 0
                    self.deleteIconView.alpha = 0
                    self.leftView.backgroundColor = UIColor.greenColor()
                    self.archiveIconView.frame.origin.x = 280
                    self.messageImageView.frame.origin.x = 320
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.messageImageView.hidden = true
                        self.completedMessage()
                        
                })
                
                
                
            }else if translation.x < -40 && translation.x >= -260{
                print("Translation greater than -40: \(translation.x)")
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    
                    self.rightView.hidden = false
                    self.rightView.alpha = 1
                    self.rightView.backgroundColor = UIColor.yellowColor()
                    self.listIconView.alpha = 0
                    self.laterIconView.alpha = 1
                    self.laterIconView.frame.origin.x = -25
                    self.messageImageView.frame.origin.x = -320
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.performSegueWithIdentifier("laterSegue", sender: nil)
                })
                
            }else if translation.x < -260{
                print("translation greater than -260: \(translation.x)")
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    self.rightView.backgroundColor = UIColor.brownColor()
                    self.laterIconView.alpha = 0
                    self.listIconView.alpha = 1
                    self.listIconView.frame.origin.x = -25
                    self.messageImageView.frame.origin.x = -320
                    
                    }, completion:{ (Bool) -> Void in
                        
                        self.performSegueWithIdentifier("listSegue", sender: nil)
                        
                })
                
            }else if translation.x > 260{
                
                self.deleteIconView.frame.origin.x = translation.x - 40
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    self.leftView.backgroundColor = UIColor.redColor()
                    self.deleteIconView.alpha = 1
                    self.archiveIconView.alpha = 0
                    self.deleteIconView.frame.origin.x = 320
                    self.messageImageView.frame.origin.x = 360
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.messageImageView.hidden = true
                        self.completedMessage()
                        
                })
                
            }else if translation.x < -260{
                print("translation greater than -260: \(translation.x)")
                
                self.listIconView.frame.origin.x = 340 + translation.x
                
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    
                    self.rightView.backgroundColor = UIColor.brownColor()
                    self.laterIconView.alpha = 0
                    self.listIconView.alpha = 1
                    self.listIconView.frame.origin.x = -20
                    self.messageImageView.frame.origin.x = -360
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.messageImageView.hidden = true
                        self.completedMessage()
                        
                })
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
    }
}