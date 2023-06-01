//
//  Music.swift
//  Pomodoro
//
//  Created by Rama Adi Nugraha on 01/06/23.
//

import Foundation

struct Music: Identifiable {
    
    var id = UUID()
    var name: String
    var artist: String
    var image: String
    var audio: String
    
    // MARK: -  Available musics in the app
    static let availableMusics = [
        Music(
            name: "Mystique as iris",
            artist: "かねこちはる",
            image: "img-music-mystique",
            audio: "music-mystique"
        ),
        
        Music(
            name: "\"411Ψ892\"",
            artist: "Tanchiky",
            image: "img-music-411Ψ892",
            audio: "music-411Ψ892")
    ]
}
