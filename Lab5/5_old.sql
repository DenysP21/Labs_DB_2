CREATE TABLE IF NOT EXISTS Book_Details (
    book_id serial PRIMARY KEY,
    title varchar(64) NOT NULL,
    authors varchar(255), 
    categories varchar(255),
    publisher_name varchar(64) NOT NULL,
    publisher_address text NOT NULL 
);

CREATE TABLE IF NOT EXISTS Loan_Details (
    loan_id serial PRIMARY KEY,
    loan_date date NOT NULL,
    return_date date,
    member_name varchar(32) NOT NULL,
    member_surname varchar(32) NOT NULL,
    member_phone varchar(13) UNIQUE, 
    book_title varchar(64) NOT NULL, 
    librarian_name varchar(32) NOT NULL, 
    librarian_position varchar(32) 
);