import express from 'express';
import { getAllCoaches } from '../controllers/CoachController';

const router = express.Router();

/**
 * @openapi
 * /api/coaches:
 *   get:
 *     summary: Get all coaches
 *     description: Retrieve a list of all coaches
 *     responses:
 *       '200':
 *         description: A list of coaches
 */
router.get('/coaches', getAllCoaches);

export default router;