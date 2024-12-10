import SwiftUI

struct AddEntryTooltip: View {
    @Binding var isVisible: Bool
    @EnvironmentObject var onboardingController: OnboardingController

    private func dismissTooltip() {
        onboardingController.isOnboarded = true
        withAnimation {
            isVisible = false
        }
    }

    var body: some View {
        if isVisible {
            VStack(alignment: .center, spacing: 10) {
                Text("Start Your Journey!")
                    .font(.headline)
                    .foregroundColor(.white)

                Text("Tap the + button to create\n your first journal entry")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Button {
                    dismissTooltip()
                } label: {
                    Text("Got it!")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.barberry)
                }
                .padding(.vertical, 10)
            }
            .padding()
            .background(Color.mainColor)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding(.bottom, 80)
        }
    }
}

#Preview {
    @Previewable @State var isVisible = true

    VStack {
        Spacer()
        AddEntryTooltip(isVisible: $isVisible)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.backgroundColor)
}

#Preview("Hidden") {
    @Previewable @State var isVisible = false

    VStack {
        Spacer()
        AddEntryTooltip(isVisible: $isVisible)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.backgroundColor)
}
