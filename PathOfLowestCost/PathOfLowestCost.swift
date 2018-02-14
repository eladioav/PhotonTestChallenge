//
//  PathOfLowestCost.swift
//  PathOfLowestCost
//
//  Created by Eladio Alvarez Valle on 2/7/18.
//  Copyright © 2018 Eladio Alvarez Valle. All rights reserved.
//

import Foundation

struct Position {
    
    var row : Int
    var col : Int
    var cost : Int
}

struct Route {
    
    var route : [Position] = []
    var routeRows : [Int] = []
    var totalCost : Int = 0
    
    //Add Route
    mutating func addRoute(to : Position, maxPos : Position) -> Bool {
        
        //Add new node and calculate totalCost
        route.append(Position(row: to.row, col: to.col, cost: to.cost))
        routeRows.append(to.row+1)
        totalCost += to.cost
        print("Add new route : \(to) - tc : \(totalCost)")
        
        if totalCost > maxTotalCost { //max total cost surpassed
            
            print("Delete last Route - maxTotalCost")
            deleteLastRoute()
            return false
            
        } else if to.col == maxPos.col && to.row != maxPos.row /*&& maxPos.col > 1*/ { //Reach max col, but not last row
            
            print("Delete last Route - max col reached")
            deleteLastRoute()
            return false
            
        } else {
            
            print("Route added")
            return true
        }
    }
    
    //Delete last route
    mutating func deleteLastRoute() {
        
        if let last = route.last { //There are an existing route
            
            if last.col == 0 { //If is the first col, delete the latest route
                
                print("Delete Route, first col - tc : \(totalCost)")
                //totalCost = 0
                route = []
                routeRows = []
                
            } else { //Is not the first col

                print("Delete Route, Not first col - tc : \(totalCost)")
                totalCost -= last.cost //Rest from total cost
                _ = route.removeLast() // Delete last route
                _ = routeRows.removeLast() //Delete last rows route
            }
            
            
        }
    }
    
    //Clean all
    mutating func deleteAll() {
        
        print("Delete Route, first col - tc : \(totalCost)")
        totalCost = 0
        route = []
        routeRows = []
    }
}

class PathOfLowestCost {
    
    var matrix : [[Int]]?
    var traveledRoutes : [[Int]]? //Ran paths
    var rows : Int //Total matrix rows
    var cols : Int //Total matrix cols
    var route = Route() //Final Path
    var maxPosition : Position?
    
    //Failable Initializer
    init?(rows : Int , columns : Int ,_ values : [Int]) {

        //Init rows and cols
        self.cols = columns
        self.rows = rows
        
        //Check the size of the matrix rows and cols
        if rows < minRows || columns < minCols || rows > maxRows || columns > maxCols || values.count > rows*columns || values.count < rows*columns {
            
            return nil
            
        }
        
        //Init matrix & route
        matrix = Array(repeating: Array(repeating: 0, count: columns), count: rows)
        traveledRoutes = Array(repeating: Array(repeating: 0, count: columns), count: rows)
        
        //Fill Matrix
        var index : Int = -1
        for i in 0..<rows {
            for j in 0..<columns {
                
                index += 1
                matrix![i][j] = values[index]
            }
        }
        
        //Set max Position, cell to reach
        maxPosition = Position(row: columns-1, col: rows-1, cost: values[index])
    }
    
    func findLowestCost() -> (ok : Bool, totalCost : Int, routeRows : [Int]) {
        
        var nextPos : Position?
        var startPos : Position?
        
        startPos = findStartingCol()
        
        //Find starting position
        while startPos != nil { //startPos is not nil
            
            nextPos = findNextCol(pos: startPos!) //Find next position
            while nextPos != nil { //Run thru starting cols
                
                //If found goal position
                if nextPos!.col == cols-1 && nextPos!.row == rows-1 {
                    
                    return (true, route.totalCost, route.routeRows)
                }
                
                //Check the latest position
                if route.route.count == 0 { //There are not starting position
                    
                    nextPos = findStartingCol() //Find new starting col position
                    
                    if nextPos == nil { //Could not find an starting col
                     
                        return (false,0,[])
                    }
                    
                } else { //There are an existing route path
                    
                    nextPos = findNextCol(pos: route.route.last!) //Find next col node
                    
                    if nextPos == nil { //Could not find a next col, go back a position
                        //route.deleteLastRoute() //Delete current route
                        nextPos = findNextCol(pos: route.route.last!) //Find other route
                    }
                }
                
                
            }//End while
         
            //If this point is reached, a route was not found with the starting column
            route.deleteAll() //Delete all routes
            startPos = findStartingCol() //Find next starting starting col
        }//End Run thru starting cols 
        
        return (false,0,[])
    }
    
