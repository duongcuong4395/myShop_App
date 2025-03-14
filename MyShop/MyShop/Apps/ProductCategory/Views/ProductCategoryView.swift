//
//  ProductCategoryView.swift
//  MyShop
//
//  Created by Macbook on 14/3/25.
//

import SwiftUI
import ChipsSelection

struct ProductCategoryView: View {
    @EnvironmentObject var productCategoryVM: ProductCategoryViewModel
    @State var categoriesSelected:  [ProductCategory] = []
    var body: some View {
        VStack {
            ChipsView(tags: productCategoryVM.categories
                      , selectedTags: $categoriesSelected
                      , isSelectOne: true) { item, isSelecttion in
                ChipView(item, isSelected: isSelecttion)
            } didChangeSelection: { itemsSelected in
                productCategoryVM.categorySelected = itemsSelected[0]
            }
        }
        .onAppear{
            categoriesSelected = [productCategoryVM.categorySelected]
        }
    }
    
    @ViewBuilder
    func ChipView(_ item: ProductCategory, isSelected: Bool) -> some View {
        VStack(spacing: 10) {
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? 50 : 100, height: UIDevice.current.userInterfaceIdiom == .phone ? 50 : 100)
                .clipShape(.rect(cornerRadius: 8))
            Text(item.rawValue)
                .font(.callout)
                .foregroundStyle(isSelected ? .white : Color.primary)
            /*
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.white)
            }
            */
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.background)
                    .opacity(!isSelected ? 1 : 0)
                RoundedRectangle(cornerRadius: 8)
                    .fill(.green.gradient)
                    .opacity(isSelected ? 1 : 0)
            }
        }
    }
}
