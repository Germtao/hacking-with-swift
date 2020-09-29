//
//  Loading.swift
//  BucketList
//
//  Created by QDSG on 2020/9/27.
//

import SwiftUI

enum LoadingState {
    case loading, loaded, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed!")
    }
}
