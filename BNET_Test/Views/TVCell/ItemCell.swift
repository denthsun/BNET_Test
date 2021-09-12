//
//  TableViewCell.swift
//  BNET_Test
//
//  Created by Denis Velikanov on 06.09.2021.
//

import UIKit

final class ItemCell: UITableViewCell {
    
    static let identifier = "ItemCell"
    
    let dateLabel = UILabel()
    let bodyLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupUI() {
        [dateLabel, bodyLabel].forEach { contentView.addSubview($0) }
        selectionStyle = .none
        bodyLabel.numberOfLines = 0
        dateLabel.font = UIFont.italicSystemFont(ofSize: 20)
    }
    
    private func constraintUI() {
        dateLabel.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, leading: contentView.safeAreaLayoutGuide.leadingAnchor, bottom: bodyLabel.safeAreaLayoutGuide.topAnchor, trailing: contentView.safeAreaLayoutGuide.trailingAnchor)
        bodyLabel.anchor(top: dateLabel.safeAreaLayoutGuide.bottomAnchor, leading: contentView.safeAreaLayoutGuide.leadingAnchor, bottom: contentView.safeAreaLayoutGuide.bottomAnchor, trailing: contentView.safeAreaLayoutGuide.trailingAnchor)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        constraintUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
