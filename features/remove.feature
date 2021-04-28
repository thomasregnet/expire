Feature: Remove
  In order to remove backups without applying rules
  As a User
  I want to use the `expire remove` command

  Scenario: Remove a directory
    Given a directory named "backups/bad_backup"
    When I run `expire remove backups/bad_backup`
    Then it should pass with exactly:
    """
    removed backups/bad_backup
    """
    And the directory "backups/bad_backup" should not exist
    
  Scenario: Try to remove a directory that does not exist
    Given a directory named "backups/bad_backup" does not exist
    When I run `expire remove backups/bad_backup`
    Then it should fail with regex:
    """
    can't remove backups/bad_backup: No such file or directory
    """
  Scenario: Try to remove a directory that does not exist per API
    Given a directory named "backups/bad_backup" does not exist
    When I call Expire.remove("backups/bad_backup")
    Then an Errno::ENOENT exception is thrown

