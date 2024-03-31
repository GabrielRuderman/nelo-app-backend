import { completeQuestionMarks } from "../utilities/sql";
import { pool } from '../../config/database';

const GET_PASSWORD_BY_EMAIL = `SELECT * FROM users WHERE email='/?/'`;

export const getPasswordByEmail = (email: string) => {
    const query = completeQuestionMarks(GET_PASSWORD_BY_EMAIL, [email]);
    return pool.query(query);
};