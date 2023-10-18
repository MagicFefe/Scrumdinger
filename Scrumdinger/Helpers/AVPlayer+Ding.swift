//
//  AVPlayer+Ding.swift
//  Scrumdinger
//
//  Created by Данил Шипицын on 17.10.2023.
//

import Foundation
import AVFoundation

extension AVPlayer {
    static let sharedDingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
}
