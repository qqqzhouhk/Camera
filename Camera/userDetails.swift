//
//  userDetails.swift
//  Camera
//
//  Created by Apple on 16/10/8.
//  Copyright © 2016年 Eriiic. All rights reserved.
//

import UIKit
import MjpegStreamingKit

class userDetails: UIViewController {
    
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var playButton: UIButton!
    
    var url: URL?
    
    var playing = false
    
    var streamingController: MjpegStreamingController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        streamingController = MjpegStreamingController(imageView: imageView)
        streamingController.didStartLoading = { [unowned self] in
            self.loadingIndicator.startAnimating()
        }
        streamingController.didFinishLoading = { [unowned self] in
            self.loadingIndicator.stopAnimating()
        }
        
        url = URL(string: "http://192.168.10.123:7060")
        streamingController.contentURL = url
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    @IBAction func playAndStop(_ sender: Any) {
        if playing {
            playButton.setTitle("PLAY", for: .normal)
            streamingController.stop()
            playing = false
        } else {
            
            streamingController.play()
            playing = true
            playButton.setTitle("STOP", for: .normal)
        }
    }
    
    
}
