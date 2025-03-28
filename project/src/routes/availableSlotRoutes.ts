import { Router } from "express";
import { createAvailableSlot } from "../controllers/AvailableSlotController";

const router = Router();

router.post("/", createAvailableSlot);

export default router;