import UIKit

extension UIView {
    func scaleAnimation(duration: TimeInterval, completion: @escaping() -> Void) {
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: {
            // Scale the view down
            self.transform = self.transform.scaledBy(x: 0.6, y: 0.6)
        }, completion: { [weak self] finished in
            guard let strongSelf = self else { return }
            // Scale the view to original size
            UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: {
                strongSelf.transform = CGAffineTransform.identity
            }, completion: { [weak self] finished in
                guard let strongSelf = self else { return }
                // Notify that animation is done
                if finished && strongSelf.transform == CGAffineTransform.identity {
                    completion()
                }
            })
        })
    }
    
    func rotateAnimation(duration: TimeInterval, completion: @escaping() -> Void) {
        UIView.animate(withDuration: duration , delay: 0.0, options: [.curveEaseInOut], animations: {
            // Rotate the view
            self.transform = self.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { [weak self] finished in
            guard let strongSelf = self else { return }
            // Rotate to original
            UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
                strongSelf.transform = CGAffineTransform.identity
            }, completion: { [weak self] finished in
                guard let strongSelf = self else { return }
                // Notify that animation is done
                if finished && strongSelf.transform == CGAffineTransform.identity {
                    completion()
                }
            })
        })
    }
}
