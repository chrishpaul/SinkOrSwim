//
//  TableViewController.swift
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/11/24.
//

import UIKit

class LogoTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logoUsernameLabel: UILabel!
    @IBOutlet weak var logoDateLabel: UILabel!
    @IBOutlet weak var logoLevelLabel: UILabel!
}

class PinyinTableViewCell: UITableViewCell {

    @IBOutlet weak var pinyinLabel: UILabel!
    @IBOutlet weak var pinyinImage: UIImageView!
}

class TableViewController: UITableViewController, UserSelectDelegate {

    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUserDetailsFor(index: 0)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //print(self.userModel.getUser())
        //print(self.userModel.getLevel())
    }

    lazy var userModel: UserModel = {
        return UserModel.sharedInstance()
    }()
    
    lazy var mandarinModel: MandarinModel = {
        return MandarinModel.sharedInstance()
    }()
    
    var userImage : UIImage?
    var userName : String?
    var userLevel : String?
    
    // MARK: - Table view data source

    func changeUserFor(index: Int) {
        print(index)
        let indexPath = IndexPath(row: 0, section: 0)
        print(indexPath)
        self.setUserDetailsFor(index: index)
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return self.mandarinModel.numberOfWords()
        }else if section == 4 {
            return self.mandarinModel.numberOfWords()
        }else{
            return 1
        }
    }

    func setUserDetailsFor(index : Int){
        self.userName = self.userModel.getUserBy(index)
        self.userLevel = self.userModel.getLevelBy(index)
        self.userImage = self.userModel.getUserImage(by: index)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            print(indexPath)
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogoCell", for: indexPath) as! LogoTableViewCell
            cell.logoImage.layer.cornerRadius = 60
            cell.logoImage.layer.masksToBounds = true
            //cell.logoImage.image = UIImage(named: "alice")
            //cell.logoImage.image = self.userModel.getUserImage()
            cell.logoImage.image = self.userImage
            let currentDate = Date.now
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            cell.logoDateLabel.text = formatter.string(from: currentDate)
            //cell.logoUsernameLabel.text = self.userModel.getUser()
            //cell.logoLevelLabel.text = self.userModel.getLevel()
            cell.logoUsernameLabel.text = self.userName
            cell.logoLevelLabel.text = self.userLevel
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VocabCell", for: indexPath)
            
            let englishWord = self.mandarinModel.getEnglishWord(at: indexPath.row)
            cell.textLabel?.text = englishWord
            cell.detailTextLabel?.text = self.mandarinModel.getMandarinForEnglish(englishWord)
            
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
            cell.textLabel?.text = "Quiz"
            cell.textLabel?.textAlignment = NSTextAlignment.center
            //cell.backgroundColor = .
            return cell
        }else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PicCell", for: indexPath)
            cell.textLabel?.textAlignment = NSTextAlignment.center
            cell.textLabel?.text = "Picture Dictionary"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PinyinCell", for: indexPath) as! PinyinTableViewCell
            
            let englishWord = self.mandarinModel.getEnglishWord(at: indexPath.row)
            cell.pinyinLabel.text =  self.mandarinModel.getPinyinForEnglish(englishWord)
            cell.pinyinImage.image = self.mandarinModel.getPicForEnglishWord(englishWord)
            
            return cell
        }
        
        /*else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
            cell.textLabel?.text = "Quiz"
            cell.textLabel?.textAlignment = NSTextAlignment.center
            return cell

        }else if indexPath.section == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PicReviewCell", for: indexPath)
            cell.textLabel?.textAlignment = NSTextAlignment.center
            cell.textLabel?.text = "Picture Review"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogoCell", for: indexPath) as! LogoTableViewCell
            cell.logoImage.layer.cornerRadius = 60
            cell.logoImage.layer.masksToBounds = true
            //cell.logoImage.image = UIImage(named: "alice")
            cell.logoImage.image = self.userModel.getUserImage()
            let currentDate = Date.now
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            cell.logoDateLabel.text = formatter.string(from: currentDate)
            cell.logoUsernameLabel.text = self.userModel.getUser()
            cell.logoLevelLabel.text = self.userModel.getLevel()
            return cell
        }*/
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
        }else if let vc = segue.destination as? UserTableViewController{
            vc.delegate = self
        }
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        if section == 1 {
            return "This Week's Vocabulary:"
        }
        return nil
    }

}
