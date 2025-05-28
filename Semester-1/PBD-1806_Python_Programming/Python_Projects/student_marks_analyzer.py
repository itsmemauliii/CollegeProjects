def add_student():
    with open("students.txt", "a") as f:
        name = input("Enter student name: ")
        marks = input("Enter marks: ")
        f.write(f"{name},{marks}\n")
        print("Student added successfully.")

def view_students():
    try:
        with open("students.txt", "r") as f:
            print("\nStudent Records:")
            for line in f:
                name, marks = line.strip().split(",")
                print(f"Name: {name}, Marks: {marks}")
    except FileNotFoundError:
        print("No student records found.")

def find_topper():
    try:
        with open("students.txt", "r") as f:
            topper = ("", 0)
            for line in f:
                name, marks = line.strip().split(",")
                if int(marks) > topper[1]:
                    topper = (name, int(marks))
            print(f"\nTopper: {topper[0]} with {topper[1]} marks.")
    except FileNotFoundError:
        print("No data found.")

def main():
    while True:
        print("\n1. Add Student\n2. View Students\n3. Find Topper\n4. Exit")
        choice = input("Enter choice: ")
        if choice == '1':
            add_student()
        elif choice == '2':
            view_students()
        elif choice == '3':
            find_topper()
        elif choice == '4':
            break
        else:
            print("Invalid choice.")

if __name__ == "__main__":
    main()
