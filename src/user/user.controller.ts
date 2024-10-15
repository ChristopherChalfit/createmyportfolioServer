import { Body, Controller, Get, Param, Post, UseGuards } from '@nestjs/common';
import { UserService } from './user.service';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { updateUserInfoPerso } from 'src/auth/auth.types';

@Controller('user')
export class UserController {
  constructor(private readonly appService: UserService) {}

  @Get()
  getUsers() {
    return this.appService.getUsers();
  }
  @Get('/:userId')
  getUser(@Param('userId') userId: string) {
    return this.appService.getUser({ userId });
  }
  @Get('/name/:userId')
  getUserByName(@Param('userId') userId: string) {
    return this.appService.findByName({ userId });
  }
  @UseGuards(JwtAuthGuard)
  @Post('/:userId/info')
  postUser(
    @Param('userId') userId: string,
    @Body()
    updateUser: {
      firstName: string;
      lastName: string;
      email: string;
      phone: string;
      birthDate: string;
      address: string;
      website: string;
      github: string;
      linkedin: string;
      vehicle: string;
      description: string;
    },
  ) {
    return this.appService.updateUserInfoPerso({ userId }, { updateUser });
  }
  @UseGuards(JwtAuthGuard)
  @Post('/:userId/skills')
  postSkills(
    @Param('userId') userId: string,
    @Body() updateUser: { name: string },
  ) {
    return this.appService.updateUserSkills(
      { userId },
      { updateUser: [updateUser] },
    );
  }
  @UseGuards(JwtAuthGuard)
  @Post('/:userId/languages')
  postLanguages(
    @Param('userId') userId: string,
    @Body() updateUser: { name: string },
  ) {
    return this.appService.updateUserLanguages(
      { userId },
      { updateUser: [updateUser] },
    );
  }

  @UseGuards(JwtAuthGuard)
  @Post('/:userId/experiences')
  postExperiences(
    @Param('userId') userId: string,
    @Body() updateUser: { title: string; company: string; location: string; startDate: string; endDate: string; description: string },
  ) {
     return this.appService.updateUserExperiences(
      { userId },
      { updateUser: [updateUser] },
    );
  }
  @UseGuards(JwtAuthGuard)
  @Post('/:userId/formations')
  postFormations(
    @Param('userId') userId: string,
    @Body() updateUser: { diplome: string; description: string; school: string; startDate: string; endDate: string; },
  ) {
     return this.appService.updateUserFormations(
      { userId },
      { updateUser: [updateUser] },
    );
  }
}
