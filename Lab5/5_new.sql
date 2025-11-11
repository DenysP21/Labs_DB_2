CREATE TYPE position_name AS ENUM ('Провідний бібліотекар', 'Бібліотекар І категорії', 'Бібліотекар ІІ категорії', 'Бібліотекар');
CREATE TYPE department_name AS ENUM ('Відділ електронної бібліотеки', 'Відділ читальних залів', 'Відділ рідкісних і цінних книг');
CREATE TYPE status_name AS ENUM ('Видано', 'Повернено', 'Прострочено');
 
-- 1. Таблиця категорій (Category)
CREATE TABLE IF NOT EXISTS Category (
    category_id serial PRIMARY KEY,
    category_name varchar(32) NOT NULL
);
 
-- 2. Таблиця видавців (Publisher)
CREATE TABLE IF NOT EXISTS Publisher (
    pub_id serial PRIMARY KEY,
    name varchar(32) NOT NULL,
    address text NOT NULL
); 
 
-- 3. Таблиця авторів (Author)
CREATE TABLE IF NOT EXISTS Author (
    author_id serial PRIMARY KEY,
    name varchar(32) NOT NULL,
    surname varchar(32) NOT NULL,
    birth_year smallint,
    country varchar(32)
);
 
-- 4. Таблиця книг (Book)
CREATE TABLE IF NOT EXISTS Book (
    book_id serial PRIMARY KEY,
    title varchar(64) NOT NULL,
    publication_year smallint,
    pub_id integer NOT NULL REFERENCES Publisher(pub_id)
);
 
-- 5. Зв’язкова таблиця Автор–Книга (many-to-many)
CREATE TABLE IF NOT EXISTS AuthorBook (
    author_id integer NOT NULL REFERENCES Author(author_id),
    book_id integer NOT NULL REFERENCES Book(book_id),
    PRIMARY KEY (author_id, book_id)
);
 
-- 6. Зв’язкова таблиця Категорія–Книга (many-to-many)
CREATE TABLE IF NOT EXISTS BookCategory (
    category_id integer NOT NULL REFERENCES Category(category_id),
    book_id integer NOT NULL REFERENCES Book(book_id),
    PRIMARY KEY (category_id, book_id)
);
 
-- 7. Таблиця бібліотекарів (Librarian)
CREATE TABLE IF NOT EXISTS Librarian (
    librarian_id serial PRIMARY KEY,
    name varchar(32) NOT NULL,
    surname varchar(32) NOT NULL,
    position position_name,
    department department_name,
    email varchar(32) NOT NULL UNIQUE
);
 
-- 8. Таблиця читачів (Member)
CREATE TABLE IF NOT EXISTS Member (
    member_id serial PRIMARY KEY,
    name varchar(32) NOT NULL,
    surname varchar(32) NOT NULL,
    address text NOT NULL,
    phone_number varchar(13) CHECK (phone_number ~ '^\+?\d{10,12}$') UNIQUE,
    registration_date date NOT NULL CHECK (registration_date <= CURRENT_DATE)
);
 
-- 9. Таблиця видач книг (Loan)
CREATE TABLE IF NOT EXISTS Loan (
    loan_id serial PRIMARY KEY,
    member_id integer NOT NULL REFERENCES Member(member_id),
    book_id integer NOT NULL REFERENCES Book(book_id),
    librarian_id integer NOT NULL REFERENCES Librarian(librarian_id),
    loan_date date NOT NULL,
    return_date date,
    status status_name
);
 
