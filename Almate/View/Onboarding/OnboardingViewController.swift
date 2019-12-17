//
//  OnboardingViewController.swift
//  Almate
//
//  Created by Andi Ikhsan Eldrian on 13/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageIndex: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides:[Slide] = [];
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true

    }
    
    func createSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.illustrationImage.image = UIImage(named: "ic_onboarding_1")
        slide1.titleLabel.text = "Find great opportunities"
        slide1.descriptionLabel.text = "Browse and share jobs in various fields with others"
        currentIndex = slides.count
//        slide1.backgroundColor = .yellow
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.illustrationImage.image = UIImage(named: "ic_onboarding_2")
        slide2.titleLabel.text = "Build meaningful relationship"
        slide2.descriptionLabel.text = "Find fellow alumni and students based on their expertise and build professional network"
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.illustrationImage.image = UIImage(named: "ic_onboarding_3")
        slide3.titleLabel.text = "Stay connected"
        slide3.descriptionLabel.text = "Stay up to date with latest news from your institution"
        
        return [slide1, slide2, slide3]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 549.0)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: 549.0)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }

}
