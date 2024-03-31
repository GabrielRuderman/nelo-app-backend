import jwt from 'jsonwebtoken';

export const generateToken = (userId: number, email: string, firstName: string, lastName: string): string => {
    if (!process.env.JWT_PRIV_KEY) throw new Error('JWT_PRIV_KEY is undefined');

    const jwtPrivKey: string = process.env.JWT_PRIV_KEY ? process.env.JWT_PRIV_KEY : '';
    const payload = { userId, email, firstName, lastName };
    const options = { expiresIn: '1d' };

    const token = jwt.sign(payload, jwtPrivKey, options);
    return token;
}