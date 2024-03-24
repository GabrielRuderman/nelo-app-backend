import { Gender } from "../enums/gender.enum";

export interface Player {
    id: number;
    firstName: string;
    lastName: string;
    gender: Gender;
    email: string;
}