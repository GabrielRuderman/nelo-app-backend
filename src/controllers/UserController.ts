import { Request, Response } from 'express';
import bcrypt from 'bcrypt';
import { getUserByEmail } from '../daos/userDAO';
import { generateToken } from '../utilities/token';
import { Status } from '../enums/status.enum';

export const login = async (req: Request, res: Response) => {
    const { email, pwdHash } = req.body;
    try {
        const { rows } = await getUserByEmail(email);
        if (rows.length === 0) {
            res.status(Status.Unauthorized).send("Email is not registered");
            return;
        }
        bcrypt.compare(pwdHash, rows[0].pwd_hash, (error, result) => {
            if (error) {
                console.error('UserController : Error comparing passwords:', error);
                res.status(Status.InternalError).send(error);
            }
            if (result) {
                if (!rows[0].active) {
                    res.status(Status.Forbidden).send("Inactive User");
                }
                const token = generateToken(rows[0].user_id, email, rows[0].first_name, rows[0].last_name);
                res.status(Status.Ok).send(token);
            } else {
                res.status(Status.Unauthorized).send("Invalid Credentials");
            }
        });
    } catch (error) {
        console.error('UserController :', error);
        res.status(Status.InternalError).send(error);
    }
};