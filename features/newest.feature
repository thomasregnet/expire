Feature: Latest
  As an User
  I want to get the latest backup

  Background:
    Given a directory named "backups/2020-05-25-12-13"
    Given a directory named "backups/2020-05-24-12-13"
    Given a directory named "backups/2020-05-23-12-13"

  Scenario: Get the latest backup per API
    When I call Expire.newest(path)
    Then I get the latest backup
    
  Scenario: Get the latest backup per CLI
    When I run `expire newest backups`
    Then the output should contain "backups/2020-05-25-12-13"

