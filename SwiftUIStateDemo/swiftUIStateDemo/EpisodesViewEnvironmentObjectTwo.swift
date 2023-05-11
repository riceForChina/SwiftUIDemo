//
//  EpisodesViewEnvironmentObjectTwo.swift
//  swiftUIStateDemo
//
//  Created by fan.qile on 2023/4/27.
//

import SwiftUI

struct EpisodesViewEnvironmentObjectTwo: View {
    
    @EnvironmentObject var player: PodcastPlayer
    
    var body: some View {
        Button {
            if self.player.isPlaying {
                self.player.pause()
            } else {
                self.player.play()
            }
        } label: {
            Text(player.isPlaying ? "Pause2": "Play2")
        }
    }
}

struct EpisodesViewEnvironmentObjectTwo_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesViewEnvironmentObjectTwo()
    }
}
