import { writeFileSync } from 'fs';
import { dirname, join } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const content = `
import express from 'express';
import { dirname, join } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const PORT = 14200;

const app = express();
// 设置静态文件目录
app.use(express.static(__dirname));
app.get('/', (req, res) => {
    res.sendFile(join(__dirname, 'index.html'));
});
app.listen(PORT, () => {
    console.log('Server running on port ' + PORT);
});
`;
writeFileSync(join(__dirname, 'dist', 'index.js'), content);
console.log('Custom index.js has been created.');