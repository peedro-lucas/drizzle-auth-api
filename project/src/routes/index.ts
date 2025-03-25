import { Router } from "express";

import userRouter from "./userRoutes";
const routes = Router();

// Rotas de usuário
routes.use("/user", userRouter);


export default routes;
