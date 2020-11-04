//
//  ViewController.swift
//  BacarakaV1
//
//  Created by Eci AL on 27/10/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //sound effect
    var sfx = AVAudioPlayer()
    var falseSfx = AVAudioPlayer()
    var suaraCerita1 = AVAudioPlayer()
    var suaraCerita2 = AVAudioPlayer()
    var suaraCerita3 = AVAudioPlayer()
    
    // Set the different options of rotation
    var rotationOptions: Array = [0, Double.pi/2, Double.pi, 3*Double.pi/2]
    
    // Set the original matrix
    var matrix: [[Double]] = [
        [0,0,0,0],
        [0,0,0,0],
        [0,0,0,0]
    ]
    
    //if logic
    let cerita = ["Alkisah ada seorang pemuda sakti yang bernama Ajisaka. ", "Ajisaka memiliki dua orang abdi yang sangat setia bernama Dora dan Sembada. ", "Suatu ketika, Ajisaka pergi mengembara ke Kerajaan Medhangkamulan dan mengajak Dora untuk menemaninya."]
    var i = 0
    var m0 = false
    var m1 = false
    var m2 = false
    
    //ini untuk ngebuat sebuah variabel untuk nyimpen baris dan kolom
    var maxRow: Int = 0
    var maxCol: Int = 0
    
    //+90 derajat
    let origin: Double = 0
    let delta: Double = Double.pi/2
    let round: Double = 2 * Double.pi
   
    @IBOutlet weak var textLabel: UILabel!
    
    func showText(_ text: String){
        self.textLabel?.text = text
    }
    
    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet weak var btn00: UIButton!
    @IBOutlet weak var btn01: UIButton!
    @IBOutlet weak var btn02: UIButton!
    @IBOutlet weak var btn03: UIButton!
    @IBOutlet weak var btn10: UIButton!
    @IBOutlet weak var btn11: UIButton!
    @IBOutlet weak var btn12: UIButton!
    @IBOutlet weak var btn13: UIButton!
    @IBOutlet weak var btn20: UIButton!
    @IBOutlet weak var btn21: UIButton!
    @IBOutlet weak var btn22: UIButton!
    @IBOutlet weak var btn23: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //deklarasi buttons, karena kita nggak buat di luar viewDidLoad (gak bisa di luar)
        let buttons: [[UIButton]] = [
            [btn00,btn01,btn02,btn03],
            [btn10,btn11,btn12,btn13],
            [btn20,btn21,btn22,btn23]
        ]
        
        //ini dikurang 1 karena kita hitung, dia mulai dari 1. kalau .count array dia mulai dari 0
        maxRow = matrix.count-1
        maxCol = matrix[0].count-1
        
        randomizeMatrix()
        sound()
        
        //kita deklarasi ulang matriks baris 1 kolom ke nilai 0 karena kita mau lock dia supaya gk gerak
        matrix[0][0] = 0
        matrix[0][1] = 0
        matrix[1][0] = 0
        
        //for loop supaya semua button ke panggil secara dinamis -- daripada yg row 73-76, mending yang ini
        for r in 0...maxRow {
            for c in 0...maxCol {
                buttons[r][c].imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(matrix[r][c]))
            }
        }
    }
    
    func rotateElement(row: Int, col: Int, sender: UIButton) {
        //delta = selisih data (angle)  dari tiap button
        matrix[row][col] = matrix[row][col] + delta >= round ? origin : matrix[row][col] + delta
        rotate(view: sender)

        sfx.play()
        verifyGoal()
    }
    
    @IBAction func btn00t(_ sender: Any) {
        falseSfx.play()
        //ngga dimasukin command apapun sup`aya dia tidak ikut ter-randomize
    }
    
    @IBAction func btn01t(_ sender: Any) {
        falseSfx.play()
    }
    
    @IBAction func btn02t(_ sender: Any) {
        rotateElement(row: 0, col: 2, sender: btn02)
    }
    
    @IBAction func btn03t(_ sender: Any) {
        rotateElement(row: 0, col: 3, sender: btn03)
    }
    
    @IBAction func btn10t(_ sender: Any) {
        falseSfx.play()
    }
    
    @IBAction func btn11t(_ sender: Any) {
        rotateElement(row: 1, col: 1, sender: btn11)
    }
    
    @IBAction func btn12t(_ sender: Any) {
        rotateElement(row: 1, col: 2, sender: btn12)
    }
    
    @IBAction func btn13t(_ sender: Any) {
        rotateElement(row: 1, col: 3, sender: btn13)
    }
        
    @IBAction func btn20t(_ sender: Any) {
        rotateElement(row: 2, col: 0, sender: btn20)
    }
        
    @IBAction func btn21t(_ sender: Any) {
        rotateElement(row: 2, col: 1, sender: btn21)
    }
        
    @IBAction func btn22t(_ sender: Any) {
        rotateElement(row: 2, col: 2, sender: btn22)
    }
        
    @IBAction func btn23t(_ sender: Any) {
        rotateElement(row: 2, col: 3, sender: btn23)
    }
    
    //kita ulang (for) sebanyak maxRow yg udah kita deklarasi di atas (baris 67). stelah itu kita buat randomAngle untuk ambil nilai antara 0, Double.pi/2, Double.pi, 3*Double.pi/2
    func randomizeMatrix() {
        for r in 0...maxRow {
            for c in 0...maxCol {
                let randomAngleIndex: Int = Int.random(in: 0...3)
                
                // kita set matrix[baris][kolom] = di angle random
                matrix[r][c] = rotationOptions[randomAngleIndex]
            }
        }
    }
    
    func gulungansukses() {
    //Use half the screen size width when on an iPhone and on Landscape
        let image: UIImage = UIImage(named: "gulunganreward")!
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        //add to sub view
        view.addSubview(imageView)

        //center image
        let centerXConst = NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.525)
        let centerYConst = NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)

