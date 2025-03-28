import { database } from "../config/database";
import { availableSlotsTable } from "../database/schemas/availableSlot";
import { and, eq }from "drizzle-orm";

interface CreateSlotDTO{
    doctorId:string;
    date:string;
    time:string;
    isBooked:boolean;
}

export class AvailableSlotService{
    async createSlot(data:CreateSlotDTO, specialty:string){
        if (specialty){
            throw new Error("Apenas médicos podem criar horarios")
        }

        const [newSlot] = await database
      .insert(availableSlotsTable)
      .values(data)
      .returning();
    
        return newSlot;
    }

    async getAvailableSlots(doctorId:string){
        return await database
        .select()
        .from(availableSlotsTable)
        .where(and(eq(availableSlotsTable.doctorId, doctorId), eq(availableSlotsTable.isBooked, false)))
        // .where()
    }

}