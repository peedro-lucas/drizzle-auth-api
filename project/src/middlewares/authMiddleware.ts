import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

const SECRET_KEY = process.env.JWT_SECRET || "secret";

// Definição da interface para representar o usuário decodificado do JWT
interface DecodedUser {
  id: string;
  email: string;
  role: string;
}

// Extensão da interface Request para incluir o user
interface AuthenticatedRequest extends Request {
  user?: DecodedUser;
}

// Middleware para verificar autenticação e role de admin
export function isAdmin(req: AuthenticatedRequest, res: Response, next: NextFunction) {
  const authHeader = req.headers.authorization

  if (!authHeader) {
    return res.status(401).json({ message: "Token não fornecido" })
  }

  const token = authHeader.split(" ")[1];

  try {
    const decoded = jwt.verify(token, SECRET_KEY) as DecodedUser;

    if (decoded.role !== "admin") {
      return res.status(403).json({ message: "Acesso negado. Apenas admins podem executar esta ação." })
    }
    req.user = decoded
    next()
  } catch (error) {
    return res.status(401).json({ message: "Token inválido" })
  }
}
