'''
Assignment #3

'''

import csv, json, math, pandas as pd, requests, unittest, uuid

# ------ Create your classes here \/ \/ \/ ------

'''
    
Remember, here immutable means there are no setter methods. States can change 
with the methods required below i.e. combine(), invert(). So for example if s1 
is an instance of Square and you call s1.expand(1), the expand method will 
return a new instance of Square with the new state instead of modifying the 
internal state of s1
        
'''

# Box class declaration below here (for exerce01)
    
class Box:
    """Represents a box.
    
    attributes: length, width
    """
    
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
In the function exercise01():

    '''        

    # ------ Place code below here \/ \/ \/ ------
    
    #Instantiate 3 boxes of dimensions 5,10 , 3,4 and 5,10 and assign to 
    # variables b1, b2 and b3 respectively 
    
    b1 = Box(5, 10)
    b2 = Box(3, 4)
    b3 = Box(5, 10)

    
    # Print dimension info for each using print_dim()
    b1.print_dim()
    b2.print_dim()
    b3.print_dim()
    
    # Evaluate if b1 == b2, and also evaluate if b1 == b3, print True 
    # or False to the screen accordingly
    b1 == b2
    b1 == b3
    
    # Combine b3 into b1 (i.e. b1.combine())
    b1 = b1.combine(b3)


    # Double the size of b2
    b2 = b2.double()

    
    # Combine b2 into b1
    b1 = b1.combine(b2)

    
    # Using a for loop, iterate through and print the tuple received from 
    # calling b2's get_dim()
    for i in b2.get_dim():
        b2.get_dim()
        
    
    # Find the size of the diagonal of b2
    b2.get_hypot()

    return b1, b2, b3

    # ------ Place code above here /\ /\ /\ ------


class TestAssignment3(unittest.TestCase):
    def test_exercise01(self):
        print('Testing exercise 1')
        b1, b2, b3 = exercise01()
        self.assertEqual(b1.get_length(),16)
        self.assertEqual(b1.get_width(),28)
        self.assertTrue(b1==Box(16,28))
        self.assertEqual(b2.get_length(),6)
        self.assertEqual(b2.get_width(),8)
        self.assertEqual(b3.get_length(),5)
        self.assertEqual(b2.get_hypot(),10)
        self.assertEqual(b1.double().get_length(),32)
        self.assertEqual(b1.double().get_width(), 56)
        self.assertTrue(6 in b2.get_dim())
        self.assertTrue(8 in b2.get_dim())
        self.assertTrue(b2.combine(Box(1,1))==Box(7,9))

   
     

if __name__ == '__main__':
    unittest.main()
