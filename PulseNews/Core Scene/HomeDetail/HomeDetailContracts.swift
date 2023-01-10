//
//  HomeDetailContracts.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/5/23.
//

import Foundation

enum HomeDetailOutput {
    case load(NewsPresentation)
    case showMorePage(url: String)
    case isSaved(Bool)
}
