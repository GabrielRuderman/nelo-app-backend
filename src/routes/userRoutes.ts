import express from 'express';
import { login } from '../controllers/UserController';

const router = express.Router();

/**
 * @openapi
 * /api/user/login:
 *   post:
 *     summary: Login
 *     description: Validate credentials
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
 *         description: Successful
 */
router.post('/user/login', login);

export default router;