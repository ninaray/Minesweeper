//
//  MediumViewController.swift
//  Final Project
//
//  Created by Nina Ray on 11/28/15.
//  Copyright © 2015 Nina Ray. All rights reserved.
//

import UIKit
import AVFoundation

class MediumViewController: UIViewController {
    
    @IBOutlet weak var highScore: UILabel!
    
    @IBOutlet weak var timer: UILabel!
    
    @IBOutlet weak var mediumBoard: UIView!
    
    @IBOutlet weak var youWon: UILabel!
    
    var audioPlayer:AVAudioPlayer!

    var nice: AVAudioPlayer!

    
    var fullTime = 0  {
        didSet {
            self.timer.text = "Time: \(fullTime)"
            self.timer.sizeToFit()
        }
    }
    
    var time: NSTimer?
    
    let boarddim: Int = 10
    var minesweeperboard: MineSweeperBoard
    var squareButtonarray: [SquareButton] = []
    
    required init?(coder aDecoder: NSCoder) {
        self.minesweeperboard = MineSweeperBoard(size: boarddim)
        //creates a board with boarddim dimensions
        super.init(coder: aDecoder)
        //not really sure what this does but let's just roll with it
    }
    
    func hitMine() {
        let newAlert = UIAlertView()
        newAlert.addButtonWithTitle("Try Again? Tap 'New Game' ")
        newAlert.title = "Whoops!"
        newAlert.message = "Looks like you hit a mine."
        newAlert.show()
        newAlert.delegate = self
        audioPlayer.play()

        self.youDied()
    }
    
    //Restart the game when you hit "Try Again?"
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        self.startNewGame()
    }
    
    func youDied() {
        self.time = nil
    }
    
    func startNewGame() {
        self.minesweeperboard.resetGame()
        for squareButton in self.squareButtonarray {
            squareButton.userInteractionEnabled = true
            squareButton.setTitle("-", forState: .Normal)
        }
        self.fullTime = 0
        
    }
    
    func didYouWin() -> Bool {
        var minesuntouched = true
        var allsquares = true
        var win = false
        for button in squareButtonarray {
            if button.square.isMine == true {
                if button.square.showSquare == true {
                    minesuntouched = false
                }
            }
            if button.square.isMine == false {
                if button.square.showSquare == false {
                    allsquares = false
                }
            }
        }
        if minesuntouched == true {
            if allsquares == true {
                win = true
            }
        }
        else {
            win = false
        }
        return win
    }
    
    func tapSquareButton(sender: SquareButton) {
        sender.setTitle("", forState: .Normal)
        sender.square.showSquare = true
        sender.setTitle("\(sender.getText())", forState: .Normal)
        if sender.square.isMine {
            self.hitMine()
        }
        sender.userInteractionEnabled = false
        if didYouWin() == true {
            print("You Won!")
            if "High Score: \(fullTime)" > self.highScore.text {
                self.highScore.text = "High Score: \(fullTime)"
                self.highScore.sizeToFit()
            }
            youWon.hidden = false
            youWon.text = "CONGRATULATIONS!!!!!!"
            nice.play()
            nice.numberOfLoops = -1
        }
    }
    
    func createBoard() {
        for row in 0 ... minesweeperboard.size-1 {
            for column in 0 ... minesweeperboard.size-1 {
                let squareButton = minesweeperboard.mineboard[row][column]
                let squareButtonDim: CGFloat = self.mediumBoard.frame.width/CGFloat(boarddim)
                //superview, NOT it's own view
                let addSquareButton = SquareButton(newsquare: squareButton, squareDim: squareButtonDim, row: 8, col: 8)
                addSquareButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
                //when putting the numbers in
                addSquareButton.addTarget(self, action: "tapSquareButton:", forControlEvents: .TouchUpInside)
                self.mediumBoard.addSubview(addSquareButton)
                self.squareButtonarray.append(addSquareButton)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.title = "Level: Medium"
        time = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerFired:", userInfo: nil, repeats: true)
        let soundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("explosion", ofType: "mp3")!)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            try audioPlayer = AVAudioPlayer(contentsOfURL: soundURL)
            audioPlayer.prepareToPlay()
        } catch {
            print("ERROR")
        }

        //MY PLAN i think
        //create an 8x8 table of 64 buttons
        //randomly, some buttons will have mines and some will not
        //to identify if a button has a mine, it will have a property (mine) which is True
        //if a button does not have a mine, it's mine property will be False
        //upon loading, there will be 8 random buttons that will have mine = True, thus, there will be 8 mines
        //
        
        let nicesoundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("nice", ofType: "mp3")!)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            try nice = AVAudioPlayer(contentsOfURL: nicesoundURL)
            nice.prepareToPlay()
        } catch {
            print("ERROR")
        }
        self.createBoard()
        self.startNewGame()
    }
    
    func timerFired(sender: NSTimer) {
        self.fullTime++
    }
    
    @IBAction func newGame(sender: UIButton) {
        minesweeperboard.resetGame()
        self.startNewGame()
        self.youDied()
    }
    
}


