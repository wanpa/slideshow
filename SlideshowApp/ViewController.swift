//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 西田稔 on 2017/08/09.
//  Copyright © 2017年 minoru.nishida. All rights reserved.
//
/*
 画面を2つ作成してください
 1つ目の画面ではスライドショー, 2つ目の画面では拡大画像を表示します
 スライドショー画面には、画像と3つのボタン（進む、戻る、再生/停止）を配置してください
 進むボタンで1つ先の画像を表示し、戻るボタンで1つ前の画像を表示します
 最後の画像の表示時に、進むボタンをタップすると、最初の画像が表示されるようにしてください
 最初の画像の表示時に、戻るボタンをタップすると、最後の画像が表示されるようにしてください
 再生ボタンをタップすると自動送りが始まり、2秒毎にスライドさせてください
 自動送りの間は、進むボタンと戻るボタンはタップ不可にしてください
 再生ボタンをタップすると停止ボタンになり、停止ボタンをタップすると再生ボタンにしてください
 停止ボタンをタップすると自動送りが止まり、進むボタンと戻るボタンをタップ可能にしてください
 
 
 画像をタップすると画面を遷移させ、拡大画像と戻るボタンを表示させてください
 戻るボタンがタップされると、スライドショー画面に戻り、同じ画像を表示してください
 Auto Layoutを使用して、iPhone5, 6s, 6s plusの画面サイズでレイアウトが崩れないようにしてください
 画像は、Xcodeのナビゲーションエリア（Project Navigator）へドラッグアンドドロップし、
 Copy items if neededにチェックを入れてCreate groups を選択し、Xcodeプロジェクトへコピーしてください
 */
import UIKit

class ViewController: UIViewController {
    
    
    // タイマー用の時間のための変数
    var timer_sec: Float = 0
    
    //　画像を配列に格納
    let images = ["1.png","2.png","3.png"]
    
    //
    var imageIndex :Int = 0
    //画像表示用のメソッド画像の配列を渡す
    func show(image: Int) {
        imageView.image = UIImage(named: images[image])
    }
    
    //imageViewを宣言しUIImageView
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    @IBAction func play(_ sender: Any) {
        
        if playToggle == true {
            // タイマーの作成始動
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            nextButton.isEnabled = false
            backButton.isEnabled = false
            nextButton.setTitleColor(UIColor.brown, for: UIControlState.disabled)
            backButton.setTitleColor(UIColor.brown, for: UIControlState.disabled)
            
            playToggle = false
        }else{
            self.timer.invalidate()
            playToggle = true
            nextButton.isEnabled = true
            backButton.isEnabled = true
            
        }
        
    }
    
    //nextボタン
    @IBAction func next(_ sender: Any) {
        if imageIndex == 2 {
            imageIndex = 0
        }else if imageIndex < images.count - 1 {
            imageIndex += 1
        }
        print(imageIndex)
        show(image: imageIndex)
        
    }
    
    //backボタン
    @IBAction func back(_ sender: Any) {
        if imageIndex <= images.count - 1 && 1  <= imageIndex {
            imageIndex -= 1
        }else if 0 <= imageIndex {
            imageIndex = 2
        }
        print(imageIndex)
        show(image: imageIndex)
        
    }

    // selector: #selector(updatetimer) で指定された関数
    // timeInterval: 0.1, repeats: true で指定された通り、0.1秒毎に呼び出され続ける
    func updateTimer(timer: Timer) {
        if imageIndex == 2 {
            imageIndex = 0
        }else if imageIndex < images.count - 1 {
            imageIndex += 1
        }
        print(imageIndex)
        show(image: imageIndex)
    }
    
    
    var timer: Timer!
    
    //再生のon off 用の変数を用意
    var playToggle = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // シングルタップ
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.tap(_:)))
        
        // viewにタップを登録
        self.view.addGestureRecognizer(tapGesture)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        print("taped")
        //参考　http://qiita.com/fromage-blanc/items/b3cb0e7833a1d5659463
        let zoomUp = storyboard!.instantiateViewController(withIdentifier: "zoomUp")
        self.present(zoomUp,animated: true, completion: nil)
    }
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }

}

