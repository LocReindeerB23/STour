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
                const file = call.args.TargetFile;
                if (!file) continue;
                
                if (file.includes('tour-booking/src/main/resources/templates/') || 
                    file.includes('tour-booking/src/main/java/com/example/tourbooking/controller/')) {
                    
                    if (call.name === 'write_to_file') {
                        if (!backups[file]) backups[file] = { type: 'write', content: call.args.CodeContent, step: obj.step_index };
                    } else if (call.name === 'replace_file_content' || call.name === 'multi_replace_file_content') {
                        // If we didn't have it, we can't fully reconstruct it just from replace_file_content.
                        // But wait! If we didn't write it, and we replaced it, where did we get it from?
                        // We must have viewed it. But view_file is not in tool_calls args, it's in response.
                    }
                }
            }
        }
        
        // Also check tool responses for view_file
        if (obj.type === 'ACTION_RESPONSE' && typeof obj.content === 'string') {
            if (obj.content.includes('File Path: `file:///Users/nguyenanhtuan/Documents/BACKEND')) {
                // Parse view file output
                const lines = obj.content.split('\n');
                let filePath = '';
                let isCode = false;
                let fileContent = [];
                for (let i = 0; i < lines.length; i++) {
                    if (lines[i].startsWith('File Path: `file://')) {
                        filePath = decodeURI(lines[i].replace('File Path: `file://', '').replace('`', ''));
                    }
                    if (lines[i].startsWith('1: ')) {
                        isCode = true;
                    }
                    if (isCode) {
                        const match = lines[i].match(/^\d+:\s(.*)/);
                        if (match) {
                            fileContent.push(match[1]);
                        } else if (lines[i] === 'The above content shows the entire, complete file contents of the requested file.' || lines[i].startsWith('Showing lines')) {
                            isCode = false;
                        }
                    }
                }
                
                if (filePath && !backups[filePath]) {
                    backups[filePath] = { type: 'view', content: fileContent.join('\n'), step: obj.step_index };
                }
            }
        }
    } catch(e) {}
}

for (const file in backups) {
    console.log("Restoring " + file + " (from step " + backups[file].step + ")");
    fs.writeFileSync(file, backups[file].content);
}
