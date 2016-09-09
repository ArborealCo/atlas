//
//  Pager.swift
//  Atlas
//
//  Created by Isaac Overacker on 9/7/16.
//  Copyright © 2016 Arboreal, LLC. All rights reserved.
//

import UIKit

class Pager: UIPageViewController {

    var pages = [UIViewController]()

    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        dataSource = self

        guard let storyboard = storyboard else {
            return
        }

        let page1 = storyboard.instantiateViewControllerWithIdentifier("BoardViewController")
        let page2 = storyboard.instantiateViewControllerWithIdentifier("TrendingViewController")

        pages.append(page1)
        pages.append(page2)

        setViewControllers([page1], direction: .Forward, animated: false, completion: nil)
    }

}

// MARK: UIPageViewControllerDataSource
extension Pager: UIPageViewControllerDataSource {

    // swiftlint:disable:next line_length
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.indexOf(viewController) else {
            return nil
        }

        let previousIndex = currentIndex - 1
        if pages.indices.contains(previousIndex) {
            return pages[previousIndex]
        }

        return nil
    }

    // swiftlint:disable:next line_length
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.indexOf(viewController) else {
            return nil
        }

        let nextIndex = currentIndex + 1
        if pages.indices.contains(nextIndex) {
            return pages[nextIndex]
        }

        return nil
    }

}

// MARK: UIPageViewControllerDelegate
extension Pager: UIPageViewControllerDelegate {

}
