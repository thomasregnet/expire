Feature: Expire Format
  In order to see only the paths that are kept
  as a user
  I want to uset the --format=expire option

 Background:
    Given a file named "rules.yml" with:
    """
    ---
    most_recent: 3
    """
    Given a directory named "backups/2020-05-25-12-13"
    Given a directory named "backups/2020-05-24-12-13"
    Given a directory named "backups/2020-05-23-12-13"
    Given a directory named "backups/2020-04-23-12-13"
    Given a directory named "backups/2020-03-23-12-13"

  Scenario: Purge with the --format=expire option
    When I run `expire purge --rules-file=rules.yml --format=expired backups` 
    Then the output should contain "backups/2020-04-23-12-13"
    And the output should contain "backups/2020-03-23-12-13"
    And the output should not contain "backups/2020-05-25-12-13"
    And the output should not contain "backups/2020-05-24-12-13"
    And the output should not contain "backups/2020-05-23-12-13"
    And the following directories should exist:
      | backups/2020-05-25-12-13 |
      | backups/2020-05-24-12-13 |
      | backups/2020-05-23-12-13 |
    And the following directories should not exist:
      | backups/2020-04-23-12-13 |
      | backups/2020-03-23-12-13 |
