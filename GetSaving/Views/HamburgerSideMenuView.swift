//
//  HamburgerSideMenuView.swift
//  GetSaving
//
//  Created by Kajetan Patryk Zarzycki on 26/08/2023.
//

import SwiftUI

struct HamburgerSideMenuView<Content: View>: View {
    @Binding var isShowing: Bool
    var content: Content
    var edgeTransition: AnyTransition = .move(edge: .leading)
    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .transition(edgeTransition)
                    .background(
                        Color.clear
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}

struct HamburgerSideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        HamburgerSideMenuView(isShowing: .constant(true), content: TransactionView(isSideMenuShowing: .constant(true)))
    }
}
