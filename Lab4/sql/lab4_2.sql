-- 2. Групування даних (GROUP BY)

-- 1. Групування бібліотекарів за відділами та підрахунок кількості працівників у кожному відділі
SELECT department, COUNT(librarian_id) AS num_librarians 
FROM Librarian 
GROUP BY department;
-- 2. Групування книг за ідентифікатором категорії та підрахунок кількості книг у кожній категорії
SELECT category_id, COUNT(book_id) AS num_books 
FROM BookCategory 
GROUP BY category_id 
ORDER BY num_books DESC;
-- 3. Групування видач за статусом та підрахунок кількості видач для кожного статусу
SELECT status, COUNT(*) AS loan_count 
FROM Loan 
GROUP BY status;