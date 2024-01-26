extends Reference

const SET = "Core Set"
const CARDS := {
	"Yochanan ben Zakkai": {
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
	},
	"Rav Yehudah": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
	},
	"Rav Saadia": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
	},
	"Rashi": {
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
	},
	"Maharal": {
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
	},
	"Rebbi Eliezer": {
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
	},
	"Rav": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
	},
	"Rav Hai": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
	},
	"Rambam": {
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
	},
	"Vilna Gaon": {
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
	},
		"Rebbi Akiva": {
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
	},
	"Shmuel": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
	},
	"Rav Mari b Rav Dimi": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
	},
	"Ramban": {
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
	},
	"Sforno": {
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
	},
	"Rebbi Yishmael": {
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
	},
	"Rav Huna": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
	},
	"Rav Ra'ava": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
	},
	"R Yehuda HaLevi": {
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
	},
	"Rema": {
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
	},
	"Rebbi Meir": {
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
	},
	"Rava": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
	},
	"Rav Bustenai": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
	},
	"Ibn Ezra": {
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
	},
	"Arizal": {
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
	},
	"Rebbi Yehuda": {
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
	},
	"Abaye": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
	},
	"Chezkiah": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
	},
	"Rabbeinu Tam": {
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
	},
	"Baal Shem Tov": {
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
	},
	"Avraham Avinu": {
		"Type": "Tanach",
		"Effect": "Gain 2 actions"
	},
#	"Yitzchak Avinu": {
#		"Type": "Tanach",
#		"Effect": "Increase max Torah Tokens"
#	},
#	"Yaakov Avinu": {
#		"Type": "Tanach",
#		"Effect": "Gain 1 token for each Sage in the BM"
#	},
#	"Yosef HaTzadik": {
#		"Type": "Tanach",
#		"Effect": "Draw 3 cards"
#	},
#	"Aharon": {
#		"Type": "Tanach",
#		"Effect": "Your opponent loses 1 Action for 2 turns"
#	},
#	"Moshe Rabbeinu": {
#		"Type": "Tanach",
#		"Effect": "Your next Sage goes in the Timeline for 0 cost and no action"
#	},
#	"Yehoshua": {
#		"Type": "Tanach",
#		"Effect": "View opponent's cards in the Beit Midrash"
#	},
#	"Shimshon": {
#		"Type": "Tanach",
#		"Effect": "Drop both player's Torah Tokens to 0"
#	},
#	"David HaMelech": {
#		"Type": "Tanach",
#		"Effect": "Your Sages can't be challenged for 2 turns"
#	},
#	"Shlomo HaMelech": {
#		"Type": "Tanach",
#		"Effect": "Take up to 3 Tokens from your opponent"
#	},
	"Eliyahu HaNavi": {
		"Type": "Tanach",
		"Effect": "If you have 1 Timeline slot left, fill it with this card"
	},
#	"Elisha HaNavi": {
#		"Type": "Tanach",
#		"Effect": "Draw top 2 cards from the discard pile"
#	},
}
