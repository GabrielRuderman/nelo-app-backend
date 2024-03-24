import express from 'express';
import { getAllCoaches } from '../controllers/coachController';

const router = express.Router();

router.get('/coaches', getAllCoaches);

export default router;