-- 4. Запити JOIN (INNER, LEFT, RIGHT, FULL, CROSS)

-- 1. Показати імена читачів та назви книг, які вони позичали
SELECT m.name AS member_name, m.surname AS member_surname, b.title AS book_title
FROM Member m
INNER JOIN Loan l ON m.member_id = l.member_id
INNER JOIN Book b ON l.book_id = b.book_id;
-- 2. Показати всіх авторів та назви їхніх книг
SELECT a.name, a.surname, b.title
FROM Author a
LEFT JOIN AuthorBook ab ON a.author_id = ab.author_id
LEFT JOIN Book b ON ab.book_id = b.book_id;
-- 3. Показати всі книги та імена авторів
SELECT b.title, a.name, a.surname
FROM AuthorBook ab
JOIN Author a ON ab.author_id = a.author_id
RIGHT JOIN Book b ON ab.book_id = b.book_id;
-- 4. Створити список "Кожен читач - кожна категорія"
SELECT m.name AS member_name, c.category_name
FROM Member m
CROSS JOIN Category c;