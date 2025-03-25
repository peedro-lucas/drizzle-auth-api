ALTER TABLE "subscription_changes" ADD COLUMN "description" text NOT NULL;--> statement-breakpoint
ALTER TABLE "subscription_changes" DROP COLUMN "changes";