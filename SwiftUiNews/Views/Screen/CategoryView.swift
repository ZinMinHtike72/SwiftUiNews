//
//  CategoryView.swift
//  SwiftUiNews
//
//  Created by ZMH Sabahna on 1/25/24.
//

import SwiftUI

struct CategoryView: View {
    let griColumns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())];
    @State var categoryList : [CategoryModel] = [CategoryModel]()
    @State var selectedList : [String] = []
    @State var apiStatus : ApiStatus = ApiStatus.processing
    
    private func selectCategory(id: String){
        if let index = self.selectedList.firstIndex(where: { $0 == id }) {
            self.selectedList.remove(at: index)
        }else{
            self.selectedList.append(id)
        }
    }
    
    private func getCategory (){
        apiStatus = ApiStatus.processing
        NetworkManager.instance.get(path: URL(string: "\(ApiPath.BasePath)\(ApiPath.CategoriesPath)")!){ value,error  in
            if(!error){
                apiStatus = ApiStatus.completed
                let jsonList = value!["data"].arrayValue
                for category in jsonList{
                    self.categoryList.append(CategoryModel(json: category))
                }
            }else{
                apiStatus = ApiStatus.failure
            }
        }
    }
    
    
    var body: some View {
//        NavigationView(content: {
//            NavigationLink(destination: Text("Destination")) { /*@START_MENU_TOKEN@*/Text("Navigate")/*@END_MENU_TOKEN@*/ }
//        })
        NavigationView{
                VStack{
                    if(apiStatus == ApiStatus.completed){
                        ScrollView{
                            LazyVGrid(columns: griColumns,alignment: .listRowSeparatorLeading,spacing: 10){
                                ForEach(categoryList){ category in
                                    let filterList = self.selectedList.filter{id in return id == category.id }
                                    CategoryImage(
                                        
                                        isSelected: filterList.count > 0, category: category)
                                    .onTapGesture {
                                        selectCategory(id: category.id)
                                    }
                                }
                                
                            }.padding(.horizontal,10).padding(.vertical,20)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("Complete")
                                .frame(maxWidth: .infinity)
                                .font(.system(size: 20,weight: .bold))
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color("AppColor"))
                        .padding(.horizontal,10)
                    }
                    if(apiStatus == ApiStatus.processing){
                        Text("Loading")
                    }
                    if(apiStatus == ApiStatus.failure){
                        Text("Error")
                    }
                }.toolbar{
                    ToolbarItemGroup(placement:.topBarLeading){
                        VStack(alignment: .leading){
                            Text("Select Category")
                                .font(.system(size: 24,weight: .bold))
                            Text("Better Content")
                                .font(.system(size: 20,weight: .medium)).foregroundStyle(.secondary)
                        }
                    }
                    ToolbarItemGroup(placement:.topBarTrailing){
                        Text("\(selectedList.count)/\(categoryList.count)")
                            .font(.system(size: 20,weight: .medium))
                            .foregroundStyle(.white)
                            .padding(.horizontal,20)
                            .padding(.vertical,12)
                            .background(Color("AppColor"))
                            .cornerRadius(10)
                    }
                }.padding(.vertical,20)
               
        }.onAppear{
            getCategory()
        }
    }
}

#Preview {
    CategoryView()
}
