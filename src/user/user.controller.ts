import {
  Body,
  Controller,
  Get,
  Param,
  Post,
  UploadedFile,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { UserService } from './user.service';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { FileInterceptor } from '@nestjs/platform-express';
import {
  ApiBearerAuth,
  ApiTags,
  ApiOperation,
  ApiResponse,
} from '@nestjs/swagger';

@ApiTags('users') 
@Controller('user')
export class UserController {
  constructor(private readonly appService: UserService) {}

  @Get()
  @ApiOperation({ summary: 'Get all users' }) 
  @ApiResponse({ status: 200, description: 'List of all users.' })
  getUsers() {
    return this.appService.getUsers();
  }

  @Get('/:userId')
  @ApiOperation({ summary: 'Get user by ID' })
  @ApiResponse({ status: 200, description: 'The user with the given ID.' })
  getUser(@Param('userId') userId: string) {
    return this.appService.getUser({ userId });
  }

  @Get('/name/:userId')
  @ApiOperation({ summary: 'Get user by name' })
  @ApiResponse({ status: 200, description: 'The user with the given name.' })
  getUserByName(@Param('userId') userId: string) {
    return this.appService.findByName({ userId });
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @Post('/:userId/photo')
  @ApiOperation({ summary: 'Upload user photo' })
  @ApiResponse({ status: 201, description: 'User photo updated.' })
  @UseInterceptors(FileInterceptor('photo'))
  postUploadPhoto(
    @Param('userId') userId: string,
    @UploadedFile() image: Express.Multer.File,
  ) {
    if (!image) {
      console.error('Aucune image reçue');
      throw new Error('Aucune image reçue');
    }

    return this.appService.updateUserPhoto({ userId }, { image });
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @Post('/:userId/info')
  @ApiOperation({ summary: 'Update user info' })
  @ApiResponse({ status: 201, description: 'User information updated.' })
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
  @ApiBearerAuth()
  @Post('/:userId/skills')
  @ApiOperation({ summary: 'Update user skills' })
  @ApiResponse({ status: 201, description: 'User skills updated.' })
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
  @ApiBearerAuth()
  @Post('/:userId/languages')
  @ApiOperation({ summary: 'Update user languages' })
  @ApiResponse({ status: 201, description: 'User languages updated.' })
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
  @ApiBearerAuth()
  @Post('/:userId/experiences')
  @ApiOperation({ summary: 'Update user experiences' })
  @ApiResponse({ status: 201, description: 'User experiences updated.' })
  postExperiences(
    @Param('userId') userId: string,
    @Body()
    updateUser: {
      title: string;
      company: string;
      location: string;
      startDate: string;
      endDate: string;
      description: string;
    },
  ) {
    return this.appService.updateUserExperiences(
      { userId },
      { updateUser: [updateUser] },
    );
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @Post('/:userId/formations')
  @ApiOperation({ summary: 'Update user formations' })
  @ApiResponse({ status: 201, description: 'User formations updated.' })
  postFormations(
    @Param('userId') userId: string,
    @Body()
    updateUser: {
      diplome: string;
      description: string;
      school: string;
      startDate: string;
      endDate: string;
    },
  ) {
    return this.appService.updateUserFormations(
      { userId },
      { updateUser: [updateUser] },
    );
  }
}
