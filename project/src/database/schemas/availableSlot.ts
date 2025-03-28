import {date,boolean,timestamp, text, pgTable } from "drizzle-orm/pg-core";

import { doctorsTable } from "./doctor";
import { createId } from "@paralleldrive/cuid2";


export const availableSlotsTable = pgTable("available_slots", {
    id:text("id").primaryKey().$defaultFn(createId),
    doctorId: text("doctor_id").notNull().references(()=> doctorsTable.id).notNull(),
    date:date("date").notNull(),
    time:text("time").notNull(),
    isBooked:boolean("is_booked").default(false).notNull(),
    createdAt:timestamp("created_at").defaultNow().notNull(),
    updatedAt:timestamp("updated_at").defaultNow()
});