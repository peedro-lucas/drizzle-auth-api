import { Router } from "express";
import { CreateDoctor, GetAllDoctors, GetDoctorById } from "../controllers/doctorController";
import { isAdmin } from "../middlewares/authMiddleware";

const router = Router();

router.post("/", isAdmin, CreateDoctor);

router.get("/", GetAllDoctors)

router.get("/id", GetDoctorById)

export default router;