ALTER TABLE "doctors" ALTER COLUMN "updated_at" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "available_slots" ALTER COLUMN "time" SET DATA TYPE text;