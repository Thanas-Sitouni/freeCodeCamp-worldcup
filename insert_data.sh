#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
TRES=$($PSQL "TRUNCATE TABLE games CASCADE")
TRES=$($PSQL "TRUNCATE TABLE teams CASCADE")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNERGOALS OPPONENTGOALS
do
  if [[ $YEAR != year ]]
  then
    WINNER_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
    OPPONENT_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
    if [[ -z $WINNER_TEAM_ID ]]
    then
      RES=$($PSQL "INSERT INTO teams (name) VALUES ('$WINNER')")
      WINNER_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
    fi
    if [[ -z $OPPONENT_TEAM_ID ]]
    then 
      RES=$($PSQL "INSERT INTO teams (name) VALUES ('$OPPONENT')")
      OPPONENT_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
    fi
    RES=$($PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_TEAM_ID, $OPPONENT_TEAM_ID, $WINNERGOALS, $OPPONENTGOALS)")
  fi
done
