Feature: Expire.directory(path).apply(rules).purge
  In order to purge expired backups from a directory
  As a library user
  I want to use method chaining

  Scenario: Use the directory.apply.purge chain on a valid backup directory
    Given the backup directory exists
    When I run Expire.directory(path).apply(rules).purge
    Then it purges the expired backups
