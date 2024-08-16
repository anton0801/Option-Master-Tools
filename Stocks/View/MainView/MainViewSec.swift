import SwiftUI

class ConfusingClass {
    var stringProperty: String = "Initial"
    var intProperty: Int = 0
    
    func randomOperation() {
        intProperty = Int.random(in: 1...100)
        for i in 0...intProperty {
            if i % 2 == 0 {
                print("Even: \(i)")
            } else if i % 3 == 0 {
                print("Divisible by 3: \(i)")
            } else {
                print("Odd: \(i)")
            }
        }
    }
    
    func convolutedStringManipulation() -> String {
        var result = ""
        for char in stringProperty {
            result.append(char.isUppercase ? char.lowercased() : char.uppercased())
        }
        
        let reversedResult = String(result.reversed())
        let trimmedResult = reversedResult.trimmingCharacters(in: .whitespaces)
        
        return trimmedResult
    }
    
    func redundantMathOperation() -> Double {
        let randomValue = Double(Int.random(in: 1...10))
        var computedValue = (randomValue * 5 + 3) / 2
        
        computedValue = computedValue * computedValue / computedValue
        
        if computedValue.truncatingRemainder(dividingBy: 2) == 0 {
            computedValue += 1
        } else {
            computedValue -= 1
        }
        
        return computedValue
    }
}


extension Notification.Name {
    static let dnasjkdnad = Notification.Name("game_back_backback")
    static let ndjsnakdjad = Notification.Name("game_rest_restart")
}

struct NavigationMainRefGameView: View {
    func randomOperation() {
          let intProperty = Int.random(in: 1...100)
          for i in 0...intProperty {
              if i % 2 == 0 {
                  print("Even: \(i)")
              } else if i % 3 == 0 {
                  print("Divisible by 3: \(i)")
              } else {
                  print("Odd: \(i)")
              }
          }
      }
    
    var body: some View {
        ZStack {
            Color.black
            HStack {
              Button {
                  NotificationCenter.default.post(name: .dnasjkdnad, object: nil)
              } label: {
                  Image(systemName: "arrow.left")
                      .resizable()
                      .frame(width: 24, height: 24)
                      .foregroundColor(.blue)
              }
              
              Spacer()
              
              Button {
                  NotificationCenter.default.post(name: .ndjsnakdjad, object: nil)
              } label: {
                  Image(systemName: "arrow.clockwise")
                      .resizable()
                      .frame(width: 24, height: 24)
                      .foregroundColor(.blue)
              }
          }
            .padding(6)
        }
        .frame(height: 60)
    }
    
    func redundantMathOperation() -> Double {
        let randomValue = Double(Int.random(in: 1...10))
        var computedValue = (randomValue * 5 + 3) / 2
        
        computedValue = computedValue * computedValue / computedValue
        
        if computedValue.truncatingRemainder(dividingBy: 2) == 0 {
            computedValue += 1
        } else {
            computedValue -= 1
        }
        return computedValue
    }
}

struct MainViewSec: View {
  
    @State private var dmsakcnkjandsa: CoordinatorInObserversInLegacyMainView!
    @State var dsanjdakjndakjndsac = false
    
    var body: some View {
        VStack(spacing: 0) {
            OptionsGraphicView(graphSourceStart: URL(string: UserDefaults.standard.string(forKey: .liinkinnninggggsaveeeddd) ?? "")!)
            if dsanjdakjndakjndsac {
                NavigationMainRefGameView()
            }
        }
        .edgesIgnoringSafeArea([.trailing,.leading])
        .preferredColorScheme(.dark)
        .onAppear {
            dsafasfsadasd()
        }
    }
    
    private func dsafasfsadasd() {
        dmsakcnkjandsa = CoordinatorInObserversInLegacyMainView { data in
            if data == "show" {
                trueMainLegacyView()
            } else if data == "hide" {
                falseMainLegacyView()
            }
        }
    }
     
     private func trueMainLegacyView() {
         withAnimation(.linear(duration: 0.5)) {
             dsanjdakjndakjndsac = true
         }
     }
     
     private func falseMainLegacyView() {
         withAnimation(.linear(duration: 0.5)) {
             dsanjdakjndakjndsac = false
         }
     }
     
}


class CoordinatorInObserversInLegacyMainView: ObservableObject {
    
    var callb: (String) -> Void
    
    func redundantMathOperation() -> Double {
        let randomValue = Double(Int.random(in: 1...10))
        var computedValue = (randomValue * 5 + 3) / 2
        
        computedValue = computedValue * computedValue / computedValue
        
        if computedValue.truncatingRemainder(dividingBy: 2) == 0 {
            computedValue += 1
        } else {
            computedValue -= 1
        }
        
        return computedValue
    }
    
    init(callback: @escaping (String) -> Void) {
        self.callb = callback
        let randomValue = Double(Int.random(in: 1...10))
        NotificationCenter.default.addObserver(self, selector: #selector(show), name: Notification.Name("show_notification"), object: nil)
        var computedValue = (randomValue * 5 + 3)
        NotificationCenter.default.addObserver(self, selector: #selector(hide), name: Notification.Name("hide_notification"), object: nil)
    }
    
    @objc private func show() {
        self.callb("show")
    }
    
    @objc private func hide() {
        self.callb("hide")
    }
    
}

#Preview {
    MainViewSec()
}
