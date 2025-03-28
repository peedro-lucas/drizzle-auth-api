import { database } from "../config/database";
import {usersTable} from '../database/schemas/user'
import { eq } from "drizzle-orm";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config()

const SECRET_KEY = process.env.JWT_SECRET || "secret";

export class AuthService {
    async login(email:string, password:string){
    const user = await database.select().from(usersTable).where(eq(usersTable.email, email)).limit(1);

    if (user.length === 0) {
      throw new Error("E-mail ou senha inválidos");
    }

    const foundUser = user[0];

    const passwordMatch = await bcrypt.compare(password, foundUser.password);

    if (!passwordMatch) {
      throw new Error("E-mail ou senha inválidos");
    }

    const payload = { id: foundUser.id, 
                    email: foundUser.email,
                    role:foundUser.role 
                  };

    const token = jwt.sign(payload, SECRET_KEY, {
      expiresIn: "1h",
    });

    return { token, user: { id: foundUser.id, name: foundUser.name, email: foundUser.email } };
        

    }

}