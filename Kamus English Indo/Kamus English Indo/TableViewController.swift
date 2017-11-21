//
//  TableViewController.swift
//  Kamus English Indo
//
//  Created by Gw on 09/11/17.
//  Copyright © 2017 Gw. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let URLKamus = "http://localhost/KamusWeb/index.php/DataKamus/getAllKamus"
    var kamus = [Kamus]()
    var indoSelected:String?
    var englishtSelected:String?
    var idSelected:String?
    var rencana_donorSelected:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDictionarysData()
        
        //set row height to 92
        tableView.estimatedRowHeight = 92.0
        //set row table height to automatic dimension
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return kamus.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.labelIndo.text = kamus[indexPath.row].kamus_indonesia
        cell.labelEnglish.text = kamus[indexPath.row].kamus_inggris
        cell.labelID.text = kamus[indexPath.row].id_kamus
        return cell
    }
    func getDictionarysData() {
        guard let studentsURL = URL(string: URLKamus) else {
            return //this return is for back up the value that got when call variable loanURL
        }
        let request = URLRequest(url: studentsURL)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                //condition when error
                //print error
                print(error)
                return //back up value error that we get
            }
            //parse JSON data
            //declare variable data to call data
            if let data = data {
                //for this part will call method parseJsonData that we will make in below
                self.kamus = self.parseJsonData(data: data)
                
                //reload tableView
                OperationQueue.main.addOperation({
                    //reload data again
                    self.tableView.reloadData()
                })
            }
        })
        //task will resume to call the json data
        task.resume()
    }
    func parseJsonData(data: Data) -> [Kamus] {
        var kamus = [Kamus]()
        do{
            //declare jsonResult for take data from the json
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            //parse json data
            //declare jsonLoans for call data array jsonResult with name Loans
            let jsonLoans = jsonResult?["data"] as! [AnyObject]
            //will call data be repeated for jsonLoan have data json array from variable jsonLoans
            for jsonLoan in jsonLoans {
                //declare loan as object from class loan
                let kamoes = Kamus()
                kamoes.kamus_inggris = jsonLoan["kamus_inggris"] as! String
                kamoes.kamus_indonesia = jsonLoan["kamus_indonesia"] as! String
                kamoes.id_kamus = jsonLoan["id_kamus"] as! String
                
                kamus.append(kamoes)
            }
        }catch{
            print(error)
        }
        return kamus
    }
}
