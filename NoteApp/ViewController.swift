//
//  ViewController.swift
//  NoteApp
//
//  Created by Hiroyuki Aoki on 2016/03/23.
//  Copyright © 2016年 sample. All rights reserved.
//

import UIKit

/// UITextFieldDelegateプロトコルを適用することで、ビューコントローラ自体がdelegateとなる
class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!

    /// 追加ボタンがクリックされた時に実行されるメソッド
    @IBAction func tapAddButton(sender: UIButton) {
        // メモの追加メソッドを呼び出し
        self.addNewNote()
    }

    /// 画面が読み込まれ、ビューが用意された後に実行されるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テキストフィールドのdelegateには、ビューコントローラ自身を指定
        textField.delegate = self
    }

    /// 入力内容をメモに追加するメソッド
    func addNewNote() {
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

    // MARK: - UITextFieldDelegate

    /// テキストフィールド内で、Returnキーが押された時に実行されるメソッド
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // 編集を終了するので、カーソルを外しておく
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(textField: UITextField) {
        // メモの追加メソッドを呼び出し
        self.addNewNote()
    }
}
