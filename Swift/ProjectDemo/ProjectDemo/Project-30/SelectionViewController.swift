//
//  SelectionViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/4.
//

import UIKit

class SelectionViewController: UITableViewController {
    
    private var items = [String]()
    
    private var viewControllers = [UIViewController]()
    
    var dirty = false
    
    private var loadImageOperations = [String: Any]()
    
    private var imageLoadingOperationQueue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Reactionist"
        
        tableView.rowHeight = 90
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: UITableViewCell.reuseIdentifier())
        
        let manager = FileManager.default
        guard let path = Bundle.main.resourcePath,
              let tempItems = try? manager.contentsOfDirectory(atPath: path) else { return }
        
        let arr = tempItems.filter { $0.range(of: "Large") != nil }
        items += arr
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if dirty { tableView.reloadData() }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        imageLoadingOperationQueue.cancelAllOperations()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count * 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier(), for: indexPath)
        
        let currentImage = self.items[indexPath.row % self.items.count]
        let imageRootName = currentImage.replacingOccurrences(of: "Large", with: "Thumb")
        
        let loadImageBlockOp = BlockOperation()
        loadImageBlockOp.addExecutionBlock { [unowned self, loadImageBlockOp] in
            let path = Bundle.main.path(forResource: imageRootName, ofType: nil) ?? ""
            let original = UIImage(contentsOfFile: path) ?? UIImage()
            
            let renderer = UIGraphicsImageRenderer(size: original.size)
            let image = renderer.image { ctx in
                ctx.cgContext.addEllipse(in: CGRect(origin: .zero, size: original.size))
                ctx.cgContext.clip()
                
                original.draw(at: .zero)
            }
            
            OperationQueue.main.addOperation {
                if !loadImageBlockOp.isCancelled {
                    let cell = tableView.cellForRow(at: indexPath)
                    cell?.imageView?.image = image
                    cell?.textLabel?.text = "\(indexPath.row)"
                    
                    //                cell.imageView?.layer.shadowColor = UIColor.black.cgColor
                    //                cell.imageView?.layer.shadowOpacity = 1
                    //                cell.imageView?.layer.shadowRadius = 10
                    //                cell.imageView?.layer.shadowOffset = CGSize.zero
                    
                    self.loadImageOperations.removeValue(forKey: imageRootName)
                }
            }
        }
        
        if !imageRootName.isEmpty {
            loadImageOperations[imageRootName] = loadImageBlockOp
        }
        
        imageLoadingOperationQueue.addOperation(loadImageBlockOp)
        
        cell.imageView?.image = nil
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentImage = self.items[indexPath.row % self.items.count]
        let imageRootName = currentImage.replacingOccurrences(of: "Large", with: "Thumb")
        
        guard let loadImageBlockOp = loadImageOperations[imageRootName] as? BlockOperation else { return }
        
        loadImageBlockOp.cancel()
        loadImageOperations.removeValue(forKey: imageRootName)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ImageViewController()
        vc.image = items[indexPath.row % items.count]
        vc.owner = self
        
        // 当我们返回时, 将我们标记为不需要重新加载计数器
        dirty = false
        
        viewControllers.append(vc)
        navigationController?.pushViewController(vc, animated: true)
    }

}
