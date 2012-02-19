# increase build number for beta builds
if [ "$CONFIGURATION" == "Distribution" ]
	then /usr/bin/perl -pe 's/(BUILD_NUMBER = )(\d+)/$1.($2+1)/eg' -i Xcode/buildnumber.xcconfig
fi