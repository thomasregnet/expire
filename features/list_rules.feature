Feature: List rules
  As an User
  In order to see the available rules
  I want to use some commands to list them
  
  Scenario: List all rule-classes
    When I run `expire rule-classes`
    Then it should pass with exactly:
    """
    Expire::MostRecentRule
    Expire::MostRecentForRule
    Expire::FromNowMostRecentForRule
    Expire::HourlyRule
    Expire::DailyRule
    Expire::WeeklyRule
    Expire::MonthlyRule
    Expire::YearlyRule
    Expire::HourlyForRule
    Expire::DailyForRule
    Expire::WeeklyForRule
    Expire::MonthlyForRule
    Expire::YearlyForRule
    Expire::FromNowHourlyForRule
    Expire::FromNowDailyForRule
    Expire::FromNowWeeklyForRule
    Expire::FromNowMonthlyForRule
    Expire::FromNowYearlyForRule
    """
