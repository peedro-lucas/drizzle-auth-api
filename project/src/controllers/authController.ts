import { loginSchema } from "../validators/authSchema";
import { AuthService } from "../services/authService";
import {Request,Response} from 'express'

const authService =  new AuthService()

export async function loginUser(req:Request, res:Response){
    try{
        const validatedData = loginSchema.safeParse(req.body)

        if(!validatedData.success){
            return res.status(400).json({erros:validatedData.error.format()})
        }

        const {email, password} = validatedData.data
        const result = await authService.login(email,password)

        return res.status(200).json(result)
    }catch(err){
        return res.status(401).json({ error: err instanceof Error ? err.message : "Erro desconhecido" });
    }

}