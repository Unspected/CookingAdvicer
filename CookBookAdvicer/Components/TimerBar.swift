import SwiftUI
import Combine

struct TimerBar: View {
    
    @State var isActive: Bool = false
    @Binding var secondsToReady: Int
    @State private var timerIsRunning = false
    @State private var timer: Timer?
    
    @State private var timerUp: Double = 0.0

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                isActive.toggle()
                
                if isActive {
                    startTimer()
                } else {
                    stopTimer()
                }
                
            },
                   label: {
                Image(systemName: isActive ? "stop.circle" : "play.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            })
            VStack {
                ZStack {
                    ProgressView(value: timerUp, total: Double(secondsToReady))
                        .tint(Color.black)
                        .background(Color.white)
                        .scaleEffect(x: 1, y: 10, anchor: .center)
                    Text(timeString(time: secondsToReady))
                        .font(.custom("Avenir Next", size: 40))
                        .fontWeight(.black)
                }
            }
            .padding([.leading, .trailing], 20)
        }
    }
    
    private func startTimer() {
         timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
             if secondsToReady > 0 {
                 secondsToReady -= 1
                 timerUp += 1.0
                 
                 print(secondsToReady)
             } else {
                 self.stopTimer()
             }
         }
     }
     
     private func stopTimer() {
         timer?.invalidate()
         timer = nil
     }
    
    private func timeString(time: Int) -> String {
         let minutes = time / 60
         let seconds = time % 60
         return String(format: "%02d:%02d", minutes, seconds)
     }
}

#Preview {
    TimerBar(secondsToReady: .constant(130))
}
