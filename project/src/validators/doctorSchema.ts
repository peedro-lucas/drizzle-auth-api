import {z} from 'zod'

export const doctorSchema = z.object({
    name: z.string().min(3, 'O nome deve ter pelo menos 3 caracteres'),
    email: z.string().email('Email inválido'),
    specialty: z.string(),
})

export type CreateDoctorDTO = z.infer<typeof doctorSchema>