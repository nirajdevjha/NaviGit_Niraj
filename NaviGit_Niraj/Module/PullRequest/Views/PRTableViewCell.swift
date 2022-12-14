//
//  PRTableViewCell.swift
//  NaviGit_Niraj
//
//  Created by Niraj Jha on 09/10/22.
//

import UIKit

final class PRTableViewCell: BaseTableViewCell {

    private let contentStackView: UIStackView = {
        let stackView = UIStackView().disableAutoResize()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private let userStackView: UIStackView = {
        let stackView = UIStackView().disableAutoResize()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()

    private let dateStackView: UIStackView = {
        let stackView = UIStackView().disableAutoResize()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel().disableAutoResize()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel().disableAutoResize()
        label.textColor = .darkGrayTxtColor
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let createdDateLabel: UILabel = {
        let label = UILabel().disableAutoResize()
        label.textColor = .mediumGrayTxtColor
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    private let closedDateLabel: UILabel = {
        let label = UILabel().disableAutoResize()
        label.textColor = .mediumGrayTxtColor
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    private let avtarImageView: UIImageView = {
        let imageView = UIImageView().disableAutoResize()
        return imageView
    }()

    static var reuseIdentifier : String {
        return String(describing: self)
    }

    override func initialSetup() {
        super.initialSetup()
        selectionStyle = .none
        contentView.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            avtarImageView.widthAnchor.constraint(equalToConstant: 40),
            avtarImageView.heightAnchor.constraint(equalToConstant: 40),
        ])

        contentStackView.addArrangedSubviews(
            titleLabel,
            userStackView,
            dateStackView
        )
        userStackView.addArrangedSubviews(
            avtarImageView,
            userNameLabel
        )
        dateStackView.addArrangedSubviews(
            createdDateLabel,
            closedDateLabel
        )
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avtarImageView.cornerRadius = avtarImageView.frame.size.height / 2
    }

    func configure(from model: PRListCellViewModel) {
        userNameLabel.text = model.userName
        createdDateLabel.text = model.createdDate
        closedDateLabel.text = model.closedDate
        titleLabel.text = model.title
        if let avtarUrl = model.avtarUrl {
            avtarImageView.load(url: avtarUrl, placeholder: UIImage(named: "avatar_placeholder"))
        }
    }
}
