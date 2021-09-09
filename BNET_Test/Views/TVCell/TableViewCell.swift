//
//  TableViewCell.swift
//  BNET_Test
//
//  Created by Denis Velikanov on 06.09.2021.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    let dateLabel = UILabel()
    let bodyLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        constraintUI()
    }
    
    private func setupUI() {
        [dateLabel, bodyLabel].forEach { contentView.addSubview($0) }
        selectionStyle = .none
    }
    
    private func constraintUI() {
        dateLabel.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, leading: contentView.safeAreaLayoutGuide.leadingAnchor, bottom: bodyLabel.safeAreaLayoutGuide.topAnchor, trailing: contentView.safeAreaLayoutGuide.trailingAnchor)
        bodyLabel.anchor(top: dateLabel.safeAreaLayoutGuide.bottomAnchor, leading: contentView.safeAreaLayoutGuide.leadingAnchor, bottom: contentView.safeAreaLayoutGuide.bottomAnchor, trailing: contentView.safeAreaLayoutGuide.trailingAnchor)
    }
    
    func setDateLabel(date: String) {
        dateLabel.text = "Date: \(date)"
    }
    
    func setBodyLabel(body: String) {
        bodyLabel.text = body.maxLength(length: 200)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    
}
