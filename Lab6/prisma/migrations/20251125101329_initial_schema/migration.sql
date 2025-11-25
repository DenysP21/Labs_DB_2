-- CreateEnum
CREATE TYPE "department_name" AS ENUM ('Відділ електронної бібліотеки', 'Відділ читальних залів', 'Відділ рідкісних і цінних книг');

-- CreateEnum
CREATE TYPE "position_name" AS ENUM ('Провідний бібліотекар', 'Бібліотекар І категорії', 'Бібліотекар ІІ категорії', 'Бібліотекар');

-- CreateEnum
CREATE TYPE "status_fine" AS ENUM ('Нараховано', 'Сплачено', 'Списано');

-- CreateEnum
CREATE TYPE "status_name" AS ENUM ('Видано', 'Повернено', 'Прострочено');

-- CreateTable
CREATE TABLE "author" (
    "author_id" SERIAL NOT NULL,
    "name" VARCHAR(32) NOT NULL,
    "surname" VARCHAR(32) NOT NULL,
    "birth_year" SMALLINT,
    "country" VARCHAR(32),

    CONSTRAINT "author_pkey" PRIMARY KEY ("author_id")
);

-- CreateTable
CREATE TABLE "authorbook" (
    "author_id" INTEGER NOT NULL,
    "book_id" INTEGER NOT NULL,

    CONSTRAINT "authorbook_pkey" PRIMARY KEY ("author_id","book_id")
);

-- CreateTable
CREATE TABLE "book" (
    "book_id" SERIAL NOT NULL,
    "title" VARCHAR(64) NOT NULL,
    "publication_year" SMALLINT,
    "pub_id" INTEGER NOT NULL,

    CONSTRAINT "book_pkey" PRIMARY KEY ("book_id")
);

-- CreateTable
CREATE TABLE "bookcategory" (
    "category_id" INTEGER NOT NULL,
    "book_id" INTEGER NOT NULL,

    CONSTRAINT "bookcategory_pkey" PRIMARY KEY ("category_id","book_id")
);

-- CreateTable
CREATE TABLE "category" (
    "category_id" SERIAL NOT NULL,
    "category_name" VARCHAR(32) NOT NULL,

    CONSTRAINT "category_pkey" PRIMARY KEY ("category_id")
);

-- CreateTable
CREATE TABLE "fine" (
    "fine_id" SERIAL NOT NULL,
    "loan_id" INTEGER,
    "amount" DECIMAL(6,2),
    "status" "status_fine",

    CONSTRAINT "fine_pkey" PRIMARY KEY ("fine_id")
);

-- CreateTable
CREATE TABLE "librarian" (
    "librarian_id" SERIAL NOT NULL,
    "name" VARCHAR(32) NOT NULL,
    "surname" VARCHAR(32) NOT NULL,
    "position" "position_name",
    "department" "department_name",
    "email" VARCHAR(32) NOT NULL,

    CONSTRAINT "librarian_pkey" PRIMARY KEY ("librarian_id")
);

-- CreateTable
CREATE TABLE "loan" (
    "loan_id" SERIAL NOT NULL,
    "member_id" INTEGER NOT NULL,
    "book_id" INTEGER NOT NULL,
    "librarian_id" INTEGER NOT NULL,
    "loan_date" DATE NOT NULL,
    "return_date" DATE,
    "status" "status_name",

    CONSTRAINT "loan_pkey" PRIMARY KEY ("loan_id")
);

-- CreateTable
CREATE TABLE "member" (
    "member_id" SERIAL NOT NULL,
    "name" VARCHAR(32) NOT NULL,
    "surname" VARCHAR(32) NOT NULL,
    "address" TEXT NOT NULL,
    "phone_number" VARCHAR(13),
    "registration_date" DATE NOT NULL,

    CONSTRAINT "member_pkey" PRIMARY KEY ("member_id")
);

-- CreateTable
CREATE TABLE "publisher" (
    "pub_id" SERIAL NOT NULL,
    "name" VARCHAR(32) NOT NULL,
    "address" TEXT NOT NULL,

    CONSTRAINT "publisher_pkey" PRIMARY KEY ("pub_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "fine_loan_id_key" ON "fine"("loan_id");

-- CreateIndex
CREATE UNIQUE INDEX "librarian_email_key" ON "librarian"("email");

-- CreateIndex
CREATE UNIQUE INDEX "member_phone_number_key" ON "member"("phone_number");

-- AddForeignKey
ALTER TABLE "authorbook" ADD CONSTRAINT "authorbook_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "author"("author_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "authorbook" ADD CONSTRAINT "authorbook_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "book"("book_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "book" ADD CONSTRAINT "book_pub_id_fkey" FOREIGN KEY ("pub_id") REFERENCES "publisher"("pub_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "bookcategory" ADD CONSTRAINT "bookcategory_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "book"("book_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "bookcategory" ADD CONSTRAINT "bookcategory_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "category"("category_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "fine" ADD CONSTRAINT "fine_loan_id_fkey" FOREIGN KEY ("loan_id") REFERENCES "loan"("loan_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "loan" ADD CONSTRAINT "loan_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "book"("book_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "loan" ADD CONSTRAINT "loan_librarian_id_fkey" FOREIGN KEY ("librarian_id") REFERENCES "librarian"("librarian_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "loan" ADD CONSTRAINT "loan_member_id_fkey" FOREIGN KEY ("member_id") REFERENCES "member"("member_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
