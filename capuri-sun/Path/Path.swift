//
//  Path.swift
//  capuri-sun
//
//  Created by 조세연 on 7/21/24.
//

import Foundation

enum OnboardingPath: Hashable {
    case pukaSunView
    case alarmView
}

enum Path: Hashable {
    case alarmView
    case uvView
    case suncreamView
}

@Observable
final class PathModel {
    var paths: [Path] = []
    var onboardingPaths: [OnboardingPath] = []
}
