Feature: Smoke test: combination of moves
  In order to play a full game
  As a player
  I want the moves to work in combination

  Background:
    Given a board with:
      | type   | from | to |
      | snake  | 3    | 2  |
      | ladder | 5    | 10 |
      | snake  | 15   | 11 |
      | ladder | 1    | 7  |
      | ladder | 14   | 23 |

  @implemented
  Scenario: Playing a game
    When I start a game with 3 players
    And a 1 is rolled
    And a 6 is rolled
    And a 6 is rolled
    And a 3 is rolled
    And a 2 is rolled
    And a 3 is rolled
    And a 3 is rolled
    Then player 1 is now on position 10
    And player 2 is now on position 23
    And player 3 is now on position 2
    And it is now player 3's go
