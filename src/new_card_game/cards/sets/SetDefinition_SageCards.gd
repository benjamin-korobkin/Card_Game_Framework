extends Reference

## Cards at the bottom of the script are ordered as such 
## for the sake of the tutorial
## Full organized list of cards can be found in README (eventually, חחח)

const SET = "Core Set"
const CARDS := {

	### SAGE CARDS BEGIN ###

## TANNAIM

	"Nittai HaArbaily": {
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
		"Teaching": "Distance yourself from evildoers. Don't befriend the wicked"
	},
	"Yehuda ben Tabbai": {
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
		"Teaching": "When judging, view all as guilty. View them as innocent after"
	},
	"Shimon ben Gamliel": {
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
		"Teaching": "The world stands on 3 things: Justice, Truth, and Peace"
	},
	
## AMORAIM

	"Reish Lakish": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
		"Teaching": "Great is teshuva, for it transforms intended sins into merits"
	},
	"Rav (Abba Aricha)": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
		"Teaching": "Better to cast oneself into a furnace than embarrass someone"
	},
	"Shmuel (bar Abba)": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
		"Teaching": "It is forbidden to deceive anyone, whether Jew or Pagan"
	},
	"Rabbi Ami": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
		"Teaching": "One who prepares a mitzva, then can't do it, is still credited"
	},
	"Bar Kappara": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
		"Teaching": "Teach your child a clean and easy profession"
	},
	"Rabbi Yehoshua ben Levi": {
		"Type": "Sage",
		"Power": 4,
		"Era": "Amora",
		"Teaching": "One who rejoices while suffering brings salvation to the world"
	},
	
## GAONIM

#	"Rav Hai": {
#		"Type": "Sage",
#		"Power": 3,
#		"Era": "Gaon",
#		"Teaching": "The true test of knowledge is action"
#	},
	"Rav Sherira": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
		"Teaching": "The Torah is broad and deep. None can claim mastery over it"
	},
	"Rav Natronai": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
		"Teaching": "It is forbidden to rely on miracles"
	},
	"Rav Amram": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
		"Teaching": "The essence of prayer is the heart's intent"
	},
	"Rav Yehudai": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
		"Teaching": "One's true wealth is his mitzvot. They join him after death"
	},
	"Rav Shimon Kayyara": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
		"Teaching": "One who learns, but doesn't teach, diminishes the Torah"
	},
	"Rav Saadia": {
		"Type": "Sage",
		"Power": 3,
		"Era": "Gaon",
		"Teaching": "Our nation is a nation only because of the Torah"
	},
	
	
	"Ramban (Nachmonides)": {
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
		"Teaching": "The soul of a person is a reflection of the Divine"
	},
	"Rabbeinu Tam": {
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
		"Teaching": "To question is the essence of understanding"
	},
	"Isaac Alfasi (Rif)": {
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
		"Teaching": "The study of Torah is a path to wisdom and peace"
	},

	"Rabbi Yaakov Emden": {
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
		"Teaching": "One should never be afraid to speak the truth"
	},
	"Rabbi Yaakov Kamenetsky": {
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
		"Teaching": "The strength of a person lies in the ability to choose"
	},
	"Vilna Gaon": {
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
		"Teaching": "Overcoming negative traits is harder than mastering Talmud"
	},
	
# TANACH CARDS
	
	"Avraham Avinu": {
		"Type": "Tanach",
		"Effect": "Gain extra action"
	},
	"Yitzchak Avinu": {
		"Type": "Tanach",
		"Effect": "Increase max Torah Tokens by 5"
	},
	"Yaakov Avinu": {
		"Type": "Tanach",
		"Effect": "Gain 1 token for each Sage in the BM"
	},
	"Aharon": {
		"Type": "Tanach",
		"Effect": "Your opponent loses 1 Action for 2 turns"
	},
	"Yehoshua": {
		"Type": "Tanach",
		"Effect": "View opponent's cards in the Beit Midrash"
	},
	"Shlomo HaMelech": {
		"Type": "Tanach",
		"Effect": "Take up to 2 tokens from your opponent"
	},
	"Eliyahu HaNavi": {
		"Type": "Tanach",
		"Effect": "Can fill the final timeline slot with this card"
	},
	"Elisha HaNavi": {
		"Type": "Tanach",
		"Effect": "Draw the top card from the discard pile"
	},
	## TODO: Implement David and other cards in the future
#	"David HaMelech": {
#		"Type": "Tanach",
#		"Effect": "Your Sages can't be replaced for 2 turns"
#	},
#	"Shimshon": {
#		"Type": "Tanach",
#		"Effect": "Drop opponent's Torah Tokens to 0"
#	},
	
	
	### TUTORIAL CARDS - Also included in main game ###
	"Chafetz Chaim": {
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
		"Teaching": "One moment of lashon hara can destroy years of work"
	},
	"Hillel": {  ## P2 4th move - put in Timeline
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
		"Teaching": "Be disciples of Aharon, loving and pursuing peace"
	},
	"Moshe Rabbeinu": { # P1 4th move
		"Type": "Tanach",
		"Effect": "Put a Sage in the Timeline for no tokens or action"
	},
	"Rashi": { # P2 3rd move
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
		"Teaching": "The Torah begins with creation to show G-d's world authority"
	},
	"Yehoshua ben Prachya": { # P2 2nd move
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
		"Teaching": "Appoint for you a teacher, acquire a friend, and judge favorably"
	},
	"Chazon Ish": {
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
		"Teaching": "Emunah (faith) is not weakness. It's courage to face reality"
	},
	"Rabbi Yehuda HaLevi": {
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
		"Teaching": "The soul's longing for G-d is like a bird yearning to fly"
	},
	"Rav Nachman of Breslov": {
		"Type": "Sage",
		"Power": 1,
		"Era": "Acharon",
		"Teaching": "If you believe you can destroy, believe you can also create"
	},
	"Yosef HaTzadik": {
		"Type": "Tanach",
		"Effect": "Draw 3 cards"
	},
	"Rambam (Maimonides)": { # P2 first move
		"Type": "Sage",
		"Power": 2,
		"Era": "Rishon",
		"Teaching": "The ultimate purpose of knowledge is to know G-d"
	},
	"Shammai": { # P1 first move
		"Type": "Sage",
		"Power": 5,
		"Era": "Tanna",
		"Teaching": "Say little and do much, and greet all with a smile"
	},
}
