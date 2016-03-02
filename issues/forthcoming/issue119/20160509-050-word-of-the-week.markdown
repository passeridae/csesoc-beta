---
title: Words of the Week
---

Words of the Week
=================

Every week, we bring you the latest and greatest in Jargon, be it obscure or otherwise. Where does this Jargon come from, you ask? Why, the Jargon Files of course, the internet's favourite place for all things *hacker*. Have fun! These weeks words are:


**lint**: [from Unix's lint(1), named for the bits of fluff it supposedly picks from programs] 

1. vt. To examine a program closely for style, language usage, and portability problems, esp. if in C, esp. if via use of automated analysis tools, most esp. if the Unix utility lint(1) is used. This term used to be restricted to use of lint(1) itself, but (judging by references on Usenet) it has become a shorthand for any exhaustive review process at some non-Unix shops, even in languages other than C. Also as v. delint. 
2. n. Excess verbiage in a document, as in “This draft has too much lint”.


**fudge factor**: [common] A value or parameter that is varied in an ad hoc way to produce the desired result. The terms tolerance and slop are also used, though these usually indicate a one-sided leeway, such as a buffer that is made larger than necessary because one isn't sure exactly how large it needs to be, and it is better to waste a little space than to lose completely for not having enough. A fudge factor, on the other hand, can often be tweaked in more than one direction. A good example is the fuzz typically allowed in floating-point calculations: two numbers being compared for equality must be allowed to differ by a small amount; if that amount is too small, a computation may never terminate, while if it is too large, results will be needlessly inaccurate. Fudge factors are frequently adjusted incorrectly by programmers who don't fully understand their import. See also coefficient of X.


**dread questionmark disease**: The result of saving HTML from Microsoft Word or some other program that uses the nonstandard Microsoft variant of Latin-1; the symptom is that various of those nonstandard characters in positions 128-160 show up as questionmarks. The usual culprit is the misnamed ‘smart quotes’ feature in Microsoft Word. For more details (and a program called demoroniser that cleans up the mess) see http://www.fourmilab.ch/webtools/demoroniser/.

