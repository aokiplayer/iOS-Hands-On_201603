//
//  ViewController.swift
//  NoteApp
//
//  Created by Hiroyuki Aoki on 2016/03/23.
//  Copyright © 2016年 sample. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!

    /// 追加ボタンがクリックされた時に実行されるメソッド
    @IBAction func tapAddButton(sender: UIButton) {
        // 入力値を取得（未入力なら何もせずに終了）
        guard let line = textField.text where !line.isEmpty else { return }
        
        // 前回までのメモを取得（Optional型から、!で強制取り出し）
        let currentNote = textView.text!
        
        // メモの先頭に入力値を追加した文字列を作成（間に改行を挟む）
        let newNote = "\(line)\n\(currentNote)"
        
        // テキストビューの表示文字列を、新しいメモで更新
        textView.text = newNote
        
        // テキストフィールドの入力内容をクリア
        textField.text = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
