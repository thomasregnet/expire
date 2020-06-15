Feature: Simple Format
  In order to see the porogress of purging
  as an user
  I want to watch the output with a simple format

  Scenario: Purge with no special parameter
    Given the backup directory exists
    Given a file named "rules.yml" with:
    """
    at_least: 3
    """
    When I run `expire purge --rules-file=rules.yml --format=simple backups`
    Then the output should contain "keeping"
    And the output should contain "purged"
