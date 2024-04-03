import { Request, Response } from 'express';
import bcrypt from 'bcrypt';
import { createUser, getUserByEmail } from '../daos/userDAO';
import { generateToken } from '../utilities/token';
import { Status } from '../enums/status.enum';
import { sendNewUserEmail, sendPasswordRecoveryEmail } from '../utilities/mailer';

export const login = async (req: Request, res: Response) => {
    const { email, password } = req.body;
    try {
        const { rows } = await getUserByEmail(email);
        if (rows.length === 0) {
            res.status(Status.Unauthorized).send("Email is not registered");
            return;
        }
        bcrypt.compare(password, rows[0].pwd_hash, (error, result) => {
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

export const signup = async (req: Request, res: Response) => {
    const { email, firstName, lastName } = req.body;
    try {
        const { rows } = await getUserByEmail(email);
        if (rows.length > 0) {
            res.status(Status.BadRequest).send("Email is already registered");
            return;
        }
        const userData = {
            email,
            first_name : firstName,
            last_name : lastName,
            active : false // the new user is inactive until the password is generated
        }
        const { rowCount } = await createUser(userData);
        if (rowCount === 0) {
            res.status(Status.InternalError).send("User could not be created");
            return;
        }
        await sendNewUserEmail(email, firstName, lastName);
        res.status(Status.Created).send("User was created with inactive status");
    } catch (error) {
        console.error('UserController :', error);
        res.status(Status.InternalError).send(error);
    }
};

export const recoverPassword = async (req: Request, res: Response) => {
    const { email } = req.body;
    try {
        const { rows } = await getUserByEmail(email);
        if (rows.length === 0) {
            res.status(Status.BadRequest).send("The user doesn't exist");
            return;
        }
        await sendPasswordRecoveryEmail(email);
        res.status(Status.Ok).send("Recovery password email was sent");
    } catch (error) {
        console.error('UserController :', error);
        res.status(Status.InternalError).send(error);
    }
};