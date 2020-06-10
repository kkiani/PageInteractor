import Foundation

open class PageInteractor<T>{
    private var data = [T]()
    private let startPage: Int
    private var page: Int
    private(set) var isLoading: Bool = false
    public var identifier: String?
    public var delegate: PageInteractorDelegate
    
    
    public init(firstPage: Int, delegate: PageInteractorDelegate) {
        self.delegate = delegate
        self.page = firstPage
        self.startPage = firstPage
    }
    
    private func loadPage(refresh: Bool){
        isLoading = true

        delegate.pageInteractor(self, fetchDataForPage: page) { [weak self] (newBatch: [Any]) in
            guard let newBatch = newBatch as? [T] else {
                fatalError("type not match")
            }
            
            // no further page
            guard newBatch.count > 0 else{
                return
            }
            
            if refresh{
                self?.data = newBatch
            }
            else{
                self?.data.append(contentsOf: newBatch)
            }
            
            self?.page += 1
            self?.isLoading = false
        }
    }
}

extension PageInteractor{
    public func prefetchIfNeededItem(at index: Int){
        if !isLoading && index >= data.count - 1 {
            loadPage(refresh: false)
        }
    }
    
    public func item(for index: Int) -> T{
        return data[index]
    }
        
    public func numberOfVisibleItems() -> Int{
        return data.count
    }

    public func reload(){
        page = startPage
        loadPage(refresh: true)
    }
}
