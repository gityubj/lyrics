//
//  ListTableViewController.swift
//  lyrics
//
//  Created by 유병재 on 2017. 8. 3..
//  Copyright © 2017년 유병재. All rights reserved.
//

import Foundation
import UIKit

class ListTableViewController : UITableViewController {
    
    var lyricsArr : [LyricsListData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List"
        let firstData = LyricsListData(title: "주님 다시오실 때까지", time: "today", lyricsArr: [LyricsData(type:"<V1>", lyrics:"벌스"), LyricsData(type:"<C>", lyrics:"코러스"), LyricsData(type:"<V2>", lyrics:"벌스2"), LyricsData(type:"<P.C>", lyrics:"프리 코러스"), LyricsData(type:"<B>", lyrics:"브릿지")])
        self.lyricsArr.append(firstData)
        self.tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? EditViewController, segue.identifier == "showEditVCSG", let cell = sender as? ListTableCell, let indexPath = self.tableView.indexPath(for: cell) {
            dest.typeArr = self.lyricsArr[indexPath.row].lyricsArr
            dest.title = cell.titleLabel?.text
        }
    }
}

extension ListTableViewController {
    //dataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lyricsArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListTableCell {
            cell.configure(data:self.lyricsArr[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    //delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        self.performSegue(withIdentifier: "showEditVCSG", sender: cell)
    }
}

struct LyricsListData {
    var title       : String?
    var time        : String?
    var lyricsArr   : [LyricsData]
}

struct LyricsData {
    var type    : String?
    var lyrics  : String?
}

class ListTableCell : UITableViewCell {
    
    @IBOutlet var titleLabel : UILabel?
    @IBOutlet var timeLabel  : UILabel?
    
    func configure(data:LyricsListData) {
        self.titleLabel?.text = data.title
        self.timeLabel?.text = data.time
    }
}

class EditLyricsTableCell : UITableViewCell {
    
    @IBOutlet var typeLabel     : UILabel?
    @IBOutlet var lyricsLabel   : UILabel?
    
    func configure(data:LyricsData) {
        self.typeLabel?.text = data.type
        self.lyricsLabel?.text = data.lyrics
    }
}

class EditLyricsCollectionCell : UICollectionViewCell {
    @IBOutlet var typeLabel : UILabel?
    
    func configure(data:LyricsData) {
        self.typeLabel?.text = data.type
    }
}
