export type AuthBody = { email: string; password: string };
export type userPayload = { userId: string };
export type requestWithUser = { user: userPayload };
export type createUser = {
  email: string;
  firstName: string;
  lastName: string;
  password: string;
};
export type updateUserInfoPerso = {
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
};
export type updateUserSkills = {
  name: string;
}[];
export type updateUserLanguages = {
  name: string;
}[];

export type updateUserExperiences = {
  title: string;
  company: string;
  location: string;
  startDate: string;
  endDate: string;
  description: string;
}[];
export type updateUserFormations = {
  diplome: string;
  description: string;
  school: string;
  startDate: string;
  endDate: string;
}[];
