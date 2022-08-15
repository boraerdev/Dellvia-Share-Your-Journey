//
//  LoginPage.swift
//  YemekTarifi
//
//  Created by Bora Erdem on 12.08.2022.
//

import SwiftUI

struct SignUp: View {
    @State var ad: String = ""
    @State var soyad: String = ""
    @State var mail : String = ""
    @State var pass : String = ""
    @EnvironmentObject var authVm : AuthViewModel
    @Environment (\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            VStack(spacing: 0){
                VStack{
                    Text("Hoş Geldin").font(.footnote)
                    Text("Kayıt Ol").font(.title2.bold())
                }
                .padding([.top, .horizontal])
                .foregroundColor(.primary)
                VStack{
                    TextField("Ad", text: $ad)
                        .disableAutocorrection(true)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    TextField("Soyad", text: $soyad)
                        .disableAutocorrection(true)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))

                    TextField("Email", text: $mail)
                        .disableAutocorrection(true)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    SecureField("Şifre", text: $pass)
                        .disableAutocorrection(true)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    HStack(spacing: 16){
                        Button("Kayıt Ol") {
                            signUp(ad: ad, soyad: soyad, mail: mail, pass: pass)
                        }
                        .buttonStyle(.bordered)
                    }.padding()
                }.padding()
            }
            .onTapGesture {
                Home().manager.requestAlwaysAuthorization()
            }

                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .padding()
                .alert(isPresented: $authVm.showError){
                    Alert(title: Text("Bir Şey Oldu"), message: Text(authVm.errorMessage ?? "Kontol ediniz."), dismissButton: Alert.Button.default(Text("OK")))
                }
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .overlay(
            HStack{
                Text("Hesabın var mı?")
                Text("Giriş Yap")
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                
            }
            .padding()
            .font(.footnote)
            , alignment: .bottom
        )
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp().environmentObject(AuthViewModel())
    }
}

extension SignUp {
    
    func signUp(ad: String, soyad: String, mail: String, pass: String) {
        authVm.register(ad: ad, soyad: soyad, mail: mail, pass: pass)
    }
    
}
