//
//  BookCell.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/10/24.
//

import SwiftUI

struct BookCell: View {
    var book: Book
    let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            HStack(alignment: .top, spacing: 12){
                Text(book.name)
                Text(dateFormatter.string(from: book.time))
            }
                .font(.title3)
            Text(book.location)
                .font(.subheadline)
        }
    }
}

#Preview {
    BookCell(book: Book(id: UUID().uuidString, name: "Connor", time: Date(), location: "Yellow Vase"))
}
