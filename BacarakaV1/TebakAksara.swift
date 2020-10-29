//
//  TebakAksara.swift
//  BacarakaV1
//
//  Created by Eci AL on 29/10/20.
//

import UIKit

class TebakAksara: UIViewController {
    
    @IBOutlet weak var KartuAksara: UIImageView!
    @IBOutlet weak var suaraAksaraBenar: UIImageView!
    @IBOutlet weak var suaraAksaraSalah: UIImageView!
    
    var fileViewOrigin:CGPoint!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPanGesture(view: KartuAksara)
        fileViewOrigin = KartuAksara.frame.origin
    }
    func addPanGesture(view:UIView) {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector (TebakAksara.handlePan(sender:)))
        view.addGestureRecognizer(pan)
        
    }
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let fileView = sender.view!
        let translation = sender.translation(in: view)
        
        
        switch sender.state {
        case .began, .changed:
            fileView.center = CGPoint (x: fileView.center.x + translation.x, y: fileView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
                
    
        case .ended:
            break
            
        default:
            break
        }
        
    }
    

}
