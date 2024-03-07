-- CreateEnum
CREATE TYPE "Skills" AS ENUM ('graphicDesigner', 'frontEndDevloper', 'BackEndDevloper', 'LogoExpert');

-- CreateEnum
CREATE TYPE "Industry" AS ENUM ('webDevlopment', 'appDevlopment', 'agriculture', 'design');

-- CreateEnum
CREATE TYPE "ApplicantStatus" AS ENUM ('rejected', 'pending', 'accepted');

-- CreateEnum
CREATE TYPE "EmployeeType" AS ENUM ('remote', 'hybrid', 'physical');

-- CreateTable
CREATE TABLE "Freelancer" (
    "freelancerID" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "userName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phoneNumber" INTEGER NOT NULL,
    "bio" TEXT NOT NULL,
    "basedIn" TEXT NOT NULL,
    "totalEarnings" INTEGER NOT NULL DEFAULT 0,
    "avgRating" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "workPreferences" TEXT NOT NULL,

    CONSTRAINT "Freelancer_pkey" PRIMARY KEY ("freelancerID")
);

-- CreateTable
CREATE TABLE "Client" (
    "clientID" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "userName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phoneNumber" INTEGER NOT NULL,
    "basedIn" TEXT NOT NULL,
    "companyName" TEXT,
    "noOfOrders" INTEGER NOT NULL,

    CONSTRAINT "Client_pkey" PRIMARY KEY ("clientID")
);

-- CreateTable
CREATE TABLE "Portfolio" (
    "portfolioID" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "usefulLinks" "Skills"[],
    "yearsOfExperience" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Portfolio_pkey" PRIMARY KEY ("portfolioID")
);

-- CreateTable
CREATE TABLE "Ratings" (
    "reviewID" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "clientClientID" TEXT NOT NULL,
    "freelancerFreelancerID" TEXT NOT NULL,
    "Rating" INTEGER NOT NULL,
    "feedBack" TEXT NOT NULL,
    "likes" INTEGER NOT NULL DEFAULT 0,
    "clientSatisfactionScore" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Ratings_pkey" PRIMARY KEY ("reviewID")
);

-- CreateTable
CREATE TABLE "Project" (
    "projectID" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "projectName" TEXT NOT NULL,
    "projectDescription" TEXT NOT NULL,
    "clientID" TEXT NOT NULL,
    "isHiring" BOOLEAN NOT NULL DEFAULT true,
    "startDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "endDate" TIMESTAMP(3) NOT NULL,
    "paymentStatus" BOOLEAN NOT NULL DEFAULT false,
    "industry" "Industry" NOT NULL,
    "proposedPrice" INTEGER NOT NULL,

    CONSTRAINT "Project_pkey" PRIMARY KEY ("projectID")
);

-- CreateTable
CREATE TABLE "ProjectApplications" (
    "projectApplicationID" TEXT NOT NULL,
    "submittedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicantID" TEXT NOT NULL,
    "projectProjectID" TEXT NOT NULL,
    "proposedAmount" INTEGER NOT NULL,
    "addtionalNotes" TEXT,
    "Status" "ApplicantStatus" NOT NULL DEFAULT 'pending',

    CONSTRAINT "ProjectApplications_pkey" PRIMARY KEY ("projectApplicationID")
);

-- CreateTable
CREATE TABLE "ProjectSelections" (
    "projectSelectionID" TEXT NOT NULL,
    "selecteAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "selectedFreelancerID" TEXT NOT NULL,
    "wage" INTEGER NOT NULL,
    "projectProjectID" TEXT NOT NULL,
    "OfferingDetails" TEXT,
    "projectRole" "Skills"[],
    "endOfContract" TIMESTAMP(3) NOT NULL,
    "empType" "EmployeeType" NOT NULL DEFAULT 'remote',

    CONSTRAINT "ProjectSelections_pkey" PRIMARY KEY ("projectSelectionID")
);

-- AddForeignKey
ALTER TABLE "Ratings" ADD CONSTRAINT "Ratings_clientClientID_fkey" FOREIGN KEY ("clientClientID") REFERENCES "Client"("clientID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ratings" ADD CONSTRAINT "Ratings_freelancerFreelancerID_fkey" FOREIGN KEY ("freelancerFreelancerID") REFERENCES "Freelancer"("freelancerID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Project" ADD CONSTRAINT "Project_clientID_fkey" FOREIGN KEY ("clientID") REFERENCES "Client"("clientID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectApplications" ADD CONSTRAINT "ProjectApplications_applicantID_fkey" FOREIGN KEY ("applicantID") REFERENCES "Freelancer"("freelancerID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectApplications" ADD CONSTRAINT "ProjectApplications_projectProjectID_fkey" FOREIGN KEY ("projectProjectID") REFERENCES "Project"("projectID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectSelections" ADD CONSTRAINT "ProjectSelections_selectedFreelancerID_fkey" FOREIGN KEY ("selectedFreelancerID") REFERENCES "Freelancer"("freelancerID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectSelections" ADD CONSTRAINT "ProjectSelections_projectProjectID_fkey" FOREIGN KEY ("projectProjectID") REFERENCES "Project"("projectID") ON DELETE CASCADE ON UPDATE CASCADE;
