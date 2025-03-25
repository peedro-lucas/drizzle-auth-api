CREATE TYPE "public"."SUBSCRIPTION_CHANGE_ENUM" AS ENUM('Liberação de uso extra', 'Bloqueio de uso extra', 'Aumento de créditos mensais', 'Diminuição de créditos mensais', 'Cancelamento');--> statement-breakpoint
CREATE TABLE "subscription_changes" (
	"id" text PRIMARY KEY NOT NULL,
	"action" "SUBSCRIPTION_CHANGE_ENUM" NOT NULL,
	"changes" jsonb NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"subscription_id" text,
	"user_id" text,
	"user_name" text
);
--> statement-breakpoint
ALTER TABLE "credits" RENAME COLUMN "extra_credits" TO "used_extra_credits";--> statement-breakpoint
ALTER TABLE "subscriptions" ADD COLUMN "billing_cycle" "CYCLE_ENUM" DEFAULT 'Mensal' NOT NULL;--> statement-breakpoint
ALTER TABLE "subscriptions" ADD COLUMN "can_use_extra_credits" boolean DEFAULT false NOT NULL;--> statement-breakpoint
ALTER TABLE "subscription_changes" ADD CONSTRAINT "subscription_changes_subscription_id_subscriptions_id_fk" FOREIGN KEY ("subscription_id") REFERENCES "public"."subscriptions"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "subscription_changes" ADD CONSTRAINT "subscription_changes_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;