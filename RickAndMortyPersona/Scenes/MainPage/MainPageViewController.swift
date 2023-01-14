//
//  ViewController.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import UIKit

class MainPageViewController: UIViewController, MainPageView {
     
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.textColor = UIColor(named: "TextWhite")
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    let pageControl: UIPaginationStack = {
        let pageControl = UIPaginationStack()

        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    let errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.textColor = UIColor(named: "TextWhite")
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        return errorLabel
    }()
    
    let collectionView: UICollectionView = {
        let collectionView:UICollectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.register(CollectionViewImageCell.self, forCellWithReuseIdentifier: "CollectionViewImageCell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var presenter: MainPagePresenter!

    var collectedData: [RickAndMortyCharacter] = []
    
    private init(withConfigurator configurator: MainPageConfigurator) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(MainPageViewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupCollectionView()
        addArrangedSubviews()
        setupConstraints()
        searchBar.delegate = self
        setupColors()
    }
    
    private func setupColors() {
        setupBackgroundColors()
        setupSearchBar()
        setupNavigationBarTitle()
        setupPageControl()
    }

    private func setupBackgroundColors() {
        self.view.backgroundColor = UIColor(named: "BackgroundGreen")
        self.collectionView.backgroundColor = UIColor(named: "BackgroundGreen")
    }
    
    private func setupSearchBar() {
        self.searchBar.isTranslucent = true
        self.searchBar.barTintColor = UIColor(named: "FrontGreen")
        self.searchBar.searchBarStyle = .minimal
    }
    
    private func setupNavigationBarTitle() {
        self.navigationController?.navigationBar.topItem?.title = "Rick And Morty"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(named: "TextWhite")!,
            NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 24)!
        ]
    }
    
    private func addArrangedSubviews() {
        self.view.addSubview(searchBar)
        self.view.addSubview(collectionView)
        self.view.addSubview(pageControl)
        self.view.addSubview(errorLabel)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupConstraints() {
        setupSearchBarConstraints()
        setupCollectionViewConstraints()
        setupPageControlConstraints()
        setupErrorLabelConstraints()
    }
    
    private func setupSearchBarConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Spacing.XS.floatValue),
            searchBar.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: Spacing.L.floatValue),
            searchBar.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -Spacing.L.floatValue)
        ])
    }
    
    private func setupCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: Spacing.S.floatValue),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: Spacing.L.floatValue),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -Spacing.L.floatValue)
        ])
    }
    
    private func setupPageControlConstraints() {
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -Spacing.L2.floatValue),
            pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Spacing.L2.floatValue)
        ])
    }
    
    private func setupErrorLabelConstraints() {
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            errorLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            errorLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
        ])
        errorLabel.isHidden = true
    }
    
    private func setupPageControl() {
        presenter.configurePageControl(pageControl)
        pageControl.configureButtons(
            rightButtonAction: { [unowned self] in
            presenter.nextPage()
            self.pageControl.configureLabel(labelTitle: String(presenter.currPage), maxPages: "42")
        },
            leftButtonAction: { [unowned self] in
            presenter.prevPage()
            self.pageControl.configureLabel(labelTitle: String(presenter.currPage), maxPages: "42")
        })
    }
    
    func showPageControl() {
        DispatchQueue.main.async { [unowned self] in
            self.pageControl.isHidden = false
        }
    }
    
    func showError(localisedErrorString: String) {
        errorLabel.text = localisedErrorString
        errorLabel.isHidden = false
    }
    
    func hideErrorMessage() {
        errorLabel.isHidden = true
    }
}

extension MainPageViewController {
    static func instantiate(configurator: MainPageConfigurator) -> MainPageViewController {
        MainPageViewController(withConfigurator: configurator)
    }
}

extension MainPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewImageCell", for: indexPath) as! CollectionViewImageCell
        presenter.configureCell(cell: cell, indexpath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getDataCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width/3+35), height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.goToDetailsPage(indexPath: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.inputViewController?.dismissKeyboard()
        searchBar.inputViewController?.dismissKeyboard()
        searchBar.endEditing(true)
    }
    
    func reload() {
        collectionView.reloadData()
        collectionView.setContentOffset(.zero, animated: false)
    }
}

extension MainPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchBarTextDidChange(text: searchText)
        pageControl.isHidden = true
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.inputViewController?.dismissKeyboard()
        searchBar.text = ""
        presenter.searchBarTextDidChange(text: "")
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
}




