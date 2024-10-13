-- CreateTable
CREATE TABLE "UserPortfolio" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "birthDate" DATETIME NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "website" TEXT,
    "github" TEXT,
    "linkedin" TEXT,
    "vehicle" BOOLEAN NOT NULL
);

-- CreateTable
CREATE TABLE "DrivingLicense" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "type" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "DrivingLicense_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserPortfolio" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "SocialLink" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "platform" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "SocialLink_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserPortfolio" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Language" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "level" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Language_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserPortfolio" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Skill" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Skill_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserPortfolio" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Experience" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "company" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "startDate" DATETIME NOT NULL,
    "endDate" DATETIME,
    "description" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Experience_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserPortfolio" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Education" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "diploma" TEXT NOT NULL,
    "field" TEXT NOT NULL,
    "school" TEXT NOT NULL,
    "startDate" DATETIME NOT NULL,
    "endDate" DATETIME NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Education_userId_fkey" FOREIGN KEY ("userId") REFERENCES "UserPortfolio" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "UserPortfolio_email_key" ON "UserPortfolio"("email");
