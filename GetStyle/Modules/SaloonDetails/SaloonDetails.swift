//
//  SaloonDetails.swift
//  GetStyle
//
//  Created by Jatesh D Maheshwari on 06/11/2022.
//

import SwiftUI

struct SaloonDetails: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationView {
            SaloonDetailsView()
        }
    }
}

struct SaloonDetails_Previews: PreviewProvider {
    static var previews: some View {
        SaloonDetails(viewRouter: ViewRouter())
    }
}

struct SaloonDetailsView: View {
    @State var currentIndex: Int = 1
    @State var slides: [SliderModel] = []
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .center) {
                        Slider(index: $currentIndex, items: slides) { slide in
                            GeometryReader { proxy in
                                let size = proxy.size
                                Image(slide.slideImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: size.width)
                                    .cornerRadius(12)
                                    .shadow(color: Color(hex: "#47684f") .opacity(0.7), radius: 5, x: 0, y: 10)
                            }
                        }
                        .frame(height: 200, alignment: .top)
                        .onAppear {
                            for index in 1...3 {
                                slides.append(.init(slideImage: "\(index)"))
                            }
                        }
                        .padding(.vertical, 20)
                        
                        HStack(spacing: 10) {
                            ForEach(slides.indices, id: \.self) { index in
                                Circle()
                                    .fill(Color.black.opacity(currentIndex == index ? 1: 0.1))
                                    .frame(width: 10, height: 10)
                                    .scaleEffect(currentIndex == index ? 1.4 : 1)
                                    .animation(.spring(), value: currentIndex == index)
                            }
                        }
                    }
                    .padding(.bottom, 20)
                    
                    Text("Plush Beauty Lounge")
                        .padding(.leading, 20)
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                    
                    HStack(spacing: 10) {
                        Image(ImagesConstants.tabbar.saloon)
                        Text("Home & On Site Service")
                    }
                    .padding(.leading, 20)
                    .frame(height: 30)
                    Divider()
                    
                    Text("About Plush")
                        .padding(.leading, 20)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    
                    Text("Services About this saloon is to be a good one but details are not provided yet so typing random things. I am new at this so typo should not be considered!! Services About this saloon is to be a good one but details are not provided yet so typing random things. I am new at this so typo should not be considered!! Services About this saloon is to be a good one but details are not provided yet so typing random things. I am new at this so typo should not be considered!! Services About this saloon is to be a good one but details are not provided yet so typing random things. I am new at this so typo should not be considered!! Services About this saloon is to be a good one but details are not provided yet so typing random things. I am new at this so typo should not be considered!! Services About this saloon is to be a good one but details are not provided yet so typing random things. I am new at this so typo should not be considered!!")
                        .padding(.leading, 20)
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                    
                    Divider()
                    
                    Text("Services")
                        .padding(.leading, 20)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    
                    HStack(spacing: 10) {
                        Image(ImagesConstants.tabbar.saloon)
                        Text("Service 1")
                        Spacer()
                        Text("$20")
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    Spacer(minLength: 60)
                }
            }
            
            VStack {
                Spacer()
                HStack() {
                    Button( action: {
                        
                    }) {
                        Text("Book An Appointment")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                    }
                    .frame(height: 30)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(.green)
                    .tint(.white)
                    .cornerRadius(12)
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(Color.white)
                .frame(height: 30)
                .shadow(radius: 2)
            }
        }
    }
}
