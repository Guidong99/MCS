# Example

## 1.Example from paper

For data SXA1E, SXP1E, SXW1E and SXXP, we construct 160 models by R:

> *( AVGARCH, AVGARCH, NGARCH, TGARCH,  apARCH, csGARCH, eGARCH, gjrGARCH, iGARCH, sGARCH ) ![](http://latex.codecogs.com/gif.latex?\\times)
(ged, ghyp, jsu, norm, sged, snorm, sstd, std)  ![](http://latex.codecogs.com/gif.latex?\\times)
(mean, no mean)*

* Get loss (R)

```
library(rugarch)
library(MCSLoss)
library(MCS)

data("STOXXIndexesRet")
SXA1E=get_loss(STOXXIndexesRet[,'SXA1E'])
```

* Save loss (R)

```
write.csv(x = as.data.frame(SXA1E),file = "/Users/guidongzhang/Desktop/701project/701data/SXAIE_loss.csv")
```

* Performing the MCS produce (python)

```
SXA1E=pd.read_csv("/Users/guidongzhang/Desktop/701project/701data/SXA1E_loss.csv")
mcs = ModelConfidenceSet(Loss40,alpha=0.2,B=2000,w=3,algorithm="SQ").run()
```

* Statistical result (python)

```
def stat(mcs):
    l1,l2,l3=[],[],[]
    for w in mcs.included:
        l=w.split("-")
        l1.append(l[0])
        l2.append(l[1])
        l3.append(l[2])
    print(pd.DataFrame(pd.value_counts(l1)).sort_index())
    print(pd.DataFrame(pd.value_counts(l2)).sort_index())
    print(pd.DataFrame(pd.value_counts(l3)).sort_index())

stat(mcs)
```

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

## 2.Example from Yahoo data

Take the return data of five companies on Yahoo as example: MMM, AMD, AES, AAPL, AOS.
Here is a comparison of 80 modles:

> *( AVGARCH, AVGARCH, NGARCH, TGARCH,  apARCH, csGARCH, eGARCH, gjrGARCH, iGARCH, sGARCH )$\times$
(ged, ghyp, jsu, norm, sged, snorm, sstd, std)*

Perform the operation of the previous section.

```
mcs=Gain_mcs('MMM',0.2)
mcs.included
```

The value of ![](http://latex.codecogs.com/gif.latex?\\alpha)is chosen as 0.2. After filtering the final results of the remaining models:

| **Company** | **Included Models**          |
|-------------|------------------------------|
| MMM         | TGARCH-sged                  |
| AMD         | NGARCH-smorm, NGARCH-norm    |
| AES         | gjrGARCH-snorm, apARCH-snorm |
| AAPL        | apARCH-snorm, NAGARCH-snorm  |
| AOS         | csGARCH-snorm, NGARCH-snorm  |

