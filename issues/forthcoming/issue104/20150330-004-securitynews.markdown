---
title: Exciting Security News #0
author: Andrew Bennett
---

\endmulticols\LRmulticolcolumns\vfill\pagebreak

Exciting Security News™
=======================

\begin{center}
{\large\it In this new column, we look at what has gone wrong with
  information security in the real world.}
\end{center}
\multicols{2}

Today on Exciting Security News™, we look at how the NSA have, once
again, secretly taken over the world; this time, through undetectable
malware on hard drive firmware.

It sounds pretty crazy, but strangely enough, this sort of thing is
actually possible.  Researchers at Kaspersky Labs discovered some
interesting viruses that they hadn't seen before, which could do a lot
of powerful and scary things.  As their investigations unfolded, they
discovered that the scope of the situation was a lot greater than
they'd first suspected---this was one of the most "sophisticated
cyber attacks" they'd ever encountered.  They dubbed the group behind
this malware the "Equation Group", due to their use of complex
encryption algorithms.

The general pattern of these viruses followed one similar to that seen
in Stuxnet, a carefully targeted piece of malware aimed at air-gapped
nuclear fuel refinement systems in the Middle-East, and one that is
already strongly suspected to have originated in the US NSA.

In fact, the Kaspersky team had uncovered a new family of viruses that
not only predated Stuxnet by a significant time, but which utilised
the same attack vectors as Stuxnet did.

Stuxnet, and the newly-discovered Equation Group family, both tapped
into the vast reservoir of attacks based on security vulnerabilities
that were, at the time of their discovery, otherwise unknown and
unfixed.  These attacks, dubbed 0-day attacks, are an incredibly
potent threat to just about all software, because the vulnerabilities
they leverage cannot be rectified until developers are aware of them.
A black market exists in 0-day vulnerabilities, and good examples are
often able to fetch a hefty sum of money.

There's lots of different pieces to the puzzle---the various viruses
can chain on top of each other, depending on what they're trying to
do.  There's an initial virus, dubbed "DoubleFantasy", which creates a
backdoor in a target's computer, at which point they determine whether
the victim is "interesting".  If they are, they carry out further
attacks.

The next step is "EquationDrug", "TripleFantasy", or "GrayFish", which
are a series of malware platforms designed for having complete control
over a victim's computer.  EquationDrug and TripleFantasy are scary
enough, with their ability to completely control a computer remotely;
but the last of these, GrayFish, is about as scary as it gets.

GrayFish is an almost completely undetectable virus, which becomes the
puppet-master of the operating system, effectively taking over how the
entire system works, dictating how every step is taken, and making
malicious changes wherever it sees fit.  It's practically impossible
to detect, since it controls how the entire OS is run, and hence it
can just hide the fact that it's doing anything at all if you're
trying to detect it.

It gets scarier, though.  It's also able to infect the firmware of a
hard drive---the piece of software that runs on the hard drive at the
lowest level and tells the computer how to read the data from the disk
itself.  Being able to infect this is Very Bad News.  Once the
firmware of the hard drive is infected, it's pretty much game over.
The firmware tells the operating system about how to access the data
from the disk, and so it can just skip over what it tells the OS to
selectively hide whatever it wants to.  To make things worse, while
you can change a hard drive's firmware, there's no easy way to read
the firmware back, so you can't even tell whether the firmware has
been messed with.  In other words, the NSA are literally hiding inside
hard drives, in a way that's nearly impossible to detect.

Conceptually similar attacks also work not only against conventional
spinning-rust hard disks, but also solid-state drives, and flash
memory in general, which tend to maintain software-managed "bad block"
tables.  So, although it hasn't yet been seen there, mobile phones and
tablets are just as vulnerable, too.

Of course, it hasn't been officially confirmed that the NSA are behind
this---they wouldn't want to own up to such a thing.  But there have
been strong suspicions from various security researchers, as well as
ex-NSA employees confirming the source.

As for the implications for us---well, there's _some_ good news.
While these viruses are extremely powerful, stealthy, and dangerous,
they don't seem to be targeting the average computer user.  So, unless
you've pissed the NSA off in a pretty big way, your hard drives and
operating systems are probably safe.

For now.

\byline{Andrew~Bennett}

\begin{center}
{\it Join us for our next episode of Exciting Security News™,\\
  where we look at how leaving off curly-brackets from single line
  \texttt{if} statements can turn into a global security crisis.}
\end{center}
