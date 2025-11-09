-- 6. Підзапити (SELECT, WHERE, FROM, HAVING)

-- 1. Знайти читачів, які взяли книгу "Лісова пісня"
SELECT name, surname
FROM Member
WHERE member_id IN (
    SELECT member_id
    FROM Loan
    WHERE book_id = (
        SELECT book_id
        FROM Book
        WHERE title = 'Лісова пісня'
    )
);
-- 2. Показати кожного читача та загальну кількість його видач
SELECT
    m.name,
    m.surname,
    (SELECT COUNT(*) FROM Loan l WHERE l.member_id = m.member_id) AS total_loans
FROM
Member m;
-- 3. Знайти середню кількість видач на одного бібліотекаря
SELECT AVG(books_issued) AS avg_loans_per_librarian
FROM (
    SELECT librarian_id, COUNT(*) AS books_issued
    FROM Loan
    GROUP BY librarian_id
) AS librarian_stats;