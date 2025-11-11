# Лабораторна робота №5

# Нормалізація бази даних

Усі таблиці, які створені в лабораторній роботі №2, вже перебувають у 3NF. Тому для демонстрації процесу нормалізації я покажу як я прийшов до 3NF-схеми з гіпотетичної денормалізованої версії.

## Початковий денормалізований варіант

### 1. Денормалізована таблиця Book_Details

```sql
CREATE TABLE IF NOT EXISTS Book_Details (
    book_id serial PRIMARY KEY,
    title varchar(64) NOT NULL,
    authors varchar(255),
    categories varchar(255),
    publisher_name varchar(64) NOT NULL,
    publisher_address text NOT NULL
);
```

- Порушення 1NF: Стовпці authors та categories не є атомарними. Вони містять списки значень (повторювані групи). Це ускладнює пошук і порушує цілісність.
- Аномалія оновлення: Якщо видавництво "Старий Лев" змінить адресу, доведеться оновлювати всі рядки, де згадується "Старий Лев".
- Аномалія вставки: Неможливість додати нового видавця, якщо у нього ще немає жодної книги в базі.
- Аномалія видалення: Якщо видалити останню книгу видавництва "Старий Лев", втратиться вся інформація про це видавництво (його адресу).

### Функціональні залежності (ФЗ):

- {book_id} → {title, authors, categories, publisher_name, publisher_address} (Основна ФЗ)

- {publisher_name} → {publisher_address} (Транзитивна залежність book_id → publisher_name → publisher_address)

### 2. Денормалізована таблиця Loan_Details

```sql
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
```

- Аномалія оновлення: Якщо бібліотекар отримає підвищення, доведеться оновити його посаду в кожному записі про видачу, яку він здійснив.
- Аномалія вставки: Неможливість додати нового читача, доки він не візьме книгу.
- Надлишковість: Ім'я, прізвище та телефон читача будуть дублюватися кожного разу, коли він бере книгу.

### Функціональні залежності (ФЗ):

- {loan_id} → {loan_date, return_date, member_name, member_surname, member_phone, book_title, librarian_name, librarian_position}
- {member_phone} → {member_name, member_surname} (Транзитивна залежність)
- {librarian_name} → {librarian_position} (Транзитивна залежність)

## Покрокова нормалізація

### 1. Усунеення повторюваних груп

Розбиваємо Book_Details на кілька таблиць, створюючи окремі таблиці для сутностей, що повторюються (Author, Category).

- Book_1NF

  - book_id (PK)
  - title
  - publisher_name
  - publisher_address

- Author

  - author_id (PK)
  - author_name

- Category

  - category_id (PK)
  - category_name

- AuthorBook (many to many)

  - author_id (PK, FK)
  - book_id (PK, FK)

- BookCategory (many to many)

  - category_id (PK, FK)
  - book_id (PK, FK)

### 2. Усунення часткових залежностей

У наших поточних таблицях (після кроку 1) немає явних порушень 2NF. Таблиці AuthorBook та BookCategory мають складені ключі, але не мають неключових атрибутів, тому вони автоматично в 2NF.

### 3. Усунення транзитивних залежностей

### Проблема 1: Таблиця Book_1NF

Book_1NF: (book_id (PK), title, publisher_name, publisher_address)
ФЗ: book_id → publisher_name → publisher_address

Виправлення: винести видавця в окрему таблицю.

- Publisher

  - pub_id (PK)
  - name
  - address

- Book (Оновлена таблиця)
  - book_id (PK)
  - title
  - pub_id (FK до Publisher.pub_id)

### Проблема 2: Таблиця Loan_Details

Loan_Details: (loan_id (PK), loan_date, ..., member_name, member_surname, ..., book_title, ..., librarian_name, ...)

Транзитивні залежності: loan_id → member_phone → member_name. loan_id → (прихований book_id) → book_title. loan_id → (прихований librarian_id) → librarian_name.

Виправлення: Винести Member, Book та Librarian в окремі сутності.

- Member

  - member_id (PK)
  - name
  - surname
  - address
  - phone_number

- Librarian

  - librarian_id (PK)
  - name
  - surname
  - position
  - department
  - email

- Loan
  - loan_id (PK)
  - loan_date
  - return_date
  - status
  - member_id (FK до Member.member_id)
  - book_id (FK до Book.book_id)
  - librarian_id (FK до Librarian.librarian_id)
