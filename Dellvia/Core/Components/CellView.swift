//
//  CellView.swift
//  Dellvia
//
//  Created by Bora Erdem on 15.08.2022.
//

import SwiftUI
import Kingfisher

struct CallView: View {
    var gelenCell: Call
    @State var goDetail: Bool = false
    var body: some View {
            HStack(alignment:.center, spacing:16){
                KFImage(URL(string: gelenCell.qrUrl)!)
                    .resizable()
                    .frame(width: 64, height: 64)
                    .padding()
                    .background(.white, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                VStack(alignment: .leading, spacing: 3){
                    HStack{
                        Text(gelenCell.destinationName)
                            .lineLimit(1)
                            .font(.system(.body, design: .rounded))
                    
                    Text("\(String(format: "%.2f", gelenCell.fair))₺")
                        .font(.system(.footnote, design: .rounded))
                        .lineLimit(1)
                        .foregroundColor(Color("main"))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color("main").opacity(0.2),in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                    
                    VStack(alignment: .leading){
                        Text("\(gelenCell.timestamp.formatted(date: .omitted, time: .shortened))")
                        Text("\(gelenCell.distance) KM")
                        Text("Teklifin dağıtıldı.")
                            .font(.caption2)
                            .foregroundColor(Color("main"))
                    }
                        .font(.system(.footnote))
                        .foregroundColor(Color("secondary"))
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundColor(Color("main"))
                    .onTapGesture {
                        goDetail.toggle()
                    }



            }
            .padding()
            .background(Color("main").opacity(0.2), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .fullScreenCover(isPresented: $goDetail) {
                DetailView(call: gelenCell)
            }
        
    }
}

