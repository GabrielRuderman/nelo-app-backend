import fs from 'fs';
import path from 'path';

const serverConfig = {
    key: fs.readFileSync(path.join(__dirname, '../ssl/key.pem')),
    cert: fs.readFileSync(path.join(__dirname, '../ssl/cert.pem'))
};

export default serverConfig;