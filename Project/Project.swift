import ProjectDescription

// MARK: - Project

enum ProjectSettings {
	public static var organizationName: String { "SwiftbookTeam5" }
	public static var projectName: String { "MdEditor" }
	public static var appVersionName: String { "1.0.0" }
	public static var appVersionBuild: Int { 1 }
	public static var developmentTeam: String { "" }
	public static var targetVersion: String { "15.0" }
	public static var bundleId: String { "\(organizationName).\(projectName)" }
}

private var scripts: [TargetScript] {
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

	let swiftLintScript = TargetScript.post(
		script: swiftLintScriptString,
		name: "SwiftLint",
		basedOnDependencyAnalysis: false
	)
	
	scripts.append(swiftLintScript)
	return scripts
}

let target = Target(
	name: ProjectSettings.projectName,
	platform: .iOS,
	product: .app,
	productName: "MdEditor",
	bundleId: ProjectSettings.bundleId,
	deploymentTarget: .iOS(targetVersion: ProjectSettings.targetVersion, devices: .iphone),
	infoPlist: "Sources/Info.plist",
	sources: ["Sources/**"],
	resources: ["Resources/**"],
	scripts: scripts,
	dependencies: [
		.package(product: "TaskManagerPackage"),
		.package(product: "DataStructuresPackage")
	]
)

let targetTest = Target(
	name: "\(ProjectSettings.projectName)Tests",
	platform: .iOS,
	product: .unitTests,
	bundleId: "\(ProjectSettings.bundleId)Tests",
	deploymentTarget: .iOS(targetVersion: ProjectSettings.targetVersion, devices: .iphone),
	infoPlist: .none,
	sources: ["Tests/**"],
	dependencies: [
		.target(name: "\(ProjectSettings.projectName)")
	],
	settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])
)

let project = Project(
	name: "MdEditor",
	organizationName: ProjectSettings.organizationName,
	packages: [
		.local(path: .relativeToManifest("../Packages/TaskManagerPackage")),
		.local(path: .relativeToManifest("../Packages/DataStructuresPackage"))
	],
	settings: .settings(
		base: [
			"DEVELOPMENT_TEAM": "\(ProjectSettings.developmentTeam)",
			"MARKETING_VERSION": "\(ProjectSettings.appVersionName)",
			"CURRENT_PROJECT_VERSION": "\(ProjectSettings.appVersionBuild)",
			"DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym"
		],
		defaultSettings: .recommended()
	),
	targets: [target, targetTest]
)
