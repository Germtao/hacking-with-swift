//
//  SelfieShareViewController.swift
//  ProjectDemo
//
//  Created by QDSG on 2021/6/3.
//

import UIKit
import MultipeerConnectivity

private let screenW = UIScreen.main.bounds.width

class SelfieShareViewController: UICollectionViewController {
    
    private var images = [UIImage]()
    
    private var peerID: MCPeerID!
    private var mcSession: MCSession!
    private var mcAdvertiserAssistant: MCAdvertiserAssistant!
    
    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (screenW - 4 * 10) / 3, height: 145)
        
        super.init(collectionViewLayout: layout)
        
        collectionView.backgroundColor = .white
        collectionView.register(SelfieShareCell.nibForCell(),
                                forCellWithReuseIdentifier: SelfieShareCell.reuseIdentifier())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Selfie Share"

        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
        let cameraItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
        navigationItem.rightBarButtonItems = [addItem, cameraItem]
        
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelfieShareCell.reuseIdentifier(), for: indexPath) as! SelfieShareCell
    
        cell.imageView.image = images[indexPath.item]
    
        return cell
    }
    
}

// MARK: - Actions

extension SelfieShareViewController {
    @objc private func showConnectionPrompt() {
        let alert = UIAlertController(title: "会议连接", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "主持会议", style: .default, handler: startHosting))
        alert.addAction(UIAlertAction(title: "加入会议", style: .default, handler: joinSession))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func startHosting(_ action: UIAlertAction) {
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "hws-project25", discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant.start()
    }
    
    private func joinSession(_ action: UIAlertAction) {
        let mcBrowser = MCBrowserViewController(serviceType: "hws-project25", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension SelfieShareViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        
        images.insert(image, at: 0)
        collectionView.reloadData()
        
        sendImage(image)
    }
    
    private func sendImage(_ image: UIImage) {
        // 1.
        guard mcSession.connectedPeers.count > 0 else { return }
        
        // 2.
        guard let imageData = image.pngData() else { return }
        
        // 3.
        do {
            try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable)
        } catch {
            let alert = UIAlertController(title: "发送错误", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "我知道了", style: .default))
            present(alert, animated: true)
        }
    }
}

// MARK: - MCBrowserViewControllerDelegate

extension SelfieShareViewController: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
}

// MARK: - MCSessionDelegate

extension SelfieShareViewController: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("Connected: \(peerID.displayName)")
        case .connecting:
            print("Connecting: \(peerID.displayName)")
        case .notConnected:
            print("Not Connected: \(peerID.displayName)")
        default:
            break
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        guard let image = UIImage(data: data) else { return }
        
        DispatchQueue.main.async { [unowned self] in
            self.images.insert(image, at: 0)
            self.collectionView.reloadData()
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
}
