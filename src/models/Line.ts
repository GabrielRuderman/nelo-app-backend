import { Gender } from "../enums/gender.enum";

export interface Line {
    id: number;
    description: string;
    gender: Gender;
    division: string;
}