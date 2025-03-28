import { DoctorService } from "../services/doctorService";
import { Request, Response } from "express";
import { doctorSchema } from "../validators/doctorSchema";



const doctorService = new DoctorService();


export async function CreateDoctor(req: Request, res: Response){
    try{
        const {email, name, specialty} = req.body;

        const validatedData = doctorSchema.parse({email, name, specialty});

        const user = await doctorService.createDoctor(validatedData);

        return res.status(201).json(user);
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    }catch(err:any){
        if (err instanceof Error) {
      return res.status(400).json({ error: err.message });
    }
    return res.status(500).json({ error: err.message });
    }
}

export async function GetAllDoctors(req: Request, res: Response){
    try{
        const doctors = await doctorService.getAllDoctors();

        return res.status(200).json(doctors);

    }catch(err){
        return res.status(500).json({message: err});
    }
}

export async function GetDoctorById(req: Request, res: Response){
    try{
        const {id} = req.body;

        const doctor = await doctorService.getDoctorById(id);

        return res.status(200).json(doctor);

    }catch(err){
        return res.status(500).json({message: err});
    }
}