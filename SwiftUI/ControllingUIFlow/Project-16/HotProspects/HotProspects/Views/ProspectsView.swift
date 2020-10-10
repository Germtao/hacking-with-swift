//
//  ProspectsView.swift
//  HotProspects
//
//  Created by QDSG on 2020/10/10.
//

import SwiftUI

enum FilterType {
    case none, contacted, uncontacted
}

struct ProspectsView: View {
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "所有人"
        case .contacted:
            return "最近联系"
        case .uncontacted:
            return "未联系"
        }
    }
    
    @EnvironmentObject var prospects: Prospects
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(trailing: Button(action: {
                let prospect = Prospect()
                prospect.name = "Paul Hudson"
                prospect.emailAddress = "paul@hackingwithswift.com"
                self.prospects.people.append(prospect)
            }, label: {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            }))
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
