//
//  Home.swift
//  UI-620
//
//  Created by nyannyan0328 on 2022/07/23.
//

import SwiftUI

struct Home: View {
    
    @State var hederHeight :   CGFloat = 0
    @State var headeroffset : CGFloat = 0
    @State var lastHedarOffset : CGFloat = 0
    @State var swipDelection : Delection = .none
    
    
    @State var shiftOffset : CGFloat = 0
   
    
    

   
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            
        
            ThmanailView()
                .padding(.top,hederHeight)
                .offsetY { previous, current in
                    
                    if previous > current{
                        
                        if swipDelection != .up && current < 0{
                         shiftOffset = current - headeroffset
                            swipDelection = .up
                            lastHedarOffset = headeroffset
                            
                        }
                        
                        let offset = current < 0 ? (current - shiftOffset) : 0
                        
                        headeroffset = (-offset < hederHeight ? (offset < 0 ? offset : 0) : -hederHeight)
                        
                        
                        
                    }
                    else{
                        
                        
                        if swipDelection != .down{
                            
                            shiftOffset = current
                            swipDelection = .down
                            lastHedarOffset = headeroffset
                        }
                        
                        let offset = lastHedarOffset + (current - shiftOffset)
                        headeroffset = (offset > 0 ? 0 : offset)
                    }
                    
                }
        }
        .coordinateSpace(name: "SCROLL")
        .overlay(alignment:.top) {
            
            
            HederView()
                .anchorPreference(key : BoundsOffset.self, value: .bounds) {  $0
                    
                }
                .overlayPreferenceValue(BoundsOffset.self) { value in
                
                    GeometryReader{proxy in
                        
                        if let anhor = value{
                            
                            Color.clear
                                .onAppear{
                                    
                                    hederHeight = proxy[anhor].height
                                }
                        }
                    }
                }
                .offset(y:-headeroffset < hederHeight ? headeroffset : (headeroffset < 0 ? headeroffset : 0))
          
            
        }
        .ignoresSafeArea(.all,edges: .top)
    }
    @ViewBuilder
    func HederView()->some View{
        
        VStack(spacing:16){
            
            VStack(spacing:0){
                
                HStack{
                    
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                         .frame(width: 120)
                    
                    HStack(spacing:18){
                        
                        let image = ["Notifications","Search","Shareplay"]
                        
                        ForEach(image,id:\.self){image in
                            
                            Image(image)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 30,height: 30)
                            
                            
                            
                        
                        }
                        
                        Button {
                            
                        } label: {
                            
                            Image("Pic")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                             .frame(width: 30,height: 30)
                             .clipShape(Circle())
                        }

                        
                        
                    }
                      .frame(maxWidth: .infinity,alignment: .trailing)
                }
                .padding()
                Divider()
                    .padding(.horizontal,-15)
                    
                
            }
            .padding(.bottom,20)
            
            TagView()
            
            
        }
        .padding(.top,getSafeArea().top)
        .background{Color.white.ignoresSafeArea()}
        .padding(.bottom,20)
        
    }
    
    @ViewBuilder
    func TagView()->some View{
        
        ScrollView(.horizontal,showsIndicators: false){
            
            let tags = ["All","iJustine","Kavsoft","Apple","SwiftUI","Programming","Technology"]
            
            
            HStack(spacing:10){
                
                ForEach(tags,id:\.self){tag in
                    
                    Text(tag)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .background{
                         
                            Capsule()
                                .fill(.gray.opacity(0.3))
                                
                        }
                }
            }
            
        }
    }
    @ViewBuilder
    func ThmanailView()->some View{
        
        
        VStack(spacing:16){
            
            ForEach(0...10,id:\.self){index in
                GeometryReader{proxy in
                    
                     let size = proxy.size
                    
                    Image("Image\((index % 5) + 1)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:size.width ,height:size.height)
                        .clipped()
                }
                .frame(height:250)
                
            }
        }
        .padding(.horizontal)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum Delection{
    
    case up
    case down
    case none
}
