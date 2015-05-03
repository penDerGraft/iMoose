//
//  ImageViewController.swift
//  iMoose
//
//  Created by Brent Pendergraft on 4/23/15.
//  Copyright (c) 2015 Bpenderg. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate
{

    
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var species = String()
    var weight = String()
    var color = String()
    var time = String()
    
    
    
    
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet private weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size // critical to set this!
            scrollView.delegate = self                    // required for zooming
            scrollView.minimumZoomScale = 0.03            // required for zooming
            scrollView.maximumZoomScale = 1.0             // required for zooming
            scrollView.zoomScale = 0.11
            
        }
    }
    
    // UIScrollViewDelegate method
    // required for zooming
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    private var imageView = UIImageView()
    
    // convenience computed property
    // lets us get involved every time we set an image in imageView
    // we can do things like resize the imageView,
    //   set the scroll view's contentSize,
    //   and stop the spinner
    var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            if let width = imageView.superview?.frame.size.width {
                if let height = imageView.superview?.frame.size.height {
                    imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
                }
                    
            }
            
            imageView.contentMode = .ScaleAspectFit
//            self.imageView.frame = CGRectMake (0,0,scrollView?.frame.size.width,self.scrollView.frame.size.height);
            scrollView?.contentSize = imageView.frame.size
        
            //spinner?.stopAnimating()
        }
    }
    
    // put our imageView into the view hierarchy
    // as a subview of the scrollView
    // (will install it into the content area of the scroll view)
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        speciesLabel.text = species
        weightLabel.text = weight
        colorLabel.text = color
        timeLabel.text = time
    }
    
    // for efficiency, we will only actually fetch the image
    // when we know we are going to be on screen
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        if image == nil {
//            fetchImage()
//        }
//    }
}
