//
//  EpisodesViewEnvironmentObject.swift
//  swiftUIStateDemo
//
//  Created by fan.qile on 2023/4/27.
//

import SwiftUI

struct EpisodesViewEnvironmentObject: View {
    @EnvironmentObject var player: PodcastPlayer
    
    var body: some View {
        List {
            Button(
                action: {
                    if self.player.isPlaying {
                        self.player.pause()
                    } else {
                        self.player.play()
                    }
            }, label: {
                    Text(player.isPlaying ? "Pause": "Play")
                }
            )
            EpisodesViewEnvironmentObjectTwo()
        }
    }
}

struct EpisodesViewEnvironmentObject_Previews: PreviewProvider {
    static var previews: some View {
        let player = PodcastPlayer()
        return EpisodesViewEnvironmentObject()
            .environmentObject(player)
    }
}
