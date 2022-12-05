

print("Strings are basically plain text - any text that you want to store in our program")
print("To separate the string and create a new line within the string of text use the backslahs n")

print("Giraffe Academy")
print("Then becomes...")
print("Giraffe\n Academy")

print("Use the backslash key to print out quotation marks or simply a backslash")
print("For example:")

print("Giraffe\"Academy")
print("...Or just the backslash... ")
print("Giraffe\Academy")

print("You can also create string variables with Python")
phrase = "Giraffe Academy"
print("phrase")

print("You can also append a phrase to a variable using a ' + ' and quotation marks")
print(phrase + "is cool")
print("This process is called concatenation")

print("You can also create functions in python to interact with strings")
print("This function will cause the string to become all lowercase")
print(phrase.lower())

print("There is also an uppercase function")

print("We can also determine if the string is entirely uppercase or lowercase")
print(phrase.isupper())
print("This function determined if the entire string is in uppercase")

print("Functions can also be combined to produce different results")
print("For example, if we convert the string to entirely uppercase")
print("then run the is.upper function, we should get a value of true.")
print(phrase.upper().isupper())

print("There are many kind of functions")
print("Another common use is to determine the length of a string")
print(len(phrase))
print("This determined there were 15 characters in the phrase 'Giraffe Academy' ")

print("You can also select out individual characters")
print(phrase[0])
print("This function printed the first character in the string 'G'")
print("With Python, strings start at 0")


print("We can also find a specific character inside of our string")
print("This can be done using the index value")
print(phrase.index("G"))
''

print("The value that you give to a function is called a parameter")
print("For example, the 'G' in the index function above is the parameter")
print("The function is the .index")

print("You can also find the begining of words with the index function")
print(phrase.index("Academy"))

print("The index function will always return the starting point of the characters specified")

print("When you attempt to find a character that does not exist in the string")
print("Python will show an error, since the character does not exist in the string")

print("You can also replace values in a string using the phrase.replace function")
print(phrase.replace("Giraffe", "Elephant"))
print("The phrase \"Giraffe Academy\" is now \"Elephant Academy\"")


