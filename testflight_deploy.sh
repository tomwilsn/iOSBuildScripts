#REQUIRED SETTINGS
#Either in here or in .xcconfig file
#TESTFLIGHT_API_TOKEN="APIKEY"
#TESTFLIGHT_TEAM_TOKEN="APIKEY"
#TESTFLIGHT_SIGNING_IDENTITY="iPhone Distribution: Client Name"
#TESTFLIGHT_PROVISIONING_PROFILE="${SRCROOT}/../../provisioning/Adhoc_Distribution_Profile.mobileprovision"
LOG="/tmp/testflight.log"
APP="${ARCHIVE_PRODUCTS_PATH}/Applications/${PRODUCT_NAME}.app"


/usr/bin/open -a /Applications/Utilities/Console.app $LOG

cd "${ARCHIVE_DSYMS_PATH}"
zip -r "/tmp/${PRODUCT_NAME}.dSYM.zip" "${DWARF_DSYM_FILE_NAME}"
echo -n "App is located at ${APP}, DSYM at ${DWARF_DSYM_FILE_NAME}" >> $LOG
echo -n "Creating .ipa for ${PRODUCT_NAME}... " >> $LOG

/usr/bin/xcrun -sdk iphoneos PackageApplication -v "${APP}" -o "/tmp/${PRODUCT_NAME}.ipa" --sign "${TESTFLIGHT_SIGNING_IDENTITY}" --embed "${TESTFLIGHT_PROVISIONING_PROFILE}"

echo "done." >> $LOG

echo -n "Uploading to TestFlight... " >> $LOG

/usr/bin/curl "http://testflightapp.com/api/builds.json" \
-F file=@"/tmp/${PRODUCT_NAME}.ipa" \
-F dsym=@"/tmp/${PRODUCT_NAME}.dSYM.zip" \
-F TESTFLIGHT_API_TOKEN="${TESTFLIGHT_API_TOKEN}" \
-F TESTFLIGHT_TEAM_TOKEN="${TESTFLIGHT_TEAM_TOKEN}" \
-F notes="Build uploaded automatically from Xcode." \
-F notify=True \
-F distribution_lists="Auto"

echo "done." >> $LOG

/usr/bin/open "https://testflightapp.com/dashboard/builds/"
