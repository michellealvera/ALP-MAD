//
//  MusicPlayerViewModel.swift
//  Pomodoro
//
//  Created by Rama Adi Nugraha on 01/06/23.
//

import SwiftUI
import AVKit
import Combine


extension MusicPlayerView {
    class ViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
        
        private var displayLink: CADisplayLink?
        
        // MARK: Combine
        private var cancellables: Set<AnyCancellable> = []
        
        @Published var isPlaying = false
        @Published var audioPlayer: AVAudioPlayer!
        @Published var progress = 0.0
        @Published var currentMusic: Music = Music.availableMusics[0]
        @Published var forwards = false
        
        // MARK: track the music indexes so that there's no repeating music played
        @Published var playedMusic: [UUID] = []
        
        func initMusic() -> Void {
            
            
            // Load the audio bundle
            self.loadBundle()
            
            // Remove the current played music from the queue
            playedMusic.append(currentMusic.id)
            
            // DisplayLink is used to synchronize the progressbar
            // with the screen refresh rate.
            // Alternative: we can just use a timer for ease.
            // But where's the fun in that?
            displayLink = CADisplayLink(target: self, selector: #selector(updateProgress))
            displayLink?.add(to: .current, forMode: .default)
            displayLink?.isPaused = true
            
            // Observe the isPlaying property to start
            // or pause the display link accordingly using Combine
            $isPlaying.sink { [weak self] isPlaying in
                self?.displayLink?.isPaused = !isPlaying
            }.store(in: &cancellables)
            
        }
        
        // since we're using selector, we must mark this function
        // as an objc function
        @objc private func updateProgress() {
            if let audioPlayer = audioPlayer {
                progress = (audioPlayer.currentTime / audioPlayer.duration) * 100
            }
        }
        
        
        // invalidate everything when deinitializing
        deinit {
            displayLink?.invalidate()
        }
        
        
        // Removes everything if the user switched view
        func dissapear() -> Void {
            audioPlayer.stop()
            displayLink?.isPaused = true
            isPlaying = false
            progress = 0.0
            currentMusic = Music.availableMusics[0]
            forwards = false
            playedMusic = []
        }
        
        
        // a helper function to load the bundle
        // and assign the delegate to this viewModel
        func loadBundle() -> Void {
            
            let sound = Bundle.main.path(
                forResource: currentMusic.audio,
                ofType: "mp3"
            )
            
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.delegate = self // delegates the sound player to the current viewModel
        }
        
        
        
        // Delegate to detect if the song is finished
        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            print("Music is finished, playing another song...")
            
            // Check if all song has already been played
            if Music.availableMusics.count == playedMusic.count {
                print("Playlist is exhausted. playing all the song from again!")
                playedMusic = []
            } else {
                print("There's still music on the playlist, selecting a random music!")
            }
            
            playRandomSong()
            
        }
        
        // function to seek playback to the start
        func resetToStartPlayback() -> Void {
            withAnimation(.easeOut) {
                if self.isPlaying {
                    self.displayLink!.isPaused = true
                    self.audioPlayer.pause()
                }
                
                self.audioPlayer.currentTime = 0
                self.progress = 0.0
                
                if self.isPlaying {
                    self.displayLink!.isPaused = false
                    self.audioPlayer.play()
                }
                
            }
        }
        
        // function to toggle playback
        func togglePlayback() {
            withAnimation(.easeInOut(duration: 0.2)) {
                if !self.isPlaying {
                    self.audioPlayer.play()
                    self.isPlaying = true
                } else {
                    self.audioPlayer.pause()
                    self.isPlaying = false
                }
            }
        }
        
        // Function to go to the previous song
        func prevSong() {
            
            guard playedMusic.count > 1 else {
                print("This is the first song in the queue. Can't go back further.")
                return
            }
            
            // Remove current song
            playedMusic.removeLast()
            
            // Get the last played song from the queue and set it as the current song
            if let lastPlayedSongId = playedMusic.last {
                if let lastPlayedSong = Music.availableMusics.first(where: { $0.id == lastPlayedSongId }) {
                    forwards = false
                    play(music: lastPlayedSong)
                }
            }
        }
        
        func playRandomSong() -> Void {
            // Holds all of the unplayed songs temporarily
            var unplayedMusic: [Music] = []
            
            // Get every unplayed song from the main playlist
            // and append them to the unplayed music list
            Music.availableMusics.forEach { music in
                if !playedMusic.contains(music.id) {
                    unplayedMusic.append(music)
                }
            }
            
            forwards = true
            let selectedMusic = unplayedMusic.randomElement()!
            self.playedMusic.append(selectedMusic.id)
            play(music: selectedMusic)
        }
        
        // Function to go to the next song
        func nextSong() {
            
            // Checking if all songs have been played
            if Music.availableMusics.count == playedMusic.count {
                print("Playlist is exhausted. Playing all the songs from the start!")
                playedMusic = []
            }
            
            playRandomSong()
            
        }
        
        // Play the music
        func play(music: Music) -> Void{
            withAnimation {
                currentMusic = music
                loadBundle()
                progress = 0.0
                self.audioPlayer.play()
                self.isPlaying = true
            }
        }
    }
}

