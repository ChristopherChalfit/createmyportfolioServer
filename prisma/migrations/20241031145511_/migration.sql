/*
  Warnings:

  - You are about to drop the column `scriptPortfolio` on the `User` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "Portfolio" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "script" TEXT,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Portfolio_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "linkId" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "firstName" TEXT,
    "lastName" TEXT,
    "birthDate" DATETIME,
    "email" TEXT NOT NULL,
    "photoProfile" TEXT,
    "description" TEXT,
    "phone" TEXT,
    "address" TEXT,
    "website" TEXT,
    "github" TEXT,
    "linkedin" TEXT,
    "vehicle" BOOLEAN,
    "role" TEXT NOT NULL DEFAULT 'user'
);
INSERT INTO "new_User" ("address", "birthDate", "description", "email", "firstName", "github", "id", "lastName", "linkId", "linkedin", "password", "phone", "photoProfile", "role", "vehicle", "website") SELECT "address", "birthDate", "description", "email", "firstName", "github", "id", "lastName", "linkId", "linkedin", "password", "phone", "photoProfile", "role", "vehicle", "website" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_linkId_key" ON "User"("linkId");
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

-- CreateIndex
CREATE UNIQUE INDEX "Portfolio_userId_key" ON "Portfolio"("userId");
