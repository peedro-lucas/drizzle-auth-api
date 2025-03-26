/* eslint-disable @typescript-eslint/no-explicit-any */
import { Router } from "express";

import { CreateUser, GetAllUsers, GetUserById, UpdateUser } from "../controllers/userController";


const userRouter = Router();


// // POST /user/login - Faz login de um usuário
userRouter.post("/", CreateUser);
userRouter.get("/", GetAllUsers);
userRouter.post("/id", GetUserById)
userRouter.put("/", UpdateUser)


export default userRouter;
