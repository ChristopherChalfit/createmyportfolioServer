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
    "phone" TEXT,
    "address" TEXT,
    "website" TEXT,
    "github" TEXT,
    "linkedin" TEXT,
    "vehicle" BOOLEAN,
    "role" TEXT NOT NULL DEFAULT 'USER'
);
INSERT INTO "new_User" ("address", "birthDate", "email", "firstName", "github", "id", "lastName", "linkId", "linkedin", "password", "phone", "photoProfile", "role", "vehicle", "website") SELECT "address", "birthDate", "email", "firstName", "github", "id", "lastName", "linkId", "linkedin", "password", "phone", "photoProfile", "role", "vehicle", "website" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_linkId_key" ON "User"("linkId");
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