//        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 700)
//        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.view.frame.width / 2)
//           imageView.addConstraints([heightConstraint, widthConstraint])

        NSLayoutConstraint.activate([centerXConst, centerYConst])
    
    
        let label = UILabel()//(frame: CGRect(x: view.frame.width/2, y: 0, width: 500, height: 700)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 40)
        label.text = "Selamat!!! \n Kamu telah menyusun \n satu aksara"
        self.view.addSubview(label)
    
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
    
        UIView.animate(withDuration: 5.0,
                        animations: {
                            imageView.alpha = 0.0
                            label.alpha = 0.0
                        },
                        completion:{_ in imageView.removeFromSuperview()
                    })
        
            let imageButton = UIImage(named: "next") as UIImage?
            let button   = UIButton(type: UIButton.ButtonType.custom) as UIButton
    //            button.frame = CGRect(x: 500, y: 300, width: view.frame.size.width, height: view.frame.size.height)
            button.setImage(imageButton, for: .normal)
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            self.view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
                let widthContraints =  NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 80)
                
                let heightContraints = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 80)
                
                let xContraints = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.bottomMargin, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottomMargin, multiplier: 1, constant: -50)
                
                let yContraints = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -30)
                
                NSLayoutConstraint.activate([heightContraints,widthContraints,xContraints,yContraints])

       // let alert = UIAlertController(title: "You Won!", message: "Congratulations 👍", preferredStyle: .alert)
        //alert.addAction(UIAlertAction(title: "Next", style: //UIAlertAction.Style.default, handler: { action -> Void in
            // self.performSegue(withIdentifier: "win", sender: self)
    }
    
    //untuk memastikan puzzle sudah benar :*
    func verifyGoal() {
        var status = true
        // let's check every cells
        for r in 0...maxRow {
            for c in 0...maxCol {
                // let's check if the angle is right: angle = 0
                if matrix[r][c] != 0 {
                    // If there is one wrong, then it's false
                    status = false
                }
            }
        }
        
        updateText()
    
        //jika benar, panggil sesuatu
        if status {

        allButtons[0].isEnabled = false
        allButtons[1].isEnabled = false
        allButtons[2].isEnabled = false
        allButtons[3].isEnabled = false
        allButtons[4].isEnabled = false
        allButtons[5].isEnabled = false
        allButtons[6].isEnabled = false
        allButtons[7].isEnabled = false
        allButtons[8].isEnabled = false
        allButtons[9].isEnabled = false
        allButtons[10].isEnabled = false
        allButtons[11].isEnabled = false
            
        gulungansukses()
        
             //self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc private func didTapButton() {
        let vc = AnnotateViewController()
        self.performSegue(withIdentifier: "AnnotateViewController", sender: self)
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    func updateText() {
        
        textLabel.fadeTransition(1.0)
        
        if m0 == false {
            if matrix[0] == [0,0,0,0] {
                textLabel.text?.append(cerita[i])
                suaraCeritaa()
                i += 1
                m0 = true
            }
        }
        
        if m1 == false {
            if matrix[1] == [0,0,0,0] {
                textLabel.text?.append(cerita[i])
                suaraCeritaa()
                i += 1
                m1 = true
            }
        }
            
        if m2 == false {
            if matrix[2] == [0,0,0,0] {
                textLabel.text?.append(cerita[i])
                suaraCeritaa()
                i += 1
                m2 = true
            }
        }
    }
    
    func suaraCeritaa() {
        if i == 0 {
            suaraCerita1.play()
        } else if i == 1 {
            suaraCerita2.play()
        } else {
            suaraCerita3.play()
        }
    }
    
    func sound() {
        do {
            sfx = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "klik", ofType: "mp3")!))
        } catch {
            print(error)
        }
        
        do {
            falseSfx = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "notKlik", ofType: "mp3")!))
        } catch {
            print(error)
        }
        
        //ganti suara sesuai cerita
        do {
            suaraCerita1 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "bacaCerita1", ofType: "mp3")!))
        } catch {
            print(error)
        }
    
        do {
            suaraCerita2 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "bacaCerita2", ofType: "mp3")!))
        } catch {
            print(error)
        }
        
        do {
            suaraCerita3 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "bacaCerita3", ofType: "mp3")!))
        } catch {
            print(error)
        }
    }
    
    func rotate(view: UIView) {
        UIView.animate(withDuration: 0.05, animations: ({
            view.transform = view.transform.rotated(by: CGFloat(Double.pi/2))
        }))
    }
}
