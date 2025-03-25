ALTER TABLE "identification_histories" drop column "visualis_score";--> statement-breakpoint
ALTER TABLE "identification_histories" ADD COLUMN "visualis_score" integer GENERATED ALWAYS AS (
    visualis_first_omissions + visualis_second_omissions + visualis_third_omissions + visualis_first_additions + visualis_second_additions + visualis_third_additions
  ) STORED;