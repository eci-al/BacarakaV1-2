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
    var jawabanBenar = AVAudioPlayer()
    
    @IBOutlet weak var KartuAksara: UIImageView!
    @IBOutlet weak var bekasBenar: UIImageView!
    @IBOutlet weak var bekasSalah: UIImageView!
    @IBOutlet weak var bekasAtas: UIImageView!
    @IBOutlet weak var HaBenar: UIImageView!
    @IBOutlet weak var HaBenar1: UIImageView!
    @IBOutlet weak var SpeakerBenar: UIButton!
    @IBOutlet weak var SpeakerSalah: UIButton!
    
    var KartuAksaraOrigin:CGPoint!
    let correctPosition = CGPoint (x: 167, y: 607)
    let incorrectPosition = CGPoint(x: 520, y: 646)
    var HaBenar1Origin:CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        suara()
        
        addPanGesture(view: KartuAksara)
        addPanGesture2(view: HaBenar1)
        KartuAksaraOrigin = KartuAksara.frame.origin
        HaBenar1Origin = HaBenar1.frame.origin
        view.bringSubviewToFront(KartuAksara)
        view.bringSubviewToFront(HaBenar1)
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
    
    func addPanGesture2(view:UIView) {
        let secondPan = UIPanGestureRecognizer(target: self, action: #selector(TebakAksara.handleSecondPan(gesture:)))
        view.addGestureRecognizer(secondPan)
    }
    
    
    // Refactor
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        let point = sender.location(in: view)
        let currentPosition = point
       
//        print(currentPosition)
        
        let fileView = sender.view!
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: fileView, sender: sender)
        case .ended:
            
            if currentPosition.x >= correctPosition.x-100 &&
                currentPosition.x <= correctPosition.x+100 &&
                currentPosition.y >= correctPosition.y-100 &&
                currentPosition.y <= correctPosition.y+100 {
                
                deleteView(view: fileView, status: true)
                showHa(view: HaBenar)
                jawabanBenar.play()
//                print ("whoop whoop")
            } else if currentPosition.x >= incorrectPosition.x-100 &&
                        currentPosition.x <= incorrectPosition.x+100 &&
                        currentPosition.y >= incorrectPosition.y-100 &&
                        currentPosition.y <= incorrectPosition.y+100 {
                deleteView(view: fileView, status: true)
                showHa1(view: HaBenar1, status: true)
//               print ("boooo")
            } else {
                returnViewToOrigin(view: fileView)
            }
            
        default:
            break
        }
            
//            if fileView.frame.intersects(bekasBenar.frame) {
//                deleteView(view: fileView, status: true)
//                showHa(view: HaBenar)
//                jawabanBenar.play()
//            } else if fileView.frame.intersects(bekasSalah.frame){
//                deleteView(view: fileView, status: true)
//                showHa1(view: HaBenar1, status: true)
//            } else {
//                returnViewToOrigin(view: fileView)
//            }
//
//        default:
//            break
//        }
    }
    
    @objc func handleSecondPan(gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: view)
        let currentPosition = point
       
//        print(currentPosition)
        
        let newView = gesture.view!
        switch gesture.state {
        case .began, .changed:
          
            moveViewWithPan2(view: newView, gesture: gesture)
        case .ended:
            
            if currentPosition.x >= correctPosition.x-100 &&
                currentPosition.x <= correctPosition.x+100 &&
                currentPosition.y >= correctPosition.y-100 &&
                currentPosition.y <= correctPosition.y+100 {
                
                deleteView(view: newView, status: true)
                showHa(view: HaBenar)
                jawabanBenar.play()
//                print ("whoop whoop")
            } else if currentPosition.x >= incorrectPosition.x-100 &&
                        currentPosition.x <= incorrectPosition.x+100 &&
                        currentPosition.y >= incorrectPosition.y-100 &&
                        currentPosition.y <= incorrectPosition.y+100 {
                returnViewToRight(view: newView)
//               print ("boooo")
            } else {
                returnViewToOrigin(view: newView)
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
    
    func moveViewWithPan2(view: UIView, gesture: UIPanGestureRecognizer) {
        let newTranslation = gesture.translation(in: view)
        view.center = CGPoint(x: view.center.x + newTranslation.x, y: view.center.y + newTranslation.y)
        gesture.setTranslation(CGPoint.zero, in: view)
    }
    
    func returnViewToOrigin(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin = self.KartuAksaraOrigin
        })
    }
    
    func returnViewToRight(view:UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin = self.HaBenar1Origin
        })
    }
    
    func deleteView(view: UIView, status: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.0
        })
    }
    
    func showHa(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            self.HaBenar.alpha = 1
        })
    }
    
    func showHa1(view: UIView, status: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.HaBenar1.alpha = 1
        })
    }
    
    func suara() {
        do {
            suaraBenar = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "suaraHa", ofType: "mp3")!))
        } catch {
            print (error)
        }
        do {
            suaraSalah = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "suaraLa", ofType: "mp3")!))
        } catch {
            print (error)
        }
        do {
            jawabanBenar = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "dndTrue", ofType: "mp3")!))
        } catch {
            print (error)
        }
    }
    
}
