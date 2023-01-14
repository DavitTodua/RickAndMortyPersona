//
//  MainPagePresenter.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import UIKit

protocol MainPageView: AnyObject {
    func reload()
    func showPageControl()
    func showError(localisedErrorString: String)
    func hideErrorMessage()
}

protocol MainPagePresenter {
    func viewDidLoad()
    func configureCell(cell: CollectionViewImageCell, indexpath: IndexPath)
    var currPage: Int { get }
    func goToDetailsPage(indexPath: IndexPath)
    func searchBarTextDidChange(text: String)
    func nextPage()
    func prevPage()
    func getDataCount()-> Int
    func configurePageControl(_ pageControl: UIPaginationStack)
}

class MainPagePresenterImplementation: MainPagePresenter {
    let view: MainPageView?
    let router: MainPageRouter
    var collectedData: [RickAndMortyCharacter] = []
    var currPage: Int = 1
    
    let displayPageUseCase: DisplayPageUseCase
    let searchNameUseCase: SearchNameUseCase
    
    init(view: MainPageView,
         router:MainPageRouter,
         displayPageUseCase: DisplayPageUseCase,
         searchNameUseCase: SearchNameUseCase) {
        self.view = view
        self.router = router
        self.displayPageUseCase = displayPageUseCase
        self.searchNameUseCase = searchNameUseCase
    }
    
    func viewDidLoad() {
        fetchPage(currPage)
    }
    
    func fetchPage(_ number: Int) {
        let pageNum = number
        displayPageUseCase.displayPage(forPage: pageNum) { result in
            switch result {                
            case .failure(let error):
                self.collectedData = []
                DispatchQueue.main.async {
                    self.view?.reload()
                    self.view?.showError(localisedErrorString: error.localizedDescription)
                }
            case .success(let decodedData):
                self.collectedData = decodedData.results
                DispatchQueue.main.async {
                    self.view?.hideErrorMessage()
                    self.view?.reload()
                }
            }
        }
    }
    
    func fetchSearchedName(text: String) {
        searchNameUseCase.fetchSearchedName(name: text) { result in
            switch result {
            case .success(let decodedData):
                self.collectedData = decodedData.results
                DispatchQueue.main.async {
                    self.view?.hideErrorMessage()
                    self.view?.reload()
                }
            case .failure(let error):
                self.collectedData = []
                DispatchQueue.main.async {
                    self.view?.reload()
                    self.view?.showError(localisedErrorString: error.localizedDescription)
                }
            }
        }
    }
    
    func goToDetailsPage(indexPath: IndexPath) {
        self.router.MoveToDetailsPage(characterDetails: collectedData[indexPath.row])
    }
    
    func configureCell(cell: CollectionViewImageCell, indexpath: IndexPath) {
        cell.configure(
            title: collectedData[indexpath.row].name,
            ImageUrl: collectedData[indexpath.row].image,
            status: "Status :" + collectedData[indexpath.row].status,
            statusImage: configureImageForStatus(status: collectedData[indexpath.row].status))
    }
    
    private func configureImageForStatus(status: String)-> UIImage?
    {
        if status == "Alive" {
            return UIImage(named: "DarkGreenCircle")
        }
        if status == "Dead" {
            return UIImage(named: "DarkRedCircle")
        } else {
            return UIImage(named: "BlackCircle")
        }
    }
    
    func searchBarTextDidChange(text: String) {
        if text == "" {
            fetchPage(currPage)
            view?.showPageControl()
        } else {
            fetchSearchedName(text: text)
        }
    }
    
    func nextPage() {
        if currPage != 42 {
            currPage = currPage + 1
            fetchPage(currPage)
        }
    }
    
    func prevPage() {
        if currPage != 1 {
            currPage = currPage - 1
            fetchPage(currPage)
        }
    }
    
    func getDataCount()-> Int {
        return collectedData.count
    }
    
    func configurePageControl(_ pageControl: UIPaginationStack) {
        pageControl.configure(
            model: .init(labelTitle: "1",
                         maxPages: "42",
                         rightButtonText: "Next",
                         leftButtonText: "Prev",
                         rightButtonBackgroundColor: UIColor(named: "DarkBlue")!,
                         leftButtonBackgroundColor: UIColor(named: "DarkBlue")!,
                         labelsTextColor: UIColor(named: "TextWhite")!))
    }
}
