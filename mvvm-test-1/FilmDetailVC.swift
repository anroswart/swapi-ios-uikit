//
//  FilmDetailVC.swift
//  mvvm-test-1
//
//  Created by Anro Swart on 2018/01/30.
//  Copyright © 2018 NRTJ. All rights reserved.
//

import UIKit
import Cosmos

class FilmDetailVC: UIViewController {
    
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var filmReleaseDate: UILabel!
    @IBOutlet weak var filmCharacters: UITextView!
    @IBOutlet weak var filmCrawlingText: UITextView!
    @IBOutlet weak var filmCrawlPlaceholder: UIView!
    @IBOutlet weak var filmRating: CosmosView!
    
    
    var viewModel: FilmDetailViewModel?
    var crawlText: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUX()
        initView()
    }
    
    func initUX() {
        // Setup Crawling Text
        let og = filmCrawlPlaceholder.layer.visibleRect.origin
        let rc = filmCrawlPlaceholder.layer.visibleRect
        crawlText = UITextView(frame: CGRect(x: og.x, y: og.y, width: rc.width, height: rc.height))
        crawlText!.backgroundColor = filmCrawlingText.backgroundColor
        crawlText!.textColor = filmCrawlingText.textColor
        crawlText!.font = filmCrawlingText.font
        //crawlText!.contentSize = filmCrawlingText.contentSize
        crawlText!.contentSize = rc.size
        crawlText!.isEditable = false
        crawlText!.isScrollEnabled = false
        crawlText!.textAlignment = .center
        crawlText!.center = CGPoint(x: filmCrawlPlaceholder.frame.width / 2, y: filmCrawlPlaceholder.frame.height / 2)
        
        // Transform perspective
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 500
        transform = CATransform3DRotate(transform, CGFloat(45 * Double.pi / 180), 1, 0, 0)
        crawlText!.layer.transform = transform
        
        filmCrawlPlaceholder.addSubview(crawlText!)
    }
    
    // Credits style animation
    func loopCrawlingText(textView: UITextView) {
        textView.isScrollEnabled = true
        
        // ?? Skips animation for some reason, tried a bunch of stuff
        DispatchQueue.main.async {
            UIView.animate(withDuration: 6.0, animations: {
             //textView.contentOffset = CGPoint.zero
             let range = NSMakeRange(textView.text.characters.count - 1, 0)
             textView.scrollRangeToVisible(range)
             }, completion: nil)
        }
    }
    
    func initView() {
        filmTitle.text = viewModel!.film.title
        filmReleaseDate.text = viewModel!.film.release_date
        filmCharacters.text = viewModel!.film.characters!.joined(separator: ", ")
        crawlText!.text = viewModel!.getOpeningCrawl()
        filmRating.rating = viewModel!.film.rating! / 2
        loopCrawlingText(textView: crawlText!)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}



