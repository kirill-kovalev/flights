//
//  SafariView.swift
//  flightApp
//
//  Created by Кирилл on 03.06.2020.
//  Copyright © 2020 Kovalev K.A. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}

struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(url: URL(string: "http://ya.ru")! )
    }
}
