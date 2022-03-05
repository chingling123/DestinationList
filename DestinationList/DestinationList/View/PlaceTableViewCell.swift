//
//  PlaceTableViewCell.swift
//  DestinationList
//
//  Created by Erik Nascimento on 05/03/2022.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica Bold", size: 24)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 12)
        label.textColor = .white
        return label
    }()
    private lazy var bkgImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private lazy var iconImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "globe.europe.africa")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return img
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(data: PlaceModel) {
        titleLabel.text = data.place
        dateLabel.text = data.date.formatted()
        bkgImage.image = UIImage(named: data.image)
        bkgImage.layer.cornerRadius = 10
        bkgImage.layer.masksToBounds = true
        bkgImage.contentMode = .scaleAspectFill
        addViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }

}

private extension PlaceTableViewCell {
    func addViews() {
        contentView.addSubview(bkgImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(iconImage)
        makeConstraints()
    }
    
    func makeConstraints() {
        bkgImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        bkgImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        bkgImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        bkgImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: bkgImage.bottomAnchor, constant: -20).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: bkgImage.leftAnchor, constant: 20).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: bkgImage.rightAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: dateLabel.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: dateLabel.rightAnchor).isActive = true
        iconImage.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        iconImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -15).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
