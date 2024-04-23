#!/usr/bin/python3
'''ther information from an API'''
import requests
from sys import argv

def ghater_information(employee_id):
    url = f"https://jsonplaceholder.typicode.com/users/{employee_id}"
    url_todo = f"https://jsonplaceholder.typicode.com/users/{employee_id}/todos"
    try:
        response = requests.get(url)
        if response.status_code == 200:
            user = response.json()
    	    response = requests.get(url_todo)
            if response.status_code == 200:
                todos = response.json()
                complected_todos = []
                for todo in todos:
                    if todo['completed'] is True:
                        complected_todos.append(todo)
                print("Employee {} is done with tasks({}/{}):"
                      .format(user['name'], len(complected_todos), len(todos)))
                for todo in complected_todos:
                    print("\t {}".format(todo['title']))
            else:
                print("An error occured")
        else:
            print("An error occured")
    except (Exception):
        print("An error occured")
        return 0        
if __name__ == "__main__":
      '''only one argument'''
      if len(argv) == 2 and argv[1].isdigit():
        ghater_information(argv[1])
      else:
        print("Usage: ./0-gather_data_from_an_API.py <employee ID>")
