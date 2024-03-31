import { Request, Response } from 'express';
import bcrypt from 'bcrypt';
import { getPasswordByEmail } from '../daos/userDAO';
import { generateToken } from '../utilities/token';

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
                if (!rows[0].active) {
                    res.send("Inactive User");
                }
                const token = generateToken(rows[0].user_id, email, rows[0].first_name, rows[0].last_name);
                res.send(token);
            } else {
                res.send("Invalid Credentials");
            }
        });
    } catch (error) {
        console.error('UserController :', error);
        res.status(500).json({ message: error });
    }
};