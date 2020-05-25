Feature: Run
  In order to purge expired backups
  As a User
  I want to get rid of them

Scenario: Run with the --test parameter
  When I run `expire purge`
  Then the output should contain "Nothing usefull here"
