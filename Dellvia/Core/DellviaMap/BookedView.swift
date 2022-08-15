
import SwiftUI
import Firebase

struct Booked : View {
    
    @Binding var data : Data
    @Binding var doc : String
    @Binding var loading : Bool
    @Binding var book : Bool
    @Binding var qrUrl: String
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View{
        
            VStack(spacing: 25){
                
                Image(uiImage: UIImage(data: self.data)!)
                    .resizable()
                    .frame(width: 200, height: 200)
                
                VStack(spacing:10){
                    Button(action: {
                        
                        self.loading.toggle()
                        self.book.toggle()
                        
                        let db = Firestore.firestore()
                        ImageServices.shared.delImage(url: qrUrl)
                        db.collection("Booking").document(self.doc).delete { (err) in
                            
                            if err != nil{
                                
                                print((err?.localizedDescription)!)
                                return
                            }
                            
                            self.loading.toggle()
                        }
                        
                    }) {
                        
                        Text("İptal")
                            .foregroundColor(Color("main2"))
                            .padding(.vertical,10)
                            .frame(width: UIScreen.main.bounds.width / 2)
                        
                        
                    }
                    .background(Color("main2").opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                     
                        Button(action: {
                            
                            self.loading.toggle()
                            self.book.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.loading.toggle()
                                presentationMode.wrappedValue.dismiss()
                            }
                            
                            
                            
                        }) {
                            
                            Text("Devam Et")
                                .foregroundColor(Color("main"))
                                .padding(.vertical,10)
                                .frame(width: UIScreen.main.bounds.width / 2)
                            
                            
                        }
                        .background(Color("main").opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    

                }
                
            }
            .padding()
            .background(Color.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    
                    
            
        
    }
}
