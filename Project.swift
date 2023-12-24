import ProjectDescription

let project = Project(
	name: "MdEditor",
	organizationName: "SwiftbookTeam5",
	targets: [
		Target(
			name: "MdEditor",
			platform: .iOS,
			product: .app,
			bundleId: "SwiftbookTeam5.MdEditor",
			infoPlist: "Resources/Info.plist",
			sources: ["Sources/**"],
			resources: ["Resources/**"]
		)
	]
)
