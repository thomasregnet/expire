Feature: List rules
  As an User
  In order to see the available rules
  I want to use some commands to list them
  
  Scenario: List all rule-classes
    When I run `expire rule-classes`
    Then it should pass with exactly:
    """
    Expire::KeepMostRecentRule
    Expire::KeepMostRecentForRule
    Expire::KeepFromNowMostRecentForRule
    Expire::KeepHourlyRule
    Expire::KeepDailyRule
    Expire::KeepWeeklyRule
    Expire::KeepMonthlyRule
    Expire::KeepYearlyRule
    Expire::KeepHourlyForRule
    Expire::KeepDailyForRule
    Expire::KeepWeeklyForRule
    Expire::KeepMonthlyForRule
    Expire::KeepYearlyForRule
    Expire::FromNowKeepHourlyForRule
    Expire::FromNowKeepDailyForRule
    Expire::FromNowKeepWeeklyForRule
    Expire::FromNowKeepMonthlyForRule
    Expire::FromNowKeepYearlyForRule
    """
