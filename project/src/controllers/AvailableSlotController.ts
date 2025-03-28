import { Request, Response } from "express";
import { AvailableSlotService } from "../services/AvailableSlotService";

const availableSlotService = new AvailableSlotService();


export async function createAvailableSlot(req:Request, res:Response){
    try{
        const {doctorId, date, time} = req.body;
        
        const newSlot = await availableSlotService.createSlot({
            doctorId,
            date,
            time,
            isBooked: false
        }," ");
        return res.status(201).json(newSlot);
    }catch(err){
        return res.status(500).json({message: "Erro ao criar o horário"});
    }
}