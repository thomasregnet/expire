Feature: Purge
  In order to purge expired backups
  As a User
  I want to get rid of them


  Background:
    Given a file named "rules.yml" with:
    """
    ---
    at_least: 3
    """
    Given a directory named "backups/2020-05-25-12-13"
    Given a directory named "backups/2020-05-24-12-13"
    Given a directory named "backups/2020-05-23-12-13"
    Given a directory named "backups/2020-04-23-12-13"
    Given a directory named "backups/2020-03-23-12-13"

  Scenario: Purge with a rules-file per CLI
    # When I run `expire purge tmp/aruba/backups --rules_file=tmp/aruba/rules.yml`
    When I run `expire purge backups --rules_file=rules.yml`
    Then the following directories should exist:
      | backups/2020-05-25-12-13 |
      | backups/2020-05-24-12-13 |
      | backups/2020-05-23-12-13 |
    And the following directories should not exist:
      | backups/2020-04-23-12-13 |
      | backups/2020-03-23-12-13 |

  Scenario: Purge with a rules-file per API
    When I call Expire.purge with the rules_file option
    Then the following directories should exist:
      | backups/2020-05-25-12-13 |
      | backups/2020-05-24-12-13 |
      | backups/2020-05-23-12-13 |
    And the following directories should not exist:
      | backups/2020-04-23-12-13 |
      | backups/2020-03-23-12-13 |

