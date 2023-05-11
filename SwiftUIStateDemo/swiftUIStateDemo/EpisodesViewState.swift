//
//  EpisodesViewState.swift
//  swiftUIStateDemo
//
//  Created by fan.qile on 2023/5/8.
//

import SwiftUI

struct EpisodesViewState: View {
    @StateObject var player: PodcastPlayer = PodcastPlayer()
    
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
        }
    }
}

struct EpisodesViewState_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesViewState()
    }
}
