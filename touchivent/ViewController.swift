//
//  ViewController.swift
//  touchivent
//
//  Created by 杉浦文哉 on 2018/11/18.
//  Copyright © 2018 杉浦文哉. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageNameArray: [String] = ["hana","hoshi","onpu","shitumon"]
    
    var imageInadex: Int = 0
    
    @IBOutlet var haikeiImageView: UIImageView!
    
    var imageView: [UIImageView] = []
    
    var imageViewCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        haikeiImageView.image = UIImage(named: "background.png")
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func selectHana(){ //hana is 1st button
        imageInadex = 1
    }

    @IBAction func selectHoshi(){ //hoshi is 2nd butoon
        imageInadex = 2
    }
    
    @IBAction func selectOnpu(){ //onpu is 3rd button
        imageInadex = 3
    }
    
    @IBAction func selectShitumon(){ //shitsumon is 4th button
        imageInadex = 4
    }
    
    @IBAction func back(){
        if imageViewCount > 0{
        self.imageView[imageViewCount - 1].removeFromSuperview()
        imageViewCount -= 1
        }
    }
    
    
    @IBAction func selectBackground(){
        
       if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        
        
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.allowsEditing = true
        
        imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        imagePickerController.delegate = self
        
        self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func save(){
        //スクショ取得
        let rect: CGRect = CGRect(x: 0, y: 0, width: 375, height: 487)
        UIGraphicsBeginImageContext(rect.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //save to photo library
        UIImageWriteToSavedPhotosAlbum(capture!, nil, nil, nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //タッチされた位置を取得
        let touch: UITouch = touches.first!
        let location: CGPoint = touch.location(in: self.view)
        
        //the case of imageIndex isn't 0 (selected stamp butotn yet)
        if imageInadex != 0 {
            imageViewCount += 1
            imageView.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40)))
            
            //set the stamp image
            let image: UIImage = UIImage(named: imageNameArray[imageInadex - 1])!
            imageView[imageViewCount - 1].image = image
            
            //put the stamp image
            imageView[imageViewCount - 1].center = CGPoint(x: location.x, y: location.y)
            
            self.view.addSubview(imageView[imageViewCount - 1])
            
            
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch: UITouch = touches.first!
        let location: CGPoint = touch.location(in: self.view)
        imageView[imageViewCount - 1] = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        //set the stamp image
        let image: UIImage = UIImage(named: imageNameArray[imageInadex - 1])!
        imageView[imageViewCount - 1].image = image
        
        //put the stamp image
        imageView[imageViewCount - 1].center = CGPoint(x: location.x, y: location.y)
        
        self.view.addSubview(imageView[imageViewCount - 1])
        
        


    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let location: CGPoint = touch.location(in: self.view)
        imageView[imageViewCount - 1] = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        //set the stamp image
        let image: UIImage = UIImage(named: imageNameArray[imageInadex - 1])!
        imageView[imageViewCount - 1].image = image
        
        //put the stamp image
        imageView[imageViewCount - 1].center = CGPoint(x: location.x, y: location.y)
        
        self.view.addSubview(imageView[imageViewCount - 1])
        
       
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        
        haikeiImageView.image = image
       
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

