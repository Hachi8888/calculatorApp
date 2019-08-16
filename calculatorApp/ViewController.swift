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
    // 演算子（+、 -、 ×、 ÷）デフォルトは + とする
    var prop: property = .plus
    
    // 演算子の列挙体を設定する
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

        resultLabel.text = "0"

    }
    
    // 数字ボタンを押したときの処理
    @IBAction func tappedNum(_ sender: UIButton) {
        // タグ番号をもとに、選んだボタンの数字をnumberOnScreenに格納する
        numberOnScreen = Double(sender.tag - 1)
        
        // ボタンの数字は必ず整数なので、Int型になおしてからString型にして画面に表示する
        resultLabel.text = String(Int(numberOnScreen))
    }
    
    // クリアボタンを押したとき
    @IBAction func tapClearButton(_ sender: UIButton) {
        // すべてクリアする
        numberOnScreen = 0
        previousNumber = 0
        resultLabel.text = "0"
        prop = .none
    }
    
    // = ボタンを押したとき
    @IBAction func tapEqualButtpn(_ sender: UIButton) {
        
        var result: Double = 0
        
        // propの値をもとに、やりたい計算を行う
        switch prop{
        // 割り算
        case .devide:
            result = previousNumber / numberOnScreen
            
            // 0除算の場合、errorを返す
            if result.isInfinite {
                resultLabel.text = "error"
                return
            }
        // 掛け算
        case .milti:
            result = previousNumber * numberOnScreen
        // 引き算
        case .minus:
            result = previousNumber - numberOnScreen
        // 足し算
        case .plus:
            result = previousNumber + numberOnScreen
        // 何もしない
        case .none:
            return
        }
        
        // 画面に表示する値が、整数のとき(最後の文字が0)は整数で、小数のときは小数で表示する
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
        
        // previousNumberにそのとき画面に表示されている数字を格納する
        previousNumber = Double(resultLabel.text ?? "0") ?? 0
        
        // タグ番号によってpropの値を変える
        switch sender.tag {
        // ÷ボタンを押したとき
        case 12:
           prop = .devide
        // ×ボタンを押したとき
        case 13:
            prop = .milti
       // -ボタンを押したとき
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


