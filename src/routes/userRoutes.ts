import express from 'express';
import { login } from '../controllers/UserController';

const router = express.Router();

/**
 * @openapi
 * /api/user/login:
 *   post:
 *     summary: Login
 *     description: Validate credentials with email and password. Returns a session token in case they are valid.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *               pwdHash:
 *                 type: string
 *     responses:
 *       '200':
 *         description: Credentials are valid
 *       '401':
 *         description: Credentials are invalid
 *       '403':
 *         description: Inactive user
 *       '500':
 *         description: Internal error
 */
router.post('/user/login', login);

export default router;