import { Pool } from "pg";
import { sql } from "drizzle-orm";
import { drizzle, NodePgDatabase } from "drizzle-orm/node-postgres";

export let database: NodePgDatabase;

// Função para conectar com o banco de dados
export async function connectToDatabase() {
  try {
    const pool = new Pool({
      database: process.env.DB,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      host: process.env.DB_HOST,
      port: parseInt(process.env.DB_PORT!),
      idleTimeoutMillis: 60000,
      min: 2,
      keepAlive: true,
    });

    database = drizzle(pool);

    await database.execute(sql.raw("SELECT 1"));
  } catch (error) {
    throw new Error("Erro ao conectar com o banco de dados | " + error);
  }
}

// Função para resetar o banco de dados
export async function resetDatabase() {
  try {
    const result = await database.transaction(async (transaction) => {
      await transaction.execute(sql.raw(`CREATE EXTENSION IF NOT EXISTS unaccent;`));
      await transaction.execute(sql.raw(`CREATE EXTENSION IF NOT EXISTS pg_trgm;`));

      const tables = (await transaction.execute(sql.raw(`SELECT tablename FROM pg_tables WHERE schemaname = 'public'`)))
        .rows;

      for (const { tablename } of tables) {
        await transaction.execute(sql.raw(`DROP TABLE IF EXISTS ${tablename} CASCADE`));
      }

      const enums = (await transaction.execute(sql.raw(`SELECT typname FROM pg_type WHERE typcategory = 'E'`))).rows;

      for (const { typname } of enums) {
        await transaction.execute(sql.raw(`DROP TYPE IF EXISTS ${typname}`));
      }

      return "Banco de dados resetado com sucesso!";
    });

    console.log(result);
  } catch (error) {
    console.log(error);
    throw new Error("Erro ao resetar o banco de dados | " + error);
  }
}