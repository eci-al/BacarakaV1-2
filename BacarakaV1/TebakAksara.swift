//
//  TebakAksara.swift
//  BacarakaV1
//
//  Created by Eci AL on 29/10/20.
//

import UIKit

class TebakAksara: UIViewController {
    
    @IBOutlet weak var KartuAksara: UIImageView!
    @IBOutlet weak var KosongBenar: UIImageView!
    @IBOutlet weak var KosongSalah: UIImageView!
    @IBOutlet weak var BenarHa: UIImageView!
    @IBOutlet weak var SuaraBenar: UIButton!
    @IBOutlet weak var SuaraSalah: UIButton!
        
    //tempat asal kartu aksara
    var fileViewOrigin:CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        addPanGesture(view: KartuAksara)
        fileViewOrigin = KartuAksara.frame.origin
        view.bringSubviewToFront(KartuAksara)
    }
    
    func addPanGesture(view:UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector (self.handlePan))
        view.addGestureRecognizer(pan)
    }
    
    //Refactor
//    @objc func handlePan(sender: UIPanGestureRecognizer) {
//
//        let fileView = sender.view!
//        //translation >>  the movement of your finger
//        let translation = sender.translation(in: self.view)
//
//
//        switch sender.state {
//
//        case .began, .changed:
//            fileView.center = CGPoint (x: fileView.center.x + translation.x, y: fileView.center.y + translation.y)
//            sender.setTranslation(CGPoint.zero, in: view)
//
//        case .ended:
//            if fileView.frame.intersects(KosongBenar.frame) {
////                flipCorrect()
////                UIView.animate(withDuration: 0.3, animations: {
////                    self.KartuAksara.alpha = 0.0
////                })
//                print("it's intersected")
//            } else {
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.KartuAksara.frame.origin = self.fileViewOrigin
//                })
//            }
//
//        default:
//            break
//        }
//
//    }
    
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        
        if gesture.state == .changed {
            let translation = gesture.translation(in: self.view)
            KartuAksara.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
            
        }
        
        else if gesture.state == .ended {
            if KartuAksara.frame.intersects(KosongBenar.frame) {
                print("it's intersected")
//
            } else {
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.KartuAksara.transform = .identity
                }, completion: nil)
            
            }
        }
        
    }
//
//    func flipCorrect(speed:TimeInterval = 0.3) {
//        UIView.transition(from: self.view, to: BenarHa, duration: speed, options: [.transitionFlipFromLeft], completion: nil)
//    }
//
 
}
