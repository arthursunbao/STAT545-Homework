Zeus: A Machine Learning Training Platform based on offline training and online trading
=====================

### About Dragon: An offline machine learning training platform for stock prediction
This is the parent folder for Dragon: An offline machine learning training platform for stock prediction.

Currently it is under development and maintained by Jason Sun and will be finished within the end of 30th, Nov. 

### What is the goal for the four-month Mitcas?

Dragon provides following functionality:

- LSTM based multi-feature offline parameter training, tuning and stock price predction **Done**
- SVM/Xgboost based multi-feature offline parameter training, tuning and stock price predction **Done**
- DNN/MLP based multi-feature offline parameter training, tuning and stock price predction
- GBDT based multi-feature offline parameter training, tuning and stock price predction
- An hyper-parameter tuning framework called hypertune **Done**
- A simple 4-model integration for parametrized result generation
- A basic sentiment judgement machine for based on market sentiment

### What is the timeline for the four-month Mitcas?

Aug 1 - Aug 4: General Environment Setup, Preparation **Done**

Aug 5 - Aug 20: Developed the first model with LSTM. **Done**

Aug 21 - Sep 15: Developing Hypermeter Optimization Framework for Future Development  **Done**
  
Sep 16 - Sep 31: Developing the second model with SVM for multi-future version  **Done**

Oct 1 - Oct 8: Second Model Optimization: Underway......

Oct 9 - Oct 20: Third Model Development with XGBoost/SVM

Oct 21 - Oct 27: Third Model Optimization

Oct 28 - Nov 10: Forth Model Development with DNN/MLP

Nov 11 - Nov 18: Forth Model Optimization

Nov 19 - Nov 31: Sentiment Model Development.

### After the four month: Next Step After Mitacs: Developing online Phoneix Trading System

Developing Trading Platform called Phoneix which enables offline machine learning training and online prediction for massive stocks.

Estimated Time Frame: 4 months

Estimiated work to be done for Phoneix

- Live Data input: streaming data service provider module

- Web Crawler: Responsible for aggregating the latest ticks in real time

- Trading Strategy Submission Engine

- Data Handler: Responsible for cleaning and checking for live streaming data and submitted trading strategy

- Market Matching Handler: Responsible for matching up rules with the current state of the market and executes the trades when the conditions specified in rules are met

- Execution Engine: Responsible for sending trading commands to Interactive Brokers

- Database: Responsible for storing all the execution history, market data, offline machine learning data, parameters

- Trainer: Offline Machine Learning Training

- Web Interface: Live Web GUI for comperhensive system control


