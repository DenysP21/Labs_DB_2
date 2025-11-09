-- Базова агрегація (COUNT, SUM, AVG, MIN, MAX)

-- 1. Кількість унікальних читачів у Member
SELECT COUNT(DISTINCT member_id) AS total_members 
FROM Member;
-- 2. Кількість всіх видач книг, зафіксованих у Loan
SELECT COUNT(*) AS total_loans 
FROM Loan;
-- 3. Загальна сума нарахованих, але не сплачених штрафів
SELECT SUM(amount) AS total_fines_charged 
FROM Fine 
WHERE status = 'Нараховано';
-- 4. Обчислити середню суму сплаченого штрафу
SELECT ROUND(AVG(amount), 2) AS average_paid_fine
FROM Fine
WHERE status = 'Сплачено';
-- 5. Знаходженння найпершої реєстрації читача
SELECT 
MIN(registration_date) AS earliest_registration 
FROM Member;
-- 6. Знаходження найбльшої суми одного штрафу
SELECT 
MAX(amount) AS highest_fine 
FROM Fine;