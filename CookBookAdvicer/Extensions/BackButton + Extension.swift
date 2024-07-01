import Foundation
import SwiftUI

struct BackButtonToolbarModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    
    let placement: ToolbarItemPlacement

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: placement) {
                    Image(systemName: "arrowshape.backward.circle")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.black)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
    }
}

extension View {
    func customBackButton(placement: ToolbarItemPlacement = .topBarLeading) -> some View {
        self.modifier(BackButtonToolbarModifier(placement: placement))
    }
}
