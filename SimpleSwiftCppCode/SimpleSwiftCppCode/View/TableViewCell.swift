//
//  TableViewCell.swift
//  SimpleSwiftCppCode
//
//  Created by riza milani on 5/31/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var itemLabel: UILabel!
    var checkMarkLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 100))
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        createItemLabel(parent: containerView)
        createCheckMarkLabel(parent: containerView)
    }

    func createItemLabel(parent: UIView) {
        itemLabel = UILabel()
        itemLabel.text = "Item"
        itemLabel.textAlignment = .left
        parent.addSubview(itemLabel)
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
        itemLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 32).isActive = true
        itemLabel.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        
    }

    func createCheckMarkLabel(parent: UIView) {
        checkMarkLabel = UILabel()
        checkMarkLabel.text = "√"
        checkMarkLabel.textAlignment = .right
        parent.addSubview(checkMarkLabel)
        checkMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        checkMarkLabel.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -32).isActive = true
        checkMarkLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
        checkMarkLabel.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        checkMarkLabel.isHidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
