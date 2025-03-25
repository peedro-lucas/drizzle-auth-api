ALTER TABLE "identification_histories" ALTER COLUMN "lectio_status" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "lectio_status" DROP NOT NULL;--> statement-breakpoint
ALTER TABLE "identification_histories" drop column "lectio_status";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "lectio_status" "GAME_STATUS_ENUM" GENERATED ALWAYS AS (
    CASE 
        WHEN lectio_letter_status = 'Concluido' 
          AND lectio_word_status = 'Concluido' 
          AND lectio_pseudoword_status = 'Concluido'
        THEN 'Concluido'
        ELSE 'Em andamento'
    END
  ) STORED;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "lectio_time" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "identification_histories" drop column "lectio_time";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "lectio_time" real GENERATED ALWAYS AS (
    lectio_letter_time + lectio_word_time + lectio_pseudoword_time
  ) STORED;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "lectio_score" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "identification_histories" drop column "lectio_score";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "lectio_score" integer GENERATED ALWAYS AS (
    lectio_letter_score + lectio_word_score + lectio_pseudoword_score
  ) STORED;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "scriptura_status" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "scriptura_status" DROP NOT NULL;--> statement-breakpoint
ALTER TABLE "identification_histories" drop column "scriptura_status";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "scriptura_status" "GAME_STATUS_ENUM" GENERATED ALWAYS AS (
    CASE 
        WHEN scriptura_letter_status = 'Concluido' 
          AND scriptura_word_status = 'Concluido' 
          AND scriptura_pseudoword_status = 'Concluido'
        THEN 'Concluido'
        ELSE 'Em andamento'
    END
  ) STORED;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "scriptura_time" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "identification_histories" drop column "scriptura_time";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "scriptura_time" real GENERATED ALWAYS AS (
    scriptura_letter_time + scriptura_word_time + scriptura_pseudoword_time
  ) STORED;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "scriptura_score" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "identification_histories" drop column "scriptura_score";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "scriptura_score" integer GENERATED ALWAYS AS (
    scriptura_letter_score + scriptura_word_score + scriptura_pseudoword_score
  ) STORED;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "visualis_score" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "identification_histories" drop column "visualis_score";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "visualis_score" integer GENERATED ALWAYS AS (
    visualis_first_score + visualis_second_score + visualis_third_score + visualis_first_additions + visualis_second_additions + visualis_third_additions
  ) STORED;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "calculum_score" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "identification_histories" drop column "calculum_score";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "calculum_score" integer GENERATED ALWAYS AS (
    calculum_sum_score + calculum_sub_score + calculum_mult_score + calculum_div_score
  ) STORED;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "grafomo_score" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "identification_histories" drop column "grafomo_score";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "grafomo_score" integer GENERATED ALWAYS AS (
    grafomo_x_score + grafomo_circle_score + grafomo_square_score + grafomo_rectangle_score + grafomo_triangle_score
  ) STORED;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "nominare_status" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "nominare_status" DROP NOT NULL;--> statement-breakpoint
ALTER TABLE "identification_histories" drop column "nominare_status";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "nominare_status" "GAME_STATUS_ENUM" GENERATED ALWAYS AS (
    CASE 
        WHEN nominare_letter_status = 'Concluido' 
          AND nominare_number_status = 'Concluido' 
        THEN 'Concluido'
        ELSE 'Em andamento'
    END
  ) STORED;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "nominare_time" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "identification_histories" drop column "nominare_time";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "nominare_time" real GENERATED ALWAYS AS (
    nominare_letter_time + nominare_number_time
  ) STORED;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "nominare_score" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "identification_histories" drop column "nominare_score";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "nominare_score" integer GENERATED ALWAYS AS (
    nominare_letter_score + nominare_number_score
  ) STORED;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "opus_status" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "opus_status" DROP NOT NULL;--> statement-breakpoint
ALTER TABLE "identification_histories" drop column "opus_status";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "opus_status" "GAME_STATUS_ENUM" GENERATED ALWAYS AS (
    CASE 
        WHEN opus_number_status = 'Concluido' 
          AND opus_pseudoword_status = 'Concluido' 
        THEN 'Concluido'
        ELSE 'Em andamento'
    END
  ) STORED;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "opus_time" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "identification_histories" drop column "opus_time";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "opus_time" real GENERATED ALWAYS AS (
    opus_number_time + opus_pseudoword_time
  ) STORED;--> statement-breakpoint
ALTER TABLE "identification_histories" ALTER COLUMN "opus_score" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "identification_histories" drop column "opus_score";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "opus_score" integer GENERATED ALWAYS AS (
    opus_number_score + opus_pseudoword_score
  ) STORED;