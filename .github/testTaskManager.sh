cd TaskManagerPackage
xcodebuild clean -quiet
xcodebuild test\
	-scheme 'TaskManagerPackage' \
	-destination 'platform=iOS Simulator,name=iPhone 14 Pro'
