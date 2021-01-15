Feature: Purge
  In order to purge expired backups
  As a User
  I want to get rid of them


  Background:
    Given a file named "rules.yml" with:
    """
    ---
    most_recent: 3
    """

    Given a file named "backups.txt" with:
    """
    backups/2020-05-25-12-13
    backups/2020-05-24-12-13
    backups/2020-05-23-12-13
    backups/2020-04-23-12-13
    backups/2020-03-23-12-13

    """

    Given a directory named "backups/2020-05-25-12-13"
    Given a directory named "backups/2020-05-24-12-13"
    Given a directory named "backups/2020-05-23-12-13"
    Given a directory named "backups/2020-04-23-12-13"
    Given a directory named "backups/2020-03-23-12-13"
     
  Scenario: Purge with a rules-file per CLI
    When I run `expire purge backups --rules-file=rules.yml`
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

  Scenario: Purge with --purge-command per CLI
    When I run `expire purge backups --rules-file=rules.yml --purge-command='expire remove'`
    Then the following directories should exist:
      | backups/2020-05-25-12-13 |
      | backups/2020-05-24-12-13 |
      | backups/2020-05-23-12-13 |
    And the following directories should not exist:
      | backups/2020-04-23-12-13 |
      | backups/2020-03-23-12-13 |

  Scenario: Purge with --purge-command per API
    When I call Expire.purge with the purge-command option
    Then the following directories should exist:
      | backups/2020-05-25-12-13 |
      | backups/2020-05-24-12-13 |
      | backups/2020-05-23-12-13 |
    And the following directories should not exist:
      | backups/2020-04-23-12-13 |
      | backups/2020-03-23-12-13 |

  Scenario: Purge with rules per cli
    When I run `expire purge backups --most-recent=3`
    And the following directories should exist:
      | backups/2020-05-25-12-13 |
      | backups/2020-05-24-12-13 |
      | backups/2020-05-23-12-13 |
    And the following directories should not exist:
      | backups/2020-04-23-12-13 |
      | backups/2020-03-23-12-13 |

  Scenario: Purge with --most-recent=3 per API
    When I call Expire.purge with the most_recent option
    Then the following directories should exist:
      | backups/2020-05-25-12-13 |
      | backups/2020-05-24-12-13 |
      | backups/2020-05-23-12-13 |
    And the following directories should not exist:
      | backups/2020-04-23-12-13 |
      | backups/2020-03-23-12-13 |

  # The `sh -c` solution was found here:
  # https://stackoverrun.com/de/q/3259675
  # but this may not be a good idea on other systems than Linux/Unix
  Scenario: Purge with STDIN
    When I run `sh -c "expire purge - --most-recent=3 < backups.txt"`
    Then the following directories should exist:
      | backups/2020-05-25-12-13 |
      | backups/2020-05-24-12-13 |
      | backups/2020-05-23-12-13 |
    And the following directories should not exist:
      | backups/2020-04-23-12-13 |
      | backups/2020-03-23-12-13 |
