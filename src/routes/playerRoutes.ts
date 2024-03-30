import express from 'express';
import { getAllPlayers } from '../controllers/playerController';

const router = express.Router();

/**
 * @openapi
 * /api/players:
 *   get:
 *     summary: Get all players
 *     description: Retrieve a list of all players
 *     responses:
 *       '200':
 *         description: A list of players
 */
router.get('/players', getAllPlayers);

export default router;