CREATE TYPE "public"."USER_PERMISSION_ENUM" AS ENUM('Cadastrar profissional', 'Editar profissional', 'Excluir profissional', 'Cadastrar criança', 'Editar criança', 'Excluir criança', 'Cadastrar escola', 'Editar escola', 'Excluir escola', 'Editar clínica', 'Excluir clínica', 'Cadastrar créditos', 'Editar créditos', 'Aplicar jogo', 'Editar usuário', 'Excluir usuário');--> statement-breakpoint
CREATE TABLE "children_peis" (
	"id" text PRIMARY KEY NOT NULL,
	"pei_url" text NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"child_id" text
);
--> statement-breakpoint
ALTER TABLE "permissions" ALTER COLUMN "name" SET DATA TYPE USER_PERMISSION_ENUM;--> statement-breakpoint
ALTER TABLE "children" ADD COLUMN "pei_url" text;--> statement-breakpoint
ALTER TABLE "children_peis" ADD CONSTRAINT "children_peis_child_id_children_id_fk" FOREIGN KEY ("child_id") REFERENCES "public"."children"("id") ON DELETE cascade ON UPDATE no action;