//
//  PictureGridView.swift
//  amoring
//
//  Created by 이준녕 on 11/21/23.
//

import SwiftUI

enum PictureModel: Hashable {
    case newPicture(UIImage, String)
    case storedPicture(String, UIImage, String)
    
    var picture: UIImage {
        switch self{
        case .newPicture(let image, _):
            return image
        case .storedPicture(_, let image, _):
            return image
        }
    }
    
    var url: String {
        switch self{
        case .newPicture(_, let urlString):
            return urlString
        case .storedPicture(_, _, let urlString):
            return urlString
        }
    }
}

protocol Draggable{
    var isDraggable: Bool { get }
}

struct GridCell: Hashable, Identifiable, Draggable {
    private (set) var id: UUID = UUID()
    var picture: PictureModel? = nil
    var isDraggable: Bool {
        picture != nil
    }
}

struct PictureGridView: View {
//    let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//    ]
    @Binding var pictures: [PictureModel]
//    @Binding var picturesChanged: Bool
    @Binding var droppedOutside: Bool
    @State var cells: [GridCell] = (0...5).map{  _ in GridCell() }

    let onAddedImageClick: (Int) -> ()
    let onAddImageClick: () -> ()
    
//    init( pictures: Binding< [PictureModel] >,  picturesChanged: Binding<Bool> = .constant(false), droppedOutside: Binding<Bool> = .constant(false), onAddedImageClick: @escaping (Int) -> () = {value in}, onAddImageClick: @escaping () -> () = {}){
//        self._pictures = pictures
//        self._picturesChanged = picturesChanged
//        self._droppedOutside = droppedOutside
//        self.onAddImageClick = onAddImageClick
//        self.onAddedImageClick = onAddedImageClick
//    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                getCellView(cell: cells[0], number: 1)
                    .layoutPriority(1)
                VStack(spacing: 0) {
                    getCellView(cell: cells[1], number: 2)
                    getCellView(cell: cells[2], number: 3)
                }
            }
            HStack(spacing: 0) {
                getCellView(cell: cells[3], number: 4)
                getCellView(cell: cells[4], number: 5)
                getCellView(cell: cells[5], number: 6)
            }
        }
        // TODO: Implement Dragging?
//        LazyVGrid(columns: columns, spacing: 0) {
//            ReorderableForEach(droppedOutside: $droppedOutside, items: cells) { cell in
//                getCellView(cell: cell)
//            } moveAction: { from, to in
//                picturesChanged = true
//                cells.move(fromOffsets: from, toOffset: to)
//            }
//            
//        }
        .onChange(of: pictures, perform: { newValue in
            cells = (0...8).map{ GridCell(picture: $0 < newValue.count ? newValue[$0] : nil)}
        })
        .onAppear {
            cells = (0...8).map{ GridCell(picture: $0 < pictures.count ? pictures[$0] : nil)}
        }
    }
    
    @ViewBuilder
    func getCellView(cell: GridCell, number: Int) -> some View {
        if let picture = cell.picture, let index = pictures.firstIndex(of: picture) {
            return AnyView(AddedImageView(image: picture.picture, number: number, action:{
                onAddedImageClick(index)
            }))
        } else {
            return AnyView(AddImageView(number: number, action: onAddImageClick))
        }
    }
}

//struct PictureGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        PictureGridView(pictures: .constant([]), droppedOutside: .constant(false), onAddedImageClick: {index in}, onAddImageClick: {})
//    }
//}
