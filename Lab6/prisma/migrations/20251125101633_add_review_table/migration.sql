-- CreateTable
CREATE TABLE "Review" (
    "review_id" SERIAL NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" VARCHAR(512),
    "book_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Review_pkey" PRIMARY KEY ("review_id")
);

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "book"("book_id") ON DELETE RESTRICT ON UPDATE CASCADE;
