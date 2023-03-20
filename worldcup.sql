CREATE DATABASE worldcup;

CREATE TABLE teams (
	team_id serial PRIMARY KEY,
	name VARCHAR (50) UNIQUE NOT NULL
);

create table games (
	game_id serial PRIMARY KEY,
	name VARCHAR (50) UNIQUE NOT NULL,
	round VARCHAR (50) NOT NULL,
	"year" INT NOT NULL,
	winner_id INT NOT NULL,
	opponent_id INT NOT NULL,
	winner_goals INT NOT NULL,
	opponent_goals INT NOT NULL,
	FOREIGN KEY (winner_id) REFERENCES teams(team_id),
	FOREIGN KEY (opponent_id) REFERENCES teams(team_id)
);
