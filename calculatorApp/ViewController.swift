//
//  ViewController.swift
//  calculatorApp
//
//  Created by VERTEX22 on 2019/08/14.
//  Copyright © 2019 N-project. All rights reserved.
//

// Landscape Left/Right のチェックを外して、画面回転時もレイアウトが変わらないようにした

import UIKit

class ViewController: UIViewController {
    
 // 変数一覧
    // 画面に表示する数字
    var numberOnScreen: Double = 0
    
    // 最初に入力した数字
    var previousNumber: Double = 0
    
    // 計算プロセスに進んでいいかの判断値（真偽値）
    var performingMath: Bool = true
    
    // 演算子（+、 -、 ×、 ÷）デフォルトは + とする
    var prop: property = .plus
    
    // 演算子の列挙体
    enum property {
     case plus // 足す
     case minus // 引く
     case milti // かける
     case devide // 割る
     case none  //何も設定ない
    
    }
    
    // 画面の表示用のラベル
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // 数字ボタンを押したときの処理
    @IBAction func tappedNum(_ sender: UIButton) {
        
        numberOnScreen = Double(sender.tag - 1)
        
        // ボタンは必ず整数なので、Int型になおしてからString型にして画面に表示する
        resultLabel.text = String(Int(numberOnScreen))
    }
    
    // クリアボタンを押したとき
    @IBAction func tapClearButton(_ sender: UIButton) {
        
        // すべてクリアする
        numberOnScreen = 0
        previousNumber = 0
        resultLabel.text = ""
        prop = .none
    }
    
    // = ボタンを押したとき
    @IBAction func tapEqualButtpn(_ sender: UIButton) {
        
        sender.layer.borderColor = UIColor.black.cgColor
        
        var result: Double = 0
        
        switch prop{
        case .devide:
            result = previousNumber / numberOnScreen
            
            // 0除算の場合、errorを返す
            if result.isInfinite {
                resultLabel.text = "error"
                return
            }
        case .milti:
            result = previousNumber * numberOnScreen
            
        case .minus:
            result = previousNumber - numberOnScreen
            
        case .plus:
            result = previousNumber + numberOnScreen
            
        case .none:
            return
        
        }
        
        
        // 表示する値が、整数なのときは整数で、小数のときは小数で表示する
        if String(result).last == "0" {
            // 整数
            resultLabel.text = String(Int(result))
        } else {
            // 小数
            resultLabel.text = String(result)
        }
    }
    
    //  ÷, ×, -, + を押したときの処理
    @IBAction func tappedAction(_ sender: UIButton) {
        
        // previousNumberの定義(そのとき画面に表示されている数字を格納)
        previousNumber = Double(resultLabel.text ?? "0") ?? 0
        
        switch sender.tag {
            
        // ÷ボタンを押したとき
        case 12:
           prop = .devide
            
        // ×ボタンを押したとき
        case 13:
            prop = .milti
       
       //  -ボタンを押したとき
        case 14:
            prop = .minus

      // +ボタンを押したとき
        case 15:
            prop = .plus
            
        default:
           print("エラー")
        
        }
        
    }
}


