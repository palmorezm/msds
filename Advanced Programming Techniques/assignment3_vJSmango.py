'''
Assignment #3

'''

import csv, json, math, pandas as pd, requests, unittest, uuid


'''
    Create a class called MangoDB. The MangoDB class wraps a dictionary of 
    dictionaries. At the the root level, each key/value will be called a 
    collection, similar to the terminology used by MongoDB, an inferior version 
    of MangoDB ;) A collection is a series of 2nd level key/value paries. 
The root value key is the name of the collection and the value is another 
dictionary containing arbitrary data for that collection.

    For example:

        {
            'default': {
            'version':1.0,
            'db':'mangodb',
            'uuid':'0fd7575d-d331-41b7-9598-33d6c9a1eae3'
            },
        {
            'temperatures': {
                1: 50,
                2: 100,
                3: 120
            }
        }
    
    The above is a representation of a dictionary of dictionaries. Default and 
    temperatures are dictionaries or collections. The default collection has a 
    series of key/value pairs that make up the collection. The MangoDB class 
    should create only the default collection, as shown, on instantiation 
    including a randomly generated uuid using the uuid4() method and have the 
    following methods:
        - display_all_collections() which iterates through every collection 
        and prints to screen each collection names and the collection's content 
        underneath and may look something like:
            collection: default
                version 1.0
                db mangodb
                uuid 739bd6e8-c458-402d-9f2b-7012594cd741
            collection: temperatures
                1 50
                2 100 
        - add_collection(collection_name) allows the caller to add a new 
        collection by providing a name. The collection will be empty but will 
        have a name.
        - update_collection(collection_name,updates) allows the caller to 
        insert new items into a collection i.e. 
                db = MangoDB()
                db.add_collection('temperatures')
                db.update_collection('temperatures',{1:50,2:100})
        - remove_collection() allows caller to delete a specific collection by 
        name and its associated data
        - list_collections() displays a list of all the collections
        - get_collection_size(collection_name) finds the number of key/value 
        pairs in a given collection
        - to_json(collection_name) that converts the collection to a JSON string
        - wipe() that cleans out the db and resets it with just a default 
        collection
        - get_collection_names() that returns a list of collection names


        Make sure to never expose the underlying data structures

    '''

# ------ Create your classes here \/ \/ \/ ------
# MangoDB class declaration below here

    
class MangoDB:
    """Wraps a dictionary of dictionaries. 
    
    attributes: length, width
    """

    def __init__(self):
        self.wipe()
    
    def wipe(self):
        """resest the object with just a default collection"""
        self.__db = {
            'default': {
                'version': 1.0,
                'db': 'mangodb',
                'uuid': uuid.uuid4()
            }
        }
        
    def __str__(self):
        return str(self.__db)
    
    def __repr__(self):
        return str(self.__db)
    
    def display_all_collections(self):
        for i in self.__db:
            print("collection: " + i)
            for j in self.__db[i]:
                print(j, self.__db[i][j])
                
    def add_collection(self, collection_name):
        """add new collection by providing a name. it will be empty otherwise"""
        self.__db[collection_name] = {}
        
    def update_collection(self, collection_name, updates):
        if collection_name in self.__db:
            for key in updates:
                self.__db[collection_name][key] = updates[key]
                
    def remove_collection(self, collection_name):
        if collection_name in self.__db:
            self.__db.pop(collection_name)
        else:
            return(str(collection_name + "not found"))
        
    def get_collection_size(self, collection_name):
        return len(self.__db[collection_name])
    
    def to_json(self, collection_name):
        return json.dumps(self.__db[collection_name])
    
    def get_collection_names(self):
        output = []
        for i in self.__db.keys():
            output.append(i)
        return output
    
    def get_value(self, collection_name, key):
        print(self.__db[collection_name][key])
                
    

# ------ Create your classes here /\ /\ /\ ------





def exercise02():

    '''
        For exercise02(), perform the following:

        
    '''

    test_scores = [99,89,88,75,66,92,75,94,88,87,88,68,52]

    # ------ Place code below here \/ \/ \/ ------

    # Create an instance of MangoDB
    b = MangoDB()
    
    # Add a collection called testscores
    b.add_collection('test_scores')
    
    # Take the test_scores list and insert it into the testscores 
    # collection, providing a sequential key i.e 1,2,3...
    for i in range(len(test_scores)):
        b.update_collection("test_scores", {i + 1:test_scores[i]})
    
    # Display the size of the testscores collection
    print(b.get_collection_size("test_scores"))
    
    # Display a list of collections
    b.display_all_collections()
    
    # Display the db's UUID
    b.get_value("default", "uuid")
    
    # Wipe the database clean
    b.wipe()
    
    # Display the db's UUID again, confirming it has changed
    b.get_value("default", "uuid")



    # ------ Place code above here /\ /\ /\ ------




class TestAssignment3(unittest.TestCase):
   
    def test_exercise02(self):
        print('Testing exercise 2')
        exercise02()
        db = MangoDB()
        self.assertEqual(db.get_collection_size('default'),3)
        self.assertEqual(len(db.get_collection_names()),1)
        self.assertTrue('default' in db.get_collection_names() )
        db.add_collection('temperatures')
        self.assertTrue('temperatures' in db.get_collection_names() )
        self.assertEqual(len(db.get_collection_names()),2)
        db.update_collection('temperatures',{1:50})
        db.update_collection('temperatures',{2:100})
        self.assertEqual(db.get_collection_size('temperatures'),2)
        self.assertTrue(type(db.to_json('temperatures')) is str)
        self.assertEqual(db.to_json('temperatures'),'{"1": 50, "2": 100}')
        db.wipe()
        self.assertEqual(db.get_collection_size('default'),3)
        self.assertEqual(len(db.get_collection_names()),1)
        
  

if __name__ == '__main__':
    unittest.main()
