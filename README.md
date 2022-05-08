# README
[Github URL](https://github.com/Guidong99/MCS)

Using the `rugrach` package of R, multiple models are constructed. Use these models to make predictions and finally pool the observed data to calculate the loss.
I have encapsulated the above procedure into a package that contains the functions to calculate the loss.
Since the `MCSproduce`method in R's `MCS` package runs too slowly, I only use R to calculate the loss, but use python to perform the `MCSproduce` process instead of R.

## Install

Run following code:

```
library(usethis)
library(devtools)
install_github("Guidong99/MCS/MCSLoss")
library(MCSLoss)
library(rugarch)
library(MCS)
```

## Get loss

```
get_loss()
```

Parameter：

| Par             | Describe                                                                                                                                          |
|-----------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| Data            | List of observed data.                                                                                                                            |
| models          | Parameters of ugarchspec object, includeing: "sGARCH", "eGARCH", "gjrGARCH", "apARCH", "csGARCH", "iGARCH".                                       |
| submodels       | Parameters of ugarchspec object, includeing: "TGARCH", "AVGARCH", "NGARCH", "NAGARCH".                                                            |
| distributions   | Parameters of ugarchspec object, includeing: "norm", "std", "ged", "snorm", "sstd", "sged", "jsu", "ghyp".                                        |
| mean            | Parameters of ugarchspec object, TRUE means that only the in-mean option is selected, FALSE means distinguish between in-mean/not in-mean option. |
| Forecast.length | Length of forecasting.                                                                                                                            |
| Refit.every     | Length of refit windows.                                                                                                                          |

## `MCSproduce` in python

Refer to the following code:

[MCS in python](https://michael-gong.com/blogs/model-confidence-set/)

The following function is summary of included models:

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
```

Run the following code to get the result:

```
mcs = ModelConfidenceSet(Loss,alpha=0.2,B=2000,w=3,algorithm="SQ").run()
stat(mcs)
```
👇
[EXAMPLE](https://github.com/Guidong99/MCS/blob/main/Example/Example.md)
