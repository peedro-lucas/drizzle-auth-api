import { pgTable, text, timestamp } from "drizzle-orm/pg-core";
import { usersTable } from "./user";
import { doctorsTable } from "./doctor";
import { availableSlotsTable } from "./availableSlot";
import { createId } from "@paralleldrive/cuid2";

export const appointmentsTable = pgTable("appointments", {
  id: text("id").primaryKey().$defaultFn(createId),
  userId: text("user_id").references(() => usersTable.id).notNull(),
  doctorId: text("doctor_id").references(() => doctorsTable.id).notNull(),
  slotId: text("slot_id").references(() => availableSlotsTable.id).notNull(),
  status: text("status").default("agendado").notNull(), // 'agendado', 'cancelado', 'concluído'
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});
