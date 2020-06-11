Feature: Oldest
  As an User
  I want to get the oldest backup

  Background:
    Given a directory named "backups/2020-05-25-12-13"
    Given a directory named "backups/2020-05-24-12-13"
    Given a directory named "backups/2020-05-23-12-13"

  Scenario: Get the oldest backup per API
    When I call Expire.oldest(path)
    Then I get the oldest backup
    
  # Scenario: Get the oldest backup per CLI
  #   When I run `expire oldest backups`
  #   Then the output should contain "backups/2020-05-23-12-13"

