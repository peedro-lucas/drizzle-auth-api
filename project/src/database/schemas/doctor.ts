import { createId } from "@paralleldrive/cuid2";
import { pgTable,text,timestamp } from "drizzle-orm/pg-core";

export const doctorsTable = pgTable("doctors", {
    id:text("id").primaryKey().$defaultFn(createId),
    email:text("email").notNull(),
    name:text("name").notNull(),
    specialty:text("specialty").notNull(),
    createdAt:timestamp("created_at").defaultNow(),
    updatedAt:timestamp("updated_at"),
});