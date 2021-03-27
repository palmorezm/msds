# -*- coding: utf-8 -*-
"""
Created on Thu Mar 18 19:21:03 2021

@author: Zachary Palmore
"""

'''
Assignment #3
1. Add / modify code ONLY between the marked areas (i.e. "Place code below"). Do not modify or add code elsewhere.
2. Run the associated test harness for a basic check on completeness. A successful run of the test cases does not guarantee accuracy or fulfillment of the requirements. Please do not submit your work if test cases fail.
3. To run unit tests simply use the below command after filling in all of the code:
    python 03_assignment.py
4. Unless explicitly stated, please do not import any additional libraries but feel free to use built-in Python packages
5. Submissions must be a Python file and not a notebook file (i.e *.ipynb)
6. Do not use global variables
7. Use the test cases to infer requirements wherever feasible - not all exercises will have test cases
'''
import csv, json, math, pandas as pd, requests, unittest, uuid


# ------ Create your classes here \/ \/ \/ ------

#BankAccount class declaration below here




# Box class declaration below here
        
class Box:
    # Represents a box. attributes: length, width
    
    # setting instantiation with 2 attributes for the Box class
    # Create an immutable class Box that has private attributes length and width 
    # that takes values for length and width upon construction (instantiation 
    # via the constructor). Make sure to use Python 3 semantics. Make sure the 
    # length and width attributes are private and accessible only via getters. 
    # Immutable here means that any change to its internal state results in a 
    # new Box being returned.
        def __init__(self, length, width):
            self.__length = length
            self.__width = width
        
        def get_length(self):
            return self.__length
    
        def get_width(self):
            return self.__width
        
    
    # create a method called render() that prints out to the screen a box 
    # made with asterisks of length and width dimensions
        def render(self):
            print('*' * self.__width)
            for row in range(self.__length - 2):
                print('*', ' ' * (self.__width -4), '*')
                print('*' * self.__width)
    
    #testbox = Box(4, 7)
    #testbox.render()


    # create a method called invert() that switches length and width with each 
    # other
        def invert(self):
           return Box(self.__width, self.__length)
    
    #testbox = Box(4, 7)
    #testbox.invert()
    #print(testbox.__width)
    #print(testbox.__length)
    
    # create methods get_area() and get_perimeter() that return appropriate 
    # geometric calculations
        def get_area(self):
            return self.__width * self.__length
    
        def get_perimeter(self):
            return self.__width * 2 + self.__length * 2

    #testbox = Box(4, 7)
    #testbox.get_area()
    #testbox.get_perimeter()
    
    # create a method called double() that doubles the size of the box. 
    # Hint: Pay attention to return value here
    
        def double(self):
            return Box(2*self.__length, 2*self.__width)
    
    #testbox = Box(4, 7)
    #testbox.double()
    
    # Implement __eq__ so that two boxes can be compared using ==. Two boxes 
    # are equal if their respective lengths and widths are identical.
    
        def __eq__(self, other):
            return self.__length == other.__length and self.__width == other.__width
        
    #testbox = Box(8, 7)
    #testb2 = Box(6, 7)
    #testbox == testb2
    
    # create a method print_dim that prints to screen the length and width 
    # details of the box
    
        def print_dim(self):
            print(self.__length, self.__width)
        
        #testbox = Box(4, 7)
        #testbox.print_dim()
    
    # create a method get_dim that returns a tuple containing the length and 
    # width of the box
    
        def get_dim(self):
            return (self.__length, self.__width)
    
    #testbox = Box(4, 7)
    #testbox.get_dim()
    
    # create a method combine() that takes another box as an argument and increases 
    # the length and width by the dimensions of the box passed in

        def combine(self, other):
            return Box(self.__length + other.__length, self.__width + other.__width)
    
    #testbox = Box(4, 7)
    #testb2 = Box(1, 2)
    #testbox.combine(testb2)

    # create a method get_hypot() that finds the length of the diagonal that 
    # cuts throught the middle
    
        def get_hypot(self):
            return math.sqrt(self.__length**2 + self.__width**2)
    
    #testbox = Box(4, 7)
    #testbox.get_hypot()
    #testbox.get_length()
    
    
# ------ Create your classes here /\ /\ /\ ------




