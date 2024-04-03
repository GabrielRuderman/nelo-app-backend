require('dotenv').config();

import express from 'express';
import cors from 'cors';
import https from 'https';
import serverConfig from '../config/server';
import { initRoutes } from './routes/router';

const app = express();
app.use(cors());

app.use(express.json()); // Middleware to get the body of JSON requests

initRoutes(app);

const PORT = process.env.PORT || 3000;

const server = https.createServer(serverConfig, app);

server.listen(PORT, () => {
  console.log(`Server HTTPS running in the port ${PORT}`);
});