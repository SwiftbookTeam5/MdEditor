import ProjectDescription

public var scripts: [TargetScript] {
	var scripts = [TargetScript]()
	
	let swiftLintScriptString = """
								export PATH="$PATH:/opt/homebrew/bin"
								if which swiftlint > /dev/null; then
									swiftlint
								else
									echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
									exit 1
								fi
								"""
	let swiftLintScript = TargetScript.post(script: swiftLintScriptString, name: "SwiftLint", basedOnDependencyAnalysis: false)
	
	scripts.append(swiftLintScript)
	return scripts
}

let target = Target(
	name: "MdEditor",
	platform: .iOS,
	product: .app,
	productName: "MdEditor",
	bundleId: "SwiftbookTeam5.MdEditor",
	deploymentTarget: .iOS(targetVersion: "15.0", devices: .iphone),
	infoPlist: "Sources/Info.plist",
	sources: ["Sources/**"],
	resources: ["Resources/**"],
	scripts: scripts,
	dependencies: [
		.package(product: "TaskManagerPackage")
	]
)

let project = Project(
	name: "MdEditor",
	organizationName: "SwiftbookTeam5",
	packages: [
		.package(
			path: "../TaskManagerPackage"
		),
	],
	targets: [target]
)
