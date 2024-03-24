import express from 'express';
import { getAllPlayers } from '../controllers/playerController';

const router = express.Router();

router.get('/players', getAllPlayers);

export default router;