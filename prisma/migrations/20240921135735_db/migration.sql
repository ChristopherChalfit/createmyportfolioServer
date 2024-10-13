-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "name" TEXT,
    "password" TEXT,
    "role" TEXT NOT NULL DEFAULT 'USER'
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
