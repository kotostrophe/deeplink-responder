//
//  ActorViewController.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import Foundation
import UIKit

protocol ActorViewProtocol: AnyObject {
    func setActorData(_ actor: Actor)
}

final class ActorViewController: UIViewController {
    
    // MARK: - IBOutlet properites
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    
    // MARK: - Properties
    
    private let presenter: ActorPresenterProtocol
    
    // MARK: - Initializers
    
    init(presenter: ActorPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadData()
    }
    
    // MARK: - Configuration methods
    
    private func configureImage(with imageData: Data?) {
        guard let data = imageData else { return }
        imageView.image = .init(data: data)
    }
    
    private func configureTitle(with text: String) {
        titleLabel.text = text
    }
}

// MARK: - ActorViewProtocol

extension ActorViewController: ActorViewProtocol {
    
    func setActorData(_ actor: Actor) {
        configureImage(with: actor.imageData)
        configureTitle(with: actor.name)
    }
}
