import fs from 'fs';  
import path from 'path';  
import { fileURLToPath } from 'url';  
import * as randomWords from 'random-words';  
  
// Helper to get the __dirname equivalent in ES modules  
const __filename = fileURLToPath(import.meta.url);  
const __dirname = path.dirname(__filename);  
  
const numFiles = 24;  
const functionsDir = path.join(__dirname, '../src/main/java/com/tricentis/functions');  
  
// Ensure the functions directory exists  
if (!fs.existsSync(functionsDir)) {  
    fs.mkdirSync(functionsDir, { recursive: true });  
}  
  
// Remove any existing files in the functions directory  
fs.readdirSync(functionsDir).forEach(file => fs.unlinkSync(path.join(functionsDir, file)));  
  
for (let i = 1; i <= numFiles; i++) {  
    const words = randomWords.generate({ exactly: 3, join: '-' });  
    const functionName = `Function${words.split('-').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join('')}`;  
    const fileName = `${functionName}.java`;  
    const filePath = path.join(functionsDir, fileName);  
  
    const fileContent = `package com.tricentis.functions;

/**
 * ${functionName} - Generated function
 */
public class ${functionName} {
    public String execute() {
        System.out.println("${functionName} executed");
        return "${functionName} executed";
    }
}
`;  
  
    fs.writeFileSync(filePath, fileContent, 'utf8');  
    console.log(`Created ${fileName}`);  
}  