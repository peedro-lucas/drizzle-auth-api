/* eslint-disable @typescript-eslint/no-explicit-any */
import { Router } from "express";

import { CreateUser, GetAllUsers, GetUserById } from "../controllers/userController";


const userRouter = Router();


// // POST /user/login - Faz login de um usuário
userRouter.post("/", CreateUser);
userRouter.get("/", GetAllUsers);
userRouter.get("/:id", GetUserById)


export default userRouter;
