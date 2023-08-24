//
//  SettingViewController.swift
//  result-builder-mastering
//
//  Created by taekki on 2023/08/24.
//

import UIKit

final class OptionCell: UITableViewCell {
  static let identifier = "OptionCell"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .value1, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

final class SettingViewControlelr: UITableViewController {
  lazy var options = SettingOption.make {
    SettingOption(title: "공지사항", description: "🎉🎉🎉")
    SettingOption(title: "이용약관", description: "✨✨✨")
    SettingOption(title: "문의하기", description: "010-1234-5678")
    SettingOption(title: "최신버전", description: "v2.4.0")
  }
 
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(OptionCell.self, forCellReuseIdentifier: OptionCell.identifier)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    options.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.identifier)!
    let option = options[indexPath.row]
    cell.textLabel?.text = option.title
    cell.detailTextLabel?.text = option.description
    return cell
  }
}
