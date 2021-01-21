//
//  AttributedLabelWrapper.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import SwiftUI
import Atributika


/*extension String {
    var attributedHTML: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var textHTML: String {
        return attributedHTML?.string ?? ""
    }
}*/



struct AttributedLabelWrapper: UIViewRepresentable {
    let html: String

    func makeUIView(context: UIViewRepresentableContext<Self>) -> AttributedLabel {
        let label = AttributedLabel()

        label.numberOfLines = 0

        let all = Style.font(.systemFont(ofSize: 17))
        let link = Style("a")
            .foregroundColor(.blue, .normal)
            .foregroundColor(.brown, .highlighted) // <-- detections with this style will be clickable now

        label.attributedText = html
            .style(tags: link)
            .styleLinks(link)
            .styleAll(all)

        label.onClick = { lbl, detection in
            switch detection.type {
                case .link(let url):
                    let urlString = url.absoluteString
                    let validUrlString = urlString.hasPrefix("http") ? urlString : "https://\(urlString)"
                    if let n_url = URL(string: validUrlString) {
                        UIApplication.shared.open(n_url)
                    }
                case .tag(let tag):
                    if tag.name == "a", let href = tag.attributes["href"], let url = URL(string: href) {
                        UIApplication.shared.open(url)
                    }
                default:
                    break
            }
        }

        return label

    }

    func updateUIView(_ uiView: AttributedLabel, context: UIViewRepresentableContext<Self>) {}

}
