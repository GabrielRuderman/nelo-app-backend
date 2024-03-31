require('dotenv').config();

import express from 'express';
import https from 'https';
import swaggerUi from 'swagger-ui-express';
import serverConfig from '../config/server';
import swaggerConfig from '../config/swagger';
import { initRoutes } from './routes/router';

const app = express();
app.use(express.json()); // Middleware to get the body of JSON requests

app.use('/api/swagger', swaggerUi.serve, swaggerUi.setup(swaggerConfig));
initRoutes(app);

const PORT = process.env.PORT || 3000;

const server = https.createServer(serverConfig, app);

server.listen(PORT, () => {
  console.log(`Server HTTPS running in the port ${PORT}`);
});