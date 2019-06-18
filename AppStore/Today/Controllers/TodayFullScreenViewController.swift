//
//  FullScreenTableViewController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-10.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class TodayFullScreenViewController: UIViewController {
  
  // MARK: - constants
  
  private let itemHeight: CGFloat = 400
  
  private let mainScrollView: UIScrollView = {
    let sv = UIScrollView(frame: .zero)
    sv.contentInsetAdjustmentBehavior = .never // no insets
    sv.scrollIndicatorInsets = UIEdgeInsets(top: 400, left: 0, bottom: 0, right: 0)
    return sv
  }()
  
  let todayCardView = TodayCardView(frame: .zero)
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    let attributedText = NSMutableAttributedString(string: "Learning about science can always be more fun.", attributes: [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 18) ])
    
    attributedText.append(NSAttributedString(string: " That was the idea that Komal Dadlani, CEO and co-founder of the Chilean studio Lab4U had in mind when studying biochemistry at the University of Chile.\n\n\"You cannot learn to ride a bicycle by reading a book, you have to live the experience and ride the bicycle. The same happens with science,\" she says.\n\nThe solution? Leverage the built-in features of the iPhone and iPad to enable teachers to improve their physics lessons through experiments. The accelerometer, microphone and camera are features often used by games and photography apps, but they're also really useful in science education\n\n Do you want to figure out the difference between distance and displacement? Jump on the \"You've Got the Moves\" experiment. Just start walking with your device and the Lab4Physics app will build a reference system that, through graphics, will show you the difference.\n\nIf you want to know what a sound wave looks like, try experiment \"So Wavy\" with Marie Curie. Whistle close to the speaker and you'll see the sound's shape in an amptitude vs. time graphic.\n\nThere are multiple experiments for you to discover the principles of physics, beyond the books. Just a little warning: the activities are designed for children over 13. For teachers, the app includes support materials designed to bring the app's experiments into their classes. \"Talent is universal, but not the opportunities. We want to democratize science by enabling both teachers and students to have a laboratory in their pockets,\" says Dadlani.", attributes: [.foregroundColor: UIColor.gray]))
    
    label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    label.attributedText = attributedText
    label.numberOfLines = 0 // infinite lines
    
    return label
  }()
  
  // MARK: - variables
  
  var todayItem: TodayItem? {
    didSet {
      todayCardView.todayItem = todayItem
    }
  }
  // status bar animation
  var statusBarHidden = false
  override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
    return .slide
  }
  override var prefersStatusBarHidden: Bool {
    return statusBarHidden
  }
  
  // MARK: - view controller life cylces
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupPanGestureRecognizer()
  }
  
  // MARK: - helper methods
  
  private func setupUI() {
    view.clipsToBounds = true
    view.backgroundColor = .white
    view.addSubview(mainScrollView)
    mainScrollView.matchParent()
    
    let cardWrapperView = UIView()
    mainScrollView.addSubview(cardWrapperView)
    cardWrapperView.anchors(topAnchor: mainScrollView.topAnchor, leadingAnchor: mainScrollView.leadingAnchor, trailingAnchor: mainScrollView.trailingAnchor, bottomAnchor: nil)
    let cardWrapperHeight = cardWrapperView.heightAnchor.constraint(equalToConstant: 400)
    cardWrapperHeight.priority = .defaultHigh
    cardWrapperHeight.isActive = true
    
    cardWrapperView.addSubview(todayCardView)
    let todayCardViewTop = todayCardView.topAnchor.constraint(equalTo: cardWrapperView.topAnchor)
    todayCardViewTop.priority = .defaultHigh
    todayCardViewTop.isActive = true
    
    todayCardView.leadingAnchor.constraint(equalTo: cardWrapperView.leadingAnchor).isActive = true
    todayCardView.trailingAnchor.constraint(equalTo: cardWrapperView.trailingAnchor).isActive = true
    
    NSLayoutConstraint(item: todayCardView, attribute: .width, relatedBy: .equal, toItem: cardWrapperView, attribute: .width, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: todayCardView, attribute: .height, relatedBy: .equal, toItem: cardWrapperView, attribute: .height, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: todayCardView, attribute: .top, relatedBy: .lessThanOrEqual, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
    
    mainScrollView.addSubview(descriptionLabel)
    let descriptionLabelWidth = descriptionLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 32)
    descriptionLabelWidth.priority = .required
    descriptionLabelWidth.isActive = true
    
    descriptionLabel.anchors(topAnchor: cardWrapperView.bottomAnchor, leadingAnchor: mainScrollView.leadingAnchor, trailingAnchor: mainScrollView.trailingAnchor, bottomAnchor: mainScrollView.bottomAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
  }
}

// MARK: - UIGestureRecognizerDelegate

extension TodayFullScreenViewController: UIGestureRecognizerDelegate {
  
  private func setupPanGestureRecognizer() {
    let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragToDismiss))
    gestureRecognizer.delegate = self
    view.addGestureRecognizer(gestureRecognizer)
  }
  
  @objc private func dragToDismiss(gesture: UIPanGestureRecognizer) {
    let contentOffsetY: CGFloat = mainScrollView.contentOffset.y
    // we do not want to transform when the contentOffset > 0
    // contentOffsetY == 0 when scrolled to the top
    if contentOffsetY > 0 { return }
    
    let translationY = gesture.translation(in: view).y
    if gesture.state == .changed {
      // we do not want to transfrom when scrolling up
      if translationY > 0 {
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.isScrollEnabled = false
        var scale = 1 - (translationY / 2000)  // translationY value too big
        // 0.85 <= scale <= 1
        scale = max(0.85, min(1, scale))
        view.transform = CGAffineTransform(scaleX: scale, y: scale)
        view.layer.cornerRadius = (1 - scale) * (16 / 0.15)
      }
    } else if gesture.state == .ended {
      if translationY > 200 {
        presentingViewController?.dismiss(animated: true, completion: nil)
      } else {
        view.transform = .identity
        mainScrollView.showsVerticalScrollIndicator = true
        mainScrollView.isScrollEnabled = true
      }
    }
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
