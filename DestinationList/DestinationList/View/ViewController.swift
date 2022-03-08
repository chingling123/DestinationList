//
//  ViewController.swift
//  DestinationList
//
//  Created by Erik Nascimento on 05/03/2022.
//

import UIKit

class ViewController: UIViewController {
    private let coordinator: DestinationsCoordinator?
    private var lastShowCell: Bool = false
    private var toTop: Bool = false
    private var currentOffset: CGFloat = 0.0
    private var viewModel: DestinationViewModelProtocol
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PlaceTableViewCell.self, forCellReuseIdentifier: "Cell")
        table.delegate = self
        table.dataSource = viewModel.dataSource
        table.separatorStyle = .none
        table.rowHeight = 250
        return table
    }()
    
    init(viewModel: DestinationViewModelProtocol, coordinator: DestinationsCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
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
        navigationController?.delegate = self
        title = "My Trips"
        addViews()
    }
    
    func addViews() {
        view.addSubview(tableView)
        makeConstraints()
    }
    
    func makeConstraints() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
        guard let hasPlace = viewModel.dataSource?.destinations?[indexPath.row] else { return }
        viewModel.indexPath = indexPath
        coordinator?.goDetails(place: hasPlace)
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

extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return Animation(duration: 0.8, type: .present)
        case .pop:
            return Animation(duration: 0.8, type: .dismiss)
        default:
            return nil
        }
    }
}

extension ViewController: PlaceTransitionProtocol {
    var backgroundView: UIImageView {
        guard let indexPath = viewModel.indexPath, let cell = tableView.cellForRow(at: indexPath) as? PlaceTableViewCell else { return UIImageView() }
        return cell.bkgImage
    }
}
