Feature: Simple Format
  In order to see the porogress of purging
  as an user
  I want to watch the output with a simple format

  Scenario: Purge with no special parameter
    Given the backup directory exists
    When I run `expire purge`
    Then the output should contain "keeping"
    And the output should contain "purged"
