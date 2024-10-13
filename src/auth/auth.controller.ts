import { Body, Controller, Get, Post, Req, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { JwtAuthGuard } from './jwt-auth.guard';
import { requestWithUser } from './auth.types';
import { UserService } from 'src/user/user.service';
@Controller('auth')
export class AuthController {
  constructor(
    private readonly authService: AuthService,
    private readonly userService: UserService,
  ) {}
  @Post('login')
  async login(@Body() authBody: { email: string; password: string }) {
    return await this.authService.login({ authBody });
  }
  @Post('register')
  async register(@Body() createUser: { email: string; firstName: string,lastName: string, password: string }) {
    return await this.authService.register({ createUser });
  }
  @UseGuards(JwtAuthGuard)
  @Get()
  async authenticateUser(@Req() request: requestWithUser) {
    return await this.userService.getUser({
      userId: request.user.userId,
    });
  }
}
