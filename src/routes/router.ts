import { Application } from 'express';
import userRoutes from './userRoutes';
import playerRoutes from './playerRoutes';
import coachRoutes from './coachRoutes';

export const initRoutes = (app: Application) => {
    app.use('/api', userRoutes);
    app.use('/api', playerRoutes);
    app.use('/api', coachRoutes);
};