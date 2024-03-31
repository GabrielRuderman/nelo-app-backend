import { NextFunction, Request, Response } from 'express';
import jwt from 'jsonwebtoken';
import { Status } from '../enums/status.enum';

const jwtPrivKey: string = process.env.JWT_PRIV_KEY ? process.env.JWT_PRIV_KEY : '';

export const generateToken = (userId: number, email: string, firstName: string, lastName: string): string => {
    if (jwtPrivKey === '') throw new Error('JWT_PRIV_KEY is undefined');

    const payload = { userId, email, firstName, lastName };
    const options = { expiresIn: '1d' };

    const token = jwt.sign(payload, jwtPrivKey, options);
    return token;
}

interface UserRequest extends Request {
    user?: any;
}

export const validateToken = (req: UserRequest, res: Response, next: NextFunction) => {
    const token = req.headers.authorization?.split(' ')[1];

    if (!token) {
        return res.status(Status.Unauthorized).send('Session Token was not received');
    }

    jwt.verify(token, jwtPrivKey, (error, decoded) => {
        if (error) {
            return res.status(Status.Unauthorized).send('Invalid token');
        }
        req.user = decoded;
        next();
    });
};