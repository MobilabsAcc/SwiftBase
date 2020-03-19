//
//  LocationTableViewCell.swift
//  mvcSample
//
//  Created by Leszek Barszcz on 17/03/2020.
//  Copyright © 2020 lpb. All rights reserved.
//

import UIKit

final class LocationTableViewCell: UITableViewCell {
    private let separatorView = UIView()

    var model: SearchViewController.SearchItem! {
        didSet {
            let attributedString = NSMutableAttributedString()
            let lightAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24.0, weight: UIFont.Weight.light),
                                   NSAttributedString.Key.foregroundColor: UIColor.white]
            let mediumAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24.0, weight: UIFont.Weight.medium),
                                    NSAttributedString.Key.foregroundColor: UIColor.white]

            attributedString.append(NSAttributedString(string: model.0,
                                                       attributes: mediumAttributes))
            if !model.1.isEmpty {
                attributedString.append(NSAttributedString(string: ", ",
                                                           attributes: mediumAttributes))
                attributedString.append(NSAttributedString(string: model.1,
                                                           attributes: lightAttributes))
            }
            textLabel?.attributedText = attributedString
        }
    }
    
    var imageCell: SearchViewController.ImageItem! {
        didSet{
            let imageView = UIImageView(image: imageCell.0.associatedValue)
            imageView.tintColor = imageCell.1
            accessoryView = imageView
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setupView()
    }

    private func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        textLabel?.textColor = .white
        textLabel?.font = .systemFont(ofSize: 24.0, weight: .medium)

        separatorView.backgroundColor = .white
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separatorView)
        separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23.0).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 28.0).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
