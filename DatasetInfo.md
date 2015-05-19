About This Dataset
===================
The data set used in this app is drawn from the US State Facts and Figures dataset (state) from the R "datasets" library.

The data is taken from two sources:

*	U.S. Department of Commerce, Bureau of the Census (1977) Statistical Abstract of the United States.

*	U.S. Department of Commerce, Bureau of the Census (1977) County and City Data Book.

Data Items Used in This Application
-----------------------------------
An explanation of the data items from the state dataset that are used in this application follows:

*	State: character vector of 2-letter abbreviations for the state names.

*	Region: factor giving the region (Northeast, South, North Central, West) that each state belongs to.

*	Population: population estimate as of July 1, 1975

*	Income: per capita income (1974)

*	Illiteracy: illiteracy (1970, percent of population)

*	Life Expectancy: life expectancy in years (1969–71)

*	Murder Rate: murder and non-negligent manslaughter rate per 100,000 population (1976)

*	HS Graduation Rate: percent high-school graduates (1970)

*	Days Frost: mean number of days with minimum temperature below freezing (1931–1960) in capital or large city

*	Area: land area in square miles

Regional Data Aggregation
-------------------------

Data items in the regional data set were aggregated from the state data in the following ways:

*	Population: summed by region
*	Income: mean by region
*	Illiteracy: mean by region
*	Life Expectancy: mean by region
*	Murder Rate: mean by region
*	HS Graduation Rate: mean by region
*	Days Frost: mean by region
*	Area: summed by region

