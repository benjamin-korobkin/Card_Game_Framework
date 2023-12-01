# This file contains just card definitions. See also `CardConfig.gd`

extends Reference

const SET = "Demo Set 1"
const CARDS := {
	"Rich Text Card": {
		"Type": "Purple",
		"Tags": ["Rich","Text"],
		"Requirements": "",
		"Cost": 0,
		"Power": 0,
	},
	"Shaking Card": {
		"Type": "Purple",
		"Tags": ["Rich","Text"],
		"Requirements": "",
		"Cost": 0,
		"Power": 0,
	},
	"Test Card 1": {
		"Type": "Blue",
		"Tags": ["Tag 1","Tag 2"],
		"Requirements": "Demo Requirements",
		"Cost": 0,
		"Power": 0,
		"_max_allowed": 1,
		"_illustration": "Nobody",
		"_keywords": ["Keyword 1"]
	},
	"Test Card 2": {
		"Type": "Red",
		"Tags": ["Tag 1","Tag 2"],
		"Requirements": "",
		"Cost": 2,
		"Power": 5,
		"_max_allowed": 10,
		"_illustration": "Nobody",
	},
	"Spawn Card": {
		"Type": "Token",
		"Tags": [],
		"Requirements": "",
		"Cost": 0,
		"Power": 1,
		"_hide_in_deckbuilder": true,
	},
}
