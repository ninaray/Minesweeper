//
//  MineSweeperBoard.swift
//  Final Project
//
//  Created by Nina Ray on 11/27/15.
//  Copyright © 2015 Nina Ray. All rights reserved.
//

import UIKit
import Darwin

class MineSweeperBoard {
    let size: Int
    //8x8 or 10x10 or 12x12
    var mineboard: [[Square]] = []
    //var buttonboard: [[SquareButton]] = []
    //START WITH AN EMPTY BOARD
    //Board is an AxB array, where each spot is taken up by a Square
    //Each Square is found through [A][B], which is [row][column]
    
    init(size: Int) {
        self.size = size
        //row of squares is initially empty
        for row in (0 ... size-1) {
            var squareRow: [Square] = []
            //var buttonRow: [SquareButton] = []
            //create 8 or 10 or 12 empty rows that must only contain squares
            for column in (0 ... size-1) {
                let square = Square(row: row, column: column)
                //let button = SquareButton(newsquare: Square, squareDim: CGFloat, row: row, col: column)
                //Create a square in row 1 column 1, row 1 column 2...row 7 column 1...row 8 column 8
                squareRow.append(square)
                //add 8 or 10 or 12 squares to a row
            }
            mineboard.append(squareRow)
            //add 8 or 10 or 12 rows to the board
        }
    
    }
    
    func assignMine(square: Square) {
        if arc4random_uniform(8) == 1 {
            square.isMine = true
            //1 in 8 chance that a square is a mine
        }
    }
    
    func getSquareLocation(column : Int, row : Int) -> Square? {
        var location: Square?
        if row >= 0 && row < self.size {
            //if valid row
            if column >= 0 && column < self.size {
                //if valid column
                location = mineboard[row][column]
            }
        }
        else {
            location = nil
        }
        return location
    }

    
    func getSurroundingSquares (square: Square) -> [Square] {
        //returns a list of touching squares
        var surroundingSquares: [Square] = []
        let computeSquares = [(1, 0), (1, 1), (0, 1), (-1, 1), (-1, 0), (-1, -1), (0, -1), (1, -1)]
        //position of surrounding squares
        //moving in x direction indicates changing columns, moving in y direction indicates changing rows
        for (computecolumn, computerow) in computeSquares {
            let neighbor: Square? = getSquareLocation(square.column + computecolumn, row: square.row + computerow)
            //get a neighboring square THAT MIGHT NOT BE A SQUARE (consider corner squares)
            if let surroundingSquare = neighbor {
                //only add to list of surroundingSquares IF THE SQUARE EXISTS
                surroundingSquares.append(surroundingSquare)
            }
        }
        return surroundingSquares
    }
    
    
    func countSurroundingMines (square: Square) {
        var surroundingMines = 0
        //number of mines touching
        let surroundingSquares = getSurroundingSquares(square)
        //number of squares touching (Not always 8!!! Think about corner squares)
        for square in surroundingSquares {
            if square.isMine == true {
               surroundingMines++
            }
        }
        square.numberOfMines = surroundingMines
    }
    
    func resetGame() {
        for row in (0...size-1) {
            for column in (0...size-1) {
                mineboard[row][column].showSquare = false
                //"unclicks" all squares
                self.assignMine(mineboard[row][column])
                //calls function assignMine to assign a mine randomly to each square
            }
        }
        //now that each square has been calibrated...
        for row in (0...size-1) {
            for column in (0...size-1) {
                self.countSurroundingMines(mineboard[row][column])
                //count the number of surrounding mines for each square
            }
        }
    }
    
    

}
