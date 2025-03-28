import { database } from "../config/database";
import { doctorsTable } from "../database/schemas/doctor";
import { eq } from "drizzle-orm";


interface CreateDoctorDTO{
    email:string;
    name:string;
    specialty:string;
}

export class DoctorService {
    async createDoctor(data:CreateDoctorDTO){

        const existingDoctor = await database.select().from(doctorsTable).where(eq(doctorsTable.email,data.email));

        if(existingDoctor.length > 0 ){
            throw new Error('Usuario ja existe')
        }

        const [newDoctor] = await database.insert(doctorsTable).values(data).returning();

        return newDoctor
}

    async getAllDoctors(){
        const doctors = await database.select().from(doctorsTable);

        return doctors;
    }

    async getDoctorById(id:string){
        const doctor = await database.select().from(doctorsTable).where(eq(doctorsTable.id,id));

        if(doctor.length === 0){
            throw new Error("Usuario não encontrado");
        }

        return doctor[0]
    }

}