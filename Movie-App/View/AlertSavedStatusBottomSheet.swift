//
//  AlertSavedStatusBottomSheet.swift
//  Movie-App
//
//  Created by William Santoso on 16/09/23.
//

import SwiftUI

struct AlertSavedStatusBottomSheet: View {
    @Environment(\.dismiss) var dismiss
    var isSuccess: Bool
    
    var body: some View {
        Text(isSuccess ?  "Success" :  "Failed")
            .foregroundColor(isSuccess ?  .green :  .red)
            .presentationDetents([.fraction(0.1)])
    }
}

struct AlertSavedStatusBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            
        }
        .sheet(isPresented: .constant(true)) {
            AlertSavedStatusBottomSheet(isSuccess: false)
        }
    }
}
