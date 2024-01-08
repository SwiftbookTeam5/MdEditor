cd DataStructuresPackage
xcodebuild clean -quiet
xcodebuild test\
	-scheme 'DataStructuresPackage' \
	-destination 'platform=iOS Simulator,name=iPhone 14 Pro'
