Feature: Latest
  As an User
  I want to get the latest backup

  Background:
    Given a directory named "backups/2020-05-25-12-13"
    Given a directory named "backups/2020-05-24-12-13"
    Given a directory named "backups/2020-05-23-12-13"

  Scenario: Get the latest Backup per API
    When I call Expire.latest(path)
    Then I get the latest backup
