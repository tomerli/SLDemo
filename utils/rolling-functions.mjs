import fs from 'fs';  
import path from 'path';  
import { fileURLToPath } from 'url';  
import * as randomWords from 'random-words';  
  
// Get the directory name of the current module  
const __filename = fileURLToPath(import.meta.url);  
const __dirname = path.dirname(__filename);  
  
const functionsDir = path.join(__dirname, '../src/main/java/com/tricentis/swan/station/functions');  
  
// Read all function files  
let files = fs.readdirSync(functionsDir).filter(file => file.endsWith('.java'));  
  
// Sort files by creation time (oldest first)  
files.sort((a, b) => {  
  const aStats = fs.statSync(path.join(functionsDir, a));  
  const bStats = fs.statSync(path.join(functionsDir, b));  
  return aStats.birthtimeMs - bStats.birthtimeMs;  
});  
  
// Delete the oldest file if there are 24 files  
if (files.length >= 24) {  
  const oldestFile = files.shift();  
  fs.unlinkSync(path.join(functionsDir, oldestFile));  
  console.log(`Deleted ${oldestFile}`);  
}  
  
// Generate random words  
const words = randomWords.generate({ exactly: 3, join: '-' });  
const newFileName = `Function${words.split('-').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join('')}.java`;  
const newFunctionName = `function${words.split('-').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join('')}`;  
const newFilePath = path.join(functionsDir, newFileName);  
const newFileContent = `package functions;

/**
 * ${newFileName}
 */
public class ${newFileName.replace('.java', '')} {
    public String ${newFunctionName}() {
        System.out.println("${newFunctionName} executed");
        return "${newFunctionName} executed";
    }
}
`;  
  
// Write the new file  
fs.writeFileSync(newFilePath, newFileContent, 'utf8');  
console.log(`Created ${newFileName}`);  