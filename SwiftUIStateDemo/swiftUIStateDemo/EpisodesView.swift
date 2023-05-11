//
//  EpisodesView.swift
//  swiftUIStateDemo
//
//  Created by fan.qile on 2023/4/27.
//

import SwiftUI

final class PodcastPlayer: ObservableObject {
    @Published private(set) var isPlaying: Bool = false

    func play() {
        isPlaying = true
    }

    func pause() {
        isPlaying = false
    }
}

struct EpisodesView: View {
    @ObservedObject var player: PodcastPlayer
    
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

struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        let player = PodcastPlayer()
        EpisodesView(player: player)
    }
}
