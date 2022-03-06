//
//  ViewController.swift
//  DestinationList
//
//  Created by Erik Nascimento on 05/03/2022.
//

import UIKit

class ViewController: UIViewController {
    private var lastShowCell: Bool = false
    private var toTop: Bool = false
    private var currentOffset: CGFloat = 0.0
    private var viewModel: DestinationViewModelProtocol
    private lazy var tableview: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PlaceTableViewCell.self, forCellReuseIdentifier: "Cell")
        table.delegate = self
        table.dataSource = viewModel.datasource
        table.separatorStyle = .none
        table.rowHeight = 250
        return table
    }()
    
    init(viewModel: DestinationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
        configure()
    }

}

private extension ViewController {
    func configure() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "My Trips"
        addViews()
    }
    
    func addViews() {
        view.addSubview(tableview)
        makeConstraints()
    }
    
    func makeConstraints() {
        tableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !tableView.isDragging {
            cell.contentView.layer.opacity = 0
            cell.contentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                cell.contentView.layer.opacity = 1
                cell.contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
            return
        }
        if toTop {
            cell.contentView.transform = CGAffineTransform(translationX: 0, y: 80)
        } else {
            cell.contentView.transform = CGAffineTransform(translationX: 0, y: -80)
        }
                
        UIView.animate(withDuration: 1,
                       delay: 0.05,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.1,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: { cell.contentView.transform = CGAffineTransform(translationX: 0, y: 0) },
                       completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.4,
                            delay: 0,
                            usingSpringWithDamping: 0.8,
                            initialSpringVelocity: 1,
                            options: [.curveEaseInOut],
                            animations: { cell?.transform = CGAffineTransform.identity.scaledBy(x: 0.90, y: 0.90) },
                            completion: {_ in
                                        cell?.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                            })
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        currentOffset = scrollView.contentOffset.y
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newOffset = scrollView.contentOffset.y
        toTop = newOffset > currentOffset
        currentOffset = newOffset
    }
}
