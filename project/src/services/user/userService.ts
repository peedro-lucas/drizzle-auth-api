/* eslint-disable @typescript-eslint/no-explicit-any */

import { database } from "../../config/database";
import {usersTable} from '../../database/schemas/user'
import {eq} from 'drizzle-orm'

interface CreateUserDTO{
    name:string;
    email:string;
    password:string;
}

export class UserService{
    async createUser(data:CreateUserDTO){
        const existingUser = await database.select().from(usersTable).where(eq(usersTable.email,data.email))

        if(existingUser.length > 0 ){
            throw new Error('Usuario ja existe')
        }

        const [newUser] = await database.insert(usersTable).values(data).returning()

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
}