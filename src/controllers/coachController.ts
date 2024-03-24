import { Request, Response } from 'express';
import { Coach } from '../models/Coach';
import { Gender } from '../enums/gender.enum';

export const getAllCoaches = (req: Request, res: Response) => {
    const coaches: Coach[] = [
        { id: 1, firstName: 'Gabriel', lastName: 'Ruderman', gender: Gender.M, email: 'asd@gmail.com' },
        { id: 2, firstName: 'Gabriela', lastName: 'Rudermana', gender: Gender.F, email: 'asd@gmail.com' },
    ];
    res.json(coaches);
};