def exercise01():
    '''
    Create a class called BankAccount that has four attributes: bankname, firstname, lastname, and balance. 
    The default balance should be set to 0.  (Create your class above.)

    In addition, create ...
    - A method called depost() that allows the user to make deposts into their balance. 
    - A method called withdrawal() that allows the user to withdraw from their balance. 
    - Withdrawls may not exceed the available balance.  Hint: consider a conditional argument in your withdrawl() method.
    - Use the __str__() method in order to display the bank name, owner name, and current balance.

    In the function of exercise01():
    - Make a series of deposts and withdraws to test your class (below).

    '''

    # ------ Place code below here \/ \/ \/ ------

    


    # ------ Place code above here /\ /\ /\ ------





def exercise02():

    '''
        Create a class Box that has attributes length and width that takes values for length and width upon construction (instantiation via the constructor). 
        Make sure to use Python 3 semantics. 
       
        In addition, create...
        - A method called render() that prints out to the screen a box made with asterisks of length and width dimensions
        - A method called invert() that switches length and width with each other
        - Methods get_area() and get_perimeter() that return appropriate geometric calculations
        - A method called double() that doubles the size of the box. Hint: Pay attention to return value here
        - Implement __eq__ so that two boxes can be compared using ==. Two boxes are equal if their respective lengths and widths are identical.
        - A method print_dim that prints to screen the length and width details of the box
        - A method get_dim that returns a tuple containing the length and width of the box
        - A method combine() that takes another box as an argument and increases the length and width by the dimensions of the box passed in
        - A method get_hypot() that finds the length of the diagonal that cuts throught the middle
        
        In the function exercise02():
        - Instantiate 3 boxes of dimensions 5,10 , 3,4 and 5,10 and assign to variables box1, box2 and box3 respectively 
        - Print dimension info for each using print_dim()
        - Evaluate if box1 == box2, and also evaluate if box1 == box3, print True or False to the screen accordingly
        - Combine box3 into box1 (i.e. box1.combine())
        - Double the size of box2
        - Combine box2 into box1
        - Using a for loop, iterate through and print the tuple received from calling box2's get_dim()
        - Find the size of the diagonal of box2
'''

    # ------ Place code below here \/ \/ \/ ------

    #Instantiate 3 boxes of dimensions 5,10 , 3,4 and 5,10 and assign to 
    # variables b1, b2 and b3 respectively 
    
    box1 = Box(5, 10)
    box2 = Box(3, 4)
    box3 = Box(5, 10)

    
    # Print dimension info for each using print_dim()
    box1.print_dim()
    box2.print_dim()
    box3.print_dim()
    
    # Evaluate if b1 == b2, and also evaluate if b1 == b3, print True 
    # or False to the screen accordingly
    box1 == box2
    box1 == box3
    
    # Combine b3 into b1 (i.e. b1.combine())
    box1 = box1.combine(box3)


    # Double the size of b2
    box2 = box2.double()

    
    # Combine b2 into b1
    box1 = box1.combine(box2)

    
    # Using a for loop, iterate through and print the tuple received from 
    # calling b2's get_dim()
    for i in box2.get_dim():
        box2.get_dim()
        
    
    # Find the size of the diagonal of b2
    box2.get_hypot()

    return box1, box2, box3



    # ------ Place code above here /\ /\ /\ ------





def exercise03():
    '''
    1. Read about avocado prices on Kaggle (https://www.kaggle.com/neuromusic/avocado-prices/home)
    2. Load the included avocado.csv file and display every line to the screen
    3. Use the imported csv library
    '''

    # ------ Place code below here \/ \/ \/ ------
    
    # Error 404 - Page not found
    
    
    # ------ Place code above here /\ /\ /\ ------


class TestAssignment3(unittest.TestCase):

    def test_exercise02(self):
        print('Testing exercise 2')
        b1, b2, b3 = exercise02()
        self.assertEqual(b1.get_length(),16)
        self.assertEqual(b1.get_width(),28)
        self.assertTrue(b1==Box(16,28))
        self.assertEqual(b2.get_length(),6)
        self.assertEqual(b2.get_width(),8)
        self.assertEqual(b3.get_length(),5)
        self.assertEqual(b2.get_hypot(),10)
        self.assertEqual(b1.double().get_length(),32)
        self.assertEqual(b1.double().get_width(),112)
        self.assertTrue(6 in b2.get_dim())
        self.assertTrue(8 in b2.get_dim())
        self.assertTrue(b2.combine(Box(1,1))==Box(7,9))

        
    def test_exercise03(self):
        print('Exercise 3 not tested')
        exercise03()
     

if __name__ == '__main__':
    unittest.main()