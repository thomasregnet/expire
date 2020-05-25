Feature: Run
  In order to purge expired backups
  As a User
  I want to get rid of them


  Background:
    Given a directory named "2020-05-25-12-13"
    Given a directory named "2020-05-24-12-13"
    Given a directory named "2020-05-23-12-13"

  Scenario: Run with the --test parameter
    When I run `expire purge`
    Then the output should contain "2020-05-23-12-13"
