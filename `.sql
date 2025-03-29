CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Genre VARCHAR(100),
    PublishedYear INT,
    TotalCopies INT,
    AvailableCopies INT
);
CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address TEXT,
    MembershipDate DATE DEFAULT CURRENT_DATE
);
CREATE TABLE BorrowedBooks (
    BorrowID INT PRIMARY KEY AUTO_INCREMENT,
    MemberID INT,
    BookID INT,
    BorrowDate DATE DEFAULT CURRENT_DATE,
    DueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
INSERT INTO Books (Title, Author, Genre, PublishedYear, TotalCopies, AvailableCopies)
VALUES ('Atomic Habits', 'James Clear', 'Self-Help', 2018, 10, 10);
INSERT INTO BorrowedBooks (MemberID, BookID, DueDate)
VALUES (1, 3, DATE_ADD(CURRENT_DATE, INTERVAL 14 DAY));
UPDATE Books 
SET AvailableCopies = AvailableCopies - 1 
WHERE BookID = 3;
UPDATE BorrowedBooks 
SET ReturnDate = CURRENT_DATE 
WHERE BorrowID = 5;
UPDATE Books 
SET AvailableCopies = AvailableCopies + 1 
WHERE BookID = (SELECT BookID FROM BorrowedBooks WHERE BorrowID = 5);
SELECT * FROM Books WHERE AvailableCopies > 0;
SELECT bb.BorrowID, m.Name, b.Title, bb.DueDate 
FROM Borrowed Books bb
JOIN Members m ON bb.MemberID = m.MemberID
JOIN Books b ON bb.BookID = b.BookID
WHERE bb.DueDate < CURRENT_DATE AND bb.ReturnDate IS NULL;
