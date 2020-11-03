//
//  TebakAksara.swift
//  BacarakaV1
//
//  Created by Eci AL on 29/10/20.
//

import UIKit
import AVFoundation

class TebakAksara: UIViewController {
    
//        var player: AVAudioPlayer?
    var suaraBenar = AVAudioPlayer()
    var suaraSalah = AVAudioPlayer()
    
    @IBOutlet weak var KartuAksara: UIImageView!
    @IBOutlet weak var bekasBenar: UIImageView!
    @IBOutlet weak var HaBenar: UIImageView!
    @IBOutlet weak var SpeakerBenar: UIButton!
    @IBOutlet weak var SpeakerSalah: UIButton!
    
    var KartuAksaraOrigin:CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        suara()
        
        addPanGesture(view: KartuAksara)
        KartuAksaraOrigin = KartuAksara.frame.origin
        view.bringSubviewToFront(KartuAksara)
    }
    
    @IBAction func benarDidTapped(_ sender: Any) {
        suaraBenar.play()
    }
    
    @IBAction func salahDidTapped(_ sender: Any) {
        suaraSalah.play()
    }
    
    
    func addPanGesture(view:UIView) {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector (TebakAksara.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    // Refactor
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let fileView = sender.view!
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: fileView, sender: sender)
        case .ended:
            if fileView.frame.intersects(bekasBenar.frame) {
                deleteView(view: fileView)
                showHa(view: HaBenar)
                
            } else {
                returnViewToOrigin(view: fileView)
            }
            
        default:
            break
        }
    }
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    func returnViewToOrigin(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin = self.KartuAksaraOrigin
        })
    }
    
    func deleteView(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.0
        })
    }
    
    func showHa(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            self.HaBenar.alpha = 1
        })
    }
    
    func suara() {
        do {
            suaraBenar = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "klik", ofType: "mp3")!))
        } catch {
            print (error)
        }
        do {
            suaraSalah = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "notKlik", ofType: "mp3")!))
        } catch {
            print (error)
        }
    }
    
}
