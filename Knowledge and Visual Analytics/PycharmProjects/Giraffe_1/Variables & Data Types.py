print("Theere once was a man named George")
print("he was 70 years old")
print("He really liked the name George, ")
print("but didn't like being 70.")

print("What do we do when we want to change the character's name? (ex: George to John)")

print("Theere once was a man named John")
print("he was 70 years old")
print("He really liked the name John, ")
print("but didn't like being 70.")

print("Without variables, you would need to rewrite the name in the quotation marks")

print("What if we also wanted to change the character's age? (ex: 70 to 35)")

print("rather than repeatedly rewrite, better create a variable")

print("We are going to create a variable for his name and age since those are the things that often change")

character_name = "John"
character_age = "35"

print("To use those variable in the print statement - ")
print("you have to close the quotation marks")
print("Then, you can add the variable")

print("Theere once was a man named " + character_name)
print("he was 70 years old")
print("He really liked the name" + character_name, ",")
print("but didn't like being 70.")

print("To add the variable to the text you use the plus sign ' + ' ")

print("Theere once was a man named " + character_name)
print("he was" + character_age, "years old")
print("He really liked the name " + character_name, ",")
print("but didn't like being " + character_age, ".")

print("Now, if you want to change the character's name or age it is simple")
print("Edit the name stored in the variable with a new function")

print("As always, remember that order matters!")
print("If you edit the variable after a few lines of code then where the variable is used")
print("those changes will be reflected in the variables after (or below) where you made the change")
print("For example:")

character_age = "50"

print("Theere once was a man named " + character_name)
print("he was" + character_age, "years old")
print("He really liked the name " + character_name, ",")
print("but didn't like being " + character_age, ".")


character_name = "Zach"

print("Variables can also be numbers or boolean (True or False")
print("For example")

character_name = "Tom"
character_age = 50.5678213
is_male = True

print("In general, there are 3 types of data that we work with")
