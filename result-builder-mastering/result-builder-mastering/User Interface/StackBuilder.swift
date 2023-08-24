//
//  StackBuilder.swift
//  result-builder-mastering
//
//  Created by taekki on 2023/08/24.
//

// https://medium.com/bootcampers/swift-result-builder-building-declarative-stackview-320f588fa47b

import UIKit

@resultBuilder
enum StackBuilder {
  static func buildBlock(_ views: UIView...) -> [UIView] {
    return views
  }
}

protocol StackModifier {
  associatedtype Stack: UIStackView
  
  func setAlignment(_ alignment: UIStackView.Alignment) -> Stack
  func setDistribution(_ distribution: UIStackView.Distribution) -> Stack
  func setSpacing(_ spacing: CGFloat) -> Stack
}

final class VStack: UIStackView {
  // 생성자에서 builder 사용 가능(많이 활용하는 형태)
  init(@StackBuilder views: () -> [UIView]) {
    super.init(frame: .zero)
    
    translatesAutoresizingMaskIntoConstraints = false
    axis = .vertical
    views().forEach(addArrangedSubview)
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
  }
}

extension VStack: StackModifier {
  func setAlignment(_ alignment: UIStackView.Alignment) -> VStack {
    self.alignment = alignment
    return self
  }
  
  func setDistribution(_ distribution: UIStackView.Distribution) -> VStack {
    self.distribution = distribution
    return self
  }
  
  func setSpacing(_ spacing: CGFloat) -> VStack {
    self.spacing = spacing
    return self
  }
}

final class HStack: UIStackView {
  init(@StackBuilder views: () -> [UIView]) {
    super.init(frame: .zero)
    axis = .horizontal
    translatesAutoresizingMaskIntoConstraints = false
    views().forEach(addArrangedSubview)
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
  }
}

extension HStack: StackModifier {
  func setAlignment(_ alignment: UIStackView.Alignment) -> HStack {
    self.alignment = alignment
    return self
  }
  
  func setDistribution(_ distribution: UIStackView.Distribution) -> HStack {
    self.distribution = distribution
    return self
  }
  
  func setSpacing(_ spacing: CGFloat) -> HStack {
    self.spacing = spacing
    return self
  }
}

final class RootView: UIView {
  init(@StackBuilder views: () -> [UIView]) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    views().forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}
