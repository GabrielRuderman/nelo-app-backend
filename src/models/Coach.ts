import { Gender } from "../enums/gender.enum";

export interface Coach {
    id: number;
    firstName: string;
    lastName: string
    gender: Gender;
    email: string;
}