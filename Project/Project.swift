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

	enum UnitTests {
		public static var name: String { "\(ProjectSettings.projectName)Tests" }
		public static var bundleId: String { "\(ProjectSettings.bundleId)Tests" }
	}

	enum UITests {
		public static var name: String { "\(ProjectSettings.projectName)UITests" }
		public static var bundleId: String { "\(ProjectSettings.bundleId)UITests" }
	}
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

	let swiftLintScript = TargetScript.pre(
		script: swiftLintScriptString,
		name: "Run SwiftLint",
		basedOnDependencyAnalysis: false
	)
	
	scripts.append(swiftLintScript)
	return scripts
}

let target = Target(
	name: ProjectSettings.projectName,
	platform: .iOS,
	product: .app,
	productName: ProjectSettings.projectName,
	bundleId: ProjectSettings.bundleId,
	deploymentTarget: .iOS(targetVersion: ProjectSettings.targetVersion, devices: .iphone),
	infoPlist: "Sources/Info.plist",
	sources: ["Sources/**", "Shared**"],
	resources: [
		"Resources/**",
		.folderReference(path: "Docs")
	],
	scripts: scripts,
	dependencies: [
		.package(product: "TaskManagerPackage"),
		.package(product: "FileManagerPackage"),
		.package(product: "DataStructuresPackage"),
		.package(product: "MarkdownParserPackage"),
		.package(product: "NetworkLayerPackage")
	]
)

let targetUnitTest = Target(
	name: ProjectSettings.UnitTests.name,
	platform: .iOS,
	product: .unitTests,
	bundleId: ProjectSettings.UnitTests.bundleId,
	deploymentTarget: .iOS(targetVersion: ProjectSettings.targetVersion, devices: .iphone),
	infoPlist: .none,
	sources: ["Tests/MdEditorTests/Sources/**", "Shared**"],
	dependencies: [
		.target(name: ProjectSettings.projectName)
	],
	settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])
)

let targetUITest = Target(
	name: ProjectSettings.UITests.name,
	platform: .iOS,
	product: .uiTests,
	bundleId: ProjectSettings.UITests.bundleId,
	deploymentTarget: .iOS(targetVersion: ProjectSettings.targetVersion, devices: .iphone),
	infoPlist: .none,
	sources: ["Tests/MdEditorUITests/Sources**", "Shared**"],
	resources: ["Resources/**"],
	dependencies: [
		.target(name: ProjectSettings.projectName)
	],
	settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])
)

let project = Project(
	name: ProjectSettings.projectName,
	organizationName: ProjectSettings.organizationName,
	packages: [
		.local(path: .relativeToManifest("../Packages/TaskManagerPackage")),
		.local(path: .relativeToManifest("../Packages/FileManagerPackage")),
		.local(path: .relativeToManifest("../Packages/DataStructuresPackage")),
		.local(path: .relativeToManifest("../Packages/MarkdownParserPackage")),
		.local(path: .relativeToManifest("../Packages/NetworkLayerPackage"))
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
	targets: [target, targetUnitTest, targetUITest],
	schemes: [
		Scheme(
			name: ProjectSettings.projectName,
			shared: true,
			buildAction: .buildAction(targets: ["\(ProjectSettings.projectName)"]),
			testAction: .targets(
				[
					"\(ProjectSettings.UnitTests.name)",
					TestableTarget(target: "\(ProjectSettings.UITests.name)", skipped: true)
				]
			),
			runAction: .runAction(executable: "\(ProjectSettings.projectName)")
		),
		Scheme(
			name: ProjectSettings.UnitTests.name,
			shared: true,
			buildAction: .buildAction(targets: ["\(ProjectSettings.UnitTests.name)"]),
			testAction: .targets(["\(ProjectSettings.UnitTests.name)"]),
			runAction: .runAction(executable: "\(ProjectSettings.UnitTests.name)")
		),
		Scheme(
			name: ProjectSettings.UITests.name,
			shared: true,
			buildAction: .buildAction(targets: ["\(ProjectSettings.UITests.name)"]),
			testAction: .targets(["\(ProjectSettings.UITests.name)"]),
			runAction: .runAction(executable: "\(ProjectSettings.UITests.name)")
		)
	]
)
