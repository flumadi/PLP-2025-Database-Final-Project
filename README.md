# PLP-2025-Database-Final-Project
## Library Management System
## MySQL Database Implementation
📌 Project Description
This project is a Library Management System built entirely with MySQL. It includes:
✅ Database schema with tables for books, patrons, and borrowing_records
✅ Proper constraints (PK, FK, NOT NULL, UNIQUE)
✅ Sample data for testing
✅ Well-commented SQL for easy understanding

📂 Repository Structure
library-management-db/
├── library_schema.sql   # Complete SQL script (tables + sample data)
└── README.md            # This guide

## 🔧 How to Set Up the Database
1. Create the Database
Run this in MySQL:

sql
CREATE DATABASE library_management;
USE library_management;

2. Execute the SQL Script
Copy and run the entire library_schema.sql file in your MySQL client (e.g., MySQL Workbench, command line).

📊 ERD (Entity-Relationship Diagram)
[Library Management ERD]

Relationships:

Books → Borrowing Records (1-to-Many)

Patrons → Borrowing Records (1-to-Many)

📜 library_schema.sql
sql

-- 1. BOOKS TABLE (Stores all book information)
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,  -- ISBN must be unique
    publication_year INT,
    genre VARCHAR(100),
    available_copies INT DEFAULT 1,
    total_copies INT DEFAULT 1,
    CONSTRAINT chk_copies CHECK (available_copies <= total_copies)  -- Prevent negative availability
);

-- 2. PATRONS TABLE (Library members)
CREATE TABLE patrons (
    patron_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,  -- No duplicate emails
    phone VARCHAR(20),
    membership_date DATE DEFAULT (CURRENT_DATE),  -- Auto-set joining date
    active_status BOOLEAN DEFAULT TRUE  -- Active by default
);

-- 3. BORROWING RECORDS (Tracks book loans)
CREATE TABLE borrowing_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    patron_id INT NOT NULL,
    borrow_date DATE DEFAULT (CURRENT_DATE),  -- Auto-set borrow date
    due_date DATE NOT NULL,
    return_date DATE,
    status ENUM('borrowed', 'returned', 'overdue') DEFAULT 'borrowed',
    -- Foreign keys with proper constraints
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (patron_id) REFERENCES patrons(patron_id) ON DELETE CASCADE,
    -- Data validation rules
    CONSTRAINT chk_dates CHECK (due_date > borrow_date),
    CONSTRAINT chk_return_date CHECK (return_date IS NULL OR return_date >= borrow_date)
);

-- 📂 SAMPLE DATA INSERTION
-- Add sample books
INSERT INTO books (title, author, isbn, publication_year, genre, total_copies, available_copies)
VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 1925, 'Classic', 5, 3),
('To Kill a Mockingbird', 'Harper Lee', '9780061120084', 1960, 'Fiction', 3, 2),
('1984', 'George Orwell', '9780451524935', 1949, 'Dystopian', 4, 4);

-- Add sample patrons
INSERT INTO patrons (first_name, last_name, email, phone)
VALUES 
('John', 'Smith', 'john.smith@email.com', '555-0101'),
('Emily', 'Johnson', 'emily.j@email.com', '555-0102'),
('Michael', 'Williams', 'michael.w@email.com', NULL);

-- Add sample borrowing records
INSERT INTO borrowing_records (book_id, patron_id, borrow_date, due_date, return_date, status)
VALUES 
(1, 1, '2023-01-15', '2023-02-15', NULL, 'borrowed'),  -- Currently borrowed
(2, 2, '2023-02-01', '2023-03-01', '2023-02-28', 'returned'),  -- Returned early
(3, 3, '2023-03-10', '2023-04-10', NULL, 'borrowed');  -- Currently borrowed

🔍 Key Features
✔ Data Integrity – Constraints prevent invalid data (e.g., available_copies ≤ total_copies)
✔ Auto-increment IDs – No manual ID management
✔ Default Values – membership_date, borrow_date, and status set automatically
✔ Sample Data – Ready for immediate testing

🚀 How to Use
Clone the repo:

git clone https://github.com/root/library-management-db.git
Import into MySQL:

bash
mysql -u root -p library_management < library_schema.sql
Query the database:

sql
-- Example: Check available books
SELECT * FROM books WHERE available_copies > 0;

##For any or further inquiries about the same feel free to contact for assistance on [mathiasfridah2@gmail.com]
🧑‍💻Happy coding!!
