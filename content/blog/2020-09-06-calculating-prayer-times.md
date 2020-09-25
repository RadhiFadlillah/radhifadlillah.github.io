+++
Author = "Radhi Fadlillah"
CreateTime = 2020-09-06T15:59:43+07:00
Tags = ["tutorial", "summary", "islam"]
Title = "Step by Step: Calculating Prayer Times"
+++

> This post is summary of book ["Mekanika Benda Langit"][1] by [Rinto Anugraha][2] supplemented with information from several sources. I write this summary because Anugraha's book is quite long and only available in Indonesian language, so I decided to translate the part of calculating prayer times to English.

Muslims have five obligatory prayers a day. Each prayer is given a certain prescribed time during which it must be performed. There are six points of time per day that we need to calculate to determine the time period for each prayer :

| Time    | Definition                                                                                                                                                              |
|---------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Fajr    | When the sky begins to lighten (dawn).                                                                                                                                  |
| Sunrise | The time at which the first part of the Sun appears above the horizon.                                                                                                  |
| Zuhr    | The time when the Sun begins to decline after reaching its highest point in the sky.                                                                                    |
| Asr     | The time when the length of any object's shadow reaches a factor (usually 1 or 2) of the length of the object itself plus the length of  that object's shadow at noon. |
| Maghrib | Same as sunset, i.e. the time at which the Sun disappears below the horizon.                                                                                            |
| Isha    | The time at which darkness falls and there is no scattered light in the sky.                                                                                            |

## Requirements

Before calculating the prayer times, there are several parameters that must be known beforehand :

