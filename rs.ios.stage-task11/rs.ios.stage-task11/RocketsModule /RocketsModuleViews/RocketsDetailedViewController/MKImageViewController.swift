//
//  MKDetailedImageViewController.swift
//  rs.ios.stage-task11
//
//  Created by dev on 15.09.21.
//

import UIKit

class MKImageViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let dismissButtton = MKDismissButton()
    let imageView = UIImageView()
    
    var navBarCheck = true //показывает что навбар был
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .rsWhite
        
        if !(self.navigationController?.navigationBar.isHidden)! {
            navBarCheck = true
            self.navigationController?.navigationBar.isHidden = true
        }
            
        configureElements()
        layoutUI()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        scrollView.zoomScale = 1
    }
    
    
    // MARK: - Configurations
    private func configureElements() {
        scrollView.delegate = self
        scrollView.maximumZoomScale = 3
        scrollView.minimumZoomScale = 1
        scrollView.contentSize = imageView.bounds.size
        imageView.contentMode  = .scaleAspectFit
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints  = false
        setupGesturesAndTargets()
    }
    
    private func setupGesturesAndTargets() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleInterfaceAppearance))
        view.addGestureRecognizer(tap)
        dismissButtton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
    }
    
    @objc func toggleInterfaceAppearance() {
        dismissButtton.isHidden.toggle()
        self.view.toggle()
    }
    
    @objc private func dismissController() {
        self.navigationController?.popViewController(animated: true)
        if navBarCheck {
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    
    // MARK: - Layout
    private func layoutUI() {
        view.addSubview(scrollView)
        view.addSubview(dismissButtton)
        scrollView.addSubview(imageView)
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            dismissButtton.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            dismissButtton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            dismissButtton.heightAnchor.constraint(equalToConstant: 32),
            dismissButtton.widthAnchor.constraint(equalToConstant: 32),
        ])
    }
}


extension MKImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
    }
}

extension UIView {
    func toggle() {
        if self.backgroundColor == .rsWhite {
            self.backgroundColor = .black
        } else {
            self.backgroundColor = .rsWhite
        }
    }
}
