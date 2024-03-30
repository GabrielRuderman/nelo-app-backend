import express, { Request, Response } from 'express';
import swaggerUi from 'swagger-ui-express';
import swaggerConfig from '../swaggerConfig';
import playerRoutes from './routes/playerRoutes';
import coachRoutes from './routes/coachRoutes';

const app = express();

app.use('/api/swagger', swaggerUi.serve, swaggerUi.setup(swaggerConfig));
app.use('/api', playerRoutes);
app.use('/api', coachRoutes);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});
