//
//  AnnotateViewController.swift
//  BacarakaV1
//
//  Created by Rifki Triaditiya Putra on 29/10/20.
//

import UIKit
import PencilKit

class AnnotateViewController: UIViewController,PKCanvasViewDelegate,PKToolPickerObserver{
    
    @IBOutlet weak var labelCerita: UILabel!
    @IBOutlet weak var mCanvas: PKCanvasView!
    
    var drawing = PKDrawing()
    var toolPicker: PKToolPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mCanvas.tool = PKInkingTool(.marker, color: .black, width: 1000)
        mCanvas.drawing = drawing
        mCanvas.delegate = self
        mCanvas.alwaysBounceVertical = true
        mCanvas.allowsFingerDrawing = true
        mCanvas.drawingPolicy = .anyInput
        
//        judul()
        ceritaSatu()
        // Set up the tool picker
//        if #available(iOS 14.0, *) {
//            toolPicker = PKToolPicker()
//        } else {
//            let window = parent?.view.window
//            toolPicker = PKToolPicker.shared(for: window!)
//        }
//        toolPicker.setVisible(true, forFirstResponder: mCanvas)
//        toolPicker.addObserver(mCanvas)
//        toolPicker.addObserver(self)
//        updateLayout(for: toolPicker)
//        mCanvas.becomeFirstResponder()
        
        
        
    }

    
    
//    @IBAction func saveFile(_ sender: Any) {
//    let myArray = mCanvas.drawing.dataRepresentation() //NSDATA
//
////        let path = FileManager.default.urls(for: .documentDirectory,
////                                            in: .userDomainMask)[0].appendingPathComponent("myFile.drawing")
//
//        let mPath = "\(AppDelegate.getAppDelegate().getDocDir())/myFile.drawing"
//        do{
//            try myArray.write(to: URL(fileURLWithPath: mPath))
////            print(path)
//        }catch{
//            print(error)
//        }
//
//        //sharing via airdrop
//        let activityItems = [NSData(contentsOfFile: "\(mPath)")!]
//        let applicationActivities: [UIActivity]? = nil
//        let excludedActivityTypes: [UIActivity.ActivityType]? = nil
//        typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
//        let callback: Callback? = nil
//
//        let controller = UIActivityViewController(
//            activityItems: activityItems,
//            applicationActivities: applicationActivities)
//        controller.excludedActivityTypes = excludedActivityTypes
//        controller.completionWithItemsHandler = callback
//        present(controller, animated: true)
//    }
//
//
//
//    func updateLayout(for toolPicker: PKToolPicker) {
//        let obscuredFrame = toolPicker.frameObscured(in: view)
//
//        // If the tool picker is floating over the canvas, it also contains
//        // undo and redo buttons.
//        if obscuredFrame.isNull {
//            mCanvas.contentInset = .zero
//            navigationItem.leftBarButtonItems = []
//        }
//
//        // Otherwise, the bottom of the canvas should be inset to the top of the
//        // tool picker, and the tool picker no longer displays its own undo and
//        // redo buttons.
//        else {
//            mCanvas.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.bounds.maxY - obscuredFrame.minY, right: 0)
//
//        }
//        mCanvas.scrollIndicatorInsets = mCanvas.contentInset
//    }
//    func judul() {
//        BAB1.text = "BAB I"
//    }
    
    func ceritaSatu() {
//        labelCerita.lineBreakMode = NSLineBreakMode.byWordWrapping
//        labelCerita.numberOfLines = 6
  //      label.font = UIFont.systemFont(ofSize: 40)
        labelCerita.text = "Alkisah ada seorang pemuda sakti yang bernama Ajisaka. Ajisaka memiliki dua orang abdi yang sangat setia bernama Dora dan Sembada. Suatu ketika, Ajisaka pergi mengembara ke Kerajaan Medhangkamulan dan mengajak Dora untuk menemaninya."
        self.view.addSubview(labelCerita)
    }
}
