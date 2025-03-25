ALTER TABLE "addresses" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "audit_logs" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "error_logs" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "children_peis" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "children" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "responsibles" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "clinic_medics" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "clinics" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "credit_transactions" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "credits" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "payments" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "subscription_changes" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "subscriptions" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "identification_histories" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "offline_schools" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "school_classes" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "schools" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "teacher_classes" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "permissions" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "recovery_codes" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "user_changes" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "user_deletions" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "login_attempts" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "user_logins" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "user_permissions" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
DROP TABLE "addresses" CASCADE;--> statement-breakpoint
DROP TABLE "audit_logs" CASCADE;--> statement-breakpoint
DROP TABLE "error_logs" CASCADE;--> statement-breakpoint
DROP TABLE "children_peis" CASCADE;--> statement-breakpoint
DROP TABLE "children" CASCADE;--> statement-breakpoint
DROP TABLE "responsibles" CASCADE;--> statement-breakpoint
DROP TABLE "clinic_medics" CASCADE;--> statement-breakpoint
DROP TABLE "clinics" CASCADE;--> statement-breakpoint
DROP TABLE "credit_transactions" CASCADE;--> statement-breakpoint
DROP TABLE "credits" CASCADE;--> statement-breakpoint
DROP TABLE "payments" CASCADE;--> statement-breakpoint
DROP TABLE "subscription_changes" CASCADE;--> statement-breakpoint
DROP TABLE "subscriptions" CASCADE;--> statement-breakpoint
DROP TABLE "identification_histories" CASCADE;--> statement-breakpoint
DROP TABLE "offline_schools" CASCADE;--> statement-breakpoint
DROP TABLE "school_classes" CASCADE;--> statement-breakpoint
DROP TABLE "schools" CASCADE;--> statement-breakpoint
DROP TABLE "teacher_classes" CASCADE;--> statement-breakpoint
DROP TABLE "permissions" CASCADE;--> statement-breakpoint
DROP TABLE "recovery_codes" CASCADE;--> statement-breakpoint
DROP TABLE "user_changes" CASCADE;--> statement-breakpoint
DROP TABLE "user_deletions" CASCADE;--> statement-breakpoint
DROP TABLE "login_attempts" CASCADE;--> statement-breakpoint
DROP TABLE "user_logins" CASCADE;--> statement-breakpoint
DROP TABLE "user_permissions" CASCADE;--> statement-breakpoint
ALTER TABLE "users" DROP CONSTRAINT "users_email_hash_unique";--> statement-breakpoint
ALTER TABLE "users" DROP CONSTRAINT "users_phone_hash_unique";--> statement-breakpoint
DROP INDEX "email_hash_idx";--> statement-breakpoint
DROP INDEX "phone_hash_idx";--> statement-breakpoint
ALTER TABLE "users" DROP COLUMN "email_iv";--> statement-breakpoint
ALTER TABLE "users" DROP COLUMN "email_hash";--> statement-breakpoint
ALTER TABLE "users" DROP COLUMN "phone";--> statement-breakpoint
ALTER TABLE "users" DROP COLUMN "phone_iv";--> statement-breakpoint
ALTER TABLE "users" DROP COLUMN "phone_hash";--> statement-breakpoint
ALTER TABLE "users" DROP COLUMN "profile_picture";--> statement-breakpoint
ALTER TABLE "users" DROP COLUMN "role";--> statement-breakpoint
ALTER TABLE "users" DROP COLUMN "status";--> statement-breakpoint
ALTER TABLE "users" DROP COLUMN "state";--> statement-breakpoint
ALTER TABLE "users" DROP COLUMN "crm";--> statement-breakpoint
ALTER TABLE "users" DROP COLUMN "is_first_login";--> statement-breakpoint
DROP TYPE "public"."CHILD_TYPE_ENUM";--> statement-breakpoint
DROP TYPE "public"."CREDIT_TRANSACTION_TYPE_ENUM";--> statement-breakpoint
DROP TYPE "public"."CYCLE_ENUM";--> statement-breakpoint
DROP TYPE "public"."GAME_STATUS_ENUM";--> statement-breakpoint
DROP TYPE "public"."GENDER_ENUM";--> statement-breakpoint
DROP TYPE "public"."PAYMENT_METHOD_ENUM";--> statement-breakpoint
DROP TYPE "public"."PAYMENT_STATUS_ENUM";--> statement-breakpoint
DROP TYPE "public"."RELATIONSHIP_ENUM";--> statement-breakpoint
DROP TYPE "public"."SCHOOL_SECTOR_ENUM";--> statement-breakpoint
DROP TYPE "public"."SCHOOL_TYPE_ENUM";--> statement-breakpoint
DROP TYPE "public"."SCHOOL_ZONE_ENUM";--> statement-breakpoint
DROP TYPE "public"."SHIFT_ENUM";--> statement-breakpoint
DROP TYPE "public"."SUBSCRIPTION_STATUS_ENUM";--> statement-breakpoint
DROP TYPE "public"."SUBSCRIPTION_CHANGE_ENUM";--> statement-breakpoint
DROP TYPE "public"."USER_PERMISSION_ENUM";--> statement-breakpoint
DROP TYPE "public"."USER_ROLE_ENUM";--> statement-breakpoint
DROP TYPE "public"."USER_STATUS_ENUM";