import { Router } from "express";

import userRouter from "./userRoutes";
import authRouter from "./authRoutes";

const routes = Router();

// Rotas de usuário
routes.use("/user", userRouter);

//Rotas de autenticação
routes.use("/auth", authRouter)


export default routes;
