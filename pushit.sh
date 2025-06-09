#!/bin/bash
# one button push for godot project
TestSuffix=""
# while getopts ":tmb:" option; do
#    case $option in
#       b) # build godot project
         
# 		 ;;
#       t) # push to test host
#          TestSuffix="-test"
# 		 ;;
#      \?) # Invalid option
#          echo "Error: Invalid option"
#          exit;;
#    esac
# done

#build!
"/c/Program Files (x86)/Godot/Godot_v4.3-stable_win64.exe" --headless --export-release "Web" ./exports/index.html

#push!
Butler="butler push exports Windfall890/flerpy-birb"
Butler2=":html5-web --beeps4life"
$Butler$TestSuffix$Butler2

# Replace 'YOUR_WEBHOOK_URL' with your actual Discord webhook URL
WEBHOOK_URL="https://discord.com/api/webhooks/1206972175035138058/KhPTLgnYdxDeCa1kLf-QZACXsIbjmKkpwtMhm3AZxXQDsEVvzR-8KztogHKpBCJ7n8kQ"

# Replace 'Your Message Here' with the message you want to send
COMMIT_MESSAGE=`git log -1 --pretty=%B`

MESSAGE="Jon Just Farted out [Flerpy Birb](https://windfall890.itch.io/flerpy-birb?secret=ROAxhJ9KQOA99dv8Sdy2Xc1OA) to itch! Commit: \`\`\` ${COMMIT_MESSAGE} \`\`\`"
# Construct JSON payload
JSON="{\"content\":\"$MESSAGE\"}"

# Send the message using curl
echo "Farting out an update: $MESSAGE"
curl -X POST -H "Content-Type: application/json" -d "$JSON" "$WEBHOOK_URL"