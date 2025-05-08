-- Database creation
CREATE DATABASE library_management;
USE library_management;

-- Core Entities
CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100)
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_year INT,
    edition VARCHAR(20),
    publisher_id INT,
    total_copies INT DEFAULT 1,
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);

CREATE TABLE book_copies (
    copy_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    barcode VARCHAR(50) UNIQUE NOT NULL,
    status ENUM('available', 'checked_out', 'maintenance') DEFAULT 'available',
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE book_authors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- User Management
CREATE TABLE patrons (
    patron_id INT AUTO_INCREMENT PRIMARY KEY,
    library_id VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    membership_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('librarian', 'admin', 'assistant') NOT NULL
);

-- Transactions
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    copy_id INT NOT NULL,
    patron_id INT NOT NULL,
    staff_id INT,
    checkout_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    due_date DATETIME NOT NULL,
    return_date DATETIME,
    FOREIGN KEY (copy_id) REFERENCES book_copies(copy_id),
    FOREIGN KEY (patron_id) REFERENCES patrons(patron_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    patron_id INT NOT NULL,
    reserve_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    expiry_date DATETIME,
    status ENUM('pending', 'fulfilled', 'cancelled'),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (patron_id) REFERENCES patrons(patron_id)
);

CREATE TABLE fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    issue_date DATE DEFAULT (CURRENT_DATE),
    paid_date DATE,
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);