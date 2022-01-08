{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "86e2ae1f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-06T14:39:36.743284Z",
     "iopub.status.busy": "2022-01-06T14:39:36.741111Z",
     "iopub.status.idle": "2022-01-06T14:39:36.79785Z"
    },
    "papermill": {
     "duration": 0.024503,
     "end_time": "2022-01-08T02:21:09.625947",
     "exception": false,
     "start_time": "2022-01-08T02:21:09.601444",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# 0.0 Introduction\n",
    "I just finished a data science course with R in Udemy and this will be my first ever project as a self-learner. Since everyone who knows about data science says that this dataset is sort of like the default first for most data scientists, here I am! To be honest, feeling a little bit nervous and lost on what I should be doing but I know the only way to grow is to START DOING nad hopefully the rest will come flowing in! So that is what I am doing now. Let's get started!\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "614c87ad",
   "metadata": {
    "papermill": {
     "duration": 0.023917,
     "end_time": "2022-01-08T02:21:09.674479",
     "exception": false,
     "start_time": "2022-01-08T02:21:09.650562",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# 1. Objective\n",
    "The objective of this project is to try and predict which passengers are likely to survive the Titanic ship wreck. Therefore, we will have to do some feature engineering (if needed) and exploratory data analysis (EDA) to look out for certain variables which may increase the possibility of survival such as location of cabin, social status, gender, age, dependents, etc. \n",
    "\n",
    "For this version, I will be using the logistic regression model for the classification prediction as it is one of the first models that I have learnt."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "a48569b9",
   "metadata": {
    "papermill": {
     "duration": 0.023941,
     "end_time": "2022-01-08T02:21:09.721549",
     "exception": false,
     "start_time": "2022-01-08T02:21:09.697608",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# 2. Data Preprocessing\n",
    "## 2.1 Importing the libraries needed"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "fe091903",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-08T02:21:09.774293Z",
     "iopub.status.busy": "2022-01-08T02:21:09.771562Z",
     "iopub.status.idle": "2022-01-08T02:21:10.191402Z",
     "shell.execute_reply": "2022-01-08T02:21:10.190382Z"
    },
    "papermill": {
     "duration": 0.446827,
     "end_time": "2022-01-08T02:21:10.191547",
     "exception": false,
     "start_time": "2022-01-08T02:21:09.744720",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\n",
      "Attaching package: ‘dplyr’\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:stats’:\n",
      "\n",
      "    filter, lag\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:base’:\n",
      "\n",
      "    intersect, setdiff, setequal, union\n",
      "\n",
      "\n",
      "Loading required package: Rcpp\n",
      "\n",
      "## \n",
      "## Amelia II: Multiple Imputation\n",
      "## (Version 1.7.6, built: 2019-11-24)\n",
      "## Copyright (C) 2005-2022 James Honaker, Gary King and Matthew Blackwell\n",
      "## Refer to http://gking.harvard.edu/amelia/ for more information\n",
      "## \n",
      "\n"
     ]
    }
   ],
   "source": [
    "library(dplyr)\n",
    "library(ggplot2)\n",
    "library(Amelia)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "9161d28b",
   "metadata": {
    "papermill": {
     "duration": 0.028968,
     "end_time": "2022-01-08T02:21:10.253828",
     "exception": false,
     "start_time": "2022-01-08T02:21:10.224860",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## 2.2 Importing the data set"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "a1c2b74f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-08T02:21:10.367015Z",
     "iopub.status.busy": "2022-01-08T02:21:10.316021Z",
     "iopub.status.idle": "2022-01-08T02:21:10.477627Z",
     "shell.execute_reply": "2022-01-08T02:21:10.475625Z"
    },
    "papermill": {
     "duration": 0.194579,
     "end_time": "2022-01-08T02:21:10.477746",
     "exception": false,
     "start_time": "2022-01-08T02:21:10.283167",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 12</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>PassengerId</th><th scope=col>Survived</th><th scope=col>Pclass</th><th scope=col>Name</th><th scope=col>Sex</th><th scope=col>Age</th><th scope=col>SibSp</th><th scope=col>Parch</th><th scope=col>Ticket</th><th scope=col>Fare</th><th scope=col>Cabin</th><th scope=col>Embarked</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1</td><td>0</td><td>3</td><td>Braund, Mr. Owen Harris                            </td><td>male  </td><td>22</td><td>1</td><td>0</td><td>A/5 21171       </td><td> 7.2500</td><td>    </td><td>S</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>2</td><td>1</td><td>1</td><td>Cumings, Mrs. John Bradley (Florence Briggs Thayer)</td><td>female</td><td>38</td><td>1</td><td>0</td><td>PC 17599        </td><td>71.2833</td><td>C85 </td><td>C</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>3</td><td>1</td><td>3</td><td>Heikkinen, Miss. Laina                             </td><td>female</td><td>26</td><td>0</td><td>0</td><td>STON/O2. 3101282</td><td> 7.9250</td><td>    </td><td>S</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>4</td><td>1</td><td>1</td><td>Futrelle, Mrs. Jacques Heath (Lily May Peel)       </td><td>female</td><td>35</td><td>1</td><td>0</td><td>113803          </td><td>53.1000</td><td>C123</td><td>S</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>5</td><td>0</td><td>3</td><td>Allen, Mr. William Henry                           </td><td>male  </td><td>35</td><td>0</td><td>0</td><td>373450          </td><td> 8.0500</td><td>    </td><td>S</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>6</td><td>0</td><td>3</td><td>Moran, Mr. James                                   </td><td>male  </td><td>NA</td><td>0</td><td>0</td><td>330877          </td><td> 8.4583</td><td>    </td><td>Q</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 12\n",
       "\\begin{tabular}{r|llllllllllll}\n",
       "  & PassengerId & Survived & Pclass & Name & Sex & Age & SibSp & Parch & Ticket & Fare & Cabin & Embarked\\\\\n",
       "  & <int> & <int> & <int> & <chr> & <chr> & <dbl> & <int> & <int> & <chr> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 1 & 0 & 3 & Braund, Mr. Owen Harris                             & male   & 22 & 1 & 0 & A/5 21171        &  7.2500 &      & S\\\\\n",
       "\t2 & 2 & 1 & 1 & Cumings, Mrs. John Bradley (Florence Briggs Thayer) & female & 38 & 1 & 0 & PC 17599         & 71.2833 & C85  & C\\\\\n",
       "\t3 & 3 & 1 & 3 & Heikkinen, Miss. Laina                              & female & 26 & 0 & 0 & STON/O2. 3101282 &  7.9250 &      & S\\\\\n",
       "\t4 & 4 & 1 & 1 & Futrelle, Mrs. Jacques Heath (Lily May Peel)        & female & 35 & 1 & 0 & 113803           & 53.1000 & C123 & S\\\\\n",
       "\t5 & 5 & 0 & 3 & Allen, Mr. William Henry                            & male   & 35 & 0 & 0 & 373450           &  8.0500 &      & S\\\\\n",
       "\t6 & 6 & 0 & 3 & Moran, Mr. James                                    & male   & NA & 0 & 0 & 330877           &  8.4583 &      & Q\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 12\n",
       "\n",
       "| <!--/--> | PassengerId &lt;int&gt; | Survived &lt;int&gt; | Pclass &lt;int&gt; | Name &lt;chr&gt; | Sex &lt;chr&gt; | Age &lt;dbl&gt; | SibSp &lt;int&gt; | Parch &lt;int&gt; | Ticket &lt;chr&gt; | Fare &lt;dbl&gt; | Cabin &lt;chr&gt; | Embarked &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1 | 0 | 3 | Braund, Mr. Owen Harris                             | male   | 22 | 1 | 0 | A/5 21171        |  7.2500 | <!----> | S |\n",
       "| 2 | 2 | 1 | 1 | Cumings, Mrs. John Bradley (Florence Briggs Thayer) | female | 38 | 1 | 0 | PC 17599         | 71.2833 | C85  | C |\n",
       "| 3 | 3 | 1 | 3 | Heikkinen, Miss. Laina                              | female | 26 | 0 | 0 | STON/O2. 3101282 |  7.9250 | <!----> | S |\n",
       "| 4 | 4 | 1 | 1 | Futrelle, Mrs. Jacques Heath (Lily May Peel)        | female | 35 | 1 | 0 | 113803           | 53.1000 | C123 | S |\n",
       "| 5 | 5 | 0 | 3 | Allen, Mr. William Henry                            | male   | 35 | 0 | 0 | 373450           |  8.0500 | <!----> | S |\n",
       "| 6 | 6 | 0 | 3 | Moran, Mr. James                                    | male   | NA | 0 | 0 | 330877           |  8.4583 | <!----> | Q |\n",
       "\n"
      ],
      "text/plain": [
       "  PassengerId Survived Pclass\n",
       "1 1           0        3     \n",
       "2 2           1        1     \n",
       "3 3           1        3     \n",
       "4 4           1        1     \n",
       "5 5           0        3     \n",
       "6 6           0        3     \n",
       "  Name                                                Sex    Age SibSp Parch\n",
       "1 Braund, Mr. Owen Harris                             male   22  1     0    \n",
       "2 Cumings, Mrs. John Bradley (Florence Briggs Thayer) female 38  1     0    \n",
       "3 Heikkinen, Miss. Laina                              female 26  0     0    \n",
       "4 Futrelle, Mrs. Jacques Heath (Lily May Peel)        female 35  1     0    \n",
       "5 Allen, Mr. William Henry                            male   35  0     0    \n",
       "6 Moran, Mr. James                                    male   NA  0     0    \n",
       "  Ticket           Fare    Cabin Embarked\n",
       "1 A/5 21171         7.2500       S       \n",
       "2 PC 17599         71.2833 C85   C       \n",
       "3 STON/O2. 3101282  7.9250       S       \n",
       "4 113803           53.1000 C123  S       \n",
       "5 373450            8.0500       S       \n",
       "6 330877            8.4583       Q       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 11</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>PassengerId</th><th scope=col>Pclass</th><th scope=col>Name</th><th scope=col>Sex</th><th scope=col>Age</th><th scope=col>SibSp</th><th scope=col>Parch</th><th scope=col>Ticket</th><th scope=col>Fare</th><th scope=col>Cabin</th><th scope=col>Embarked</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>892</td><td>3</td><td>Kelly, Mr. James                            </td><td>male  </td><td>34.5</td><td>0</td><td>0</td><td>330911 </td><td> 7.8292</td><td></td><td>Q</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>893</td><td>3</td><td>Wilkes, Mrs. James (Ellen Needs)            </td><td>female</td><td>47.0</td><td>1</td><td>0</td><td>363272 </td><td> 7.0000</td><td></td><td>S</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>894</td><td>2</td><td>Myles, Mr. Thomas Francis                   </td><td>male  </td><td>62.0</td><td>0</td><td>0</td><td>240276 </td><td> 9.6875</td><td></td><td>Q</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>895</td><td>3</td><td>Wirz, Mr. Albert                            </td><td>male  </td><td>27.0</td><td>0</td><td>0</td><td>315154 </td><td> 8.6625</td><td></td><td>S</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>896</td><td>3</td><td>Hirvonen, Mrs. Alexander (Helga E Lindqvist)</td><td>female</td><td>22.0</td><td>1</td><td>1</td><td>3101298</td><td>12.2875</td><td></td><td>S</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>897</td><td>3</td><td>Svensson, Mr. Johan Cervin                  </td><td>male  </td><td>14.0</td><td>0</td><td>0</td><td>7538   </td><td> 9.2250</td><td></td><td>S</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 11\n",
       "\\begin{tabular}{r|lllllllllll}\n",
       "  & PassengerId & Pclass & Name & Sex & Age & SibSp & Parch & Ticket & Fare & Cabin & Embarked\\\\\n",
       "  & <int> & <int> & <chr> & <chr> & <dbl> & <int> & <int> & <chr> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 892 & 3 & Kelly, Mr. James                             & male   & 34.5 & 0 & 0 & 330911  &  7.8292 &  & Q\\\\\n",
       "\t2 & 893 & 3 & Wilkes, Mrs. James (Ellen Needs)             & female & 47.0 & 1 & 0 & 363272  &  7.0000 &  & S\\\\\n",
       "\t3 & 894 & 2 & Myles, Mr. Thomas Francis                    & male   & 62.0 & 0 & 0 & 240276  &  9.6875 &  & Q\\\\\n",
       "\t4 & 895 & 3 & Wirz, Mr. Albert                             & male   & 27.0 & 0 & 0 & 315154  &  8.6625 &  & S\\\\\n",
       "\t5 & 896 & 3 & Hirvonen, Mrs. Alexander (Helga E Lindqvist) & female & 22.0 & 1 & 1 & 3101298 & 12.2875 &  & S\\\\\n",
       "\t6 & 897 & 3 & Svensson, Mr. Johan Cervin                   & male   & 14.0 & 0 & 0 & 7538    &  9.2250 &  & S\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 11\n",
       "\n",
       "| <!--/--> | PassengerId &lt;int&gt; | Pclass &lt;int&gt; | Name &lt;chr&gt; | Sex &lt;chr&gt; | Age &lt;dbl&gt; | SibSp &lt;int&gt; | Parch &lt;int&gt; | Ticket &lt;chr&gt; | Fare &lt;dbl&gt; | Cabin &lt;chr&gt; | Embarked &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 892 | 3 | Kelly, Mr. James                             | male   | 34.5 | 0 | 0 | 330911  |  7.8292 | <!----> | Q |\n",
       "| 2 | 893 | 3 | Wilkes, Mrs. James (Ellen Needs)             | female | 47.0 | 1 | 0 | 363272  |  7.0000 | <!----> | S |\n",
       "| 3 | 894 | 2 | Myles, Mr. Thomas Francis                    | male   | 62.0 | 0 | 0 | 240276  |  9.6875 | <!----> | Q |\n",
       "| 4 | 895 | 3 | Wirz, Mr. Albert                             | male   | 27.0 | 0 | 0 | 315154  |  8.6625 | <!----> | S |\n",
       "| 5 | 896 | 3 | Hirvonen, Mrs. Alexander (Helga E Lindqvist) | female | 22.0 | 1 | 1 | 3101298 | 12.2875 | <!----> | S |\n",
       "| 6 | 897 | 3 | Svensson, Mr. Johan Cervin                   | male   | 14.0 | 0 | 0 | 7538    |  9.2250 | <!----> | S |\n",
       "\n"
      ],
      "text/plain": [
       "  PassengerId Pclass Name                                         Sex    Age \n",
       "1 892         3      Kelly, Mr. James                             male   34.5\n",
       "2 893         3      Wilkes, Mrs. James (Ellen Needs)             female 47.0\n",
       "3 894         2      Myles, Mr. Thomas Francis                    male   62.0\n",
       "4 895         3      Wirz, Mr. Albert                             male   27.0\n",
       "5 896         3      Hirvonen, Mrs. Alexander (Helga E Lindqvist) female 22.0\n",
       "6 897         3      Svensson, Mr. Johan Cervin                   male   14.0\n",
       "  SibSp Parch Ticket  Fare    Cabin Embarked\n",
       "1 0     0     330911   7.8292       Q       \n",
       "2 1     0     363272   7.0000       S       \n",
       "3 0     0     240276   9.6875       Q       \n",
       "4 0     0     315154   8.6625       S       \n",
       "5 1     1     3101298 12.2875       S       \n",
       "6 0     0     7538     9.2250       S       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#Import train and test dataset\n",
    "train <- read.csv(\"../input/titanic/train.csv\")\n",
    "test <- read.csv(\"../input/titanic/test.csv\")\n",
    "\n",
    "#Ensure dataset loaded correctly\n",
    "head(train)\n",
    "head(test)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "0b84ea55",
   "metadata": {
    "papermill": {
     "duration": 0.029927,
     "end_time": "2022-01-08T02:21:10.538588",
     "exception": false,
     "start_time": "2022-01-08T02:21:10.508661",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Let's factorise some of the columns so that we have a better understanding on the number of variables we are working with."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "eb729fc0",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-08T02:21:10.605226Z",
     "iopub.status.busy": "2022-01-08T02:21:10.603054Z",
     "iopub.status.idle": "2022-01-08T02:21:10.671581Z",
     "shell.execute_reply": "2022-01-08T02:21:10.669675Z"
    },
    "papermill": {
     "duration": 0.103161,
     "end_time": "2022-01-08T02:21:10.671693",
     "exception": false,
     "start_time": "2022-01-08T02:21:10.568532",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t891 obs. of  12 variables:\n",
      " $ PassengerId: int  1 2 3 4 5 6 7 8 9 10 ...\n",
      " $ Survived   : Factor w/ 2 levels \"0\",\"1\": 1 2 2 2 1 1 1 1 2 2 ...\n",
      " $ Pclass     : Factor w/ 3 levels \"1\",\"2\",\"3\": 3 1 3 1 3 3 1 3 3 2 ...\n",
      " $ Name       : chr  \"Braund, Mr. Owen Harris\" \"Cumings, Mrs. John Bradley (Florence Briggs Thayer)\" \"Heikkinen, Miss. Laina\" \"Futrelle, Mrs. Jacques Heath (Lily May Peel)\" ...\n",
      " $ Sex        : Factor w/ 2 levels \"female\",\"male\": 2 1 1 1 2 2 2 2 1 1 ...\n",
      " $ Age        : num  22 38 26 35 35 NA 54 2 27 14 ...\n",
      " $ SibSp      : int  1 1 0 1 0 0 0 3 0 1 ...\n",
      " $ Parch      : int  0 0 0 0 0 0 0 1 2 0 ...\n",
      " $ Ticket     : chr  \"A/5 21171\" \"PC 17599\" \"STON/O2. 3101282\" \"113803\" ...\n",
      " $ Fare       : num  7.25 71.28 7.92 53.1 8.05 ...\n",
      " $ Cabin      : chr  \"\" \"C85\" \"\" \"C123\" ...\n",
      " $ Embarked   : Factor w/ 4 levels \"\",\"C\",\"Q\",\"S\": 4 2 4 4 4 3 4 4 4 2 ...\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "  PassengerId    Survived Pclass      Name               Sex     \n",
       " Min.   :  1.0   0:549    1:216   Length:891         female:314  \n",
       " 1st Qu.:223.5   1:342    2:184   Class :character   male  :577  \n",
       " Median :446.0            3:491   Mode  :character               \n",
       " Mean   :446.0                                                   \n",
       " 3rd Qu.:668.5                                                   \n",
       " Max.   :891.0                                                   \n",
       "                                                                 \n",
       "      Age            SibSp           Parch           Ticket         \n",
       " Min.   : 0.42   Min.   :0.000   Min.   :0.0000   Length:891        \n",
       " 1st Qu.:20.12   1st Qu.:0.000   1st Qu.:0.0000   Class :character  \n",
       " Median :28.00   Median :0.000   Median :0.0000   Mode  :character  \n",
       " Mean   :29.70   Mean   :0.523   Mean   :0.3816                     \n",
       " 3rd Qu.:38.00   3rd Qu.:1.000   3rd Qu.:0.0000                     \n",
       " Max.   :80.00   Max.   :8.000   Max.   :6.0000                     \n",
       " NA's   :177                                                        \n",
       "      Fare           Cabin           Embarked\n",
       " Min.   :  0.00   Length:891          :  2   \n",
       " 1st Qu.:  7.91   Class :character   C:168   \n",
       " Median : 14.45   Mode  :character   Q: 77   \n",
       " Mean   : 32.20                      S:644   \n",
       " 3rd Qu.: 31.00                              \n",
       " Max.   :512.33                              \n",
       "                                             "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "train$Survived <- factor(train$Survived)\n",
    "train$Pclass <- factor(train$Pclass)\n",
    "train$Sex <- factor(train$Sex)\n",
    "train$Embarked <- factor(train$Embarked)\n",
    "\n",
    "str(train)\n",
    "summary(train)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "65a2de69",
   "metadata": {
    "papermill": {
     "duration": 0.031329,
     "end_time": "2022-01-08T02:21:10.735393",
     "exception": false,
     "start_time": "2022-01-08T02:21:10.704064",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## 2.3 Feature Engineering & Hypothesis Building\n",
    "Let's look at the variables and see if we can come up with any hypothesis which may impact the probability of survival for our prediction.\n",
    "* PassengerId - this is just a unique passenger id which should be independent to the survival rate\n",
    "* Survived - this is the label (actual result) which we will use to train our model\n",
    "* Pclass - the ticket class of the passenger, which is a proxy to their socio-economic status, it might be possible for a higher proportion of rich people to survive than poor people\n",
    "* Name - we could technically extract out Mr., Mrs., Miss. and other pronouns, but I think we would have enough information based on the other variables\n",
    "* Sex - Male vs Female, from the movie, I remember they prioritised women and children safety 1st, so let's explore and see if it's true and how significant is the difference\n",
    "* Age - on one hand, more younger people maybe have been given priority as they have their futures ahead of them, on the other hand, more older people maybe have been given priority due to their dependents\n",
    "* SibSp & Parch - having dependents onboard maybe either mean the whole family survives together or some of them having to make sacrifices, we can combine them into another variable called Dependents and explore them separately as well\n",
    "* Ticket - the structure of the ticket number is unknown to me so it will be unlikely that we can extract any useful information from it\n",
    "* Cabin - we maybe able to see whether there is a higher probability of survival based of the location or deck number, however, based on the first 6 rows of both the training and testing dataset, it appears that there are a lot of missing data and there is no way to impute the cabin number as there are no connections or linkages to those that do. This might cause some distortion in the prediction so let's exclude this out\n",
    "* Embarked - the embarking port is unlikely to have any correlation on the survival rate but let's explore a bit in case I'm wrong\n",
    "\n",
    "All in all, we will be excluding out PassengerId, Name, Ticket and Cabin."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "7803f34a",
   "metadata": {
    "papermill": {
     "duration": 0.03178,
     "end_time": "2022-01-08T02:21:10.798580",
     "exception": false,
     "start_time": "2022-01-08T02:21:10.766800",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## 2.4 Missing Data\n",
    "Before we proceed with our exploratory data analysis, let's create a new training dataset by removing the variables we don't need, adding in the new \"Dependents\" variable and make sure that there aren't any missing data."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "e30b30ec",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-08T02:21:10.870185Z",
     "iopub.status.busy": "2022-01-08T02:21:10.868069Z",
     "iopub.status.idle": "2022-01-08T02:21:10.941341Z",
     "shell.execute_reply": "2022-01-08T02:21:10.940080Z"
    },
    "papermill": {
     "duration": 0.110552,
     "end_time": "2022-01-08T02:21:10.941438",
     "exception": false,
     "start_time": "2022-01-08T02:21:10.830886",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 8</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Survived</th><th scope=col>Pclass</th><th scope=col>Sex</th><th scope=col>Age</th><th scope=col>SibSp</th><th scope=col>Parch</th><th scope=col>Fare</th><th scope=col>Dependents</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0</td><td>3</td><td>male  </td><td>22</td><td>1</td><td>0</td><td> 7.2500</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1</td><td>1</td><td>female</td><td>38</td><td>1</td><td>0</td><td>71.2833</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1</td><td>3</td><td>female</td><td>26</td><td>0</td><td>0</td><td> 7.9250</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1</td><td>1</td><td>female</td><td>35</td><td>1</td><td>0</td><td>53.1000</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>0</td><td>3</td><td>male  </td><td>35</td><td>0</td><td>0</td><td> 8.0500</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0</td><td>3</td><td>male  </td><td>NA</td><td>0</td><td>0</td><td> 8.4583</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 8\n",
       "\\begin{tabular}{r|llllllll}\n",
       "  & Survived & Pclass & Sex & Age & SibSp & Parch & Fare & Dependents\\\\\n",
       "  & <fct> & <fct> & <fct> & <dbl> & <int> & <int> & <dbl> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 0 & 3 & male   & 22 & 1 & 0 &  7.2500 & 1\\\\\n",
       "\t2 & 1 & 1 & female & 38 & 1 & 0 & 71.2833 & 1\\\\\n",
       "\t3 & 1 & 3 & female & 26 & 0 & 0 &  7.9250 & 0\\\\\n",
       "\t4 & 1 & 1 & female & 35 & 1 & 0 & 53.1000 & 1\\\\\n",
       "\t5 & 0 & 3 & male   & 35 & 0 & 0 &  8.0500 & 0\\\\\n",
       "\t6 & 0 & 3 & male   & NA & 0 & 0 &  8.4583 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 8\n",
       "\n",
       "| <!--/--> | Survived &lt;fct&gt; | Pclass &lt;fct&gt; | Sex &lt;fct&gt; | Age &lt;dbl&gt; | SibSp &lt;int&gt; | Parch &lt;int&gt; | Fare &lt;dbl&gt; | Dependents &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0 | 3 | male   | 22 | 1 | 0 |  7.2500 | 1 |\n",
       "| 2 | 1 | 1 | female | 38 | 1 | 0 | 71.2833 | 1 |\n",
       "| 3 | 1 | 3 | female | 26 | 0 | 0 |  7.9250 | 0 |\n",
       "| 4 | 1 | 1 | female | 35 | 1 | 0 | 53.1000 | 1 |\n",
       "| 5 | 0 | 3 | male   | 35 | 0 | 0 |  8.0500 | 0 |\n",
       "| 6 | 0 | 3 | male   | NA | 0 | 0 |  8.4583 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "  Survived Pclass Sex    Age SibSp Parch Fare    Dependents\n",
       "1 0        3      male   22  1     0      7.2500 1         \n",
       "2 1        1      female 38  1     0     71.2833 1         \n",
       "3 1        3      female 26  0     0      7.9250 0         \n",
       "4 1        1      female 35  1     0     53.1000 1         \n",
       "5 0        3      male   35  0     0      8.0500 0         \n",
       "6 0        3      male   NA  0     0      8.4583 0         "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Creating new data set\n",
    "train.data <- dplyr::select(train,-PassengerId,-Name,-Ticket,-Cabin,-Embarked)\n",
    "\n",
    "#Creating a new variable called Dependents\n",
    "train.data$Dependents <- train.data$SibSp + train.data$Parch\n",
    "head(train.data)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "1e773ee0",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-08T02:21:11.015303Z",
     "iopub.status.busy": "2022-01-08T02:21:11.012942Z",
     "iopub.status.idle": "2022-01-08T02:21:11.379502Z",
     "shell.execute_reply": "2022-01-08T02:21:11.379040Z"
    },
    "papermill": {
     "duration": 0.404332,
     "end_time": "2022-01-08T02:21:11.379601",
     "exception": false,
     "start_time": "2022-01-08T02:21:10.975269",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\nYBQWlg6vN6gjIpf/9+GVn2dV6nQiEji8yT30UMt+8KR/Hr9wJXPf5lkpo576W1Nbyxvpkbbq\n2saPhvdccPxea/55dWvf+Gfz6smrhuWVJVl/pls7zxsL7CwsLNdt2Pib1qx8+0YdM/0yd/83\n1VVeim4dl368SESavf5x7tXcvdvS/jEjpXcb5zv0f73kxxq52+UfL1e/sKxd192a/2ABd8Hc\ni/wAqESNhfY6nW7fzZPPJicGV79YdKFYp9PdzeaJyrIzB28qvrlz8/rV81tWzgm0uzHx5x68\n7J5q/uYH6X59KInhN6osy9ZX7rr9XHXh2z6O1SX29V+sMqi8+ZXH9JV/87iTO/d85ef39SWb\nf70DtDQ/98KFCxcuXMjNLzPeL6Ps3/Ry9q3DX/6TX6rvcO+IkNt/JcPNE+P+m2/w+VXDbv7a\nTn6T7hAnAD3+DxAAY2k06MbsZMrcLBGxtPF8sa7dXbYtK9rQ8qZBX9xYmGVVp37U073Dbq7o\nsvV0v6eaiohLvDFAVfzLsu5j/12q1YmufOfCET3++acGBR0aDP/bzcsbhicuu7miTy5nrWns\n2eCRRx555JFHnln+PzH3L3OXf9Oqiov615+tvTGWeX73kj7z/2Bc8/0OMf86fE5Eqsry5w59\nYt7ZK9XlT06Nu6c4gYeXuTNLACpx++jO9eJjtQwOAXEJmF5d8+6OO6mMqaufnbQICGsXExvb\nJSrS08H6ZmGtKccK77GmAiN2laWnWjrc2nBgZevhZlvz0u37GLHT6XQnP++vL3QNbBvX/6Ve\n3drVsbzxf78dfJ4uuHFgiVF+GWX/puWXd1vXulWtYXCLpgGelr8+e/lU6Y3f/9Y5dhY3AqtT\n19PWoHkdr2cvV97pvD0AeiR2AJRxexKg0+mecb81nNPsnYzqwrs8x+5S1udNfucGUguLWrET\nNuo/+u5r/vnETqfT5R34RwObmocS93pngP71/SV2Op1uZdJT8lvcmvT+rvDW/KwxfhnF/6b/\nGdpMfq22w2Pj5z6tf9vn08zqtgY3T/Sa3s23RiuNW6vN54vvHCcAPaZiARjRoPBb/73/24t+\nd6h5O6fAuEPnjy+Y/Gb0E+FeHs4aa0srG7u6vo9FPz/s8+2n1ozrch81FeHecshPJ7aP+PtT\nvvVcrGrb+TR58r1/f//p0OZ/vuc+k78+tXP54Gc7N3zE3cZa08Av6Mkuz0z5JC3nv6vauNzK\n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\nESN/a6CDQbfubmzXqCYWAv7sa5VsV8Gy+6mL+TyexUCfB20yhULRUnV0wgg7Ho8fduIu26Wp\nXENZ2sIpPhMi8jpflhxZ2bsbn4i0RWbz1p1itzY1w56OGruP3a+4u2E77thpiv171i5euLbD\n2n36hNHWPfSbq+5npxy+UusU8c7YB0V5h46cGf7BD2ejh7JdJvPqbm9Z8dENIvrXv/41/s25\n5t1+8zgZT0vgFrQydNzvn7bhoPMx46acGfZzToyept2eUTK/d/d0j00/f7NA6edA8UVwn0Xn\nRjb+spe1slSvpfLMS1avVhk7zXr/y52LX+5oKept2E/Wd8qm1a+VntuxdkfWu+cebH3FnO0y\n1cTPRFSz4vu8yCHShh8EBp6dfwdv/Wuk6zJ5a/0FtqtTB2MdvvcPD78e0qOtPkNo5P3x/Yal\nlt1rCt/o4fpdh7SK7erUIe+D4cMSbq3cljzHm/9S3wCFQnEzJSlw6uLuC89d2+zFdnV/C4Kd\npvjiVZuVTfNKzkXrdv1Rl7cmjHX4dsjBC+tHPTjzru2klMbmMgF3/+J7eHhsO5s9uLvmPlK2\nY8eOC1/EHv/Faso4j97Gehq4IJSIDHX4468+OthPrNxYc+stM5dvZB2P2apKDY4G2MzOH3zz\n3hFbIZ+ISo/4Oc44d/JR46umQiJKdO+5pnF5deEKtstUEyMdfuCNqs+djJWDXW3xPFPnL2Ud\nGrGfn7lAe2i25NiwXmVfv9on+Gp9ywM9Ld4vP0yyGPW9rL2G7erUgcPhHsFOU5gLtMfkVxx4\n6u9ZYUjPwTntzcUKWb2WttHvH0HjHnm7tF3+9M+8QMDxr7qTnZ3dH3WVlZWpsxIWeRkJZfFX\nLrzzsnJj0U4vtxWyF/23+bN5Ggq1NlzLWfDkdPODw3ovfDD9sWRL58ufD45xnvdQ2vzn56Nz\nw6yeevmBB4p2TVL+o/79igH+e+ybq46xXZ06fOLZO7pu/MGt47cHv3nJYfvDC2+2VN1eMWr4\n549nP5Yksl2dOnA43Gv6Y9Saw0yHf/+HKvptsKu+fIfH0yaijpZiIjLgc3nXi8Z7J6e++m7a\nzfuy3/1jRkP+eaM56e0ZPnpnwMilPmv09oZO9zHT1ZY2Vp8/uevN9y46LTrHdmmqdb2pfZyn\n6b9fKdYX1NjMm9XVq2erJ5M+vVkrh2nyno6dsI/dkw3bd01SbuTGhu0Idppi26L+r7z7yge8\n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\nAAAQiP8DX5fbH8BmMrQAAAAASUVORK5CYII="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "#Check for missing data using Amelia package\n",
    "Amelia::missmap(train.data, legend = F)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "14069f1b",
   "metadata": {
    "papermill": {
     "duration": 0.037273,
     "end_time": "2022-01-08T02:21:11.453774",
     "exception": false,
     "start_time": "2022-01-08T02:21:11.416501",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Looks like everything is in order except for the Age variable, for imputing this data, let's perform some EDA and see whether there are any defining variables that can be used to estimate the missing age."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 5.110004,
   "end_time": "2022-01-08T02:21:11.599912",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-01-08T02:21:06.489908",
   "version": "2.3.3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
