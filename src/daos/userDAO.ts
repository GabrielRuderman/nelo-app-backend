import { completeQuestionMarks } from "../utilities/sql";
import { pool } from '../../config/database';

const GET_PASSWORD_BY_EMAIL = `SELECT * FROM users WHERE email='/?/';`;
const CREATE_USER = `INSERT INTO users (email, pwd_hash, first_name, last_name, active) VALUES ('/?/', '/?/', '/?/', '/?/', /?/);`;

export const getUserByEmail = (email: string) => {
    const query = completeQuestionMarks(GET_PASSWORD_BY_EMAIL, [email]);
    return pool.query(query);
};

export const createUser = (userData: Record<string, any>) => {
    const { email, pwd_hash, first_name, last_name, active } = userData;

    const query = completeQuestionMarks(CREATE_USER, [email, pwd_hash, first_name, last_name, active]);
    return pool.query(query);
};