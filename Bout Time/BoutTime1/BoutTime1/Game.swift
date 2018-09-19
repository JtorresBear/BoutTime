//
//  Game.swift
//  BoutTime1
//
//  Created by Juan Torres on 9/18/18.
//  Copyright © 2018 Juan Torres. All rights reserved.
//

import Foundation
import GameKit




class Game
{
    let gameEvents = GameEvents()
    let numberOfRounds = 6
    var score = 0
    var randomArrayForRound: [Int] = []
    
    init ()
    {
        newRound()
    }
    
    
    
    
    
    func newRound()
    {
        randomArrayForRound = makeRandomArray(sizeOfArray: 4)
        while(!noRepeatingRandoms(array: randomArrayForRound))
        {
            randomArrayForRound = makeRandomArray(sizeOfArray: 4)
        }
    }
    
    
    
    func roundEnd() -> Bool
    {
        if(checkOrder())
        {
        score += 1
    
            return true
            
        }
        else
        {return false}
    }
    
    func checkOrder() -> Bool
    {
        let count = 0
        var correct = false
        
        if(gameEvents.listOfEvents[randomArrayForRound[count]].eventYear <= gameEvents.listOfEvents[randomArrayForRound[count+1]].eventYear && gameEvents.listOfEvents[randomArrayForRound[count+1]].eventYear <= gameEvents.listOfEvents[randomArrayForRound[count+2]].eventYear) && gameEvents.listOfEvents[randomArrayForRound[count+2]].eventYear <= gameEvents.listOfEvents[randomArrayForRound[count+3]].eventYear
        {
            correct = true
        }
        return correct
    }
    
    
    func noRepeatingRandoms(array: [Int]) -> Bool
    {
        var index = 0
        
        while(index < array.count )
        {
            var temp = index + 1
            while(temp < array.count)
            {
                if(array[index] == array[temp])
                {
                    return false
                }
                temp += 1
            }
            
            index += 1
            
        }
        return true
    }
    
    
    
    func makeRandomArray(sizeOfArray: Int) -> [Int]
    {
        var randomArray: [Int] = [GKRandomSource.sharedRandom().nextInt(upperBound: gameEvents.listOfEvents.count)]
        var temp = 1
        
        while(temp < sizeOfArray)
        {
            randomArray.append(GKRandomSource.sharedRandom().nextInt(upperBound: gameEvents.listOfEvents.count))
            temp += 1
        }
        return randomArray
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}




















































