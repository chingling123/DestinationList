//
//  DetailViewController.swift
//  DestinationList
//
//  Created by Erik Nascimento on 07/03/2022.
//

import UIKit

class DetailViewController: UIViewController {
    private var place: PlaceModel
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
        img.contentMode = .scaleAspectFill
        return img
    }()
    private lazy var iconImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "globe.europe.africa")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return img
    }()
    private lazy var descView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.alpha = 0.0
        return view
    }()
    private lazy var descTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica Bold", size: 24)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Information:"
        return label
    }()
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 12)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private lazy var closeIcon = UIImage(systemName: "xmark.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
    private lazy var placeViewInfo: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.alpha = 0.0
        return view
    }()
    private lazy var animator = {
        UIViewPropertyAnimator(duration: 0.6, curve: .easeInOut) {
            self.bkgImage.alpha = 0.8
            self.placeViewInfo.alpha = 1.0
            self.descView.alpha = 1.0
        }
    }()
    
    init(viewModel: PlaceModel) {
        self.place = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animator.startAnimation()
    }
}

private extension DetailViewController {
    func configure() {
        view.backgroundColor = .black
        navBar()
        self.bkgImage.image = UIImage(named: place.image)
        self.titleLabel.text = place.place
        self.dateLabel.text = place.date.formatted()
        self.descLabel.text = place.description
        addViews()
    }
    
    func navBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: closeIcon,
            style: .plain,
            target: self,
            action: #selector(backNavigation)
        )
        navigationItem.hidesBackButton = true
    }
    
    func addViews() {
        view.addSubview(bkgImage)
        view.addSubview(placeViewInfo)
        placeViewInfo.addSubview(titleLabel)
        placeViewInfo.addSubview(dateLabel)
        placeViewInfo.addSubview(iconImage)
        view.addSubview(descView)
        descView.addSubview(descTitleLabel)
        descView.addSubview(descLabel)
        makeConstraints()
    }
    
    func makeConstraints() {
        bkgImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bkgImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bkgImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bkgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        placeViewInfo.bottomAnchor.constraint(equalTo: descView.topAnchor, constant: -20).isActive = true
        placeViewInfo.leftAnchor.constraint(equalTo: bkgImage.leftAnchor, constant: 20).isActive = true
        placeViewInfo.rightAnchor.constraint(equalTo: bkgImage.rightAnchor, constant: -20).isActive = true
        placeViewInfo.topAnchor.constraint(equalTo: iconImage.topAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: placeViewInfo.bottomAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: placeViewInfo.leftAnchor).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: placeViewInfo.rightAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: dateLabel.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: dateLabel.rightAnchor).isActive = true
        iconImage.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        iconImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -15).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        descView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
        descView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        descView.heightAnchor.constraint(equalToConstant: view.frame.height / 2).isActive = true
        descTitleLabel.topAnchor.constraint(equalTo: descView.topAnchor, constant: 20).isActive = true
        descTitleLabel.leftAnchor.constraint(equalTo: descView.leftAnchor, constant: 20).isActive = true
        descTitleLabel.rightAnchor.constraint(equalTo: descView.rightAnchor, constant: -20).isActive = true
        descLabel.leftAnchor.constraint(equalTo: descView.leftAnchor, constant: 20).isActive = true
        descLabel.rightAnchor.constraint(equalTo: descView.rightAnchor, constant: -20).isActive = true
        descLabel.topAnchor.constraint(equalTo: descTitleLabel.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc func backNavigation() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: PlaceTransitionProtocol {
    var backgroundView: UIImageView {
        return bkgImage
    }
}
