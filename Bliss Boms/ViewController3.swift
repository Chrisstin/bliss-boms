//
//  ViewController3.swift
//  Bliss Boms
//
//  Created by Christine Newbery on 22/09/2015.
//  Copyright (c) 2015 Christine Newbery. All rights reserved.
//


import UIKit

class ViewController3: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
  
  var deck = [CardView]()
  var pageController: UIPageViewController?
  
  
  // MARK: - Initial set up
  
  override func viewDidLoad() {
    super.viewDidLoad()
    createDeck()
    createPageViewController()
    setUpPageControl()
  }
  
  func createDeck() {
    
    for cardNum in 1...NumCards {
      let card = CardViewRectangle(cardNum: cardNum)
      self.deck.append(card)
    }
  }
  
  func createPageViewController() {
    
    pageController = UIPageViewController(
      transitionStyle: .Scroll,
      navigationOrientation: .Horizontal,
      options: nil)
    
    pageController?.delegate = self
    pageController?.dataSource = self
    
    let startingViewController: PageItemController = viewControllerAtIndex(0)!
    
    let viewControllers: NSArray = [startingViewController]
    pageController!.setViewControllers(viewControllers as? [UIViewController],
      direction: .Forward,
      animated: false,
      completion: nil)
    
    self.addChildViewController(pageController!)
    self.view.addSubview(self.pageController!.view)
    
    let pageViewRect = self.view.bounds
    pageController!.view.frame = pageViewRect
    pageController!.didMoveToParentViewController(self)
  }
  
  func setUpPageControl() {
    let appearance = UIPageControl.appearance()
    appearance.pageIndicatorTintColor = UIColor.grayColor()
    appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
    appearance.backgroundColor = UIColor.darkGrayColor()
  }
  
  // MARK: - UIPageViewControllerDataSource
  
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    
    let itemController = viewController as! PageItemController
    
    if itemController.itemIndex > 0 {
      return viewControllerAtIndex(itemController.itemIndex-1)
    }
    return nil
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    let itemController = viewController as! PageItemController
    
    if itemController.itemIndex < deck.count {
      return viewControllerAtIndex(itemController.itemIndex+1)
    }
    return nil
  }
  
  func viewControllerAtIndex(index: Int) -> PageItemController? {
    
    if (deck.count == 0) ||
      (index >= deck.count) {
        return nil
    }
    
    let storyBoard = UIStoryboard(name: "Main",
      bundle: NSBundle.mainBundle())
    let pageItemController = storyBoard.instantiateViewControllerWithIdentifier("PageItem") as! PageItemController
    
    pageItemController.currentCard = deck[index]
    pageItemController.itemIndex = index
    return pageItemController
  }
  
  
  // MARK: - Page Indicator
  // (currently hidden under tab bar)
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return deck.count
  }
  
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    return 0
  }
  
  // MARK: - Other
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
}

