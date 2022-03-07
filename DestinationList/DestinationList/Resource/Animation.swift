//
//  Animation.swift
//  DestinationList
//
//  Created by Erik Nascimento on 07/03/2022.
//

import UIKit

enum AnimationType {
    case present
    case dismiss
}

class Animation: NSObject {
    private let duration: Double
    private let type: AnimationType

    init(duration: Double, type: AnimationType) {
        self.duration = duration
        self.type = type
    }
}

extension Animation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: duration) ?? 0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from)
        else {
            transitionContext.completeTransition(false)
            return
        }

        switch type {
        case .present:
            presentAnimation(
                transitionContext: transitionContext,
                fromView: fromViewController,
                toView: toViewController
            )
        case .dismiss:
            dismissAnimation(
                transitionContext: transitionContext,
                fromView: fromViewController,
                toView: toViewController
            )
        }
    }
}

private extension Animation {
    func presentAnimation(transitionContext: UIViewControllerContextTransitioning,
                          fromView: UIViewController,
                          toView: UIViewController) {

        let containerView = transitionContext.containerView
        guard let fromTripList = fromView as? ViewController else { return }
        guard let toDetailTrip = toView as? DetailViewController else { return }
        let backgroundView = UIImageView()
        let backgroundFrame = containerView.convert(
            fromTripList.backgroundView.frame,
            from: fromTripList.backgroundView.superview
        )
        backgroundView.frame = backgroundFrame
        backgroundView.image = fromTripList.backgroundView.image
        backgroundView.layer.cornerRadius = fromTripList.backgroundView.layer.cornerRadius
        backgroundView.layer.masksToBounds = fromTripList.backgroundView.layer.masksToBounds
        backgroundView.contentMode = .scaleAspectFill
        containerView.addSubview(fromTripList.view)
        containerView.addSubview(toDetailTrip.view)
        containerView.addSubview(backgroundView)
        fromTripList.view.isHidden = false
        toDetailTrip.view.isHidden = true
        let frameAnim = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let animator = {
            UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
                backgroundView.frame = frameAnim
                fromTripList.tableView.alpha = 0.0
            }
        }()
        animator.addCompletion { _ in
            fromTripList.tableView.alpha = 1.0
            toDetailTrip.view.isHidden = false
            backgroundView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        animator.startAnimation()
    }
}

private extension Animation {
    func dismissAnimation(transitionContext: UIViewControllerContextTransitioning,
                          fromView: UIViewController,
                          toView: UIViewController) {
        let containerView = transitionContext.containerView
        containerView.addSubview(toView.view)
        containerView.addSubview(fromView.view)
        let animator = {
            UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
                fromView.view.alpha = 0.0
            }
        }()
        animator.addCompletion { _ in
            transitionContext.completeTransition(true)
        }
        animator.startAnimation()
    }
}
