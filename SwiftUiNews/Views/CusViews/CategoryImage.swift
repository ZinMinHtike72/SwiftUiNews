//
//  CategoryImage.swift
//  SwiftUiNews
//
//  Created by ZMH Sabahna on 1/25/24.
//

import SwiftUI
import Kingfisher

struct CategoryImage: View {
    var isSelected : Bool
    var category: CategoryModel
    var body: some View {
        ZStack(){
            KFImage(URL(string: "https://source.unsplash.com/featured/300x20\(category.id)")).resizable()
                .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/).cornerRadius(10)
            VStack(alignment: .trailing){
                if(isSelected){
                    Image(systemName: "checkmark.seal.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.top, 10) // Adjust the top padding to position the check mark
                        .padding(.trailing, 10).foregroundColor(Color("AppColor"))
                }
                Spacer()
                Text("\(category.name)")
                    .font(.system(size: 20,weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal,10)
                    .padding(.bottom,10)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    
               
            }
            if(!isSelected){
                Color.black.opacity(0.3).cornerRadius(10)
            }
            
        }
    }
}
