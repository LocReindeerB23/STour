const fs = require('fs');

const logFile = '/Users/nguyenanhtuan/.gemini/antigravity-ide/brain/43fd05ea-33d4-4027-a264-122786a2354f/.system_generated/logs/transcript_full.jsonl';
const lines = fs.readFileSync(logFile, 'utf8').split('\n');

const backups = {};

for (const line of lines) {
    if (!line.trim()) continue;
    try {
        const obj = JSON.parse(line);
        if (obj.tool_calls) {
            for (const call of obj.tool_calls) {
                if (call.name === 'write_to_file') {
                    const file = call.args.TargetFile;
                    if (file && file.includes('tour-booking/src/main/resources/templates/')) {
                        if (!backups[file]) backups[file] = [];
                        backups[file].push(call.args.CodeContent);
                    }
                }
            }
        }
    } catch(e) {}
}

for (const file in backups) {
    console.log("Found backup for: " + file);
    // Write the FIRST version created in this session, which is the original one!
    fs.writeFileSync(file, backups[file][0]);
}

// Restore HomeController and TourController from earlier versions too!
const oldControllerContent = {};
for (const line of lines) {
    if (!line.trim()) continue;
    try {
        const obj = JSON.parse(line);
        if (obj.tool_calls) {
            for (const call of obj.tool_calls) {
                if (call.name === 'write_to_file' || call.name === 'replace_file_content') {
                    const file = call.args.TargetFile;
                    if (file && file.includes('com/example/tourbooking/controller/')) {
                        if (call.name === 'write_to_file') {
                            if (!oldControllerContent[file]) oldControllerContent[file] = [];
                            oldControllerContent[file].push(call.args.CodeContent);
                        } else if (call.name === 'replace_file_content') {
                             if (!oldControllerContent[file]) oldControllerContent[file] = [];
                             // We don't have the full content here, but we can undo the latest changes
                        }
                    }
                }
            }
        }
    } catch(e) {}
}

for (const file in oldControllerContent) {
    console.log("Found backup for Controller: " + file);
    fs.writeFileSync(file, oldControllerContent[file][0]);
}

