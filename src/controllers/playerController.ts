import { Request, Response } from 'express';
import { Player } from '../models/Player';
import { Gender } from '../enums/gender.enum';

export const getAllPlayers = (req: Request, res: Response) => {
    const players: Player[] = [
        { id: 1, firstName: 'Julian', lastName: 'Gonzalez Chiquirrin', gender: Gender.M, email: 'asd@gmail.com' },
        { id: 2, firstName: 'Juliana', lastName: 'Gonzaleza Chiquirrina', gender: Gender.F, email: 'asd@gmail.com' },
    ];
    res.json(players);
};