//
//  NamesToFacesViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/1.
//

import UIKit

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

private let screenW = UIScreen.main.bounds.width

class NamesToFacesViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (screenW - 10 * 4) / 3, height: 180)
        super.init(collectionViewLayout: layout)
        
        collectionView.backgroundColor = .white
        collectionView.register(NamesToFacesCell.nibForCell(),
                                forCellWithReuseIdentifier: NamesToFacesCell.reuseIdentifier())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var namesToFaces: [NamesToFaces] = [] {
        didSet {
            performSelector(onMainThread: #selector(reload), with: nil, waitUntilDone: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performSelector(inBackground: #selector(load), with: nil)
    }
    
    @objc private func reload() {
        collectionView.reloadData()
    }
    
    @objc private func load() {
        let defaults = UserDefaults.standard
        
//        if let saveModel = defaults.object(forKey: "namesToFaces") as? Data {
//            if let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(saveModel) as? [NamesToFaces] {
//                namesToFaces = decodedModel
//            }
//        }
        
        guard let saveModel = defaults.object(forKey: "namesToFaces") as? Data else { return }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            namesToFaces = try jsonDecoder.decode([NamesToFaces].self, from: saveModel)
        } catch {
            print("Failed to load namesToFaces.")
        }
    }
    
    private func save() {
//        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: namesToFaces, requiringSecureCoding: false) {
//            UserDefaults.standard.set(savedData, forKey: "namesToFaces")
//        }
        
        let jsonEncoder = JSONEncoder()
        guard let saveData = try? jsonEncoder.encode(namesToFaces) else {
            print("Failed to save namesToFaces.")
            return
        }
        UserDefaults.standard.set(saveData, forKey: "namesToFaces")
    }

    @objc private func addNewPerson() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return namesToFaces.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NamesToFacesCell.reuseIdentifier(), for: indexPath) as! NamesToFacesCell
        cell.update(with: namesToFaces[indexPath.item])
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var model = namesToFaces[indexPath.item]
        
        let alert = UIAlertController(title: "重命名", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { [unowned self, alert] _ in
            guard let newName = alert.textFields?[0].text else { return }
            model.name = newName
            self.namesToFaces[indexPath.item] = model
            
//            self.collectionView.reloadData()
            
            self.save()
        }))
        
        present(alert, animated: true)
    }

    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            try? imageData.write(to: imagePath)
        }
        
        let model = NamesToFaces(name: "Unknown", image: imageName)
        namesToFaces.append(model)
        
        dismiss(animated: true)
    }
}