1. [Latitude of target location](#latitude-of-target-location)
2. [Longitude of target location](#longitude-of-target-location)
3. [Elevation of target location](#elevation-of-target-location)
4. [Time zone of target location](#time-zone-of-target-location)
5. [Factor of shadow length at Asr](#factor-of-shadow-length-at-asr)
6. [Sun altitude at Fajr and Isha](#sun-altitude-at-fajr-and-isha)
7. Day, month and year of the date that we want to calculate

### Latitude of target location

Latitude is geographic coordinate that specifies the north-south position of a point on the Earth's surface. It's ranged between -90° to 90°, positive for area above equator and negative for area below it. For our purpose, the value of latitude should be in decimal degrees. For example Jakarta is located in 6°12'S which equal to -6.2 degrees.

### Longitude of target location

Longitude is geographic coordinate that specifies the north-south position of a point on the Earth's surface. It's ranged between -180° to 180°, positive for Eastern Hemisphere and negative for Western Hemisphere. Like latitude, the value of longitude should also be in decimal degrees.

### Elevation of target location

Elevation above sea level is used to calculate sunrise and sunset. Places with higher elevation will see sunrise earlier and sunset later compared to people in lower elevation. For our purpose the unit for elevation should be in meter.

### Time zone of target location

Time zone is a region of the globe that observes a uniform standard time for legal, commercial and social purposes. Most of the time zones on land are offset from Coordinated Universal Time (UTC) by a whole number of hours (UTC−12:00 to UTC+14:00), but a few zones are offset by 30 or 45 minutes.

The value of time zone is positive for Eastern Hemisphere and negative for Western Hemisphere. For our purpose, the time zone should be in decimal degrees representing hours differences with UTC.

### Factor of shadow length at Asr

This parameter is used to calculate Asr time. There are [two schools][3] of thought for determining the start of Asr prayer time. **Shafii** says Asr is at the time when the length of any object's shadow equals **the length** of the object itself plus the length of that object's shadow at noon (factor = 1).

Meanwhile **Hanafi** says Asr begins when the length of any object's shadow is **twice the length** of the object plus the length of that object's shadow at noon (factor = 2).

### Sun altitude at Fajr and Isha

Fajr is started when sky begins to lighten after previously sunlight is completely invisible. In astronomy, this time is called [*astronomical dawn*][4] which happened when Sun altitude is between 12 and 18 degrees below the horizon. Meanwhile Isha is started when sky is completely dark after all sunlight is vanished and not visible anymore, which in astronomy called as *astronomical dusk*.

For simplicity, Sun altitude for both time usually called *Fajr angle* and *Isha angle*. Following the astronomy standard, value for both angle usually specified at 18 degrees. However some countries and organization has specified their own angle convention. There are also countries that doesn't use Isha angle and instead use fixed Maghrib duration.

Here are some of the [conventions][5] that commonly used around the world :

- **MWL** is calculation method from Muslim World League with Fajr at 18° and Isha at 17°. Usually used in Europe, Far East and parts of US.
- **ISNA** is method from Islamic Society of North America with both Fajr and Isha at 15°. Used in North America i.e US and Canada.
- **Umm al-Qura** is method from Umm al-Qura University in Makkah which used in Saudi Arabia. Fajr at 18.5° and Isha fixed at 90 minutes after Maghrib.
- **Gulf** is method that often used by countries in Gulf region like UAE and Kuwait. Fajr at 19.5° and Isha fixed at 90 minutes after Maghrib.
- **Algerian** is method from Algerian Ministry of Religious Affairs and Wakfs. Fajr at 18° and Isha at 17°.
- **Karachi** is method from University of Islamic Sciences, Karachi, with both Fajr and Isha at 18°. Used in Pakistan, Afganistan, Bangladesh and India.
- **Diyanet** is method from Turkey's Diyanet İşleri Başkanlığı. It has the same value as MWL with Fajr at 18° and Isha at 17°.
- **Egypt** is method from Egyptian General Authority of Survey with Fajr at 19.5° and Isha at 17.5°. Used in Africa, Syria and Lebanon.
- **EgyptBis** is another version of calculation method from Egyptian General Authority of Survey. Fajr at 20° and Isha at 18°.
- **Kemenag** is method from Kementerian Agama Republik Indonesia. Fajr at 20° and Isha at 18°.
- **MUIS** is method from Majlis Ugama Islam Singapura. Fajr at 20° and Isha at 18°.
- **JAKIM** is method from Jabatan Kemajuan Islam Malaysia. Fajr at 20° and Isha at 18°.
- **UOIF** is method from Union Des Organisations Islamiques De France. Fajr and Isha both at 12°.
- **France15** is method for France region with Fajr and Isha both at 15°.
- **France18** is method for France region with Fajr and Isha both at 18°.
- **Tunisia** is method from Tunisian Ministry of Religious Affairs. Fajr and Isha both at 18°.
- **Tehran** is method from Institute of Geophysics at University of Tehran. Fajr at 17.7° and Isha at 14°.
- **Jafari** is method from Shia Ithna Ashari that used in some Shia communities worldwide. Fajr at 16° and Isha at 14°.

## Calculation Process

Now we have all parameters ready, it's time to calculate the prayer times :

1. [Convert date to Julian Days](#convert-date-to-julian-days)
2. [Calculate Sun declination](#calculate-sun-declination)
3. [Calculate equation of time](#calculate-equation-of-time)
4. [Calculate transit time](#calculate-transit-time)
5. [Calculate Sun altitude for each prayer times](#calculate-sun-altitude-for-each-prayer-times)
6. [Calculate prayer times](#calculate-prayer-times)

### Convert date to Julian Days

[Julian Days][6] are a way of reckoning the current date by a simple count of the number of days that have passed since some remote, arbitrary date. This number of days is called the Julian Day, abbreviated as JD. The starting point, JD=0, is at noon Universal time, January 1, 4713 BC (or -4712 January 1, since there was no year '0').

Julian Days are very useful because they make it easy to determine the number of days between two events by simply subtracting their Julian Day numbers. Such calculation is difficult for the standard (Gregorian) calendar, because days are grouped into months, which contain a variable number of days, and there is the added complication of Leap Years. Not to mention there are "blank days" between 5 October 1582 and 14 October 1582 which happened because transition from Julian calendar to Gregorian calendar.

Assuming `X` is the date time that we want to convert and `Z` is the target time zone, here are steps to calculate its Julian Days :

```js
// Separate datetime's component
Y = year of X
M = month of X	// 1 for Jan, 2 for Feb and so on
D = day of X
H = hour of X
m = minute of X
s = second of X

// Assume January and February as 13th and 14th month of last year.
if (M <= 2) {
	M = M + 12
	Y = Y - 1
}

// Prepare special constant `B` for date in Gregorian calendar.
B = 0
if (X after "1582/10/14") {
	let A = INT(Y / 100)
	B = 2 + INT(A / 4) - A
}

// Finally calculate JD
JD = 1720994.5 + INT(365.25*Y) + INT(30.6001(M + 1)) + B + D +
	 ((H*3600 + m*60 + s) / 86400) - (Z / 24)
```

For example, say we want to convert 12 June 2009 at 12:00 in Jakarta to Julian Days :

```js
Y = 2009
M = 6
D = 12
H = 12
m = 0
s = 0
Z = 7	// Jakarta is UTC +7

A = INT(2009 / 100)
  = INT(20.09)
  = 20

B = 2 + INT(A / 4) - A
  = 2 + INT(20 / 4) - 20
  = 2 + 5 - 20
  = -13

JD = 1720994.5 + INT(365.25*Y) + INT(30.6001(M + 1)) + B + D +
	 ((H*3600 + m*60 + s) / 86400) - (Z / 24)
   = 1720994.5 + INT(365.25 * 2009) + INT(30.6001(6 + 1)) + (-13) + 12 +
	 ((12*3600 + 0*60 + 0) / 86400) - (7 / 24)
   = 1720994.5 + 733787 + 214 + (-13) + 12 + 0.5 - 0.292
   = 2454994.708
```

### Calculate Sun declination

The declination of the Sun is the angle between the rays of the Sun and the plane of the earth equator. The declination of the Sun changes continuously throughout the year as consequence of the Earth's tilt, i.e. the difference in its rotational and revolutionary axes.

Here is formula for calculating sun declination :

```js
T = 2 * PI * (JD - 2451545) / 365.25
DELTA = 0.37877 + 23.264 * SIN(57.297*T - 79.547) + 
		0.3812 * SIN(2*57.297*T - 82.682) + 
		0.17132 * SIN(3*57.297*T - 59.722)
```

Some notes for formula above :

- `PI` is a mathematical constant that defined as the ratio of a circle's circumference to its diameter. It is approximately equal to 3.14159.
- `SIN` here is using degrees unit instead of radians.

### Calculate equation of time

Equation of time is the difference between time as read from a sundial and a clock. It results from an apparent irregular movement of the Sun caused by a combination of the obliquity of the Earth's rotation axis and the eccentricity of its orbit. The sundial can be ahead (fast) by as much as 16 min 33 s (around November 3) or fall behind by as much as 14 min 6 s (around February 12).

Here is formula for equation of time :

```
U = (JD - 2451545) / 36525
L0 = 280.46607 + 36000.7698*U
ET1000 = -(1789 + 237*U) * SIN(L0) -
	     (7146 - 62*U) * COS(L0) + 
	     (9934 - 14*U) * SIN(2*L0) - 
	     (29 + 5*U) * COS(2*L0) +
	     (74 + 10*U) * SIN(3*L0) +
	     (320 - 4*U) * COS(3*L0) -
	     212*SIN(4*L0)
ET = ET1000 / 1000
```

Some notes for formula above :

- `U` and `L0` is in degrees.
- `SIN` and `COS` here is using degrees unit instead of radians.
- `ET` is in minutes.

### Calculate transit time

The sun transit time, is the daily moment when the Sun culminates on the observer's meridian, reaching its highest position in the sky. This solar time is most often used as local noon and therefore will vary with longitude. Here is formula for calculating it :

```
TT = 12 + Z - (LONG / 15) - (ET / 60)
```

Some notes for formula above :

- `Z` is current time zone
- `LONG` is longitude in decimal degrees.
- `ET` is equation of time in minutes.
- The calculation result is in hours.

### Calculate Sun altitude for each prayer times

Some prayer times require us to calculate its Sun altitude beforehand. With `SA` as Sun altitude, here are how to calculate them :

```
SA_FAJR    = -(FAJR_ANGLE)
SA_SUNRISE = -0.8333 - (0.0347*SQRT(H))
SA_ASR     = ACOT(SF + TAN(ABS(DELTA - LAT)))
SA_MAGHRIB = SA_SUNRISE
SA_ISHA    = -(ISHA_ANGLE)
```

Some notes for formulas above :

- `SF` is factor of shadow length that we [prepared](#factor-of-shadow-length-at-asr) before.
- `FAJR_ANGLE` and `ISHA_ANGLE` is convention of Sun altitude at Fajr and Isha time that we [prepared](#sun-altitude-at-fajr-and-isha) before.
- `DELTA` is value of Sun declination that we calculated before.
- `LAT` is latitude in decimal degrees.
- `H` is elevation above sea level in meter.
- `SQRT` is function for calculating square root.
- `ACOT` is acronym of *arcus cotangent* which is inverse of *cotangent* function. Here it's using degrees unit instead of radians.
- `TAN` here is using degrees unit instead of radians as well.
- `ABS` is function that returns absolute value of a number (number without regard to its sign).
- `-0.08333` is correction for Sun altitude that looks higher at sunrise and sunset which happened because of the athmospheric refraction.
- All Sun altitude value is in degrees.

### Calculate prayer times

At this point, now we are ready to calculate prayer times. With `HA_*` as hour angle, `TT` as transit time and `SA_*` as Sun altitude that we calculated before, here are formulas to calculate prayer times :

```
FAJR    = TT - HA_FAJR / 15
SUNRISE = TT - HA_SUNRISE / 15
ZUHR    = TT + DESCEND_CORRECTION
ASR     = TT + HA_ASR / 15
MAGHRIB = TT + HA_MAGHRIB / 15
ISHA    = TT + HA_ISHA / 15
```

For Zuhr, the prayer time is simply transit time added with some correction time. This is because there is [hadith][7] that forbade us to pray at the exactly middle of the day when sun is right above our head. Instead, we should wait until the sun has descended a bit to the west.

From this hadith, there are two different opinion on when azan should be announced :

- The azan should be announced after the sun has descended a bit (noon + 1-2 minute).
- The azan is announced right on noon when the sun is in the middle of the sky, since the prayer will be done later anyway (after iqamah).

For other prayer times, they all depends on [hour angle][8]. With `SA` as Sun altitude, here is formula for calculating hour angle :

```
COS(HA) = (SIN(SA) - SIN(LAT) * SIN(DELTA)) / (COS(LAT) * COS(DELTA))
HA = ACOS(COS(HA))
```

Some notes for formula above :

- `COS`, `SIN` and `ACOS` here is trigonometry functions that using degrees unit instead of radians.
- `DELTA` is value of Sun declination that we calculated before.
- `LAT` is latitude in decimal degrees.

## Example

For example, here we will calculate prayer times in Jakarta at 6 September 2020 :

- Its latitude is 6°12'S so `LAT = -6.2`
- Its longitude is 106°49'E so `LONG = 106.816667`
- Its elevation is 8 meter above sea level so `H = 8`
- Its time zone is UTC+7 so `Z = 7`
- Indonesia uses Shafii for calculating Asr time so `SF = 1`
- Indonesia uses Kemenag convention, so `FAJR_ANGLE = 20` and `ISHA_ANGLE = 18`

First calculate Julian Days at noon local time :

```
Y = 2020
M = 9
D = 6
H = 12
m = 0
s = 0
Z = 7

A = INT(2020 / 100)
  = INT(20.2)
  = 20

B = 2 + INT(A / 4) - A
  = 2 + INT(20 / 4) - 20
  = 2 + 5 - 20
  = -13

JD = 1720994.5 + INT(365.25*Y) + INT(30.6001(M + 1)) + B + D +
	 ((H*3600 + m*60 + s) / 86400) - (Z / 24)
   = 1720994.5 + INT(365.25 * 2020) + INT(30.6001(9 + 1)) + (-13) + 6 +
	 ((12*3600 + 0*60 + 0) / 86400) - (7 / 24)
   = 1720994.5 + 737805 + 306 + (-13) + 6 + 0.5 - 0.292
   = 2459098.708
```

Next calculate Sun declination :

```
T = 2 * PI * (JD - 2451545) / 365.25
  = 2 * 3.14159 * (2459098.708 - 2451545) / 365.25
  = 47461.3091 / 365.25
  = 129.942

DELTA = 0.37877 + 23.264 * SIN(57.297*T - 79.547) + 
		0.3812 * SIN(2*57.297*T - 82.682) + 
		0.17132 * SIN(3*57.297*T - 59.722)
      = 0.37877 + 23.264 * SIN(57.297*129.942 - 79.547) + 
		0.3812 * SIN(2*57.297*129.942 - 82.682) + 
		0.17132 * SIN(3*57.297*129.942 - 59.722)
      = 0.37877 + 23.264 * 0.24624 + 
		0.3812 * 0.742 + 
		0.17132 * (-0.69272)
      = 0.37877 + 23.264 * 0.24624 + 
		0.3812 * 0.742 + 
		0.17132 * (-0.69272)
	  = 0.37877 + 5.72845 + 0.28285 - 0.1187
	  = 6.2714
```

Next calculate equation of time :

```
U = (JD - 2451545) / 36525
  = (2459098.708 - 2451545) / 36525
  = 0.20681

L0 = 280.46607 + 36000.7698*U
   = 280.46607 + 36000.7698*0.20681
   = 280.46607 + 7445.2927
   = 7725.7587

ET1000 = -(1789 + 237*U) * SIN(L0) -
	     (7146 - 62*U) * COS(L0) + 
	     (9934 - 14*U) * SIN(2*L0) - 
	     (29 + 5*U) * COS(2*L0) +
	     (74 + 10*U) * SIN(3*L0) +
	     (320 - 4*U) * COS(3*L0) -
	     212*SIN(4*L0)
	   = -(1789 + 237 * 0.20681) * SIN(7725.7587) -
	     (7146 - 62 * 0.20681) * COS(7725.7587) + 
	     (9934 - 14 * 0.20681) * SIN(2 * 7725.7587) - 
	     (29 + 5 * 0.20681) * COS(2 * 7725.7587) +
	     (74 + 10 * 0.20681) * SIN(3 * 7725.7587) +
	     (320 - 4 * 0.20681) * COS(3 * 7725.7587) -
	     212 * SIN(4 * 7725.7587)
	   = (-1838.01397 * 0.246) -
	     (7133.1778 * -0.9693) + 
	     (9931.10467 * -0.4769) - 
	     (30.034 * 0.87896) +
	     (76.0681 * 0.67846) +
	     (319.1728 * -0.73463) -
	     (212 * -0.83834)
	   = (-452.1613) - (-6913.9643) + (-4736.05011) - 
		 (26.3988) + (51.6095) + (-234.4749) - (-177.7277)
	   = (-452.1613) - (-6913.9643) + (-4736.05011) - 
		 1694.2163

ET = ET1000 / 1000
   = 1694.2163 / 1000
   = 1.6942
```

Next calculate Sun's transit time :

```
TT = 12 + Z - (LONG / 15) - (ET / 60)
   = 12 + 7 - (106.8167 / 15) - (1.6942 / 60)
   = 11.850652
```

Next calculate Sun altitude for each time :

```
SA_FAJR = -(FAJR_ANGLE) = -20

SA_SUNRISE = SA_MAGHRIB
		   = -0.8333 - (0.0347 * SQRT(H))
		   = -0.8333 - (0.0347 * SQRT(8))
		   = -0.8333 - (0.0347 * SQRT(8))
		   = -0.8333 - (0.0347 * 2.8284)
		   = -0.8333 - (0.098145)
		   = -0.8333 - (0.098145)
		   = -0.93145

SA_ASR = ACOT(SF + TAN(ABS(DELTA - LAT)))
       = ACOT(1 + TAN(ABS(6.2714 - (-6.2))))
       = ACOT(1 + TAN(12.4714))
       = ACOT(1 + 0.2212)
       = ACOT(1.2212)
	   = 39.3129

SA_ISHA = -(ISHA_ANGLE) = -18
```

Then, we need to calculate hour angle from those Sun altitude :

```
COS(HA_FAJR) = (SIN(SA_FAJR) - SIN(LAT) * SIN(DELTA)) / (COS(LAT) * COS(DELTA))
             = (SIN(-20) - SIN(-6.2) * SIN(6.2714)) / (COS(-6.2) * COS(6.2714))
			 = (-0.342 - (-0.108 * 0.1092)) / (0.9942 * 0.994)
			 = -0.330206 / 0.988235
			 = -0.334138

COS(HA_SUNRISE) = COS(HA_MAGHRIB)
                = (SIN(SA_SUNRISE) - SIN(LAT) * SIN(DELTA)) / (COS(LAT) * COS(DELTA))
                = (SIN(-0.93145) - SIN(-6.2) * SIN(6.2714)) / (COS(-6.2) * COS(6.2714))
				= (-0.0163 - (-0.108 * 0.1092)) / (0.9942 * 0.994)
				= -0.004506 / 0.988235
				= -0.00456

COS(HA_ASR) = (SIN(SA_ASR) - SIN(LAT) * SIN(DELTA)) / (COS(LAT) * COS(DELTA))
			= (SIN(39.3129) - SIN(-6.2) * SIN(6.2714)) / (COS(-6.2) * COS(6.2714))
			= (0.6336 - (-0.108 * 0.1092)) / (0.9942 * 0.994)
			= 0.645394 / 0.988235
			= 0.653077

COS(HA_ISHA) = (SIN(SA_ISHA) - SIN(LAT) * SIN(DELTA)) / (COS(LAT) * COS(DELTA))
             = (SIN(-18) - SIN(-6.2) * SIN(6.2714)) / (COS(-6.2) * COS(6.2714))
			 = (-0.309 - (-0.108 * 0.1092)) / (0.9942 * 0.994)
			 = -0.297206 / 0.988235
			 = -0.300745

HA_FAJR = ACOS(COS(HA_FAJR))
		= ACOS(-0.334138)
		= 109.5201

HA_SUNRISE = HA_MAGHRIB
		   = ACOS(COS(HA_SUNRISE))
		   = ACOS(-0.00456)
		   = 90.2613

HA_ASR = ACOS(COS(HA_ASR))
	   = ACOS(0.653077)
	   = 49.226

HA_ISHA = ACOS(COS(HA_ISHA))
		= ACOS(-0.300745)
		= 107.5023
```

Now we just need to calculate the prayer times. Here we will add 2 minutes for as Sun descend correction for Zuhr time :

```
FAJR = TT - HA_FAJR / 15
     = 11.850652 - (109.5201 / 15)
     = 4.5493 = 04:32:57

SUNRISE = TT - HA_SUNRISE / 15
        = 11.850652 - (90.2613 / 15)
        = 5.8332 = 05:49:59

ZUHR = TT + DESCEND_CORRECTION
	 = 11.850652 + (2 / 60)
     = 11,8839 = 11:53:02

ASR = TT + HA_ASR / 15
    = 11.850652 + (49.226 / 15)
    = 15.1324 = 15:07:56

MAGHRIB = TT + HA_MAGHRIB / 15
        = 11.850652 + (90.2613 / 15)
        = 17.8681 = 17:52:05

ISHA = TT + HA_ISHA / 15
     = 11.850652 + (107.5023 / 15)
     = 19.0175 = 19:01:03
```

## Improvements

The calculation methods above is using Meeus algorithm which is the simplification of VSOP87 algorithm. If we calculate the prayer times with same parameters using software [Accurate Times][9] by Mohammad Odeh (which uses VSOP87), we will get following results :

```
FAJR    = 04:33:04 (+7s compared to our calculation)
SUNRISE = 05:50:08 (+9s)
ZUHR    = 11:53:01 (-1s)
ASR     = 15:08:01 (+5s)
MAGHRIB = 17:51:59 (-6s)
ISHA    = 19:00:58 (-5s)
```

The results of our calculations differ by about 9 seconds compared to the results of the Accurate Times calculation. So, this is already quite accurate and could be used to calculate the prayer times. However, we could improve our calculation methods to decrease the differences.

The results of our calculations use the same value for the Sun declination and equation of time for all prayer times, i.e using the value at 12.00 local time. In real world, the Sun's declination value and the equation of time always change at any time, even though the change is quite small in the span of one day.

In the case above, the Sun's declination at Fajr and Isha is 6.387024 (or 06:23:13) degrees and 6.162344 (or 06:09:44) degrees, respectively. The difference is about 14 arc minutes. With that said, the above formula can still be refined or corrected even better if for each prayer time the value of the Sun declination and the equation of time used is in accordance with the value at the time of prayer.

For example, for the Isha prayer time, the Sun declination and the equation of time are used at the time of the Isha prayer as well, not at 12.00 local time. For the initial calculation, determine the estimated hour angle obtained from Sun declination and the equation of time at 12:00 local time. From this estimated hour angle, the estimate of Isha time is found.

This estimate of Isha time is then converted to Julian Day which can then be used to calculate Sun declination and equation of time. This is done several times until a convergent (fixed) number is obtained. By using this method, we will get following results :

```
FAJR    = 4.5517  = 04:33:06 (+2s compared to Accurate Times)
SUNRISE = 5.8356  = 05:50:08 (+0s)
ZUHR    = 11.8842 = 11:53:03 (+2s)
ASR     = 15.1311 = 15:07:52 (-9s)
MAGHRIB = 17.8672 = 17:52:02 (+3s)
ISHA    = 19.0167 = 19:01:00 (+2s)
```

After our additional process, the differences decreased for some and increased for the other, but overall it become more accurate. If you think the minor increase in accuracy is worth the hassle, go for it.

## Locations at higher latitudes

In locations at higher latitude (more than 48.5 degree in north and south), twilight may persist throughout the night during some months of the year. In these abnormal periods, the determination of Fajr and Isha is not possible using the usual formulas mentioned in the previous section.

For example, in [Lunteren][10] (52°07'39.7"N 5°40'07.0"E) at 1 June 2020, if we are using our formulas we will get sunrise and Maghrib (sunset) time like this :

```
Sunrise = 5.35    = 05:21:00
Maghrib = 21.8367 = 21:50:12
```

However, when we try to calculate Fajr and Isha time our formulas will be failed because the value of `COS(HA)` will be more than 1 or less than -1. To overcome this problem, several solutions have been proposed, three of which are described below :

1. [Middle of the night](#middle-of-the-night)
2. [One-seventh of the night](#one-seventh-of-the-night)
3. [Angle-based method](#angle-based-method)

### Middle of the night

In this method, the period from sunset to sunrise is divided into two halves. The first half is considered to be the "night" and the other half as "day break". Fajr and Isha in this method are assumed to be at mid-night during the abnormal periods.

In Lunteren case, the duration of night is :

```
NIGHT_DURATION = NEXT_SUNRISE - MAGHRIB
               = (24 + SUNRISE) - MAGHRIB
			   = (24 + 5.35) - 21.8367
			   = 7.5133 = 07:30:47
```

Using this method, Fajr and Isha time in Lunteren is calculated like this :

```
FAJR = SUNRISE - (NIGHT_DURATION / 2)
	 = 5.35 - (7.5133 / 2)
	 = 1.59335 = 01:35:36

ISHA = MAGHRIB + (NIGHT_DURATION / 2)
	 = 21.8367 + (7.5133 / 2)
	 = 25.59335
	 = 24 + 1.59335 = 01:35:36 next day
```

### One-seventh of the night

In this method, the period between sunset and sunrise is divided into seven parts. Isha begins after the first one-seventh part and Fajr is at the beginning of the seventh part.

Still in Lunteren, using this method Fajr and Isha will be calculated like this :

```
FAJR = SUNRISE - (NIGHT_DURATION / 7)
	 = 5.35 - (7.5133 / 7)
	 = 4.2767 = 04:16:36

ISHA = MAGHRIB + (NIGHT_DURATION / 7)
	 = 21.8367 + (7.5133 / 7)
	 = 22.91 = 22:54:36
```

### Angle-based method

This is an intermediate solution used by some recent prayer time calculators. Let `a` be the twilight angle for Isha, and let `t = a/60`. The period between sunset and sunrise is divided into `t` parts. Isha begins after the first part. For example, if the twilight angle for Isha is 15, then Isha begins at the end of the first quarter (15/60) of the night. Time for Fajr is calculated similarly.

In Lunteren case, the conventions that used is MWL where Fajr angle is 18 and Isha angle is 17 :

```
FAJR = SUNRISE - (NIGHT_DURATION * FAJR_ANGLE / 60)
	 = 5.35 - (7.5133 * 18 / 60)
	 = 3.096 = 03:05:45

ISHA = MAGHRIB + (NIGHT_DURATION * ISHA_ANGLE / 60)
	 = 21.8367 + (7.5133 * 17 / 60)
	 = 23.9655 = 23:57:55
```

## Conclusions

While the calculation process is quite long, it's actually really simple. If you familiar with Go language or using it, you can use [`go-prayer`][11] to do the calculations for you.

[1]: https://simpan.ugm.ac.id/s/GcxKuyZWn8Rshnn
[2]: https://rintoanugraha.staff.ugm.ac.id/
[3]: http://www.prayerminder.com/faq.php#Fiqh
[4]: https://www.timeanddate.com/astronomy/astronomical-twilight.html
[5]: http://www.islamicfinder.us/index.php/api/index
[6]: https://docs.kde.org/trunk5/en/extragear-edu/kstars/ai-julianday.html
[7]: https://sunnah.com/muslim/6/357
[8]: https://en.wikipedia.org/wiki/Hour_angle
[9]: http://www.icoproject.org/accut.html?l=en
[10]: https://goo.gl/maps/gWirQYDmRmUnxNTU7
[11]: https://github.com/RadhiFadlillah/go-prayer