-- 3. Фільтрування груп (HAVING)

-- 1. Знайти читачів, які взяли більше ніж 1 книгу.
SELECT member_id, COUNT(*) AS books_taken_count
FROM Loan
GROUP BY member_id
HAVING COUNT(*) > 1;
-- 2. Знайти книги (book_id), які наразі прострочені у 2-х або більше читачів.
SELECT book_id, COUNT(*) AS overdue_count
FROM Loan
WHERE status = 'Прострочено'
GROUP BY book_id
HAVING COUNT(*) >= 2;