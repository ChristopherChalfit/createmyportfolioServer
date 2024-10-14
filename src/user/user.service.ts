import { Injectable } from '@nestjs/common';
import { updateUserExperiences, updateUserFormations, updateUserInfoPerso, updateUserLanguages, updateUserSkills } from 'src/auth/auth.types';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class UserService {
  constructor(private readonly prismaService: PrismaService) {}
  async getUsers() {
    const users = await this.prismaService.user.findMany({
        select: {
            id: true,
            firstName: true,
            lastName: true,
            birthDate: true,
            email: true,
            phone: true,
            address: true,
            website: true,
            github: true,
            linkedin: true,
            vehicle: true,
            role: true,
            drivingLicenses: true,
            socialLinks: true,
            languages: true,
            skills: true,
            experiences: true,
            educations: true,
        }
    });
    return users;
}
  async getUser({ userId }: { userId: string }) {
    const user = await this.prismaService.user.findUnique({
      where: {
        id: userId,
      },
      select: {
        id: true,
        firstName: true,
        lastName: true,
        birthDate: true,
        linkId: true,
        email: true,
        photoProfile: true,
        phone: true,
        address: true,
        website: true,
        github: true,
        linkedin: true,
        vehicle: true,
        role: true,
        drivingLicenses: true,
        socialLinks: true,
        languages: true,
        skills: true,
        experiences: true,
        educations: true,
    },
    });
    return user ? user : 'User not find';
  }
  async findByName({ userId }: { userId: string }) {
    const user = await this.prismaService.user.findFirst({
      where: {
        linkId: userId,
      },
      select: {
        id: true,
        firstName: true,
        lastName: true,
        birthDate: true,
        email: true,
        photoProfile: true,
        phone: true,
        address: true,
        website: true,
        github: true,
        linkedin: true,
        vehicle: true,
        role: true,
        drivingLicenses: true,
        socialLinks: true,
        languages: true,
        skills: true,
        experiences: true,
        educations: true,
    },
    });
    return user ? user : 'User not find';
  }

  async updateUserInfoPerso({ userId }: { userId: string }, { updateUser }: { updateUser: updateUserInfoPerso }) {
    const dataToUpdate: any = {
        firstName: updateUser.firstName,
        lastName: updateUser.lastName,
        email: updateUser.email,
        phone: updateUser.phone,
        address: updateUser.address,
        website: updateUser.website,
        github: updateUser.github,
        linkedin: updateUser.linkedin,
    };
    if (updateUser.birthDate) {
        dataToUpdate.birthDate = new Date(updateUser.birthDate);
    }

    if (updateUser.vehicle !== undefined) {
        dataToUpdate.vehicle = this.stringToBoolean(updateUser.vehicle);
    }

    const updatedUser = await this.prismaService.user.update({
        where: {
            id: userId,
        },
        data: dataToUpdate,
    });

    return updatedUser;
}
  async updateUserSkills({ userId }: { userId: string }, { updateUser }: { updateUser: updateUserSkills }) {
    const skillsToUpdate = updateUser.flat().map(skill => ({
      name: skill.name,
      userId: userId,
    }));

    await this.prismaService.skill.deleteMany({
      where: { userId: userId },
    });

    const updatedSkills = await this.prismaService.skill.createMany({
      data: skillsToUpdate,
    });

    return updatedSkills;
  }

  async updateUserLanguages({ userId }: { userId: string }, { updateUser }: { updateUser: updateUserLanguages}) {
    const LanguageToUpdate = updateUser.flat().map(skill => ({
      name: skill.name,
      userId: userId,
    }));
    await this.prismaService.language.deleteMany({
      where: { userId: userId },
    });

    const updatedLanguages = await this.prismaService.language.createMany({
      data: LanguageToUpdate,
    });

    return updatedLanguages;
  }
  async updateUserExperiences({ userId }: { userId: string }, { updateUser }: { updateUser: updateUserExperiences }) {
    
    const experiencesToUpdate = updateUser.flat().map(experience => ({
        title: experience.title,
        company: experience.company,
        location: experience.location,
        startDate: new Date(experience.startDate), 
        endDate: new Date(experience.endDate),     
        description: experience.description,
        userId: userId,
    }));

    await this.prismaService.experience.deleteMany({
        where: { userId: userId },
    });

    const updatedExperiences = await this.prismaService.experience.createMany({
        data: experiencesToUpdate,
    });

    return updatedExperiences;
  }
  async updateUserFormations({ userId }: { userId: string }, { updateUser }: { updateUser: updateUserFormations }) {
    
    const formationsToUpdate = updateUser.flat().map(formation => ({
        diplome: formation.diplome,
        description: formation.description,
        school: formation.school,
        startDate: new Date(formation.startDate), 
        endDate: new Date(formation.endDate),     
        userId: userId,
    }));

    await this.prismaService.education.deleteMany({
        where: { userId: userId },
    });

    const updatedFormation = await this.prismaService.education.createMany({
        data: formationsToUpdate,
    });

    return updatedFormation;
  }
  stringToBoolean(value: any): boolean {
    if (typeof value === 'string') {
        return value.toLowerCase() === 'true';
    }
    return false; 
  }
}
