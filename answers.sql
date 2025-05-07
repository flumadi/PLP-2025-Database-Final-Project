CREATE TABLE books (
book_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
author VARCHAR(255) NOT NULL,
isbn VARCHAR(20) UNIQUE NOT NULL, 
publication_year INT,
genre VARCHAR(100),
available_copies INT DEFAULT 1,
total_copies INT DEFAULT 1,
CONSTRAINT chk_copies CHECK (available_copies <= total_copies) 
);

CREATE TABLE patrons (
patron_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
email VARCHAR(255) UNIQUE NOT NULL, 
phone VARCHAR(20),
membership_date DATE DEFAULT (CURRENT_DATE), 
active_status BOOLEAN DEFAULT TRUE 
);

CREATE TABLE borrowing_records (
record_id INT AUTO_INCREMENT PRIMARY KEY,
book_id INT NOT NULL,
patron_id INT NOT NULL,
borrow_date DATE DEFAULT (CURRENT_DATE), 
due_date DATE NOT NULL,
return_date DATE,
status ENUM('borrowed', 'returned', 'overdue') DEFAULT 'borrowed',
FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
FOREIGN KEY (patron_id) REFERENCES patrons(patron_id) ON DELETE CASCADE,
CONSTRAINT chk_dates CHECK (due_date > borrow_date),
CONSTRAINT chk_return_date CHECK (return_date IS NULL OR return_date >= borrow_date)
);
