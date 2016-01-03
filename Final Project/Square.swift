//
//  Square.swift
//  Final Project
//
//  Created by Nina Ray on 11/26/15.
//  Copyright © 2015 Nina Ray. All rights reserved.
//

import UIKit

class Square {
    var row: Int
    //can argue 8, 10, or 12
    var column: Int
    //can argue 8, 10, or 12
    var numberOfMines = 0
    //assume there are no surrounding mines before creating the board
    var isMine = false
    //not a mine until I say so
    var showSquare = false
    //square is not shown and therefore unclicked unless clicked
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}
