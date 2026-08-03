import Testing
@testable import RazerMacOS

struct GameControllerRuntimeTests {
  @Test func matcher_whenWolverineIsPresent_prefersItsVendorName() throws {
    let dualSense = GameControllerDescriptor(
      id: "dual-sense",
      vendorName: "Sony Interactive Entertainment",
      productCategory: "DualSense"
    )
    let wolverine = GameControllerDescriptor(
      id: "wolverine",
      vendorName: "Razer Wolverine V3 Pro 2.4",
      productCategory: "Xbox One"
    )

    let match = try #require(
      GameControllerMatcher.match(
        preferredDeviceName: "Razer Wolverine V3 Pro",
        candidates: [dualSense, wolverine]
      )
    )

    #expect(match.id == "wolverine")
  }

  @Test func matcher_whenOnlyOneSystemControllerExists_usesItAsTheUSBDevicePeer() throws {
    let controller = GameControllerDescriptor(
      id: "system-controller",
      vendorName: "Xbox Wireless Controller",
      productCategory: "Xbox One"
    )

    let match = try #require(
      GameControllerMatcher.match(
        preferredDeviceName: "Razer Wolverine V3 Pro",
        candidates: [controller]
      )
    )

    #expect(match.id == "system-controller")
  }

  @Test func matcher_whenSeveralUnrelatedControllersExist_doesNotGuess() {
    let candidates = [
      GameControllerDescriptor(id: "one", vendorName: "Controller One", productCategory: "Generic"),
      GameControllerDescriptor(id: "two", vendorName: "Controller Two", productCategory: "Generic")
    ]

    #expect(
      GameControllerMatcher.match(
        preferredDeviceName: "Razer Wolverine V3 Pro",
        candidates: candidates
      ) == nil
    )
  }
}
