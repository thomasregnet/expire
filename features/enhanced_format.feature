Feature: Enhanced Format
  In order to get enhanced information of the purge process
  as a user
  I want to use the --format=enhanced option
  
  Scenario: Purge with the --format=enhanced option
    Given the backup directory exists
    Given a file named "rules.yml" with:
    """
    at_least: 3
    """
    When I run `expire purge --rules-file=rules.yml --format=enhanced backups` 
    Then the output should contain "keeping"
    And the output should contain "purged"
