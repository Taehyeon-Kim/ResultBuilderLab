//
//  SettingOptionBuilder.swift
//  result-builder-mastering
//
//  Created by taekki on 2023/08/24.
//

import Foundation

protocol Settings {}

struct SettingOption {
  let title: String
  let description: String
}

@resultBuilder
struct SettingBuilder {
  static func buildBlock(_ components: SettingOption...) -> [SettingOption] {
    return components
  }
  
  static func buildBlock(_ component: SettingOption) -> [SettingOption] {
    return [component]
  }
}

extension SettingOption {
  static func make(@SettingBuilder _ contents: () -> [SettingOption]) -> [SettingOption] {
    contents()
  }
}
