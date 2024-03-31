import { Application } from 'express';
import { validateToken } from '../utilities/token';
import swaggerUi from 'swagger-ui-express';
import swaggerConfig from '../../config/swagger';
import userRoutes from './userRoutes';
import playerRoutes from './playerRoutes';
import coachRoutes from './coachRoutes';

export const initRoutes = (app: Application) => {
    app.use('/swagger', swaggerUi.serve, swaggerUi.setup(swaggerConfig));

    // This middleware validates the token before executing the endpoint (only for /api/endpoints)
    app.use('/api', validateToken);
    
    app.use('/', userRoutes);
    app.use('/api', playerRoutes);
    app.use('/api', coachRoutes);
};