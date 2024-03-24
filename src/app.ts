import express, { Request, Response } from 'express';
import playerRoutes from './routes/playerRoutes';
import coachRoutes from './routes/coachRoutes';

const app = express();

app.use('/api', playerRoutes);
app.use('/api', coachRoutes);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});
