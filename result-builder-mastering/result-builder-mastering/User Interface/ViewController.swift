//
//  ViewController.swift
//  result-builder-mastering
//
//  Created by taekki on 2023/08/24.
//

import UIKit

final class ViewController: UIViewController {
  private let redView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    return view
  }()
  
  private let blueView: UIView = {
    let view = UIView()
    view.backgroundColor = .blue
    return view
  }()
  
  private let greenView: UIView = {
    let view = UIView()
    view.backgroundColor = .green
    return view
  }()
  
  private let yellowView: UIView = {
    let view = UIView()
    view.backgroundColor = .yellow
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    let vStack = VStack {
      redView
    
      HStack {
        blueView
        greenView
      }
      .setAlignment(.fill)
      .setDistribution(.fillEqually)
      .setSpacing(10)
    
      yellowView
    }
    .setAlignment(.fill)
    .setDistribution(.fillEqually)
    .setSpacing(10)
    
    view.addSubview(vStack)
    NSLayoutConstraint.activate([
      vStack.topAnchor.constraint(equalTo: view.topAnchor),
      vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      vStack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}
