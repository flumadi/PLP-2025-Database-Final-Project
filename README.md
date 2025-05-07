# PLP-2025-Database-Final-Project
## Library Management System
## MySQL Database Implementation
📌 Project Description
This project is a Library Management System built entirely with MySQL.  
It includes:<br>
✅ Database schema with tables for books, patrons, and borrowing_records<br>
✅ Proper constraints (PK, FK, NOT NULL, UNIQUE)<br>
✅ Sample data for testing<br>
✅ Well-commented SQL for easy understanding<br>

📂 Repository Structure<br>
library-management-db/<br>
├── library_schema.sql   # Complete SQL script (tables + sample data)<br>
└── README.md            # This guide

## 🔧 How to Set Up the Database  
1. Create the Database<br>
Run this in MySQL:<br>

CREATE DATABASE library_management;<br>
USE library_management;<br>

3. Execute the SQL Script<br>
Copy and run the entire library_schema.sql file in your MySQL client (e.g., MySQL Workbench, command line).<br>

📊 ERD (Entity-Relationship Diagram)<br>
[Library Management ERD]<br>

Relationships:<br>
Books → Borrowing Records (1-to-Many)<br>
Patrons → Borrowing Records (1-to-Many)<br>

📜 library_schema.sql  
-- 1. BOOKS TABLE (Stores all book information)  
CREATE TABLE books (  
    book_id INT AUTO_INCREMENT PRIMARY KEY,  
    title VARCHAR(255) NOT NULL,  
    author VARCHAR(255) NOT NULL,<br>
    isbn VARCHAR(20) UNIQUE NOT NULL,  -- ISBN must be unique<br>
    publication_year INT,<br>
    genre VARCHAR(100),<br>
    available_copies INT DEFAULT 1,<br>
    total_copies INT DEFAULT 1,<br>
    CONSTRAINT chk_copies CHECK (available_copies <= total_copies)  -- Prevent negative availability<br>
);<br>

-- 2. PATRONS TABLE (Library members)  
CREATE TABLE patrons (  
    patron_id INT AUTO_INCREMENT PRIMARY KEY,<br>
    first_name VARCHAR(100) NOT NULL,<br>
    last_name VARCHAR(100) NOT NULL,<br>
    email VARCHAR(255) UNIQUE NOT NULL,  -- No duplicate emails<br>
    phone VARCHAR(20),<br>
    membership_date DATE DEFAULT (CURRENT_DATE),  -- Auto-set joining date<br>
    active_status BOOLEAN DEFAULT TRUE  -- Active by default<br>
);<br>

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

## 📂 SAMPLE DATA INSERTION  
Below is a provided sample of data you could use to get to be familiar with and interact with the database codes and queries  

-- Add sample books  
INSERT INTO books (title, author, isbn, publication_year, genre, total_copies, available_copies)  
VALUES   
('The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 1925, 'Classic', 5, 3),  
('To Kill a Mockingbird', 'Harper Lee', '9780061120084', 1960, 'Fiction', 3, 2),  
('1984', 'George Orwell', '9780451524935', 1949, 'Dystopian', 4, 4);  

-- Add sample patrons  
INSERT INTO patrons (first_name, last_name, email, phone)  
VALUES   
('John', 'Supet', 'john.supet@email.com', '254 765 293876'),  
('Emily', 'Joy', 'emily.j@email.com', '254 734 615243'),  
('Michael', 'Wasilwa', 'michael.w@email.com', '254 765 423156'NULL);  

-- Add sample borrowing records  
INSERT INTO borrowing_records (book_id, patron_id, borrow_date, due_date, return_date, status)  
VALUES   
(1, 1, '2025-01-15', '2025-02-15', NULL, 'borrowed'),  -- Currently borrowed  
(2, 2, '2025-02-01', '2025-03-01', '2023-02-28', 'returned'),  -- Returned early  
(3, 3, '2025-03-10', '2025-04-10', NULL, 'borrowed');  -- Currently borrowed  

🔍 Key Features  
✔ Data Integrity – Constraints prevent invalid data (e.g., available_copies ≤ total_copies)  
✔ Auto-increment IDs – No manual ID management  
✔ Default Values – membership_date, borrow_date, and status set automatically  
✔ Sample Data – Ready for immediate testing  

🚀 How to Use  
Clone the repo:  
  
git clone ----------------------------------------------
Import into MySQL:  

mysql -u root -p library_management < library_schema.sql  
Query the database:  

sql  
-- Example: Check available books  
SELECT * FROM books WHERE available_copies > 0;  

##For any or further inquiries about the same feel free to contact for assistance on [mathiasfridah2@gmail.com]  
🧑‍💻Happy coding!!  
