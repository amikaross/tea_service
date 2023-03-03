<h1 alight="center"> Tea Service </h1>
A mock take-home challenge designed to simulate a task you might receive during an interview process. The scope is smaller scale and open ended. The goal is to complete the task in 8 hours or less. Since there is a time limit and due to the tasks open ended nature, you should manage your time and plan appropriately. Not only is completeing the take-home necessary, but also explaining your process and reasoning behind your decisions equally important. Use this challenge to practice speaking about your planning and decision making processes around the code you write. 

## Context
- This mock take-home project was completed for the Back-End Engineering program at [Turing School of Software and Desing](https://turing.edu/). 

## Built With 
![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

## Setup
Fork and clone this repo to your local machine.

Then, run the following commands:
```
cd tea_service
bundle install
rails db:{drop,create,migrate,seed}
```

Run the test suite:
```
bundle exec rspec
```

Start your server in the root directory:
```
rails s
```

You should now be able to hit API endpoints using Postman or a similar tool. 

Default host is `http://localhost:3000`

## Database Schema
![Screenshot 2023-02-28 at 3 06 57 PM](https://user-images.githubusercontent.com/101589894/222743777-3cb8d3ab-f143-4249-b2bd-57ce1f183f85.png)

## API Endpoints

#### Required Headers:
```
{
  'Content-Type': 'application/json'
}
```

- ### GET '/api/v1/customers/:customer_id/subscriptions'
  > return an index of ome customer's subscriptions
  
  #### Example Response
  ```json
    {
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "customer_id": 1,
                "tea_id": 1,
                "title": "Lapson subscription",
                "frequency": 2,
                "status": "cancelled",
                "price": 6.5
            }
        },
        {
            "id": "4",
            "type": "subscription",
            "attributes": {
                "customer_id": 1,
                "tea_id": 2,
                "title": "Genmai subscription",
                "frequency": 2,
                "status": "active",
                "price": 8.75
            }
        }
    ]
  }
  ```
  <br>

- ### POST /api/v1/subscriptions
  > create a subscription
  
  #### Example Request Body:
  ```
  {
    "tea_id": "1",
    "customer_id": "2",
    "title": "Lapsong subscription",
    "frequency": "2",
    "price": "6.50"
  }
  ```
  #### Example Response
  ```json
  {
    "data": {
        "id": "3",
        "type": "subscription",
        "attributes": {
             "tea_id": 1,
             "customer_id": 2,
             "title": "Lapsong subscription",
             "frequency": 2,
             "price": "6.50"
             "status": "active"
        }
    }
  }
  ```
  <br>

- ### PATCH '/api/v1/subscription/:id'
    > patch the subscription (ex: change status to cancelled)
    
     #### Example Request Body:
     ```
     {
       "status": "canelled"
     }
     ```

  #### Example Response
  ```json
  {
    "data": {
        "id": "3",
        "type": "subscription",
        "attributes": {
             "tea_id": 1,
             "customer_id": 2,
             "title": "Lapsong subscription",
             "frequency": 2,
             "price": "6.50"
             "status": "cancelled"
        }
    }
  }
  ```
  <br>

