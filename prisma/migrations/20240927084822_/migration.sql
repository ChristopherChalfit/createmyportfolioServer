/*
  Warnings:

  - You are about to drop the `UserPortfolio` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `name` on the `User` table. All the data in the column will be lost.
  - Made the column `password` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- DropIndex
DROP INDEX "UserPortfolio_email_key";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "UserPortfolio";
PRAGMA foreign_keys=on;

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_DrivingLicense" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "type" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "DrivingLicense_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_DrivingLicense" ("id", "type", "userId") SELECT "id", "type", "userId" FROM "DrivingLicense";
DROP TABLE "DrivingLicense";
ALTER TABLE "new_DrivingLicense" RENAME TO "DrivingLicense";
CREATE TABLE "new_Education" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
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
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
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
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "level" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Language_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Language" ("id", "level", "name", "userId") SELECT "id", "level", "name", "userId" FROM "Language";
DROP TABLE "Language";
ALTER TABLE "new_Language" RENAME TO "Language";
CREATE TABLE "new_Skill" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Skill_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Skill" ("category", "id", "name", "userId") SELECT "category", "id", "name", "userId" FROM "Skill";
DROP TABLE "Skill";
ALTER TABLE "new_Skill" RENAME TO "Skill";
CREATE TABLE "new_SocialLink" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "platform" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "SocialLink_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_SocialLink" ("id", "platform", "url", "userId") SELECT "id", "platform", "url", "userId" FROM "SocialLink";
DROP TABLE "SocialLink";
ALTER TABLE "new_SocialLink" RENAME TO "SocialLink";
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "password" TEXT NOT NULL,
    "firstName" TEXT,
    "lastName" TEXT,
    "birthDate" DATETIME,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "address" TEXT,
    "website" TEXT,
    "github" TEXT,
    "linkedin" TEXT,
    "vehicle" BOOLEAN,
    "role" TEXT NOT NULL DEFAULT 'USER'
);
INSERT INTO "new_User" ("email", "id", "password", "role") SELECT "email", "id", "password", "role" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
