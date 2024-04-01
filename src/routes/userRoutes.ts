import express from 'express';
import { login, logup } from '../controllers/UserController';

const router = express.Router();

/**
 * @openapi
 * /user/login:
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
 *               password:
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

/**
 * @openapi
 * /user/logup:
 *   post:
 *     summary: Logup
 *     description: Generate a new user. If it doesn't exist, an email is sent with a link to click and check if the user is real.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *               password:
 *                 type: string
 *               firstName:
 *                 type: string
 *               lastName:
 *                 type: string
 *     responses:
 *       '200':
 *         description: User was registered as inactive
 *       '401':
 *         description: Email is already registered
 *       '500':
 *         description: Internal error
 */
router.post('/user/logup', logup);

export default router;