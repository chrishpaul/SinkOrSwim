//
//  TableViewController.swift
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/11/24.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    lazy var mandarinModel: MandarinModel = {
        return MandarinModel.sharedInstance()
    }()
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return self.mandarinModel.numberOfWords()
        }else{
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VocabCell", for: indexPath)
            
            let englishWord = self.mandarinModel.getEnglishWord(at: indexPath.row)
            cell.textLabel?.text = englishWord
            cell.detailTextLabel?.text = self.mandarinModel.getMandarinForEnglish(englishWord)
            
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
            cell.textLabel?.text = "Quiz"
            cell.textLabel?.textAlignment = NSTextAlignment.center
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PicCell", for: indexPath)
            cell.textLabel?.textAlignment = NSTextAlignment.center
            cell.textLabel?.text = "Picture Dictionary"
            return cell
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VocabCell", for: indexPath)
            
            let englishWord = self.mandarinModel.getEnglishWord(at: indexPath.row)
            cell.textLabel?.text = englishWord
            cell.detailTextLabel?.text = self.mandarinModel.getMandarinForEnglish(englishWord)
            
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
            cell.textLabel?.text = "Quiz"
            cell.textLabel?.textAlignment = NSTextAlignment.center
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PicCell", for: indexPath)
            cell.textLabel?.textAlignment = NSTextAlignment.center
            cell.textLabel?.text = "Picture Dictionary"
            return cell
        }
    }
*/
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController,
           let cell = sender as? UITableViewCell,
           let englishWord = cell.textLabel?.text{
            vc.englishWord = englishWord
        }
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        if section == 0 {
            return "This Week's Vocabulary:"
        }
        return nil
    }

}
