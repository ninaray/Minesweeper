//
//  SquareImage.swift
//  Final Project
//
//  Created by Nina Ray on 12/3/15.
//  Copyright © 2015 Nina Ray. All rights reserved.
//

import UIKit

class SquareImage: UIImageView {
    var square: Square
    let squareDim: CGFloat
    var squareColor = UIColor.whiteColor()
    let squareMargin: CGFloat
    
    init(newsquare: Square, squareDim: CGFloat, squareMargin: CGFloat) {
        self.square = newsquare
        self.squareDim = squareDim
        self.squareMargin = squareMargin
        
        let squareFrame = CGRectMake(CGFloat(self.square.column) * (self.squareDim + self.squareMargin), CGFloat(self.square.row) * (self.squareDim + self.squareMargin), squareDim, squareDim)
        //position depends on row & column input
        
        super.init(frame: squareFrame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getMine() -> UIImage {
        let mine = UIImage(named: "Mine")!
        return mine
    }

}
