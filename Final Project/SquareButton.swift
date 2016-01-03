//
//  SquareButton.swift
//  Final Project
//
//  Created by Nina Ray on 11/27/15.
//  Copyright © 2015 Nina Ray. All rights reserved.
//

import UIKit

class SquareButton: UIButton {
    //for each square, there is a button that accompanies it
    //this button is smaller than the tile bc it needs margins
    var square: Square
    let squareDim: CGFloat
    var squareColor = UIColor.whiteColor()
    var row: Int
    var col: Int
    
    init(newsquare: Square, squareDim: CGFloat, row: Int, col: Int) {
        self.square = newsquare
        self.squareDim = squareDim
        self.row = row
        self.col = col
        
        let squareFrame = CGRectMake(CGFloat(self.square.column) * (self.squareDim), CGFloat(self.square.row) * (self.squareDim), squareDim, squareDim)
        //position depends on row & column input
        
        super.init(frame: squareFrame)
        //I think this makes the square wrt button
    }

    required init(coder aDecoder: NSCoder) {
        //idk what this does but error will occur if it's not here
        fatalError("init(coder:) has not been implemented")
    }
    
    func getText() -> String {
        if (!self.square.isMine) {
            if self.square.numberOfMines == 0 {
                //no surrounding mines
                return ""
            }
            else {
                return "\(self.square.numberOfMines)"
            }
        }
        return "M"
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
