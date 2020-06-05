Feature: Playground
  In order to get a glimpse of the program
  As a User
  I want to create a playground with example data

  Scenario: Create a playground using the library
    Given there is no playground
    When I call Expire.create_playground
    Then a layground is created
