//
//  LoginPage.swift
//  YemekTarifi
//
//  Created by Bora Erdem on 12.08.2022.
//

import SwiftUI

struct LoginPage: View {
    @State var mail : String = ""
    @State var pass : String = ""
    @EnvironmentObject var authVm : AuthViewModel

    var body: some View {
        NavigationView {
                VStack(spacing: 0){
                    VStack{
                        Text("Hoş Geldin").font(.footnote)
                        Text("Giriş Yap").font(.title2.bold())
                    }
                    .padding([.top, .horizontal])
                        .foregroundColor(.primary)
                    VStack{
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
                            NavigationLink {
                                SignUp().navigationBarHidden(true).navigationBarBackButtonHidden(false)
                            } label: {
                                Text("Kayıt Ol").foregroundColor(.primary)
                            }

                            Button("Giriş Yap") {
                                login(mail: mail, pass: pass)
                            }
                            .buttonStyle(.bordered)
                        }.padding()
                    }.padding()
                }
                .onAppear(perform: {
                    Home().manager.requestAlwaysAuthorization()
                })
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .padding()
                    .alert(isPresented: $authVm.showError){
                        Alert(title: Text("Bir Şey Oldu"), message: Text(authVm.errorMessage ?? "Kontol ediniz."), dismissButton: Alert.Button.default(Text("OK")))
                    }
                    .navigationBarHidden(true)
            
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage().environmentObject(AuthViewModel())
    }
}

extension LoginPage {
    
    func login(mail: String, pass: String) {
        authVm.login(mail: mail, pass: pass)
    }
    
}
