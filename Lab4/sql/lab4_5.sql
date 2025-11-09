-- 5. Багатотаблична агрегація (JOIN + GROUP BY)

-- 1. Знайти загальну суму нарахованих штрафів для кожного читача
SELECT m.name, m.surname, SUM(f.amount) AS total_fines_due
FROM Member m
JOIN Loan l ON m.member_id = l.member_id
JOIN Fine f ON l.loan_id = f.loan_id
WHERE f.status = 'Нараховано'
GROUP BY m.member_id, m.name, m.surname
ORDER BY total_fines_due DESC;

-- 2. Порахувати, скільки книг з кожної категорії було видано
SELECT c.category_name, COUNT(l.loan_id) AS times_loaned
FROM Category c
JOIN BookCategory bc ON c.category_id = bc.category_id
JOIN Book b ON bc.book_id = b.book_id
JOIN Loan l ON b.book_id = l.book_id
GROUP BY c.category_id, c.category_name
ORDER BY times_loaned DESC;