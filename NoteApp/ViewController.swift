//
//  ViewController.swift
//  NoteApp
//
//  Created by Hiroyuki Aoki on 2016/03/23.
//  Copyright © 2016年 Casareal,Inc. All rights reserved.
//

import UIKit

/// UITextFieldDelegateプロトコルを適用することで、ビューコントローラ自体がdelegateとなる
class ViewController: UIViewController, UITextFieldDelegate {
    /// データ永続化用のユーザデフォルトオブジェクト
    let defaults = NSUserDefaults.standardUserDefaults()
    
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
        
        // キー "note" で保存済みのメモがあれば、あらかじめ表示しておく
        if let storedNote = defaults.stringForKey("note") {
            textView.text = storedNote
        }
    }

    /// 入力内容をメモに追加するメソッド
    func addNewNote() {
        // 入力値を取得（未入力なら何もせずに終了）
        guard let line = textField.text where !line.isEmpty else { return }
        
        // 前回までのメモを取得（Optional型から、!で強制取り出し）
        let currentNote = textView.text!
        
        // 現在日時の文字列を取得
        let now = self.currentTimeText()
        
        // メモの先頭に入力値を追加した文字列を作成（間に改行を挟む）
        let newNote = "[\(now)] \(line)\n\(currentNote)"
        
        // テキストビューの表示文字列を、新しいメモで更新
        textView.text = newNote
        
        // 更新したメモの内容を、ユーザデフォルトを利用して永続化
        defaults.setObject(newNote, forKey: "note")
        defaults.synchronize()
        
        // テキストフィールドの入力内容をクリア
        textField.text = ""
    }

    /// 現在日時文字列を返すメソッド
    func currentTimeText() -> String {
        // 現在日時
        let now = NSDate()
        
        // 日時フォーマットオブジェクト
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        
        // 日付をGMTでなく、日本のロケールでフォーマットするように指定
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        
        // 日付をフォーマットし、文字列として返す
        let nowText = dateFormatter.stringFromDate(now)
        return nowText
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
