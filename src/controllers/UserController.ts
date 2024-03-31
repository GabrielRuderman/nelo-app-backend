import { Request, Response } from 'express';
import bcrypt from 'bcrypt';
import { getPasswordByEmail } from '../daos/userDAO';

export const login = async (req: Request, res: Response) => {
    const { email, pwdHash } = req.body;
    try {
        const { rows } = await getPasswordByEmail(email);
        bcrypt.compare(pwdHash, rows[0].pwd_hash, (error, result) => {
            if (error) {
                console.error('UserController : Error comparing passwords:', error);
                res.status(500).json({ message: error });
            }
            if (result) {
                res.send("crendeciales validas");
            } else {
                res.send("credenciales invalidas");
            }
        });
    } catch (error) {
        console.error('UserController :', error);
        res.status(500).json({ message: error });
    }
};