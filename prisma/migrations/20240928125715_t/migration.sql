/*
  Warnings:

  - The primary key for the `DrivingLicense` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Education` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Experience` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Language` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Skill` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `SocialLink` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_DrivingLicense" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "type" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "DrivingLicense_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_DrivingLicense" ("id", "type", "userId") SELECT "id", "type", "userId" FROM "DrivingLicense";
DROP TABLE "DrivingLicense";
ALTER TABLE "new_DrivingLicense" RENAME TO "DrivingLicense";
CREATE TABLE "new_Education" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "diploma" TEXT NOT NULL,
    "field" TEXT NOT NULL,
    "school" TEXT NOT NULL,
    "startDate" DATETIME NOT NULL,
    "endDate" DATETIME NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Education_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Education" ("diploma", "endDate", "field", "id", "school", "startDate", "userId") SELECT "diploma", "endDate", "field", "id", "school", "startDate", "userId" FROM "Education";
DROP TABLE "Education";
ALTER TABLE "new_Education" RENAME TO "Education";
CREATE TABLE "new_Experience" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "company" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "startDate" DATETIME NOT NULL,
    "endDate" DATETIME,
    "description" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Experience_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Experience" ("company", "description", "endDate", "id", "location", "startDate", "title", "userId") SELECT "company", "description", "endDate", "id", "location", "startDate", "title", "userId" FROM "Experience";
DROP TABLE "Experience";
ALTER TABLE "new_Experience" RENAME TO "Experience";
CREATE TABLE "new_Language" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "level" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Language_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Language" ("id", "level", "name", "userId") SELECT "id", "level", "name", "userId" FROM "Language";
DROP TABLE "Language";
ALTER TABLE "new_Language" RENAME TO "Language";
CREATE TABLE "new_Skill" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Skill_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Skill" ("category", "id", "name", "userId") SELECT "category", "id", "name", "userId" FROM "Skill";
DROP TABLE "Skill";
ALTER TABLE "new_Skill" RENAME TO "Skill";
CREATE TABLE "new_SocialLink" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "platform" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "SocialLink_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_SocialLink" ("id", "platform", "url", "userId") SELECT "id", "platform", "url", "userId" FROM "SocialLink";
DROP TABLE "SocialLink";
ALTER TABLE "new_SocialLink" RENAME TO "SocialLink";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
