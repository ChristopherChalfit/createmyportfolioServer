-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Language" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "level" TEXT,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Language_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Language" ("id", "level", "name", "userId") SELECT "id", "level", "name", "userId" FROM "Language";
DROP TABLE "Language";
ALTER TABLE "new_Language" RENAME TO "Language";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
