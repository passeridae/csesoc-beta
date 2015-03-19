
\endmulticols\LRmulticolcolumns\vfill\pagebreak

\LaTeX: a document preparation system
=====================================

\begin{center}
{\large\it $\ldots$ and why it should matter to you.}
\end{center}
\multicols{2}

One thing that you'll likely come across (or certainly come across, if
you do algos) during your time in computing is \LaTeX.  Like so many
other things in industry, academia, and computing, there is no mention
of it until there is an expectation that you already know the program.
So what is \LaTeX?

At its core, \LaTeX\ is a program that allows you to create documents
for other people to read (in fact, this document it rendered in
\LaTeX!).  In that respect it is similar to Word, but that's about the
only way.  Unlike Word or its analogues, which require a specific
program to be run, \LaTeX\ document generation generally starts with
any old text editor (from Vim, to gedit to something more
specialised), which is used to edit a \LaTeX\ source file (a `.tex`
file).  This source file is then run through the \LaTeX\ program to
convert it to a document format, e.g. PDF.  At this stage you're ready
to send the finished product to whoever you like (or reformat it if
you realise that you've made a terrible mistake).

The biggest difference between Word and \LaTeX\ is the presence (or
rather, absence) of a GUI.  Word is all about making things pretty,
and letting you see it, as soon as you write them, whereas in \LaTeX\
you write things, and only once you've converted it do you see the
finished product.  This is a mixed blessing; it allows \LaTeX\ to be
more flexible (want to change the spacing? Change the flags for the
conversion process), but less obviously usable to an audience unused
to it.  The various pros and cons are discussed later in this article.


What's in a name?
-----------------

\LaTeX's name is, really, one of the most frustrating things about it.
As well as making it hard to Google without bringing up results full
of fetish gear, the pronunciation will drive you crazy while you're
getting used to it (though I'll talk more about that later).  But at
least it isn't called Elm like everything else seems to be.

Typography
:    Using a generally infeasible combination of capitalization, font
     sizing, and baseline offsetting, \LaTeX\ is often (and
     officially) written: \LaTeX.  There is a reason for this bizarre
     arrangement of letters, I promise; its in part to distinguish it
     from the aforementioned rubber-like substance, but mostly to show
     off what is possible in \LaTeX.  If this were a Word document,
     that would have to be an embedded image; so much more frustrating
     to work with.  (Of course, if you can't do that, `LaTeX` works
     just fine, but doesn't look nearly as good.)

Pronunciation
:    This is a make-or-break thing in certain groups (I know, it's
     absolutely stupid); the generally accepted pronunciation is
     "_LAH-tek_".  Whatever you do, don't pronounce the second
     syllable "_teks_", or call it latex.  It is not a rubbery
     substance, and Knuth may jump down from the ceiling and glare at
     you.

Etymology
:    Like so many other things, it was Donald Knuth who first created
     "\TeX" (the three characters actually being uppercase Greek tau,
     epsilon, and chi).  This Greek forms the root of English words
     like "technical" and "technique", and the choice to group
	 \TeX\ with this was a conscious one.  Later, Leslie Lamport built
     "\LaTeX" on top of \TeX, presumably prepending "La" because
     "Lamport's \TeX" was too long.

\begin{center}
\includegraphics[trim=0mm 0mm 0mm 0mm, clip, width=0.8\linewidth]{images/ctan_lion_600.png}\\
{\it The mascot of \TeX\ and \LaTeX; drawing by Duane~Bibby}
\end{center}

Pros of \LaTeX{}
----------------

So now we have a brief idea of what \LaTeX\ is, why do people use it?

Typogaphic quality
:    A great reason to use \LaTeX\ (aside from all the other pros in
     this list) is that it produces beautiful documents.  You can fine
     tune your line spacings, the inbuilt fonts are professional The
     main reason I use \LaTeX\ is it produces output that is,
     typographically, far better than any of the alternatives.
     \LaTeX\ has excellent built-in fonts, good algorithms for
     automatic spacing, and the ability to fine-tune the spacing
     arbitrarily.  Bad typography gives a bad first impression, and
     reflects poorly on the content of a document.

Portability
:    \LaTeX\ is the single most portable document creation system of
     them all, running on just about every operating system in
     existence.  Comparatively, Microsoft Word only works on Windows
     and Mac, and even OpenOffice runs on all Unix breeds.

Version control
:    Because `.tex` files are plain text, you can use Git, diff and a
     variety of other tools to look at the change history.  Far easier
     than the complex systems (or lack thereof!) used elsewhere.

Document longevity
:    \LaTeX\ documents are functionally timeless: those written 10 years
     ago still work and still produce (mostly) the same output as they
     did at the start.  By contrast, Word documents are typically
     useful only for 3--4 years, before they stop working properly on
     new versions.

Mathematical typesetting
:    Unlike other systems, maths can be input inline, and doesn't skew
     line width formatting.  Beautiful.

     _(Seriously, have you tried Word's "Equation" "Editor"?
     Abominable.  ---Ed.)_

Macros
:    \LaTeX\ lets me define macros, canned sequences of text and/or
     markup, that I can then use repeatedly.  It's much better than
     copy-and-paste, since it can be changed by changing just the
     definition, plus I don't have to find the original each time.

Peer pressure
:    In academic publishing (my data is, admittedly, limited to
     computer science and physics) you're often not taken seriously
     unless you use \LaTeX.  As far as incentives go to use \LaTeX,
     that's often the strongest of them all.


Cons of \LaTeX{}
----------------

So given all of the great things about \LaTeX, why doesn't everyone
use it?

Fragmentation
:    Writing a document with \LaTeX\ means using an editor,
     \LaTeX\ itself, a document previewer, and usually a few other
     assorted programs.  In contrast, Word and other such programs are
     self contained.

Learning curve
:    Learning markup commands takes time, and can initially be a
     really frustrating endeavour (like learning any new programming
     language).  I'd recommend using a helpful GUI to start, before
     moving on to vim or similar---if you want.  Some of the GUIs are
     great to stay with forever.

Preview delay
:    There's a delay between typing something in the editor and seeing
     the result in the document previewer; depending on how often you
     preview, this can be a long or short gap and more or less
     frustrating.

Syntax errors
:    Like in all programming languages, it's absolutely possible to
     create a `.tex` file that \LaTeX\ will reject, complaining of a
     syntax error (and aren't they just your favourite).
     Unfortunately, the errors are often cryptic, and take some
     headbanging to fix.  There's definitely a learning curve in
     dealing with them!

Overall, I'd recommend using \LaTeX, because once you're over the
initial frustration with it, it's a highly useful skill to have.
Programs such as \TeX studio (available for all OSes) are a nice
combination of helpful but not coddling, and take a lot of the more
frustrating guesswork out of the process.  So write an assignment in
\LaTeX\ this sem, or convert an old project into \LaTeX\ as an
experiment.  Though it will probably be frustrating, it will
(probably) wind up being fun, and look amazing.

`\end{document}`

\byline{Emily~Saunders~Walmsley}
