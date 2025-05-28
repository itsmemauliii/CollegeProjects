class Book:
    def __init__(self, title, author):
        self.title = title
        self.author = author
        self.available = True

    def display(self):
        status = "Available" if self.available else "Issued"
        print(f"{self.title} by {self.author} - {status}")

class Library:
    def __init__(self):
        self.books = []

    def add_book(self, title, author):
        self.books.append(Book(title, author))
        print("Book added successfully.")

    def issue_book(self, title):
        for book in self.books:
            if book.title.lower() == title.lower() and book.available:
                book.available = False
                print(f"'{book.title}' has been issued.")
                return
        print("Book not available or not found.")

    def return_book(self, title):
        for book in self.books:
            if book.title.lower() == title.lower() and not book.available:
                book.available = True
                print(f"'{book.title}' has been returned.")
                return
        print("Book not issued or not found.")

    def display_books(self):
        if not self.books:
            print("No books in the library.")
        else:
            print("\nLibrary Books:")
            for book in self.books:
                book.display()

def main():
    lib = Library()
    while True:
        print("\n1. Add Book\n2. Issue Book\n3. Return Book\n4. View All Books\n5. Exit")
        choice = input("Choose an option: ")
        if choice == '1':
            title = input("Enter title: ")
            author = input("Enter author: ")
            lib.add_book(title, author)
        elif choice == '2':
            title = input("Enter title to issue: ")
            lib.issue_book(title)
        elif choice == '3':
            title = input("Enter title to return: ")
            lib.return_book(title)
        elif choice == '4':
            lib.display_books()
        elif choice == '5':
            break
        else:
            print("Invalid choice.")

if __name__ == "__main__":
    main()

