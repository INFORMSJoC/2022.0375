[![INFORMS Journal on Computing Logo](https://INFORMSJoC.github.io/logos/INFORMS_Journal_on_Computing_Header.jpg)](https://pubsonline.informs.org/journal/ijoc)

# An efficient scenario reduction method for problems with higher moment coherent risk measures
This archive is distributed in association with the [INFORMS Journal on Computing](https://pubsonline.informs.org/journal/ijoc) under the [MIT License](LICENSE).

This repository contains supporting material for the paper An efficient scenario reduction method for problems with higher moment coherent risk measures by Xiaolei He and Weiguo Zhang.

The software and data in this repository are a snapshot of the software and data that were used in the research reported on in the paper.

# Description
The goal of this software is to demonstrate the effectiveness of the scenario reduction method, as proposed in the paper, comparing to other reduction methods on both a simple portfolio optimization problem and a realistic one.

# Data 
In the folder [data](data), [stock_index1](data/stock_index1.xlsx) represents the weekly price of nine stock indices from different countries. The horizontal heading of the table displays the stock index names. 

[stockprice](data/stockprice.xlsx) represents the weekly price of fifty stocks selected randomly from the US S&P 500 index. The horizontal heading of the table displays the symbol of each stock in the website https://finance.yahoo.com/.

The folder [simple-samples](data/simple-samples) and [realistic-samples](data/realistic-samples) contain the 20 original scenario sets generated based on the [stock_index1](data/stock_index1.xlsx) and [stockprice](data/stockprice.xlsx) respectively.


# Code
The folder contains the Matlab implementations of the numerical experiments. The codes are split into the following two folders:

* "[simple-portfolio](code/simple-portfolio)" contains codes for numerical experiments on the simple portfolio optimization problem
  
* "[realistic-portfolio](code/realistic-portfolio)" contains codes for numerical experiments on the realistic portfolio optimization problem.
