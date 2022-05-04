# Example




## 1.Example from paper

For data SXA1E, SXP1E, SXW1E and SXXP, we construct 160 models by R:

> *( AVGARCH, AVGARCH, NGARCH, TGARCH,  apARCH, csGARCH, eGARCH, gjrGARCH, iGARCH, sGARCH )$\times$
(ged, ghyp, jsu, norm, sged, snorm, sstd, std)$\times$
(mean, no mean)*

* Get loss (R)

```
library(rugarch)
library(MCSLoss)
library(MCS)

data("STOXXIndexesRet")
get_loss(STOXXIndexesRet[,'SXA1E'])
get_loss(STOXXIndexesRet[,'SXP1E'])
get_loss(STOXXIndexesRet[,'SXW1E'])
get_loss(STOXXIndexesRet[,'SXXP'])
```

* Performing the MCS produce (python)


Composition of remaining models in the Superior Set for each index:

|                  | **SXA1E** | **SXP1E** | **SXW1E** | **SXXP** |
|------------------|-----------|-----------|-----------|----------|
|      AVGARCH     |     15    |     0     |     15    | 14       |
|      AVGARCH     |     16    |     0     |     16    | 14       |
|      NGARCH      |     16    |     0     |     12    | 0        |
|      TGARCH      |     16    |     0     |     16    | 15       |
|      apARCH      |     16    |     10    |     16    | 14       |
|      csGARCH     |     13    |     0     |     9     | 0        |
|      eGARCH      |     14    |     0     |     16    | 14       |
|     gjrGARCH     |     16    |     0     |     16    | 2        |
|      iGARCH      |     13    |     0     |     0     | 0        |
|      sGARCH      |     16    |     0     |     13    | 0        |
|        ged       |     19    |     2     |     17    | 10       |
|       ghyp       |     20    |     0     |     18    | 10       |
|        jsu       |     20    |     0     |     18    | 10       |
|       norm       |     15    |     0     |     11    | 1        |
|       sged       |     20    |     2     |     18    | 11       |
|       snorm      |     20    |     2     |     14    | 11       |
|       sstd       |     20    |     2     |     18    | 10       |
|        std       |     17    |     2     |     15    | 10       |
|       mean       |     73    |     5     |     62    | 35       |
|      no_mean     |     78    |     5     |     67    | 38       |
| **Total Number** | **151**   | **10**    | **129**   | **73**   |

