//
//  EditUserPhotoTableViewController.swift
//  Vote
//
//  Created by mc on 2017/11/28.
//  Copyright © 2017年 林以达. All rights reserved.
//

import UIKit

class EditUserPhotoTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var userphoto: UIImageView!
    @IBOutlet weak var confirmediting: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        //表格背景颜色
        tableView.backgroundColor = UIColor.black//(white: 0.98, alpha: 1)
        //去除页脚
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        // 表格分割线颜色
        tableView.separatorColor = UIColor(white:0, alpha: 0)
        
        //导航返回按钮样式
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //按钮样式
        self.confirmediting.layer.borderWidth = 1.0
        self.confirmediting.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 241/255, alpha: 1.0).cgColor
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
           
            let mmut = UIAlertController(title:nil, message:nil, preferredStyle:.actionSheet )
            let op = UIAlertAction(title: "拍照", style:.default) { (_) in
                guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                    //print("摄像头不可用")
                    return
                }
                let picker = UIImagePickerController()
                picker.allowsEditing = true //允许编辑相片
                picker.sourceType = .camera //访问相册
                picker.delegate = self//成为代理
                self.present(picker, animated: true, completion: nil)
            }
            
            let op1 = UIAlertAction(title: "从相册选择", style:.default) { (_) in
                guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                    //print("相册不可用")
                    return
                }
                let picker = UIImagePickerController()
                picker.allowsEditing = true //允许编辑相片
                picker.sourceType = .photoLibrary //访问相册
                picker.delegate = self//成为代理
                self.present(picker, animated: true, completion: nil)
            }
            let op2 = UIAlertAction(title: "取消", style:.cancel, handler: nil)
            mmut.addAction(op)
            mmut.addAction(op1)
            mmut.addAction(op2)
            self.present(mmut, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        userphoto.image = info[UIImagePickerControllerOriginalImage] as! UIImage
        userphoto.contentMode = .scaleAspectFill
        userphoto.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func save(_ sender: UIButton) {//保存数据并返回
        
        if let img = UIImageJPEGRepresentation(userphoto.image!, 0.7){
          
            
            
            
        }
         ///performSegue(withIdentifier: "closeEditUserPhoto", sender:self )//返场
        
        
    }
    
    
 /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
