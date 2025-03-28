import { Router } from "express";

import userRouter from "./userRoutes";
import authRouter from "./authRoutes";
import doctorRouter from "./doctorRoutes";
import availableSlotRouter from "./availableSlotRoutes";

const routes = Router();

// Rotas de usuário
routes.use("/user", userRouter);

//Rotas de autenticação
routes.use("/auth", authRouter)

//Rotas de doutor
routes.use("/doctor", doctorRouter);

// Rotas de horários disponíveis
routes.use("/available-slots", availableSlotRouter);


export default routes;
