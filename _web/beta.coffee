semesters =
  "2015s1": "Jashank Jeremy"
  "2015s2": "Jashank Jeremy"
  "2014s1": "Angelo Tamayo"
  "2014s2": "Angelo Tamayo"
  "2013s1": "Wen Di Lim"
  "2013s2": "Wen Di Lim"

issues =
  "2013s1":
    '073':
      date: "2013-02-25"
    '074':
      date: "2013-03-04"
    '075':
      date: "2013-03-19"
    '076':
      date: "FYC'13"
    '077':
      date: "2013-04-08"
    '078':
      date: "2013-04-22"
    '079':
      date: "2013-05-13"
    '080':
      date: "2013-05-27"

  "2013s2":
    '081':
      date: "2013-08-05"
    '082':
      date: "2013-08-19"
    '083':
      date: "2013-09-02"
    '084':
      date: "Open Day"
    '085':
      date: "2013-09-16"
    '086':
      date: "2013-10-09"
    '087':
      date: "2013-10-22"

  "2014s1":
    '088':
      date: "2014-02-24"
    '089':
      date: "2014-03-03"
    '090':
      date: "2014-03-17"
    '091':
      date: "2014-04-01"
    '092':
      date: "2014-04-14"
    '093':
      date: "2014-05-12"
    '094':
      date: "2014-05-26"

  "2014s2":
    '095':
      date: "2014-07-28"
    '097':
      date: "2014-08-25"
    '098':
      date: "2014-09-06"
    '099':
      date: "2014-09-22"
    '100':
      date: "2014-10-20"

  "2015s1":
    101:
      date: "2015-02-23"
    102:
      date: "2015-03-02"
    103:
      date: "2015-03-16"
    104:
      date: "2015-03-30"
    105:
      date: "2015-04-13"
    106:
      date: "2015-05-11"
    107:
      date: "2015-05-25"

  "2015s2":
    108:
      date: "2015-07-29"
    109:
      date: "2015-08-12"
    110:
      date: "2015-09-02"
    111:
      date: "2015-09-05"
      latest: true

generate_containers = (sem) ->
  yid = sem.substr 0, 4

  # find or create the section
  el_section = null
  if document.getElementById yid
    el_section = document.getElementById yid
  else
    sec = document.createElement "section"
    sec.id = yid
    sechead = document.createElement "h2"
    sechead.textContent = "\u2014 #{yid} \u2014"
    sec.appendChild sechead

    seclead = document.createElement "p"
    seclead.textContent = "head: "
    secname = document.createElement "strong"
    secname.textContent = semesters[sem]
    seclead.appendChild secname
    sec.appendChild seclead

    body = document.getElementById "body"
    body.insertBefore(sec, document.getElementsByTagName("footer")[0])

    el_section = sec

  el_ul = document.createElement "ul"
  el_ul.className = "list-inline"
  el_ul.id = sem
  el_section.appendChild el_ul

generate_issue = (sem, num, date, latest) ->
  sem_list = document.getElementById sem
  if not sem_list
    return console.log "! ##{sem} doesn't exist, bailing for issue #{num}"
  el_li = document.createElement "li"

  el_a = document.createElement "a"
  el_a.className = "btn btn-lg " +
    if latest is true
      "btn-primary"
    else
      "btn-default"
  el_a.href = "issue#{num}.pdf"
  el_a.text = "issue #{num}"
  el_li.appendChild el_a

  el_li.appendChild document.createElement "br"

  el_span = document.createElement "span"
  el_span.className = "text-muted"
  el_span.textContent = date
  el_li.appendChild el_span

  sem_list.appendChild el_li

generate_sem = (n, m) ->
  generate_issue n, issue, m[issue]['date'], m[issue]['latest'] for issue in Object.keys m

generate_containers sem for sem in Object.keys semesters
generate_sem sem, issues[sem] for sem in Object.keys issues
