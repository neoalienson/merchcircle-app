//
//  AccountViewController.swift
//  InstaStore
//
//  Created by Neo on 3/21/15.
//  Copyright (c) 2015 instastore. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate
{
    struct Product {
        var name : String
        var price : String
        var date : String
        var sold : Bool
    }
    var imagePicker: UIImagePickerController!
    
    var products = [Product]()

    @IBOutlet var imageViewPhoto : UIImageView!
    @IBOutlet var buttonSell : UIButton!
    @IBOutlet var tableViewProducts : UITableView!
    var imageTemp : UIImage!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products.append(Product(name: "Mastercard hygiene kit", price: "$30 HKD", date: "March 22, 2015", sold: false))
        products.append(Product(name: "Horse Mask", price: "$155 HKD", date: "March 22, 2015", sold: true))
        products.append(Product(name: "2 T. Swift Tickets", price: "$2,000 HKD", date: "March 19, 2015", sold: false))
        products.append(Product(name: "HP printer", price: "$50 HKD", date: "Feb 26, 2015", sold: false))
        products.append(Product(name: "Tiffany bracelet", price: "$1,060 HKD", date: "January 20, 2015", sold: false))
        
        imageViewPhoto.layer.cornerRadius = imageViewPhoto.frame.size.height / 2
        imageViewPhoto.clipsToBounds = true
        
        buttonSell.layer.cornerRadius = buttonSell.frame.size.height / 10
        buttonSell.clipsToBounds = true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("productCell") as UITableViewCell?
        
        let idx = indexPath.item
        print(idx)

        let view = cell!.contentView.subviews[2] as UIView
        
        view.layer.cornerRadius = view.frame.size.height / 2

        let labelName = cell!.contentView.subviews[3] as? UILabel
        let product = products[idx]
        labelName!.text = product.name

        let labelPrice = cell!.contentView.subviews[0] as? UILabel
        labelPrice!.text = product.price

        let labelDate = cell!.contentView.subviews[1] as? UILabel
        labelDate!.text = product.date

        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonStart(sender: AnyObject) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)

    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)

        // load and resized image
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let resizeRate:CGFloat = 5.0
        let newSize = CGSizeMake(image.size.width / resizeRate, image.size.height / resizeRate)
        image.resize(newSize, completionHandler: { [weak self](resizedImage, data) -> () in
            let image = resizedImage
            self?.imageTemp = image
            // move to another view after resize
            self?.showProductView()
        })
    }

    func showProductView() {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProductAddViewController") as! ProductAddViewController

        viewController.image = imageTemp
        viewController.masterView = self
        
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_picker: UIImagePickerController) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func refresh() {
        self.tableViewProducts.reloadData()
    }
}

