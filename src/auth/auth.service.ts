import {  Injectable, NotFoundException, UnauthorizedException } from '@nestjs/common';
import { AuthBody, createUser, userPayload } from './auth.types';
import { PrismaService } from 'src/prisma.service';
import { compare, hash } from 'bcrypt';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
  ) {}
  async login({ authBody }: { authBody: AuthBody }) {
    try{
    const { email, password } = authBody;
    const existingUser = await this.prisma.user.findUnique({
      where: {
        email: authBody.email,
      },
    });
    if (!existingUser) {
      throw new NotFoundException('User not found');
    }

    const isPasswordValid = await this.isPasswordValid({
      password,
      hashedPassword: existingUser.password,
    });

    if (!isPasswordValid) {
      throw new Error('Le mot de passe est invalide.');
    }

    return this.authenticateUser({
      userId: existingUser.id,
    });
  } catch (error) {
    return { error: true, message: error.message };
  }
  }
  async register({ createUser }: { createUser: createUser }) {
    const { email,firstName, lastName, password } = createUser;
    const existingUser = await this.prisma.user.findUnique({
      where: {
        email: createUser.email,
      },
    });
    if (existingUser) {
      throw new Error('Email already exist');
    }
    const hashPassword = await this.hashPassword({ password });
    const createdUser = await this.prisma.user.create({
      data: {
        email,
        firstName,
        lastName,
        password: hashPassword,
        linkId : this.generateLinkId(firstName,lastName)
      },
    });

    return this.authenticateUser({
      userId: createdUser.id,
    });
  }

  private async hashPassword({ password }: { password: string }) {
    const hashedPassword = await hash(password, 10);
    return hashedPassword;
  }

  private async isPasswordValid({
    password,
    hashedPassword,
  }: {
    password: string;
    hashedPassword: string;
  }) {
    const isPwdValid = await compare(password, hashedPassword);
    console.log({ password, hashedPassword });
    return isPwdValid;
  }
  private authenticateUser({ userId }: userPayload) {
    const payload = { userId };
    return {
      access_token: this.jwtService.sign(payload),
    };
  }
  private generateLinkId(firstName: string, lastName: string): string {
    const randomNum = Math.floor(Math.random() * 5000); // Génère un nombre aléatoire
    return `${firstName}${lastName}-${randomNum}`;
  }
}
