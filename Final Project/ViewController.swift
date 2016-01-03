//
//  ViewController.swift
//  Final Project
//
//  Created by Nina Ray on 11/26/15.
//  Copyright © 2015 Nina Ray. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //QUESTIONS:
    //1. Challenge Question #4
    //2. Hard code in an image view?
    
    @IBAction func changeSound(sender: UIButton) {
        if vgame.playing == true {
        vgame.pause()
        }
        
        else {
            vgame.play()
        }
    }
    
    @IBAction func chooseEasy(sender: UIButton) {
    }
    
    @IBAction func chooseMedium(sender: UIButton) {
    }
    
    @IBAction func chooseHard(sender: UIButton) {
    }
    
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if segue.identifier == "easySegue" {
          //  let destination = segue.destinationViewController as! EasyViewController
            //if destination.didYouWin() == true {
              //  vgame.stop()
           // }
            //else if destination.didYouWin() == false {
              //  vgame.play()
            //}
        //}
        
     //   if segue.identifier == "mediumSegue" {
       //     let destination = segue.destinationViewController as! MediumViewController
         //   if destination.didYouWin() == true {
           //     vgame.stop()
           // }
       // }
        
       // if segue.identifier == "hardSegue" {
         //   let destination = segue.destinationViewController as! HardViewController
           // if destination.didYouWin() == true {
             //   vgame.stop()
           // }
       // }
   // }

    //Also sometimes the game will glitch and everything you tap is a mine? Not sure why, but going back to the main screen will fix that.
    
    var vgame: AVAudioPlayer!
    
    override func viewDidLoad() {
        let soundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("alsovgame", ofType: "mp3")!)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            try vgame = AVAudioPlayer(contentsOfURL: soundURL)
            vgame.prepareToPlay()
        } catch {
            print("ERROR")
        }
        vgame.play()
        vgame.numberOfLoops = -1
        
        //I just wanted to let everybody know
        
        //My immediate second option for background music was
        
        //'Stayin Alive'
        
        //so,
        
        //be thankful


    }
    
    func stopPlaying() -> Void {
        vgame.stop()
    }
    
    //So 
    
    //I ended up going with the second option anyway
}
