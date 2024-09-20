//
//  TableViewController.swift
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/11/24.
//

import UIKit


class LogoTableViewCell: UITableViewCell {
// This class is used to show user details (image, name, level)
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logoUsernameLabel: UILabel!
    @IBOutlet weak var logoDateLabel: UILabel!
    @IBOutlet weak var logoLevelLabel: UILabel!
}

class PinyinTableViewCell: UITableViewCell {
// This class is used to show a picture with the associated pinyin word
    @IBOutlet weak var pinyinLabel: UILabel!
    @IBOutlet weak var pinyinImage: UIImageView!
}

class TableViewController: UITableViewController, UserSelectDelegate {
    @IBOutlet var myTableView: UITableView!

    // MARK: - Variables
    lazy var userModel: UserModel = {
        return UserModel.sharedInstance()
    }()
    
    lazy var mandarinModel: MandarinModel = {
        return MandarinModel.sharedInstance()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setUserDetailsFor(index: 0)
    }
    
    // MARK: - Table view data source

    func userChanged() {
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.automatic)
        }
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {         //Logo Section
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogoCell", for: indexPath) as! LogoTableViewCell
            
            //User Image setup
            cell.logoImage.layer.cornerRadius = 60
            cell.logoImage.layer.masksToBounds = true
            cell.logoImage.image = self.userModel.getUserImage()
            
            //Username and Level labels setup
            cell.logoUsernameLabel.text = self.userModel.getUsername()
            cell.logoLevelLabel.text = self.userModel.getLevel()
            
            //Date Label setup
            let currentDate = Date.now
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            cell.logoDateLabel.text = formatter.string(from: currentDate)

            return cell
        }else if indexPath.section == 1 {   //Vocabulary Section
            let cell = tableView.dequeueReusableCell(withIdentifier: "VocabCell", for: indexPath)
            
            let englishWord = self.mandarinModel.getEnglishWord(at: indexPath.row)
            cell.textLabel?.text = englishWord
            cell.detailTextLabel?.text = self.mandarinModel.getMandarinForEnglish(englishWord)
            return cell
        }else if indexPath.section == 2{    //Quiz link
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
            cell.textLabel?.text = "Quiz"
            cell.textLabel?.textAlignment = NSTextAlignment.center
            return cell
        }else if indexPath.section == 3{    //Picture Dictionary Link
            let cell = tableView.dequeueReusableCell(withIdentifier: "PicCell", for: indexPath)
            cell.textLabel?.textAlignment = NSTextAlignment.center
            cell.textLabel?.text = "Picture Dictionary"
            return cell
        }else{                              //Picture and Pinyin Section
            let cell = tableView.dequeueReusableCell(withIdentifier: "PinyinCell", for: indexPath) as! PinyinTableViewCell
            
            let englishWord = self.mandarinModel.getEnglishWord(at: indexPath.row)
            cell.pinyinLabel.text =  self.mandarinModel.getPinyinForEnglish(englishWord)
            cell.pinyinImage.image = self.mandarinModel.getPicForEnglishWord(englishWord)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        if section == 1 {
            return "This Week's Vocabulary:"
        }
        return nil
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Set  variables required by destination view controllers
        if let vc = segue.destination as? ViewController,   //Destination is Word Review
           let cell = sender as? UITableViewCell,
           let englishWord = cell.textLabel?.text{
            vc.englishWord = englishWord
        }else if let vc = segue.destination as? UserTableViewController{    //Destination is User Selection
            vc.delegate = self
        }
    }
}
