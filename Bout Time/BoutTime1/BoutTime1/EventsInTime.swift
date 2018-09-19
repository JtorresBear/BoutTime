//
//  EventsInTime.swift
//  BoutTime1
//
//  Created by Juan Torres on 9/18/18.
//  Copyright © 2018 Juan Torres. All rights reserved.
//

import Foundation


struct Events {
    var event: String
    var eventYear: Int
}

var historicalEvent : [String] =
    ["Emeinems First Album was Released",
     "8 Mile was released in theaters",
     "Nas Destroyed Jay-Z with the song Either",
     "Michael Jackson Was Born",
     "Michael Jackson Died",
     "Queen Released the song 'Bohemien Rhapsody'",
     "Yellow Submarine by the beatles Debuted",
     "Taylor swift tried to trademark 'This Sick Beat'",
     "Beyonce Played at the Superbowl",
     "The walmart Yodel Kid yodels in walmart",
     "Tupac died",
     "Eazy E died",
     "Biggie died",
     "Biggies Song 'Juicy' was release",
     "Beethoven Died",
     "Bethoven went Completely Deaf",
     "Elvis was Born",
     "The Song Beat it was Released",
     "Johnny Cash Died",
     "Jonny Cash was born",
     "Rihanna was Born",
     "Song Umbrella by Rihanna was released",
     "Beyonce was born",
     "Jay-Z was Born",
     "The Song Big Pimpin was released",
     "Ice T was Born",
     "Cop Killer by Ice T was released",
     "Song 'No Vaseline' by Ice Cube came out",
     "Ice Cube Leaves NWA",
     "Shakira was Born",
     "Shakira first Debut",
     "Shakira released the song 'Loca'"]

var yearOfEvent : [Int] = [1996,
                           2002,
                           2001,
                           1958,
                           2009,
                           1975,
                           1966,
                           2014,
                           2014,
                           2018,
                           1996,
                           1995,
                           1997,
                           1994,
                           1827,
                           1816,
                           1935,
                           1982,
                           2003,
                           1932,
                           1988,
                           2007,
                           1981,
                           1969,
                           1999,
                           1958,
                           1992,
                           1991,
                           1989,
                           1977,
                           1991,
                           2010]




class GameEvents
{
    
    
    var listOfEvents: [Events] = []
    
    init() {
        listOfEvents = createListOfEvents(with: historicalEvent, atThe: yearOfEvent)
    }
    
    
    
    // creates an array of events.
    func createListOfEvents(with historicalEvent: [String], atThe Time: [Int]) -> [Events]
    {
        let max = historicalEvent.count
        var count = 0
        var events: [Events] = []
        while(count < max )
        {
            events.append(Events.init(event: historicalEvent[count], eventYear: Time[count]))
            count += 1
        }
        return events
    }
}


















