    /// Find the starting cell to start search
    /// - Properties : Void
    /// - Returns : Position of the starting cell, nil if could not find it
    func findStartingCol() -> Position? {
        
        var first : Int = 0
        var minimumPos : Position?
        
        //Run thru rows
        for i in 0..<rows {
            
            if traveledRoutes![i][0] == 0 { //Did not run this path yet
                
                if first == 0 { //Get minimun
                    
                    minimumPos = Position(row: i, col: 0, cost: matrix![i][0])
                    first += 1
                    
                } else {
                    
                    //Compare to find minimum value
                    if matrix![i][0] < minimumPos!.cost {
                        
                        minimumPos = Position(row: i, col: 0, cost: matrix![i][0]) //Set minimum value
                    }
                }
            }
            
        }//End Run thru rows
        
        //Check if could find a starting col
        if minimumPos != nil {
            
            print("Traveled route starting col: Row: \(minimumPos!.row)")
            //Set as traveled route
            traveledRoutes![minimumPos!.row][0] = 1
            
            //Add Route
            if route.addRoute(to: minimumPos!, maxPos: Position(row: rows-1, col: cols-1, cost: 0)) == false {
                
                return nil //Can`t add Route
            }
        }
        
        return minimumPos
    }
    
    /// Find the next col to find path
    /// - Properties :
    ///     - pos : Position  to start finding the next path
    /// - Returns : Next cell, nil if is last column or couldn`t find the next node
    func findNextCol(pos : Position) -> Position? {
    
        var first : Int = 0
        var minimumPos : Position?
        var rowPos : Int = 0
        
        //Check if is not last column
        guard pos.col < cols-1 else {
            
            return nil
        }
        
        //Run thru adjacent columns /> -> \>
        for i in 0..<3 {
            
            //If is the first row & up diagonal
            if pos.row == 0 && i == 0 {
                
                rowPos = rows-1 //Point to last row
                
            } else if pos.row == rows-1 && i == 2 { //If is the last row & down diagonal
                
                rowPos = 0 //Point to first row
                
            } else { //Get proper row
                
                switch i {
                    case 0 :
                        rowPos = pos.row - 1
                        break
                    case 1 :
                        rowPos = pos.row
                        break
                    case 2 :
                        rowPos = pos.row + 1
                        break
                    default : ()
                }

            }
            
            if traveledRoutes![rowPos][pos.col+1] == 0 { //Did not go thru this path yet
                
                if first == 0 { //Get minimun
                    
                    minimumPos = Position(row: rowPos, col: pos.col+1, cost: matrix![rowPos][pos.col+1])
                    first += 1
                    
                } else {
                    
                    //Compare to find minimum value
                    if matrix![rowPos][pos.col+1] < minimumPos!.cost {
                        
                        minimumPos = Position(row: rowPos, col: pos.col+1, cost: matrix![rowPos][pos.col+1]) //Set minimum value
                    }
                    
                }
                
                //If is the goal cell, just select it and break the cycle
                if rowPos == rows-1 && pos.col+1 == cols-1 {
                   
                    print("Goal cell found")
                    minimumPos = Position(row: rowPos, col: pos.col+1, cost: matrix![rowPos][pos.col+1]) //Set minimum value
                    break
                }
            }
            
        }//End Run thru rows
        
        //Check if could find the next col
        if minimumPos != nil {
            
            print("Traveled route next col: Row: \(minimumPos!.row) Col: \(minimumPos!.col)")
            //Set as traveled route
            traveledRoutes![minimumPos!.row][minimumPos!.col] = 1
            
            //Add Route
            if route.addRoute(to: minimumPos!, maxPos: Position(row: rows-1, col: cols-1, cost: 0)) == false {
                
                //Try to find other path route going back 
                if let minPos = findNextCol(pos: route.route.last!) {
                    return minPos
                } else {
                    return nil //Can`t add Route
                }
            }
        }
        
        return minimumPos
    }
    
    /// Find smallest value for the first row to start
    /// - Parameters :
    ///     - void
    /// - Returns : Smaller size row
    ///

}
