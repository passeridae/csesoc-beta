---
title: Exciting Security News #1
author: Andrew Bennett
---

\endmulticols\LRmulticolcolumns\vfill\pagebreak

Exciting Security News™
=======================

\begin{center}
{\large\it In this column, we look at what has gone wrong with
  information security in the real world.  This week: the best
  crossword of all time.}
\end{center}
\multicols{2}

In late 2013, Adobe's database was hacked, and over 150 million user
records were leaked.  This is one of my favorite password leaks ever,
for several reasons: partially because of the magnitude of the
breach, but also from the unintended consequences of Adobe's mistakes. 

First up, let's look at what they did wrong, and what you can do to do
it right.

Bird is the Word
----------------

If you ever need to store usernames and passwords---if, say, you're
building a website---and you just stored this data as is:

    {username: "Alice1970", password: "hunter2"}

You'd be able to extract everybody's passwords.  If this database was
compromised, you have credentials for a large number of people, which,
understandably, is a Very Bad Thing™.

People often reuse passwords, not just usernames; a sad fact of life.
With a (large enough) username/password database, you could plausibly
steal entire identities of a large number of people.  That's email
addresses, of course, but from that, bank details, Facebook
credentials, IRC handles...

To get around this insecurity, it's crucial to encrypt passwords by
some mechanism.  Using a conventional Caesar-style cypher, like rot13,
would be unwise: `hunter2` becomes `uhagre2`, and so anybody with the
encrypted password could trivially get the original password.

Instead, we must store passwords such that the original password
cannot be derived from the stored password.  The ideal solution is
_hashing_: wherein we take the hash of a password and store that.
We can't get the original password back, but we _can_ check for
password matches.

We use a _hash function_ to achieve this: it accepts a password as
input, and returns some encrypted output.  We then check if the
inputted password to login is correct, by running the same hash
function on it and making sure the answers match.

So, hashing encrypted passwords is a Good Thing™.  And, yes, Adobe did
this.  But they made one, crucial mistake.

The Data-Base Is Under A Salt
-----------------------------

You might have spotted a weakness with the above description of
hashing and storing users' passwords.  If both Alice and Bob have
`hunter2` as their password, yes, both passwords are otherwise
unintelligible---`6a0f0731d84afa4082031e3a72354991`---but the same
password, and thus the same hash, will be stored for both users.  So,
if we somehow manage to crack that encryption, or if we find out Bob
was using the password `hunter2`, we'd also be able to get Alice's
password straight away.

To get around this, we use something called a salt.  We grab a handful
of nice, random bytes, which are stored with the password, and, when
the password needs to be checked, the bytes are added to the password
before it is hashed.  So, even if Alice and Bob both have the same
password, the hashes won't be the same.

This is a step up again, and one that Adobe hadn't done.  They'd
hashed passwords, without salting them, which means you can see which
users have the same passwords.

Adobe also has password hints... which were also stored with, and
_leaked with_ the passwords.

That may not be too worrying---you write meaningless password hints, I
hope---but if you share a password with someone, or even several
someones, who lack your vigilance, this data can often be enough to
work out what the password actually is.


"same as for unsw"
------------------

Scarily enough, a lot of these people have password hints like `same`
or `usual`, or even `same as for unsw`.  So, if you can guess their
password from other people's password hints, you also have access to
this person's password... and, potentially, access to their email, and
other services.

You know how \UNSW\ makes you do that really annoying thing where you
reset your zPass every six months?  Yeah. It might be annoying, but at least it means that student's account is safe. This time.

So, what can we learn from all this?

Well, do you need to store passwords at all?  Delegate authentication
to someone else, like Google or Facebook, who have spent considerable
time and effort to secure their services, and to set up standards that
allow for authentication offloading.

If you need to store passwords, use a good hash function, and add a
salt.  Password guidelines (e.g. "passwords must contain an uppercase
letter, a number, a haiku, a gang sign, a hieroglyph, and a blood
sacrifice") suck.  Don't use them.  Password hints suck too, but not
nearly as much.  Don't store these with passwords.

If, when you sign up for a service, they email you back your password
in plain text, make a nasty complaint, change that password, and
consider taking your custom elsewhere.

Like any self-respecting security guy, I found myself a copy of the
leaked credentials file, and spent some time picking through
it.  There's a lot of fun you can have there at trying to work out
passwords from the hints.

This guy has, however, taken it to the next level:
[zed0.co.uk/crossword](http://zed0.co.uk/crossword)

\byline{story: Andrew~Bennett\hspace{0.5em}\rule[1pt]{4pt}{4pt}\hspace{0.5em} words: Jashank~Jeremy}

\begin{center}{\small \textsc{footnote}: for bonus points, what hash
  format was this, and what's the problem with it?  Join the Security
  Society of UNSW for the answer, and to learn more! \href{http://unswsecurity.com/}{\texttt{unswsecurity.com}}}\end{center}
