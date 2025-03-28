import {Request, Response} from 'express'
import { UserService } from '../services/userService'
import { userSchema } from '../validators/userSchema';

const userService = new UserService();

// Controller para lidar com as requisições relacionadas a usuários

//FUNÇÃO DE CRIAR USUARIO
export async function CreateUser(req: Request, res: Response){
  try{
    const reqBody = req.body 

    const validateData = userSchema.parse(reqBody)

    const user = await userService.createUser(validateData)

    return res.status(201).json(user)
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  }catch(err: any){
    if (err instanceof Error) {
      return res.status(400).json({ error: err.message });
    }
    return res.status(500).json({ error: err.message });
  }
}

//FUNÇÃO DE BUSCAR TODOS OS USERS
export async function GetAllUsers(req:Request,res:Response){
    try{
      const users = await userService.getAllUsers()
      return res.status(200).json(users)
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
    }catch(err:any){
      return res.status(500).json(err.message)
    }
}

//FUNÇÃO DE BUSCAR UM USUARIO ESPECIFICO
export async function GetUserById(req:Request,res:Response){
  try{
    const {id} = req.body

    const user = await userService.getUserById(id)

    return res.status(200).json(user)
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
  }catch(err:any){
    return res.status(500).json(err.message)
  }
}

export async function UpdateUser(req:Request, res:Response){
  try{
  const {id} = req.body
  const updateData = req.body

  const updatedUser = await userService.updatedUser(id, updateData)

  return res.status(200).json(updatedUser)
// eslint-disable-next-line @typescript-eslint/no-explicit-any
}catch(err:any){
  return res.status(500).json({error: err.message})
}
}