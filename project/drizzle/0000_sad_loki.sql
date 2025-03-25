CREATE TYPE "public"."CHILD_TYPE_ENUM" AS ENUM('Dependente', 'Aluno', 'Paciente');--> statement-breakpoint
CREATE TYPE "public"."CREDIT_TRANSACTION_TYPE_ENUM" AS ENUM('Compra', 'Utilização', 'Redefinição');--> statement-breakpoint
CREATE TYPE "public"."CYCLE_ENUM" AS ENUM('Mensal', 'Anual');--> statement-breakpoint
CREATE TYPE "public"."GAME_STATUS_ENUM" AS ENUM('Em andamento', 'Concluido');--> statement-breakpoint
CREATE TYPE "public"."GENDER_ENUM" AS ENUM('Masculino', 'Feminino', 'Outro');--> statement-breakpoint
CREATE TYPE "public"."PAYMENT_METHOD_ENUM" AS ENUM('Cartão de crédito', 'Boleto', 'Pix');--> statement-breakpoint
CREATE TYPE "public"."PAYMENT_STATUS_ENUM" AS ENUM('Pendente', 'Pago', 'Cancelado');--> statement-breakpoint
CREATE TYPE "public"."RELATIONSHIP_ENUM" AS ENUM('Pai', 'Mãe', 'Responsável legal');--> statement-breakpoint
CREATE TYPE "public"."SCHOOL_SECTOR_ENUM" AS ENUM('Municipal', 'Estadual', 'Federal');--> statement-breakpoint
CREATE TYPE "public"."SCHOOL_TYPE_ENUM" AS ENUM('Pública', 'Privada');--> statement-breakpoint
CREATE TYPE "public"."SCHOOL_ZONE_ENUM" AS ENUM('Urbana', 'Rural');--> statement-breakpoint
CREATE TYPE "public"."SHIFT_ENUM" AS ENUM('Matutino', 'Vespertino', 'Noturno');--> statement-breakpoint
CREATE TYPE "public"."SUBSCRIPTION_STATUS_ENUM" AS ENUM('Aguardando liberação', 'Ativa', 'Cancelada', 'Suspensa');--> statement-breakpoint
CREATE TYPE "public"."USER_ROLE_ENUM" AS ENUM('Master', 'Suporte', 'Gestor escola', 'Professor', 'Gestor clínica', 'Médico', 'Profissional', 'Responsável');--> statement-breakpoint
CREATE TYPE "public"."USER_STATUS_ENUM" AS ENUM('Ativo', 'Inativo', 'Suspenso');--> statement-breakpoint
CREATE TABLE "addresses" (
	"id" text PRIMARY KEY NOT NULL,
	"country" varchar(30) NOT NULL,
	"zip_code" varchar(20) NOT NULL,
	"state" varchar(4) NOT NULL,
	"city" varchar(100) NOT NULL,
	"street" varchar(100) NOT NULL,
	"number" varchar(6) NOT NULL,
	"complement" varchar(100),
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp,
	"user_id" text
);
--> statement-breakpoint
CREATE TABLE "audit_logs" (
	"id" text PRIMARY KEY NOT NULL,
	"action" varchar(50) NOT NULL,
	"table_name" varchar(50) NOT NULL,
	"record_id" text NOT NULL,
	"old_value" jsonb,
	"new_value" jsonb,
	"ip" varchar(45),
	"user_agent" text,
	"performed_at" timestamp DEFAULT now() NOT NULL,
	"user_id" text
);
--> statement-breakpoint
CREATE TABLE "error_logs" (
	"id" text PRIMARY KEY NOT NULL,
	"error_message" text NOT NULL,
	"stack_trace" text,
	"endpoint" text,
	"request_payload" jsonb,
	"ip" varchar(45),
	"user_agent" text,
	"occurred_at" timestamp DEFAULT now() NOT NULL,
	"user_id" text
);
--> statement-breakpoint
CREATE TABLE "children" (
	"id" text PRIMARY KEY NOT NULL,
	"name" varchar(100) NOT NULL,
	"type" "CHILD_TYPE_ENUM" NOT NULL,
	"birthdate" date NOT NULL,
	"state" varchar(2) NOT NULL,
	"gender" "GENDER_ENUM" NOT NULL,
	"grade" integer NOT NULL,
	"current_history" integer DEFAULT 0 NOT NULL,
	"completed_games" integer DEFAULT 0 NOT NULL,
	"general_percentil" integer DEFAULT 0 NOT NULL,
	"regional_percentil" integer DEFAULT 0 NOT NULL,
	"play_count" integer DEFAULT 0 NOT NULL,
	"registry" varchar(20),
	"shift" "SHIFT_ENUM",
	"section" varchar(1),
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp,
	"clinic_id" text,
	"responsible_id" text,
	"school_id" text,
	"class_id" text,
	"parent_id" text,
	"offline_school_id" text,
	CONSTRAINT "child_type_check" CHECK (
        ((CASE WHEN "children"."type" = 'Aluno' THEN 
            (CASE WHEN "children"."school_id" IS NOT NULL AND "children"."class_id" IS NOT NULL AND 
            "children"."responsible_id" IS NULL AND "children"."parent_id" IS NULL AND 
            "children"."offline_school_id" IS NULL AND "children"."clinic_id" IS NULL THEN 1 ELSE 0 END)
          ELSE 0 END) +

          (CASE WHEN "children"."type" = 'Paciente' THEN 
            (CASE WHEN "children"."clinic_id" IS NOT NULL AND "children"."responsible_id" IS NOT NULL AND 
            "children"."parent_id" IS NULL AND "children"."school_id" IS NULL AND 
            "children"."class_id" IS NULL AND "children"."offline_school_id" IS NULL THEN 1 ELSE 0 END)
          ELSE 0 END) +

          (CASE WHEN "children"."type" = 'Dependente' THEN 
            (CASE WHEN "children"."parent_id" IS NOT NULL AND "children"."school_id" IS NULL AND 
            "children"."class_id" IS NULL AND "children"."clinic_id" IS NULL AND 
            "children"."responsible_id" IS NULL AND "children"."offline_school_id" IS NULL THEN 1 ELSE 0 END)
          ELSE 0 END) +

          (CASE WHEN "children"."type" = 'Aluno' THEN 
            (CASE WHEN "children"."offline_school_id" IS NOT NULL AND "children"."class_id" IS NOT NULL AND 
            "children"."school_id" IS NULL AND "children"."clinic_id" IS NULL AND 
            "children"."responsible_id" IS NULL AND "children"."parent_id" IS NULL THEN 1 ELSE 0 END)
          ELSE 0 END)) = 1
      )
);
--> statement-breakpoint
CREATE TABLE "responsibles" (
	"id" text PRIMARY KEY NOT NULL,
	"name" varchar(100) NOT NULL,
	"phone" varchar(32),
	"phone_iv" varchar(32),
	"phone_hash" varchar(64),
	"relationship" "RELATIONSHIP_ENUM" NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "clinic_medics" (
	"clinic_id" text NOT NULL,
	"medic_id" text NOT NULL,
	CONSTRAINT "clinic_medics_clinic_id_medic_id_pk" PRIMARY KEY("clinic_id","medic_id")
);
--> statement-breakpoint
CREATE TABLE "clinics" (
	"id" text PRIMARY KEY NOT NULL,
	"name" varchar(80) NOT NULL,
	"cnpj" varchar(14) NOT NULL,
	"picture" varchar(128),
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp,
	"manager_id" text,
	"address_id" text
);
--> statement-breakpoint
CREATE TABLE "credit_transactions" (
	"id" text PRIMARY KEY NOT NULL,
	"type" "CREDIT_TRANSACTION_TYPE_ENUM" NOT NULL,
	"amount" integer NOT NULL,
	"description" text,
	"created_at" timestamp DEFAULT now(),
	"subscription_id" text
);
--> statement-breakpoint
CREATE TABLE "credits" (
	"id" text PRIMARY KEY NOT NULL,
	"total_credits" integer DEFAULT 0 NOT NULL,
	"extra_credits" integer DEFAULT 0 NOT NULL,
	"used_credits" integer DEFAULT 0 NOT NULL,
	"last_reset" date,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	"updated_by" text,
	"subscription_id" text
);
--> statement-breakpoint
CREATE TABLE "payments" (
	"id" text PRIMARY KEY NOT NULL,
	"amount" integer NOT NULL,
	"payment_date" timestamp DEFAULT now(),
	"payment_method" "PAYMENT_METHOD_ENUM" NOT NULL,
	"status" "PAYMENT_STATUS_ENUM" NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp,
	"subscription_id" text
);
--> statement-breakpoint
CREATE TABLE "subscriptions" (
	"id" text PRIMARY KEY NOT NULL,
	"monthly_credits" integer NOT NULL,
	"start_date" timestamp DEFAULT now() NOT NULL,
	"next_reset" date NOT NULL,
	"status" "SUBSCRIPTION_STATUS_ENUM" NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"parent_id" text,
	"clinic_id" text,
	"school_id" text,
	CONSTRAINT "reference_check" CHECK (
        (CASE WHEN "subscriptions"."parent_id" IS NOT NULL THEN 1 ELSE 0 END) +
        (CASE WHEN "subscriptions"."clinic_id" IS NOT NULL THEN 1 ELSE 0 END) +
        (CASE WHEN "subscriptions"."school_id" IS NOT NULL THEN 1 ELSE 0 END) = 1
      )
);
--> statement-breakpoint
CREATE TABLE "identification_histories" (
	"id" serial PRIMARY KEY NOT NULL,
	"status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"total_score" real DEFAULT 0,
	"total_time" real DEFAULT 0,
	"completed_games" integer DEFAULT 0,
	"general_percentil" integer DEFAULT 0,
	"regional_percentil" integer DEFAULT 0,
	"lectio_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"lectio_time" real DEFAULT 0,
	"lectio_score" integer DEFAULT 0,
	"lectio_letter_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"lectio_letter_time" real DEFAULT 0,
	"lectio_letter_score" integer DEFAULT 0,
	"lectio_letter_errors" varchar(90),
	"lectio_letters_image" varchar(90),
	"lectio_word_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"lectio_word_time" real DEFAULT 0,
	"lectio_word_score" integer DEFAULT 0,
	"lectio_word_errors" varchar(200),
	"lectio_words_image" varchar(90),
	"lectio_pseudoword_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"lectio_pseudoword_time" real DEFAULT 0,
	"lectio_pseudoword_score" integer DEFAULT 0,
	"lectio_pseudoword_errors" varchar(200),
	"lectio_pseudowords_image" varchar(90),
	"lectio_updated_at" timestamp DEFAULT now(),
	"scriptura_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"scriptura_time" real DEFAULT 0,
	"scriptura_score" integer DEFAULT 0,
	"scriptura_letter_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"scriptura_letter_time" real DEFAULT 0,
	"scriptura_letter_score" integer DEFAULT 0,
	"scriptura_letter_errors" varchar(90),
	"scriptura_letters_image" varchar(90),
	"scriptura_word_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"scriptura_word_time" real DEFAULT 0,
	"scriptura_word_score" integer DEFAULT 0,
	"scriptura_word_errors" varchar(200),
	"scriptura_words_image" varchar(90),
	"scriptura_pseudoword_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"scriptura_pseudoword_time" real DEFAULT 0,
	"scriptura_pseudoword_score" integer DEFAULT 0,
	"scriptura_pseudoword_errors" varchar(200),
	"scriptura_pseudowords_image" varchar(90),
	"scriptura_updated_at" timestamp DEFAULT now(),
	"visualis_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"visualis_time" real DEFAULT 0,
	"visualis_score" integer DEFAULT 0,
	"visualis_first_additions" integer DEFAULT 0,
	"visualis_first_omissions" integer DEFAULT 0,
	"visualis_second_additions" integer DEFAULT 0,
	"visualis_second_omissions" integer DEFAULT 0,
	"visualis_third_additions" integer DEFAULT 0,
	"visualis_third_omissions" integer DEFAULT 0,
	"visualis_letters" varchar(11),
	"visualis_updated_at" timestamp DEFAULT now(),
	"calculum_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"calculum_time" real DEFAULT 0,
	"calculum_score" integer DEFAULT 0,
	"calculum_sum_score" integer DEFAULT 0,
	"calculum_sub_score" integer DEFAULT 0,
	"calculum_mult_score" integer DEFAULT 0,
	"calculum_div_score" integer DEFAULT 0,
	"calculum_errors" varchar(60),
	"calculum_updated_at" timestamp DEFAULT now(),
	"grafomo_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"grafomo_time" real DEFAULT 0,
	"grafomo_score" integer DEFAULT 0,
	"grafomo_drawed_x" varchar(80),
	"grafomo_x_score" integer DEFAULT 0,
	"grafomo_x_errors" varchar(40),
	"grafomo_drawed_circle" varchar(80),
	"grafomo_circle_score" integer DEFAULT 0,
	"grafomo_circle_errors" varchar(40),
	"grafomo_drawed_square" varchar(80),
	"grafomo_square_score" integer DEFAULT 0,
	"grafomo_square_errors" varchar(40),
	"grafomo_drawed_rectangle" varchar(80),
	"grafomo_rectangle_score" integer DEFAULT 0,
	"grafomo_rectangle_errors" varchar(40),
	"grafomo_drawed_triangle" varchar(80),
	"grafomo_triangle_score" integer DEFAULT 0,
	"grafomo_triangle_errors" varchar(40),
	"grafomo_updated_at" timestamp DEFAULT now(),
	"meta_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"meta_time" real DEFAULT 0,
	"meta_score" integer DEFAULT 0,
	"meta_errors" varchar(130),
	"meta_updated_at" timestamp DEFAULT now(),
	"nominare_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"nominare_time" real DEFAULT 0,
	"nominare_score" integer DEFAULT 0,
	"nominare_letter_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"nominare_letter_time" real DEFAULT 0,
	"nominare_letter_score" integer DEFAULT 0,
	"nominare_letter_errors" varchar(120),
	"nominare_letter_audio" varchar(90),
	"nominare_requested_letters" varchar(75),
	"nominare_number_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"nominare_number_time" real DEFAULT 0,
	"nominare_number_score" integer DEFAULT 0,
	"nominare_number_errors" varchar(160),
	"nominare_number_audio" varchar(90),
	"nominare_requested_numbers" varchar(90),
	"nominare_updated_at" timestamp DEFAULT now(),
	"opus_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"opus_time" real DEFAULT 0,
	"opus_score" integer DEFAULT 0,
	"opus_number_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"opus_number_time" real DEFAULT 0,
	"opus_number_score" integer DEFAULT 0,
	"opus_number_errors" varchar(100),
	"opus_requested_numbers" varchar(100),
	"opus_pseudoword_status" "GAME_STATUS_ENUM" DEFAULT 'Em andamento' NOT NULL,
	"opus_pseudoword_time" real DEFAULT 0,
	"opus_pseudoword_score" integer DEFAULT 0,
	"opus_pseudoword_errors" varchar(200),
	"opus_requested_pseudowords" varchar(200),
	"opus_updated_at" timestamp DEFAULT now(),
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp,
	"child_id" text
);
--> statement-breakpoint
CREATE TABLE "offline_schools" (
	"id" text PRIMARY KEY NOT NULL,
	"name" varchar(192) NOT NULL,
	"state" varchar(2),
	"city" varchar(100),
	"inep_code" varchar(8),
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "school_classes" (
	"id" text PRIMARY KEY NOT NULL,
	"shift" "SHIFT_ENUM" NOT NULL,
	"grade" integer NOT NULL,
	"section" varchar(2) NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp,
	"school_id" text,
	"offline_school_id" text
);
--> statement-breakpoint
CREATE TABLE "schools" (
	"id" text PRIMARY KEY NOT NULL,
	"name" varchar(192) NOT NULL,
	"picture" varchar(128),
	"inep_code" varchar(8),
	"cnpj" varchar(14),
	"type" "SCHOOL_TYPE_ENUM" NOT NULL,
	"sector" "SCHOOL_SECTOR_ENUM" NOT NULL,
	"zone" "SCHOOL_ZONE_ENUM" NOT NULL,
	"code" varchar(32) NOT NULL,
	"code_iv" varchar(32) NOT NULL,
	"code_hash" varchar(64) NOT NULL,
	"max_students" integer NOT NULL,
	"cur_students" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp,
	"manager_id" text,
	"address_id" text,
	CONSTRAINT "schools_code_hash_unique" UNIQUE("code_hash")
);
--> statement-breakpoint
CREATE TABLE "teacher_classes" (
	"class_id" text NOT NULL,
	"teacher_id" text NOT NULL,
	CONSTRAINT "teacher_classes_class_id_teacher_id_pk" PRIMARY KEY("class_id","teacher_id")
);
--> statement-breakpoint
CREATE TABLE "recovery_codes" (
	"id" text PRIMARY KEY NOT NULL,
	"key" varchar(255) NOT NULL,
	"code" varchar(6) NOT NULL,
	"expires_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "user_changes" (
	"id" text PRIMARY KEY NOT NULL,
	"changes" jsonb NOT NULL,
	"changed_at" timestamp DEFAULT now() NOT NULL,
	"changed_by_name" varchar(100),
	"changed_by" text,
	"user_id" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE "user_deletions" (
	"id" text PRIMARY KEY NOT NULL,
	"deleted_at" timestamp DEFAULT now() NOT NULL,
	"deleted_by_name" varchar(100),
	"deleted_by" text,
	"user_id" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE "login_attempts" (
	"id" text PRIMARY KEY NOT NULL,
	"attempted_at" timestamp DEFAULT now() NOT NULL,
	"ip" varchar(45),
	"success" boolean NOT NULL,
	"user_id" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE "user_logins" (
	"id" text PRIMARY KEY NOT NULL,
	"login_at" timestamp DEFAULT now() NOT NULL,
	"ip" varchar(45),
	"user_agent" text,
	"user_id" text NOT NULL
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" text PRIMARY KEY NOT NULL,
	"name" varchar(100) NOT NULL,
	"email" varchar(255) NOT NULL,
	"email_iv" varchar(32) NOT NULL,
	"email_hash" varchar(64) NOT NULL,
	"phone" varchar(32),
	"phone_iv" varchar(32),
	"phone_hash" varchar(64),
	"password" varchar(255) NOT NULL,
	"profile_picture" varchar(255),
	"role" "USER_ROLE_ENUM" NOT NULL,
	"status" "USER_STATUS_ENUM" DEFAULT 'Ativo' NOT NULL,
	"state" varchar(2) NOT NULL,
	"crm" varchar(32),
	"is_first_login" boolean DEFAULT true NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp,
	CONSTRAINT "users_email_hash_unique" UNIQUE("email_hash"),
	CONSTRAINT "users_phone_hash_unique" UNIQUE("phone_hash")
);
--> statement-breakpoint
ALTER TABLE "addresses" ADD CONSTRAINT "addresses_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "error_logs" ADD CONSTRAINT "error_logs_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "children" ADD CONSTRAINT "children_clinic_id_clinics_id_fk" FOREIGN KEY ("clinic_id") REFERENCES "public"."clinics"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "children" ADD CONSTRAINT "children_responsible_id_responsibles_id_fk" FOREIGN KEY ("responsible_id") REFERENCES "public"."responsibles"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "children" ADD CONSTRAINT "children_school_id_schools_id_fk" FOREIGN KEY ("school_id") REFERENCES "public"."schools"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "children" ADD CONSTRAINT "children_class_id_school_classes_id_fk" FOREIGN KEY ("class_id") REFERENCES "public"."school_classes"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "children" ADD CONSTRAINT "children_parent_id_users_id_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "children" ADD CONSTRAINT "children_offline_school_id_offline_schools_id_fk" FOREIGN KEY ("offline_school_id") REFERENCES "public"."offline_schools"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "clinic_medics" ADD CONSTRAINT "clinic_medics_clinic_id_clinics_id_fk" FOREIGN KEY ("clinic_id") REFERENCES "public"."clinics"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "clinic_medics" ADD CONSTRAINT "clinic_medics_medic_id_users_id_fk" FOREIGN KEY ("medic_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "clinics" ADD CONSTRAINT "clinics_manager_id_users_id_fk" FOREIGN KEY ("manager_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "clinics" ADD CONSTRAINT "clinics_address_id_addresses_id_fk" FOREIGN KEY ("address_id") REFERENCES "public"."addresses"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "credit_transactions" ADD CONSTRAINT "credit_transactions_subscription_id_subscriptions_id_fk" FOREIGN KEY ("subscription_id") REFERENCES "public"."subscriptions"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "credits" ADD CONSTRAINT "credits_updated_by_users_id_fk" FOREIGN KEY ("updated_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "credits" ADD CONSTRAINT "credits_subscription_id_subscriptions_id_fk" FOREIGN KEY ("subscription_id") REFERENCES "public"."subscriptions"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "payments" ADD CONSTRAINT "payments_subscription_id_subscriptions_id_fk" FOREIGN KEY ("subscription_id") REFERENCES "public"."subscriptions"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_parent_id_users_id_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_clinic_id_clinics_id_fk" FOREIGN KEY ("clinic_id") REFERENCES "public"."clinics"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_school_id_schools_id_fk" FOREIGN KEY ("school_id") REFERENCES "public"."schools"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "identification_histories" ADD CONSTRAINT "identification_histories_child_id_children_id_fk" FOREIGN KEY ("child_id") REFERENCES "public"."children"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "school_classes" ADD CONSTRAINT "school_classes_school_id_schools_id_fk" FOREIGN KEY ("school_id") REFERENCES "public"."schools"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "school_classes" ADD CONSTRAINT "school_classes_offline_school_id_offline_schools_id_fk" FOREIGN KEY ("offline_school_id") REFERENCES "public"."offline_schools"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "schools" ADD CONSTRAINT "schools_manager_id_users_id_fk" FOREIGN KEY ("manager_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "schools" ADD CONSTRAINT "schools_address_id_addresses_id_fk" FOREIGN KEY ("address_id") REFERENCES "public"."addresses"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "teacher_classes" ADD CONSTRAINT "teacher_classes_class_id_school_classes_id_fk" FOREIGN KEY ("class_id") REFERENCES "public"."school_classes"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "teacher_classes" ADD CONSTRAINT "teacher_classes_teacher_id_users_id_fk" FOREIGN KEY ("teacher_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_changes" ADD CONSTRAINT "user_changes_changed_by_users_id_fk" FOREIGN KEY ("changed_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_changes" ADD CONSTRAINT "user_changes_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_deletions" ADD CONSTRAINT "user_deletions_deleted_by_users_id_fk" FOREIGN KEY ("deleted_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_deletions" ADD CONSTRAINT "user_deletions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "login_attempts" ADD CONSTRAINT "login_attempts_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_logins" ADD CONSTRAINT "user_logins_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "idx_children_name" ON "children" USING btree ("name");--> statement-breakpoint
CREATE INDEX "idx_children_registry" ON "children" USING btree ("registry");--> statement-breakpoint
CREATE INDEX "email_hash_idx" ON "users" USING btree ("email_hash");--> statement-breakpoint
CREATE INDEX "phone_hash_idx" ON "users" USING btree ("phone_hash");