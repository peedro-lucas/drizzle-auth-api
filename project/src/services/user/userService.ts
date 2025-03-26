/* eslint-disable @typescript-eslint/no-explicit-any */

import { database } from "../../config/database";
import {usersTable} from '../../database/schemas/user'
import {eq} from 'drizzle-orm'
import bcrypt from "bcrypt";

interface CreateUserDTO{
    name:string;
    email:string;
    password:string;
}

interface UpdateUserDTO{
    name?:string;
    email?:string;
    password?:string;
}

export class UserService{
    async createUser(data:CreateUserDTO){
        const existingUser = await database.select().from(usersTable).where(eq(usersTable.email,data.email))

        if(existingUser.length > 0 ){
            throw new Error('Usuario ja existe')
        }

        const hashedPassword = await bcrypt.hash(data.password,10)

        const [newUser] = await database.insert(usersTable)
        .values({name:data.name, 
                email:data.email, 
                password:hashedPassword})
        .returning()

        return newUser
    }
    async getAllUsers(){
        const users = await database.select().from(usersTable)
        return users
    }

    async getUserById(id: string){
        const user = await database
            .select()
            .from(usersTable)
            .where(eq(usersTable.id,id))

        if(user.length < 1 ){
            throw new Error('Usuario não encontrado ou inexistente')
        }

        return user
    }

    async updatedUser(id:string, data:UpdateUserDTO){
        const existingUser = await database.select().from(usersTable).where(eq(usersTable.id, id))

        if(existingUser.length === 0){
            throw new Error("Usuário não encontrado")
        }
        
        const payload = {
            name:data.name,
            email: data.email,
            password:data.password,
            updatedAt: new Date()
        }

        const updatedUser = await database.update(usersTable)
        .set(payload)
        .where(eq(usersTable.id,id))
        .returning({ id: usersTable.id, 
            name: usersTable.name, 
            email:usersTable.email,
            updatedAt: usersTable.updatedAt })

        return updatedUser[0]
    }
}