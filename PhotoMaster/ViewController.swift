//
//  ViewController.swift
//  PhotoMaster
//
//  Created by 太田 一毅 on 2019/03/29.
//  Copyright © 2019 太田 一毅. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // 写真表示用ImageView
    @IBOutlet var photoImageView:UIImageView!
    
    @IBAction func cameraBtn(){
        presentPickerController(sourceType: .camera)
    }
    
    @IBAction func albumBtn(){
        presentPickerController(sourceType: .photoLibrary)
    }
    
    func presentPickerController(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        photoImageView.image = info[.originalImage] as? UIImage
    }
    
    func drawText(image: UIImage) -> UIImage {
        let text = "提供：Life is Tech !"
        
        let textFontAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Arial", size: 240)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        // グラフィクスコンテキスト生成 編集を開始
        UIGraphicsBeginImageContext(image.size)
        
        // 読み込んだ写真を書き出す
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        // textCGRectを定義する
        let margin: CGFloat = 5.0
        let textRect = CGRect(x: margin, y:margin, width: image.size.width - margin, height: image.size.height - margin)
        
        // textRect内にtextFontAttribuutesにしたがってtextを書き出す
        text.draw(in: textRect, withAttributes: textFontAttributes)
        
        // グラフィクスコンテキストの画像を取得
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return newImage!
    }
    
    func drawMaskImage(image:UIImage) -> UIImage {
        // マスク画像
        let maskImage = UIImage(named: "good.png")!
        
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let margin: CGFloat = 50.0
        let maskRect = CGRect(x: image.size.width - maskImage.size.width - margin,
                              y: image.size.height - maskImage.size.height - margin,
                              width: maskImage.size.width, height: maskImage.size.height)
        
        maskImage.draw(in: maskRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    @IBAction func textBtn(){
        if photoImageView.image != nil {
            photoImageView.image = drawText(image: photoImageView.image!)
        } else {
            print("画像がありません")
        }
    }
    
    @IBAction func illustBtn(){
        if photoImageView.image != nil {
            photoImageView.image = drawMaskImage(image: photoImageView.image!)
        } else {
            print("画像がありません")
        }
    }
    
    @IBAction func uploadBtn(){
        if photoImageView.image != nil {
            let activityVC = UIActivityViewController(activityItems: [photoImageView.image!, "#PhotoMaster"], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        } else {
            print("画像がありません")
        }
    }
}

