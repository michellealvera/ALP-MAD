//
//  MusicPlayer.swift
//  Pomodoro
//
//  Created by Rama Adi Nugraha on 01/06/23.
//

import SwiftUI
import AVKit

struct MusicPlayerView: View {
    @StateObject private var vm = ViewModel()
    
    
    var body: some View {
        VStack(spacing:0) {
            ProgressView(value: vm.progress, total: 100)
                .padding(.horizontal, -1)
                .progressViewStyle(.linear)
            HStack(spacing: 10) {
                Image(vm.currentMusic.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 64)
                    .cornerRadius(5)
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: vm.forwards ? .trailing : .leading),
                            removal: .move(edge: vm.forwards ? .leading : .trailing)
                        )
                        .combined(with: .opacity)
                    )
                    .id(vm.currentMusic.id)
                
                
                VStack(alignment: .leading) {
                    Text(vm.currentMusic.name)
                        .font(.headline)
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: vm.forwards ? .trailing : .leading),
                                removal: .move(edge: vm.forwards ? .leading : .trailing)
                            )
                            .combined(with: .opacity)
                        )
                        .id(vm.currentMusic.id)
                    Text(vm.currentMusic.artist)
                        .font(.subheadline)
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: vm.forwards ? .trailing : .leading),
                                removal: .move(edge: vm.forwards ? .leading : .trailing)
                            )
                            .combined(with: .opacity)
                        )
                        .id(vm.currentMusic.id)
                }
                
                Spacer()
                
                HStack(spacing: 20) {
                    Image(systemName: SymbolHelper().backward)
                        .onTapGesture(count: 2) {
                            vm.prevSong()
                        }
                        .onTapGesture(count: 1) {
                            vm.resetToStartPlayback()
                        }
                    
                    
                    
                    Button(action: {
                        vm.togglePlayback()
                        
                    }) {
                        Image(
                            systemName:
                                vm.isPlaying
                            ?SymbolHelper().pause
                            :SymbolHelper().play
                        )
                    }
                    
                    Button(action: {
                        vm.nextSong()
                        
                    }) {
                        Image(systemName: SymbolHelper().forward)
                    }
                    
                    
                }
                .foregroundColor(Color("Grayscale Ash"))
            }
            .padding()
            .background(Color("Grayscale Input"))
            .frame(maxWidth: .infinity)
            .onAppear {
                vm.initMusic()
            }
            .onDisappear {
                vm.dissapear()
            }
        }
        
    }
    
    
}


struct MusicPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            MusicPlayerView()
        }
        
    }
}
