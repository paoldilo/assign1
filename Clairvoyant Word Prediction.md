
Clairvoyant Word Prediction
========================================================
author: P. Di Lorenzo, Rome, Italy
date: 16/07/2016
autosize: true
css: bootstrap.css


Introduction
========================================================

<body>
<div class="body" align="justify">
<p>This pitch presents the work done for the final capston of the Coursera Data Science Specialization. The goal of the project is to predict the next word of a sentence given a partial sentence.<br></p><br>
 
<p>The shiny application developed for this pourpose is available here:  <br> 
<a href="https://paoldilo.shinyapps.io/Clairvoyant/" target="_top"/>Link to Clairvoyant Shiny Application</a>   <br><br>
In the next slides I will briefly present the following items:</p>
<ol>
     <li align="justify"> How I built up the prediction dictionary from the sources available</li>
     <li align="justify">How I summarized the dictionary to make it small enough and associated probability values to words</li> 
     <li align="justify">The way the next word is chosen and presented in the application</li>
</ol>
<br><br>
<p>The main references for my work are the following articles:</p>
<ul>
<li align="justify"> <i>"Text Mining Infrastructure in R"</i> - Feiner,Hornik, Meyer, J. of statistical software, 2008</li>
<li align="justify">  <i>"Speech and Language Processing"</i> -Jurafsky, Martin, Ch. 4, 2014</li>
<li align="justify">  <i>"Good-Turing Smoothing Without Tears"</i> - William A. Gale, Journal of Quantitative Linguistics, 1995</li>
</ul></div>
<body>

Building the dictionary
========================================================

<body>
<div class="body" align="justify">
<p>The training collection was way too big for the memory of my laptop so I splitted the "news",
"blogs" and "twitter" files in 4 and sampled 50% of the lines of each file.<br></p>
<p>The lines of text uderwent the following transformation, used to normalize the samples:</p>
<ul>
     <li align="justify"> Transform to lowercase</li>
     <li align="justify"> Remove Punctuation and special character (/,@,\,#,€,£,$,')</li>
     <li align="justify"> Remove numbers</li>
     <li align="justify"> Remove unnecessary white spaces</li>
</ul>
<br><br>
<p>On each file the n-gram tokenize was applied using the RWeka package, in particular it was used a 2,3 and 4-gram tokenizer. The various Term document Matrices obtained for 2,3 and 4-grams were merged toghether using data.table functions to speed up processing thus finally obtaining 3 different dictionaries each with:</p>

<ul>
     <li align="justify"> 2-gram dictionary -> ``6618594`` entries</li>
     <li align="justify"> 3-gram dictionary -> ``13114478`` entries</li>
     <li align="justify"> 4-gram dictionary -> ``16754569`` entries</li>
</ul>
<br><br>
<p>To reduce the size of the dictionaries, lower memory storage space and speed up computation time,  <u>only n-grams with 2 or more observerd occurence</u> were used for 3-grams and 4-grams dictionaries.</p>
</div>
<body>

Summarizing the dictionary 
========================================================

<body>
<div class="body" align="justify">
<p><small>Each dictionary was then smoothed using a Good Thuring Model, making it possible to estimate a linear model for the probability associated with the n-gram based on its occurrence, this was used as a baseline for the overall accuracy of the predicion.</small><br></p>
<p><small>Instead of using three different dictionaries creating a backoff model of recurring to lower n-gram in case the higher lenght n-gram was not found I used a merged dictionary suggested by the "Speech and Language processing" book mentioned before.</small></p><br>
<p><small>I collapsed all the dictionaries using the most "right" word of the n-gram as a key to merging the dictionaries and adding up the logarithm of the Good-Thuring model probabilities, weighted down by the lenght of the n-gram (that is 100% for 4-grams, 75% for 3-grams and 50% for 2-grams).<br> This means that longer n-gram match have higher probability of predicting the next word.<br></small></p>


   <br>
<p> <small>The final dictionary is made up of 1318472 entries and it's almost 15Mb compressed. As an example the n-grams with the higher associated probability values are:</small></p>
<br>
</div>
<body>

```
            W1  W2 W3  W4     Value
1544922     is one of the 0.2868093
1102143 spring  is in the 0.2744415
1098035   love  is in the 0.2741394
1103340  proof  is in the 0.2739900
1103158  devil  is in the 0.2739893
```


Predicting the next word
========================================================

<body>
<div class="body" align="justify">
<p><br>The word prediction process is quite straightforward and performs the following workflow:</p><br>
<ul>
     <li align="justify"> The shiny app unzips and loads into memory, upon startup, the n-gram dictionary;</li>
     <li align="justify"> When a new sentence is written in the text field, it reads the sentence and performs the same cleaning process described in the previous slides (lowercase, punctuation, numbers, etc.);</li>
     <li align="justify"> It splits the sentence in words;</li>
     <li align="justify"> Starting from the last word in the sentence tries to find the longest available n-gram in the dictionary;</li>
     <li align="justify"> When the longest n-gram is found, the dictionary is subsetted with the n-gram and the subset is ordered by probability value;</li>
     <li align="justify"> The higher probability value word is returned as prediction, in case more than one word have the same value the first n-gram is returned;</li>
     <li align="justify"> If the first word (unigram) is not found within the dictionary (unknown word) the word with the highest probability inside the dictionary is returned (it is the conjunction "the" in my dictionary).</li>
</ul><br>
<br>
<p>The application shows the predicted sentence and the final table showing the n-gram the result was selected from and it's available here:</p>
<p><a href="https://paoldilo.shinyapps.io/Clairvoyant/" target="_top"/>Link to Clairvoyant Shiny Application</a></p>

</div>
<body>

