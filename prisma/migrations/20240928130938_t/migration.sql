/*
  Warnings:

  - You are about to drop the column `diploma` on the `Education` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Education" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "diplome" TEXT,
    "field" TEXT NOT NULL,
    "school" TEXT NOT NULL,
    "startDate" DATETIME NOT NULL,
    "endDate" DATETIME NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Education_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Education" ("endDate", "field", "id", "school", "startDate", "userId") SELECT "endDate", "field", "id", "school", "startDate", "userId" FROM "Education";
DROP TABLE "Education";
ALTER TABLE "new_Education" RENAME TO "Education";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
