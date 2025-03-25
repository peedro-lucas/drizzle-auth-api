/* eslint-disable @typescript-eslint/no-explicit-any */
import { config } from "dotenv";
import { connectToDatabase, resetDatabase  } from "./config/database";

import express from "express";

// Importando as rotas
import routes from "./routes";

async function main() {
  try {
    // Carregando as variáveis de ambiente
    config();

    // Conectando ao banco de dados
    await connectToDatabase();

    // Criando o servidor
    const app = express();

    // Habilitando o uso de JSON
    app.use(express.json());

    // limitar o tamanho do corpo da requisição
    app.use(express.json({ limit: "4mb" }));

    // Configurando as rotas
    app.use("/", routes);

    // Definindo a porta do servidor
    const port = +(process.env.PORT ?? 8001);

    app.listen(port, () => console.log(`Servidor online na porta`, port));
  } catch (error) {
    console.error("Erro ao iniciar o servidor | ", error);
  }
}

main();