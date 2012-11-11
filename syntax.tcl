##
##    abyss's           __                       (scripted by) abyss[abyss@cataclysm.net]
##   .-----.--.--.-----|  |_.---.-.--.--.        (  e-mail   ) abyss@cataclysm.net
##   |__ --|  |  |     |   _|  _  |_   _|        (  webpage  ) www.negative.net
##   |_____|___  |__|__|____|___._|__.__| IRC    (    ftp    ) none
##         |_____|(Twilight Productions)         (  version  ) one (final)
##
##  Special thanks to behemoth for work on replace procedure, and for the duration procedure
##  (which is his, btw, as mentioned in the code). Also thanks to daem0n for the spooftrace
##  concept and to zerohour for the ascii art.
##
##  All code, except for what was mentioned in the credits, was coded by abyss.
##
##  Now go read the readme =)
##

# still to come
# -------------
#
# expand themes to modify default colors (when xircon supports it)..
# dcc auto accept (when xircon supports it)..

set loadtime [clock clicks]

alias about {
  synechox about "    "
  synechox about "    "
  synechox about "             .                                 ."
  synechox about "             :       ,                         .                 .       ."
  synechox about "             :Ä ÄÄÄ Äl  ÄÄ-Ä-ÄÄÄ ÄÄ ÄÄ ÄÄÄ-ÄÄ Ä: Ä-Ä-Ä-Ä Ä ÄÄ Ä Ä:   Ä   i ÄÄÄ¿"
  synechox about "           ,i\$i     .\$                         i                 ?       ³    ³"
  synechox about "      ,?\$¾^^Ô\$?,i i?\$\$    \$\$?i  ,?\$¾^^Ô\$?,   ,?\$¾^        ,?\$¾^^Ô\$?,   ,?\$¾  Ô\$?,"
  synechox about "     i?\$\$    íÙ\"^ \$\$\$\$    \$\$\$\$ i\$\$\$    \$\$\$i i\$\$\$_______  i\$¾     \$\$\$i i\$\$\$    \$\$\$i"
  synechox about "     \$\$\$\$         \$\$\$\$    \$\$\$\$ \$\$\$\$    \$\$\$\$ \$\$\$\$¾\"^^^^^   ,?\$¾^^^\$\$\$\$ \$\$\$\$    \$\$\$\$"
  synechox about "     ^^^^^^\"À\$\$?i \$\$\$\$¾\"^^\$\$\$\$ \$\$\$\$    \$\$\$\$ \$\$\$\$         i\$\$\$    \$\$\$\$  \$\$\$\$%%\$\$\$\$"
  synechox about "     i?\$\$±±±±\$\$\$\$     ±±±±\$\$\$\$ \$\$\$\$±±±±\$\$\$\$ \$\$\$\$±±±±\$\$\$\$ \$\$\$\$±±±±\$\$\$\$ \$\$\$\$±±±±\$\$\$\$"
  synechox about "     \$\$\$\$°°°°\$\$\$\$ \$\$\$\$°°°°\$\$\$\$ \$\$\$\$°°°°\$\$\$\$ \$\$\$\$°°°°\$\$\$\$ \$\$\$\$°°°°\$\$\$\$ \$\$\$\$°°°°\$\$\$\$"
  synechox about "     \$\$\$\$    \$\$\$\$ \$\$\$\$    \$\$\$\$ \$\$\$\$    \$\$\$\$ \$\$\$\$    \$\$\$\$ \$\$\$\$    \$\$\$\$ \$\$\$\$    \$\$\$\$"
  synechox about "     ss%%%ss%\$\$\$i \$\$\$\$%%%s%s%s \$\$\$\$    \$\$\$\$ \$\$\$\$%ss%\$\$\$\$ \$\$\$\$%ss%\$\$\$\$ \$\$\$\$    \$\$\$\$"
  synechox about "     \$\$Ù\"    ³    \$\$\$\$                 `Ô\$\$ \$\$¾`                 `Ô\$\$ \$\$¾`    \$\$Ô`"
  synechox about "     \$`      ³    \$\$¾\"   syntaxIRC 1.0   `\$ \$`                     `\$ \$`      \$`"
  synechox about "     :       ³    \$`        \[abyss\]       : :                       : :       :"
  synechox about "     .       ³    :                       . :                       . .       ."
  synechox about "             À    . - --Ä-Ä-Ä-Ä-Ä Ä ÄÄ Ä  . .   ÄÄÄ---Ä-Ä--Ä-Ä-Ä    . .   ÄÄÄÄ¾"
  synechox about "                                            .                         i"
  synechox about "    "
  synechox about "    "
  killpipe about
  noidle
  complete
}

proc get_syn_dir { } {
  return "[pwd]"
}

proc dccmsg { nick text } { /msg =$nick $text }
proc parseaction { dest text } {
  set mm ""
  foreach d [split $dest ","] {
    if {[string index $d 0] == "="} {
      if {[llength [chats [string range $d 1 end]]]} {
        /msg $d "\001ACTION $text\001"
        spylink $d "[applydccselfaction "[my_nick]" "$text"]"
      }
    } elseif {[llength [queries $d]]} {
      echo "[applymsgselfaction "[my_nick]" "$text"]" query $d
      spylink $d "[applysactionstyle "$d" "$text"]"
      lappend mm "$d"

    } elseif {[llength [channels $d]] && [ison [my_nick] $d]} {
      echo "[applyselfaction "[my_nick]" "$text"]" channel $d
      spylink $d "[applyselfaction "[my_nick]" "$text"]"
      lappend mm "$d"
    } else {
      echo "[applysactionstyle "$d" "$text"]"
      spylink $d "[applysactionstyle "$d" "$text"]"
      lappend mm "$d"
    }
  }
  if {[string length $mm]} {
    /quote privmsg [join $mm ","] :\001ACTION $text\001
    unset mm
  }
}
proc parsemsg { dest text } {
  set mm ""
  foreach d [split $dest ","] {
    if {[string index $d 0] == "="} {
      if {[llength [chats [string range $d 1 end]]]} {
        /msg $d $text
        spylink $d "[applydccselftext "[my_nick]" "$text"]"
      }
    } elseif {[llength [queries $d]]} {
      echo "[applymsgselftext "[my_nick]" "$text"]" query $d
      spylink $d "[applysmsgstyle "$d" "$text"]"
      lappend mm "$d"
    } elseif {[llength [channels $d]] && [ison [my_nick] $d]} {
      echo "[applyselftext "[my_nick]" "$text"]" channel $d
      spylink $d "[applyselftext "[my_nick]" "$text"]"
      lappend mm "$d"
    } else {
      echo "[applysmsgstyle "$d" "$text"]"
      spylink $d "[applysmsgstyle "$d" "$text"]"
      lappend mm "$d"
    }
  }
  if {[string length $mm]} {
    /quote privmsg [join $mm ","] :$text
    unset mm
  }
}

alias say {
  say "[join [args]]"
  noidle
  killpipe say
  complete
}

####
#### Addon Commands
####

proc upver { x } {
  global synver
  lappend synver "$x"
}
proc addverquote { type text } {
  global verquote
  if {$type == "say" || $type == "msg" || $type == "text" || $type == "/say"} {
    lappend verquote "/say $text"
  } elseif {$type == "action" || $type == "me" || $type == "/me"} {
    lappend verquote "/me $text"
  }
  return 1
}

####
#### SynEcho
####

proc repipe { x y } {
  global echopipe
  foreach q [array names echopipe] {
    if {[info exists echopipe($q)] && [isin $echopipe($q) $x]} {
      if {$echopipe($q) == $x} {
        set echopipe($q) $y
      } else {
        foreach thing $echopipe($q) {
          if {$thing == $x} {
            set echopipe($q) "[roflist $echopipe($q) "$x"]"
            set echopipe($q) "[atlist $echopipe($q) "$y"]"
          }
        }
      }
    }
  }
}
proc killpipe { x } {
  global echopipe
  foreach q [array names echopipe] {
    if {[info exists echopipe($q)] && [isin $echopipe($q) $x]} {
      if {$echopipe($q) == $x} { unset echopipe($q)
      } else { set echopipe($q) "[roflist $echopipe($q) "$x"]" }
    }
  }
}
proc addpipe { x y } {
  global echopipe
  if {[info exists echopipe($x)]} {
    set echopipe($x) "[atlist $echopipe($x) [string tolower [string trimleft [lindex [join $y] 0] "/"]]]"
  } else {
    set echopipe($x) "[string tolower [string trimleft [lindex [join $y] 0] "/"]]"
  }
}
proc addnullpipe { x } {
  global echopipe
  if {[info exists echopipe($x)]} {
    set echopipe($x) "[atlist $echopipe($x) "\$\$\$"]"
  } else {
    set echopipe($x) "\$\$\$"
  }
}
alias redir {
  if {"[lindex [args] 0]" == "?"} { /help redir ; complete ; return }
  if {[string range [lindex [args] 1] 0 0] != "\/"} { set redir [string trim "[query][channel]"] ; set cmd [lrange [args] 0 end]
  } else { set redir [lindex [args] 0] ; set cmd [lrange [args] 1 end] }
  if {![string length $redir]} { synecho redir "[eheader "Redirect"] Please specify a location to redirect to..."
  } elseif {$redir == "\$\$\$"} { synecho redir "[eheader "Redirect"] Invalid destination..."
  } elseif {$cmd == "/redir"} { synecho redir "[eheader "Redirect"] You cannot redirect a redirect..."
  } else {
    foreach arg [split $redir ","] { synecho redir "[eheader "Redirect"] Redirecting command output of [b][join $cmd][b] to [b]$arg[b]..." ; addpipe $arg $cmd }
    if {[catch $cmd]} { synecho redir "[eheader "Redirect"] Invalid command given ([b][join $cmd][b])..." ; foreach arg [split $redir ","] { killpipe $cmd } }
  }
  complete
}
proc synecho { cmmd text args } {
  set text "[syn] $text"
  synechoint $cmmd $text $args
}
proc synechox { cmmd text args } {
  synechoint $cmmd $text $args
}
proc synechoint { cmmd text args } {
  global echopipe
  set sendx ""
  foreach q [array names echopipe] {
    if {[isin $echopipe($q) $cmmd] && $q != "\$\$\$"} { lappend sendx "${q}" }
  }
  if {[string length $text]} {
    if {[string length $sendx]} {
      foreach xx "[split [colorstrip "$text"] "\n"]" {
        parsemsg "[join $sendx ","]" "$xx"
      }
    } else {
      echo "$text" [lindex $args 0] [lindex $args 1]
    }
  }
}

proc dsynecho { cmmd text args } {
  global echopipe
  set sendx ""
  foreach q [array names echopipe] {
    if {[isin $echopipe($q) $cmmd] && $q != "\$\$\$"} { lappend sendx "${q}" }
  }
  if {[string length $text]} {
    if {[string length $sendx]} {
      foreach xx "[split [colorstrip "[syn] $text"] "\n"]" {
        parsemsg "[join $sendx ","]" "$xx"
      }
    } else {
      if {[window type] != "status"} { echo "[syn] $text" status }
      echo "[syn] $text" [lindex $args 0] [lindex $args 1]
    }
  }
}
proc dsynechox { cmmd text args } {
  global echopipe
  set sendx ""
  foreach q [array names echopipe] {
    if {[isin $echopipe($q) $cmmd] && $q != "\$\$\$"} { lappend sendx "${q}" }
  }
  if {[string length $text]} {
    if {[string length $sendx]} {
      foreach xx "[split [colorstrip "$text"] "\n"]" {
        parsemsg "[join $sendx ","]" "$xx"
      }
    } else {
      if {[window type] != "status"} { echo "$text" status }
      echo "$text" [lindex $args 0] [lindex $args 1]
    }
  }
}

####
#### Renamed Commands
####

alias dcon { if {"[lindex [args] 0]" == "?"} { /help quit ; complete ; return } ; repipe dcon quit ; /quit [join [args]] ; conplete }
alias dc { if {"[lindex [args] 0]" == "?"} { /help dcc ; complete ; return } ; repipe dc dcc ; /dcc [join [args]] ; complete }
alias m { if {"[lindex [args] 0]" == "?"} { /help msg ; complete ; return } ; repipe m msg ; /msg [join [args]] ; complete }
alias bk { if {"[lindex [args] 0]" == "?"} { /help kb ; complete ; return } ; repipe bk kb ; /kb [join [args]] ; complete }
alias sbk { if {"[lindex [args] 0]" == "?"} { /help skb ; complete ; return } ; repipe sbk skb ; /skb [join [args]] ; complete }
alias dbk { if {"[lindex [args] 0]" == "?"} { /help dkb ; complete ; return } ; repipe dbk dkb ; /dkb [join [args]] ; complete }
alias sver { if {"[lindex [args] 0]" == "?"} { /help sv ; complete ; return } ; repipe sver sv ; /sv [join [args]] ; complete }
alias desc { if {"[lindex [args] 0]" == "?"} { /help pme ; complete ; return } ; repipe desc pme ; /pme [join [args]] ; complete }
alias ltheme { if {"[lindex [args] 0]" == "?"} { /help loadtheme ; complete ; return } ; repipe ltheme loadtheme ; /loadtheme [join [args]] ; complete }
alias config { if {"[lindex [args] 0]" == "?"} { /help tog ; complete ; return } ; repipe config tog ; /tog [join [args]] ; complete }
alias re { if {"[lindex [args] 0]" == "?"} { /help redir ; complete ; return } ; repipe re redir ; /redir [join [args]] ; complete }
alias ident { if {"[lindex [args] 0]" == "?"} { /help tog ; complete ; return } ; repipe ident tog ; /tog id [join [args]] ; complete }
alias sc { if {"[lindex [args] 0]" == "?"} { /help cs ; complete ; return } ; repipe sc cs ; /cs [join [args]] ; complete }
alias ac { if {"[lindex [args] 0]" == "?"} { /help awaycapt ; complete ; return } ; repipe ac awaycapt ; /awaycapt [join [args]] ; complete }
alias am { if {"[lindex [args] 0]" == "?"} { /help awaymsgs ; complete ; return } ; repipe am awaymsgs ; /awaymsgs [join [args]] ; complete }
alias p { if {"[lindex [args] 0]" == "?"} { /help ping ; complete ; return } ; repipe p ping ; /ping [join [args]] ; complete }
alias nslookup { if {"[lindex [args] 0]" == "?"} { /help dns ; complete ; return } ; repipe nslookup dns ; /dns [join [args]] ; complete }
alias auser { if {"[lindex [args] 0]" == "?"} { /help user ; complete ; return } ; repipe auser user ; /user [join [args]] ; complete }
alias adduser { if {"[lindex [args] 0]" == "?"} { /help user ; complete ; return } ; repipe adduser user ; /user [join [args]] ; complete }
alias deluser { if {"[lindex [args] 0]" == "?"} { /help ruser ; complete ; return } ; repipe deluser user ; /ruser [join [args]] ; complete }
alias not { if {"[lindex [args] 0]" == "?"} { /help notify ; complete ; return } ; repipe not notify ; /notify [join [args]] ; complete }
alias unnot { if {"[lindex [args] 0]" == "?"} { /help unnotify ; complete ; return } ; repipe unnot unnotify ; /unnotify [join [args]] ; complete }
alias umode { if {"[lindex [args] 0]" == "?"} { /help um ; complete ; return } ; repipe umode um ; /um [join [args]] ; complete }
alias rn { if {"[lindex [args] 0]" == "?"} { /help recnick ; complete ; return } ; repipe rn recnick ; /recnick ; complete }
alias fv { if {"[lindex [args] 0]" == "?"} { /help fakever ; complete ; return } ; repipe fv fakever ; /fakever [join [args]] ; complete }
alias kq { if {"[lindex [args] 0]" == "?"} { /help kickquote ; complete ; return } ; repipe kq kickquote ; /kickquote [join [args]] ; complete }
alias qq { if {"[lindex [args] 0]" == "?"} { /help quitquote ; complete ; return } ; repipe qq quitquote ; /quitquote [join [args]] ; complete }
alias id { if {"[lindex [args] 0]" == "?"} { /help mystat ; complete ; return } ; repipe id mystat ; /mystat ; complete }
alias whoami { if {"[lindex [args] 0]" == "?"} { /help mystat ; complete ; return } ; repipe whoami mystat ; /mystat ; complete }
alias invite { if {"[lindex [args] 0]" == "?"} { /help inv ; complete ; return } ; repipe invite inv ; /inv [join [args]] ; complete }
alias kick { if {"[lindex [args] 0]" == "?"} { /help k ; complete ; return } ; repipe kick k ; /k [join [args]] ; complete }
alias kickban { if {"[lindex [args] 0]" == "?"} { /help kb ; complete ; return } ; repipe kickban kb ; /kb [join [args]] ; complete }
alias topic { if {"[lindex [args] 0]" == "?"} { /help t ; complete ; return } ; repipe topic t ; /t [join [args]] ; complete }
alias unig { if {"[lindex [args] 0]" == "?"} { /help unignore ; complete ; return } ; repipe unig unignore ; /unignore [join [args]] ; complete }
alias ig { if {"[lindex [args] 0]" == "?"} { /help ignore ; complete ; return } ; repipe ig ignore ; /ignore [join [args]] ; complete }
alias cstat { if {"[lindex [args] 0]" == "?"} { /help cs ; complete ; return } ; repipe cstat cs ; /cs [join [args]] ; complete }
alias version { if {"[lindex [args] 0]" == "?"} { /help ver ; complete ; return } ; repipe version ver ; /ver [join [args]] ; complete }
alias j { if {"[lindex [args] 0]" == "?"} { /help join ; complete ; return } ; repipe j join ; /join [join [args]] ; complete }
alias wi { if {"[lindex [args] 0]" == "?"} { /help whois ; complete ; return } ; repipe wi whois ; /whois [join [args]] ; complete }
alias ww { if {"[lindex [args] 0]" == "?"} { /help whowas ; complete ; return } ; repipe ww whowas ; /whowas [join [args]] ; complete }
alias o { if {"[lindex [args] 0]" == "?"} { /help op ; complete ; return } ; repipe o op ; /op [join [args]] ; complete }
alias d { if {"[lindex [args] 0]" == "?"} { /help deop ; complete ; return } ; repipe d deop ; /deop [join [args]] ; complete }
alias v { if {"[lindex [args] 0]" == "?"} { /help voice ; complete ; return } ; repipe v voice ; /voice [join [args]] ; complete }
alias u { if {"[lindex [args] 0]" == "?"} { /help unvoice ; complete ; return } ; repipe u unvoice ; /unvoice [join [args]] ; complete }
alias r { if {"[lindex [args] 0]" == "?"} { /help r ; complete ; return } ; repipe r cycle ; /cycle [join [args]] ; complete }
alias n { if {"[lindex [args] 0]" == "?"} { /help n ; complete ; return } ; repipe n notice ; /notice [join [args]] ; complete }
alias w { if {"[lindex [args] 0]" == "?"} { /help wall ; complete ; return } ; repipe w wall ; /wall [join [args]] ; complete }
alias on { if {"[lindex [args] 0]" == "?"} { /help wall ; complete ; return } ; repipe on wall ; /wall [join [args]] ; complete }
alias xw { if {"[lindex [args] 0]" == "?"} { /help xwall ; complete ; return } ; repipe xw xwall ; /xwall [join [args]] ; complete }
alias expr { if {"[lindex [args] 0]" == "?"} { /help calc ; complete ; return } ; repipe expr calc ; /calc [join [args]] ; complete }

proc retversion { } {
  global synver
  if {![string length [config version]]} { return "[lindex $synver 0]"
  } elseif {"[config version]" == "random" && [string length [get_cookie fakever]]} { return "[rword [get_cookie fakever]]"
  } elseif {"[config version]" == "random" && ![string length [get_cookie fakever]]} { return "[lindex $synver 0]"
  } elseif {[isnum [config version]] && [config version] > 0 && [config version] < [expr {[llength [get_cookie fakever]] + 1}]} { return "[join [lindex [get_cookie fakever] [expr {[config version] - 1}]]]"
  } else { return "[config version]" }
}
proc retuversion { } {
  global synver
  if {![string length [config version]]} { return "[lindex $synver 0]"
  } elseif {"[config version]" == "random" && [string length [get_cookie fakever]]} { return "random"
  } elseif {"[config version]" == "random" && ![string length [get_cookie fakever]]} { return "random"
  } elseif {[isnum [config version]] && [config version] > 0 && [config version] < [expr {[llength [get_cookie fakever]] + 1}]} { return "[join [lindex [get_cookie fakever] [expr {[config version] - 1}]]]"
  } else { return "[config version]" }
}
alias rekey {
  if {"[lindex [args] 0]" == "?"} { /help rekey ; complete ; return }
  if {[string match #* [lindex [args] 0]]} { set chan "[lindex [args] 0]" ; set newkey "[lindex [args] 1]"
  } else { set chan "[channel]" ; set newkey "[lindex [args] 0]" }
  if {![string length $chan]} {
    synecho rekey "[eheader "snt"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} {
    synecho snt "[eheader "snt"] Operator status required to change mode on [b]$chan[b]..."
  } elseif {![string length $newkey] && ![string length [getkey $chan]]} {
    synecho rekey "[eheader "ReKey"] There is currently no keys to remove on [b]$chan[b]..."
  } elseif {![string length $newkey] && [string length [getkey $chan]]} {
    synecho rekey "[eheader "ReKey"] Removing key([sb][getkey $chan][sb]) from [b]$chan[b]..."
    /quote mode $chan -k [getkey $chan]
  } elseif {[string length [getkey $chan]]} {
    /quote mode $chan -k [getkey $chan][lf] mode $chan +k $newkey
    synecho rekey "[eheader "ReKey"] Resetting key on [b]$chan[b] to ([b]$newkey[b])..."
  } else {
    /quote mode $chan +k $newkey
    synecho rekey "[eheader "ReKey"] Setting key on [b]$chan[b] to ([b]$newkey[b])..."
  }
  killpipe rekey
  complete
  noidle
}
alias snt {
  if {"[lindex [args] 0]" == "?"} { /help snt ; complete ; return }
  if {[string match #* [lindex [args] 0]]} { set chan "[lindex [args] 0]"
  } else { set chan "[channel]" }
  if {![string length $chan]} {
    synecho snt "[eheader "snt"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} {
    synecho snt "[eheader "snt"] Operator status required to change mode on [b]$chan[b]..."
  } else {
    synecho snt "[eheader "snt"] Setting modes [sb]+snt[sb] on ([b]$chan[b])..."
    /quote mode $chan +snt
  }
  killpipe snt
  complete
  noidle
}
alias nt {
  if {"[lindex [args] 0]" == "?"} { /help nt ; complete ; return }
  if {[string match #* [lindex [args] 0]]} { set chan "[lindex [args] 0]"
  } else { set chan "[channel]" }
  if {![string length $chan]} {
    synecho nt "[eheader "nt"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} {
    synecho nt "[eheader "nt"] Operator status required to change mode on [b]$chan[b]..."
  } else {
    synecho nt "[eheader "nt"] Setting modes [sb]+nt[sb] on ([b]$chan[b])..."
    /quote mode $chan +nt
  }
  killpipe nt
  complete
  noidle
}
proc checkfile { file } {
  if {![file exists $file]} {
    set x "[open $file w]"
    close $x
    return 1
  } else {
    return 0
  }
}
proc clearfile { file } {
  set x "[open $file w]"
  close $x
  return 1
}
on UNLOAD {
  global originalsyn env
  catch {close $eyedent}
  catch {close $winkill}
  catch {close $portscan}
  if {[string length [get_cookie emsockblock]]} { puts [get_cookie emsockblock] "quit" ; killesock [get_cookie emsockblock] }
  if {$originalsyn} {
    if {[info exists env(synloaded)]} { unset env(synloaded) }
    if {[info exists env(rid)]} { unset env(rid) }
  }
}

# FIXME: Here was once the email check

alias timers {
  if {"[lindex [args] 0]" == "?"} { /help timer ; complete ; return }
  repipe timers timer
  /timer [join [args]]
  killpipe timer
  noidle
  complete
}
alias timer {
  if {"[lindex [args] 0]" == "?"} { /help timer ; complete ; return }
  if {![string length [lindex [args] 0]]} {
    if {[llength $timers]} {
      synecho timer "[boxtop "[b]Timers[b] [sb](([sb][su]count:[su] [b][llength $timers][b][sb]))[sb]"]"
      synecho timer "[boxside "[llb] [b]#[b] [lrb][llb][b]Interval:[b][lrb][llb][b]Repeats: [b][lrb][llb][b]Command:[b]                                [lrb]"]"
      set cc 0
      foreach tt $timers {
        incr cc
        synecho timer "[boxside "[llb][sb][align $cc 3][sb][lrb][llb][align "[lindex $tt 0]\\[lindex $tt 1]" 9][lrb][llb][align "[lindex $tt 2]\\[lindex $tt 3]" 9][lrb][llb][align [lindex $tt 4] 40][lrb]"]"
      }
      synecho timer "[boxbottom "[b]Timers[b] [sb](([sb][su]count:[su] [b][llength $timers][b][sb]))[sb]"]"
    } else {
      synecho timer "[eheader "Timer"] You have no active timers..."
    }
  } elseif {[lindex [args] 0] == "off"} {
    if {[llength $timers]} {
      set cc 0
      foreach tt $timers {
        incr cc
        synecho timer "[eheader "Timer"] Timer([b]#$cc[b]) deactivated \[[sb]interval:[sb] [b][lindex $tt 0][b]\]\[[sb]reps:[sb] [b][lindex $tt 2][b]\] with command: [sb][lindex $tt 4][sb]"
      }
      synecho timer "[eheader "Timer"] [b]$cc[b] timers deactivated..."
      set timers ""
    } else {
      synecho timer "[eheader "Timer"] You have no active timers..."
    }
  } elseif {[isnum [lindex [args] 0]] && [lindex [args] 1] == "off"} {
    if {[llength $timers]} {
      set cc 0
      set newtimer ""
      foreach tt $timers {
        incr cc
        if {$cc == [lindex [args] 0]} {
          synecho timer "[eheader "Timer"] Timer([b]#$cc[b]) deactivated \[[sb]interval:[sb] [b][lindex $tt 0][b]\]\[[sb]reps:[sb] [b][lindex $tt 2][b]\] with command: [sb][lindex $tt 4][sb]"
          set flag 1
        } else {
          lappend newtimer "$tt"
        }
      }
      set timers "$newtimer"
      if {![info exists flag]} { synecho timer "[eheader "Timer"] Unable to locate timer [b]#[lindex [args] 0][b]..."
      } else { unset flag }
    } else {
      synecho timer "[eheader "Timer"] You have no active timers..."
    }
  } elseif {![isnum [lindex [args] 0]] || [lindex [args] 1] < 0} { synecho timer "[eheader "Timer"] You must specify an interval to execute the timer at..."
  } elseif {[lindex [args] 0] <= 0} { synecho timer "[eheader "Timer"] Timer interval must be at least 1..."
  } elseif {![isnum [lindex [args] 1]] || [lindex [args] 1] < 0} { synecho timer "[eheader "Timer"] You must specify a number of times to execute the timer..."
  } elseif {![string length [lindex [args] 2]]} { synecho timer "[eheader "Timer"] You must specify an event to execute at each interval..."
  } else {
    lappend timers "[list "[lindex [args] 0]"] [list "0"] [list "[lindex [args] 1]"] [list "0"] [list "[join [lrange [args] 2 end]]"]"
    synecho timer "[eheader "Timer"] Timer([b]#[llength $timers][b]) activated \[[sb]interval:[sb] [b][lindex [args] 0][b]\]\[[sb]reps:[sb] [b][lindex [args] 1][b]\] with command: [sb][join [lrange [args] 2 end]][sb]"
  }
  killpipe timer
  noidle
  complete
}
alias nickregain {
  if {"[lindex [args] 0]" == "?"} { /help nickregain ; complete ; return }
  if {[string length [lindex [args] 0]]} {
    synecho nickregain "[eheader "NickRegain"] Attempting to regain to nickname ([b][lindex [args] 0][b])..."
    set regainnick "[lindex [args] 0]"
  } elseif {![info exists regainnick]} {
    synecho nickregain "[eheader "NickRegain"] You are not currently trying to switch to any nicknames..."
  } else {
    synecho nickregain "[eheader "NickRegain"] Stopped all regain attempts..."
    if {[info exists regtogg]} { unset regtogg }
    unset regainnick
  }
  killpipe nickregain
  noidle
  complete
}

####
#### Userlist
####

proc isuser { addr } { foreach address [get_cookie users] { if {[wmatch $address $addr]} { return 1 } } ; return 0 }
proc guserlistmask { addr } { foreach address [get_cookie users] { if {[wmatch $address $addr]} { return "$address" } } ; return "" }
proc gusersettings { addr } { foreach address [get_cookie users] { if {[wmatch $address $addr]} { return "[get_cookie user($address)]" } } ; return "" }
proc usersettings { addr chan } {
  foreach address [get_cookie users] {
    if {[wmatch $address $addr]} {
      foreach loc [split [lindex [get_cookie user($address)] 0] " ,"] {
        if {[string match [string tolower $loc] [string tolower $chan]]} {
          return "[get_cookie user($address)]"
        }
      }
    }
  }
  return ""
}
proc isprotected { addr chan } {
  foreach address [get_cookie users] {
    if {[wmatch $address $addr]} {
      foreach loc [split [lindex [get_cookie user($address)] 0] " ,"] {
        if {[string match [string tolower $loc] [string tolower $chan]]} {
          if {[string match *3* [lindex [get_cookie user($address)] 1]]} { return "3" }
          if {[string match *2* [lindex [get_cookie user($address)] 1]]} { return "2" }
          if {[string match *1* [lindex [get_cookie user($address)] 1]]} { return "1" }
        }
      }
    }
  }
  return "0"
}
proc userlistmask { addr chan } {
  foreach address [get_cookie users] {
    if {[wmatch $address $addr]} {
      foreach loc [split [lindex [get_cookie user($address)] 0] " ,"] {
        if {[string match [string tolower $loc] [string tolower $chan]]} {
          return "$address"
        }
      }
    }
  }
  return ""
}
alias ruser {
  if {"[lindex [args] 0]" == "?"} { /help ruser ; complete ; return }
  set num 0
  set hits 0
  set lines ""
  set feh ""
  if {![string match *@* [lindex [args] 0]] && ![isnum [lindex [args] 0]] && [isnick [lindex [args] 0]]} {
    if {![info exists whoisqueue]} { set whoisqueue "" }
    if {[isnum [lindex [args] 1]]} { lappend whoisqueue "ruser [lindex [args] 1] [join [lrange [args] 2 end]]"
    } { lappend whoisqueue "ruser 5 [join [lrange [args] 1 end]]" }
    addnullpipe whois
    whois [lindex [args] 0]
    noidle
    complete
    return
  }
  if {[string range [lindex [args] 0] 0 0] == "+"} {
    foreach x [split [string range [lindex [args] 0] 1 end] ""] {
      lappend feh "$x"
    }
    set feh "*[join $x "*"]*"
  }
  foreach user [get_cookie users] {
    incr num
    if {([string length $feh] && [string match $feh [lindex [get_cookie user($user)] 1]]) || ([isnum [lindex [args] 0]] && $num == [lindex [args] 0]) || ([string length [lindex [args] 0]] && ([wmatch $user [lindex [args] 0]] || [wmatch [lindex [args] 0] $user]))} {
      incr hits
      set pass "[lindex [get_cookie user($user)] 1]"
      if {![string length $pass]} { set pass "no" } { set pass "yes" }
      set comment "[lindex [get_cookie user($user)] 2]"
      if {![string length $comment]} { set comment "none" }
      lappend lines "[boxside "[llb][b][align $num 2][b][lrb][llb][align $user 30][lrb][llb][align [lindex [get_cookie user($user)] 0] 22][lrb][llb][align [lindex [get_cookie user($user)] 1] 10][lrb]"]"
      set_cookie users [rflist [get_cookie users] $user]
      set_cookie user($user) ""
    }
  }
  if {$hits} {
    synecho ruser "[boxtop "[b]Deleted Users[b] [sb](([sb][su]matches:[su] [b]$hits[b][sb]))[sb]"]"
    synecho ruser "[boxside "[llb][b]# [b][lrb][llb][b]Address:                      [b][lrb][llb][b]Access Channels:      [b][lrb][llb][b]Flags:    [b][lrb]"]"
    foreach line $lines { synecho ruser "$line" }
    synecho ruser "[boxbottom "[b]Deleted Users[b] [sb](([sb][su]matches:[su] [b]$hits[b][sb]))[sb]"]"
  } elseif {![llength [get_cookie users]]} {
    synecho ruser "[eheader "User"] You currently have no users on your userlist..."
  } else {
    synecho ruser "[eheader "User"] Unable to find any users matching the given parameters..."
  }
  killpipe ruser
  complete
  noidle
}
alias chpass {
  if {"[lindex [args] 0]" == "?"} { /help chpass ; complete ; return }
  if {![string length [lindex [args] 0]]} {
    synecho chpass "[eheader "User"] You must specify a user to reset the password for..."
  } else {
    set hits "0"
    set num "0"
    foreach host [get_cookie users] {
      incr num
      if {([isnum [lindex [args] 0]] && $num == [lindex [args] 0]) || ([string length [lindex [args] 0]] && ([wmatch $host [lindex [args] 0]] || [wmatch [lindex [args] 0] $host]))} {
        incr hits
        if {[string length [lindex [args] 1]]} { synecho chpass "[eheader "User"] Set password for ([b]$host[b]) to ([b][lindex [args] 1][b])..."
        } else { synecho chpass "[eheader "User"] Reset password for ([b]$host[b])..." }
        set_cookie user($host) "[list "[lindex [get_cookie user($host)] 0]"] [list "[lindex [get_cookie user($host)] 1]"] [list "[lindex [get_cookie user($host)] 2]"] [list "[lindex [args] 1]"] [list "[lindex [get_cookie user($host)] 4]"]"
      }
    }
    if {!$hits} {
      synecho chpass "[eheader "User"] Unable to find any users matching the given parameters..."
    } elseif {![llength [get_cookie users]]} {
      synecho chpass "[eheader "User"] You currently have no users on your userlist..."
    }
  }
  killpipe chpass
  noidle
  complete
}

alias chattr {
  global ustring
  if {"[lindex [args] 0]" == "?"} { /help chattr ; complete ; return }
  if {![string length [lindex [args] 0]]} {
    synecho chattr "[eheader "User"] You must specify a user to reset the password for..."
  } else {
    set hits "0"
    set num "0"
    foreach host [get_cookie users] {
      incr num
      if {([isnum [lindex [args] 0]] && $num == [lindex [args] 0]) || ([string length [lindex [args] 0]] && ([wmatch $host [lindex [args] 0]] || [wmatch [lindex [args] 0] $host]))} {
        incr hits
        if {[string length [lindex [args] 1]]} {
          set level "[sortby [modmode "[lindex [get_cookie user($host)] 1]" [lindex [args] 1]] $ustring]"
          set_cookie user($host) "[list "[lindex [get_cookie user($host)] 0]"] [list "$level"] [list "[lindex [get_cookie user($host)] 2]"] [list "[lindex [get_cookie user($host)] 3]"] [list "[lindex [get_cookie user($host)] 4]"]"
          synecho chattr "[eheader "User"] Changed attributes for [b]$host[b] to ([b][lindex [get_cookie user($host)] 1][b])..."
        } else {
          synecho chattr "[eheader "User"] Current attributes for [b]$host[b] are ([b][lindex [get_cookie user($host)] 1][b])..."
        }
      }
    }
    if {!$hits} {
      synecho chattr "[eheader "User"] Unable to find any users matching the given parameters..."
    } elseif {![llength [get_cookie users]]} {
      synecho chattr "[eheader "User"] You currently have no users on your userlist..."
    }
  }
  killpipe chattr
  noidle
  complete
}
alias user {
  if {"[lindex [args] 0]" == "?"} { /help user ; complete ; return }
  if {![string length [lindex [args] 1]]} {
    set num 0
    set hits 0
    set lines ""
    set feh ""
    if {[string range [lindex [args] 0] 0 0] == "+"} {
      foreach x [split [string range [lindex [args] 0] 1 end] ""] {
        lappend feh "$x"
      }
      set feh "*[join $x "*"]*"
    }
    foreach user [get_cookie users] {
      incr num
      if {([string length $feh] && [string match $feh [lindex [get_cookie user($user)] 1]]) || ([isnum [lindex [args] 0]] && $num == [lindex [args] 0]) || ([string length [lindex [args] 0]] && ([wmatch $user [lindex [args] 0]] || [wmatch [lindex [args] 0] $user])) || ![string length [lindex [args] 0]]} {
        incr hits
        set pass "[lindex [get_cookie user($user)] 3]"
        if {![string length $pass]} { set pass "no" } { set pass "yes" }
        set comment "[lindex [get_cookie user($user)] 2]"
        if {![string length $comment]} { set comment "none" }
        lappend lines "[boxside "[llb][b][align $num 2][b][lrb][llb][align $user 30][lrb][llb][align [lindex [get_cookie user($user)] 0] 22][lrb][llb][align [lindex [get_cookie user($user)] 1] 10][lrb]"]"
        lappend lines "[boxside "[llb]  [lrb][llb][sb]comment:[sb] [align "$comment" 45][lrb][llb][sb]pass:[sb] [align "$pass" 3] [lrb]"]"
      }
    }
    if {$hits} {
      synecho user "[boxtop "[b]Users Listing[b] [sb](([sb][su]matches:[su] [b]$hits[b][sb]))[sb]"]"
      synecho user "[boxside "[llb][b]# [b][lrb][llb][b]Address:                      [b][lrb][llb][b]Access Channels:      [b][lrb][llb][b]Flags:    [b][lrb]"]"
      foreach line $lines { synecho user "$line" }
      synecho user "[boxbottom "[b]Users Listing[b] [sb](([sb][su]matches:[su] [b]$hits[b][sb]))[sb]"]"
    } elseif {![llength [get_cookie users]]} {
      synecho user "[eheader "User"] You currently have no users on your userlist..."
    } else {
      synecho user "[eheader "User"] Unable to find any users matching the given parameters..."
    }
  } else {
    if {[string match *@* [lindex [args] 0]] || [isnum [lindex [args] 0]]} { set umask "[lindex [args] 0]"
    } else {
      if {![info exists whoisqueue]} { set whoisqueue "" }
      if {[isnum [lindex [args] 1]]} { lappend whoisqueue "user [lindex [args] 1] [join [lrange [args] 2 end]]"
      } { lappend whoisqueue "user 5 [join [lrange [args] 1 end]]" }
      addnullpipe whois
      whois [lindex [args] 0]
      noidle
      complete ; return
    }
    set chans "[lindex [args] 1]"
    set level "[lindex [args] 2]"
    set comment "[join [lrange [args] 3 end]]"
    set count 0
    foreach host [get_cookie users] {
      incr count
      if {[wmatch $umask $host] || $umask == $count} {
        set flag 1
        if {![string length [lindex [args] 1]] || "[lindex [args] 1]" == "-"} { set chans "[lindex [get_cookie user($host)] 0]" }
        if {![string length [lindex [args] 2]] || "[lindex [args] 2]" == "-"} { set level "[lindex [get_cookie user($host)] 1]"
        } else { set level "[sortby [modmode "[lindex [get_cookie user($host)] 1]" $level] $ustring]" }
        if {![string length [lindex [args] 3]] || "[lindex [args] 3]" == "-"} { set comment "[lindex [get_cookie user($host)] 2]" }
        set_cookie user($host) "[list "$chans"] [list "$level"] [list "$comment"] [list "[lindex [get_cookie user($host)] 3]"] [list "[string tolower [clock format [clock seconds] -format "%m/%d/%y %I:%M:%S%p"]]"]"
        if {![string length $comment]} { set comment "none" }
        synecho user "[eheader "User"] Modified user ([b]$host[b]\[[sb]$chans[sb]\]) with flags ([sb]flags:[sb] [b]$level[b])..."
      }
    }
    if {[info exists flag]} { unset flag
    } elseif {[isnum $umask]} { synecho user "[eheader "User"] Unable to locate user entry ([b][lindex [args] 0][b])..."
    } else {
      if {![string length [lindex [args] 1]]} {
        synecho user "[eheader "User"] You must specify access channels..."
      } elseif {![string length [lindex [args] 2]]} {
        synecho user "[eheader "User"] You must specify an access level..."
      } else {
        set level "[sortby "$level" "$ustring"]"
        if {[string range $level 0 0] != "+"} { set level "+" }
        set_cookie users [atlist [get_cookie users] $umask]
        set_cookie user($umask) "[list "$chans"] [list "$level"] [list "$comment"] [list ""] [list "[string tolower [clock format [clock seconds] -format "%m/%d/%y %I:%M:%S%p"]]"]"
        if {![string length $comment]} { set comment "none" }
        synecho user "[eheader "User"] Added user ([b]$umask[b]\[[sb]$chans[sb]\]) with ([sb]flags:[sb] [b]$level[b])([sb]comment:[sb] [b]$comment[b])..."
      }
    }
  }
  killpipe user
  noidle
  complete
}

####
#### Encryption
####

proc toascii { char } { if {$char == "ÿ"} { return "255" } ; if {$char == " "} { return "9" } ; if {$char == " "} { return "256" } ; scan $char "%c" chax ; return "$chax" }
proc tochar { char } { if {![string length [format "%c" $char]]} { if {$char == 9} { return " " } ; return " " } ; return "[format "%c" $char]" }
proc revorder { x } { set z "" ; for { set y [expr {[llength $x] - 1}] } { $y >= 0 } { set y [expr {$y - 1}] } { lappend z "[lindex $x $y]" } ; return $z }

proc encrypt { string } {
  if {[config cryptkey]} { return "[xencrypt "$string" "[config cryptkey]"]"
  } else { return "[xencrypt "$string" "12345"]" }
}
proc decrypt { string } {
  if {[config cryptkey]} { return "[xdecrypt "$string" "[config cryptkey]"]"
  } else { return "[xdecrypt "$string" "12345"]" }
}
proc xencrypt { string key } {
  set final ""
  set fin ""
  set randalso "[random 10 99]"
  foreach c [split $string ""] {
    set d "[toascii [tochar [expr {[expr {[toascii $c] - $randalso}] - $key}]]]"
    if {$d == "13" || $d == "10" || $d == "9" || $d == "256"} { append final "x[tochar [expr {[expr {[toascii $c] + $randalso}] + $key}]]"
    } else { append final "[randshit 1][tochar $d]" }
  }
  foreach xx [split $randalso ""] { append fin "[lindex "Ô Î Ë É õ ü ¼ Ü • Œ …" $xx]" }
  return "[join [revorder [split "[randshit 5]$final[randshit 5]${fin}õ[randshit 3]" ""]] ""]"
}
proc xdecrypt { string key } {
  set fin ""
  set final ""
  set slen "[string length $string]"
  set string "[join [revorder [split "$string" ""]] ""]"
  set numbb "[string range $string [expr {$slen - 6}] [expr {$slen - 5}]]"
  set string "[string range $string 11 [expr {$slen - 12}]]"
  foreach xx [split $numbb ""] { append fin "[lsearch -exact "Ô Î Ë É õ ü ¼ Ü • Œ …" $xx]" }
  foreach c [split $string ""] {
    if {[info exists chr]} {
      if {"[string range $chr 0 0]" == "x"} {
        if {[toascii $c] == 256} {
          set xx "[expr {[expr {[expr {[toascii $c] - $fin}] - $key}] + 32}]"
        } else {
          set xx "[expr {[expr {[toascii $c] - $fin}] - $key}]"
        }
        set xx "[toascii [tochar $xx]]"
        if {$xx != 13 && $xx != 10 && $xx != 9} { append final "[tochar $xx]" }
      } else {
        if {[toascii $c] == 256} {
          set xx "[expr {[expr {[expr {[toascii $c] + $fin}] + $key}] + 32}]"
        } else {
          set xx "[expr {[expr {[toascii $c] + $fin}] + $key}]"
        }
        set xx "[toascii [tochar $xx]]"
        if {$xx != 13 && $xx != 10 && $xx != 9} { append final "[tochar $xx]" }
      }
      unset chr
    } else {
      set chr "$c"
    }
  }
  if {[info exists chr]} { unset chr }
  return "$final"
}
proc isencrypted { string } {
  if {[string length $string] < 20 || "[string range $string 3 3]" != "õ"} { return 0 }
  set string "[join [revorder [split "$string" ""]] ""]"
  if {"[string range $string 0 5]" != ""} { return 0 }
  set slen "[string length $string]"
  set numbb "[string range $string [expr {$slen - 6}] [expr {$slen - 5}]]"
  set string "[string range $string 11 [expr {$slen - 11}]]"
  if {![string length $string]} { return 0 }
  foreach x [split $numbb ""] { if {![isin "Ô Î Ë É õ ü ¼ Ü • Œ …" $x]} { return 0 } }
  return 1
}

alias crypt {
  set x [random 100 999]
  if {"[window_type]" == "query"} {
    echo "[applydecryptedselftext "[my_nick]" "[join [args]]"]" query [window_name]
    /quote PRIVMSG [window_name] :[encrypt [join [args]]]
  } elseif {"[window_type]" == "channel"} {
    echo "[applydecryptedselftext "[my_nick]" "[join [args]]"]" channel [window_name]
    /quote PRIVMSG [window_name] :[encrypt [join [args]]]
  } else {
    synecho crypt "[eheader "Crypt"] Invalid destination specified..."
  }
  noidle
  killpipe crypt
  complete
}
alias cryptmsg { if {"[lindex [args] 0]" == "?"} { /help cryptmsg ; complete ; return } ; if {![string length [join [lrange [args] 0 0]]]} { synecho cryptmsg "[eheader "cryptmsg"] No arguments specified..." } elseif {![string length [join [lrange [args] 1 1]]]} { synecho cryptmsg "[eheader "cryptmsg"] No text to send..." } else { set x [random 100 999] ; echo "[applyscryptedmsgstyle "[join [lrange [args] 0 0]]" "[join [lrange [args] 1 end]]"]" ; spylink [lindex [args] 0] "[applyscryptedmsgstyle "[join [lrange [args] 0 0]]" "[join [lrange [args] 1 end]]"]" ; /quote PRIVMSG [join [lrange [args] 0 0]] :[encrypt [join [lrange [args] 1 end]]] } ; noidle ; killpipe cryptmsg ; complete }


####
#### Alias Commands
####

alias whokill { if {"[lindex [args] 0]" == "?"} { /help whokill ; complete ; return } ; if {![string length [lindex [args] 0]]} { synecho massmsg "[eheader "WhoKill"] Please specify a mask to search for..." } elseif {![string match *o* [string tolower [mode]]]} { synecho whokill "[eheader "WhoKill"] You must be an ircop to use /whokill..." } else { if {![string length [lrange [args] 1 end]]} { set whokill "." } else { set whokill [join [lrange [args] 1 end]] } ; synecho whokill "[eheader "WhoKill"] Killing all users matching ([b][lindex [args] 0][b]) with: $whokill" ; if {![info exists whoqueue]} { set whoqueue "" } ; lappend whoqueue "whokill [split [lindex [args] 0]] $whokill" ; /raw who [lindex [args] 0] } ; noidle ; complete }
alias globops { /quote globops :[join [args]] ; complete }
alias wallops {
  if {![string match *o* [string tolower [mode]]]} { synecho wallops "[eheader "WallOps"] You must be an ircop to use /wallops..."
  } else { synechox wallops "[applyswallopsstyle "[join [args]]"]" ; /raw wallops :[join [args]] }
  killpipe wallops
  noidle
  complete
}
alias kill {
  if {[string length [join [lrange [args] 1 end]]]} { set okmsg "[join [lrange [args] 1 end]]"
  } else { set okmsg "die" }
  set cmd ""
  if {![string match *o* [string tolower [mode]]]} {
    if {[config operpass] != "none"} { set flag 1
    } elseif {[config operserv] != "none"} { set flag 1
    } else {
      foreach server [split [config operserv]] {
        if {[string match $server [lindex [xserver] 0]]} { set flag 1 }
      }
    }
    if {[info exists flag]} { /oper ; foreach niq [split [lindex [args] 0] ","] { lappend cmd "kill $niq :$okmsg" } ; if {[string length cmd]} { /quote [join $cmd "[lf]"] } ; /quote mode [my_nick] -o
    } else { synecho kill "[eheader "Kill"] You must be an ircop to use /kill..." }
  } else { foreach niq [split [lindex [args] 0] ","] { lappend cmd "kill $niq :$okmsg" ; if {[string length cmd]} { /quote [join $cmd "[lf]"] } } }
  killpipe kill
  noidle
  complete
}
alias oper {
  if {[string match *o* [string tolower [mode]]]} { synecho oper "[eheader "Oper"] You are already an irc operator..."
  } elseif {![string length [lindex [args] 0]]} {
    if {[config operpass] == "none"} {
      synecho oper "[eheader "Oper"] You do not have a default oper pass defined..."
    } elseif {[config operserv] == "none"} {
      synecho oper "[eheader "Oper"] You do not have a default oper server defined..."
    } else {
      foreach server [split [config operserv]] {
        if {[string match $server [lindex [xserver] 0]]} { set flag 1 }
      }
      set uid "[config operuser]"
      if {$uid == "none"} { set uid "[my_nick]" }
      if {[info exists flag]} { synecho oper "[eheader "Oper"] Sent oper password to [b][lindex [xserver] 0][b]..." ; unset flag ; /quote oper $uid [config operpass]
      } else { synecho oper "[eheader "Oper"] You are not connected to your default server..." }
    }
  } elseif {![string length [lindex [args] 1]]} {
    set uid "[config operuser]"
    if {$uid == "none"} { set uid "[my_nick]" }
    /quote oper $uid [lindex [args] 0]
  } else { /quote oper [lindex [args] 0] [lindex [args] 1] }
  killpipe oper
  noidle
  complete
}
alias unoper {
  if {![string match *o* [string tolower [mode]]]} { synecho unoper "[eheader "Oper"] You are not an irc operator..."
  } else { synecho unoper "[eheader "Oper"] Removing oper status..." ; /um -o }
  killpipe unoper
  noidle
  complete
}
alias spy {
  global spylinks
  if {"[lindex [args] 0]" == "?"} { /help spy ; complete ; return }
  if {![string length [lindex [args] 0]]} {
    if {[llength $spylinks]} {
      synecho spy "[boxtop "[b]Spylinks Listing[b] [sb](([sb][su]links:[su] [b][llength $spylinks][b][sb]))[sb]"]"
      synecho spy "[boxside "[llb][b]# [b][lrb][llb][b]Redirecting From:             [b][lrb][llb][b]Redirecting To:               [b][lrb]"]"
      set num 0
      foreach link $spylinks {
        incr num
        synecho spy "[boxside "[llb][b][align "$num" 2][b][lrb][llb][align [lindex $link 0] 30][lrb][llb][align [lindex $link 1] 30][lrb]"]"
      }
      synecho spy "[boxbottom "[b]Spylinks Listing[b] [sb](([sb][su]links:[su] [b][llength $spylinks][b][sb]))[sb]"]"
    } else {
      synecho spy "[eheader "Spy"] You currently have no spylinks established..."
    }
  } elseif {![string length [lindex [args] 1]]} { synecho spy "[eheader "Spy"] You must specify a location to direct information to..."
  } else {
    foreach link $spylinks {
      if {[lindex $link 0] == [lindex [args] 0] && [lindex $link 1] == [lindex [args] 1]} { synecho spy "[eheader "Spy"] Already redirecting info from [sb][lindex [args] 0][sb] to [sb][lindex [args] 1][sb]..." ; killpipe spy ; noidle ; complete ; return }
    }
    lappend spylinks "[list "[string tolower [lindex [args] 0]]"] [list "[string tolower [lindex [args] 1]]"]"
    synecho spy "[eheader "Spy"] Established link from [sb][string tolower [lindex [args] 0]][sb] to [sb][string tolower [lindex [args] 1]][sb]..."
  }
  killpipe spy
  noidle
  complete
}
proc spylink { loc text } {
  set text "[colorstrip $text]"
  global spylinks
#  global relaytext
  foreach link $spylinks {
    if {[string tolower [lindex $link 0]] == [string tolower $loc]} {
      set dest "[strip [lindex $link 1]]"
      if {[isin [channels] $dest]} { set desttype channel
      } elseif {[isin [queries] $dest]} { set desttype query
      } else { set desttype none }
      if {$desttype == "none"} { echo "[applyselfspylinkmsg "$dest" "$text"]"
      } else { echo "[applyselfspylinktext "[my_nick]" "$text"]" $desttype $dest }
      /raw privmsg $dest :[spylinktag $loc] $text
    }
  }
#  lappend relaytext($loc) $text
}
rename echo base_echo
proc echo { string {channel ""} {name ""} } {
  global relaytext grep_for

  set winname [window_name]
  set wintype [window_type]

  regsub -all  \r $string {} string
  set string [string trim $string \n]
  if { $string == "" } return

  if { $channel == "" } { set channel $wintype ; set name $winname }
  if { $name == "" } {
    set name $channel
    if { $wintype != "status" } {
      set name [string tolower $winname]
    } else {
      set name status
    }
  }

  if { $channel == "status" } { set name status }
  set name [string tolower $name]

  lappend relaytext($name) $string

  base_echo $string $channel $name

  if { $grep_for != "" } {
    if { [string match *[string tolower $grep_for]* [string tolower [strip $string]]] } {
      base_echo "[dbullet] [eheader "Grep"] $string"
      set x "[open "[get_syn_dir]/syntax/logs/grep.log" a+]" ; puts $x [strip $string] ; close $x
    }
  }
}
alias searchw {
  if { "[lindex [args] 0]" == "?" } { /help searchw ; complete; return }
  if { ![string length [lindex [args] 0]] } { synecho searchw "[eheader "SearchW"] You must specify a word to search the window for..."
  } else {
    set found 0
    set chan [string tolower [window name]]
    if ![info exists relaytext($chan)] { synecho searchw "[eheader "SearchW"] No text to search..." ; complete ; return }
    set text $relaytext($chan)
    set match [lindex [args] 0]
    if ![string match {[*?]} $match] { set match *[string tolower $match]* ; set low 1 } { set low 0 }
    synecho searchw "[eheader "SearchW"] Searching [llength $text] lines back..."
    foreach i $text {
      if $low { set j [string tolower $i] } else { set j $i }
      set j [powerstrip $j]
      if { [string match $match $j] } {
        if !$found {
          set found 1
          synecho searchw "[eheader "SearchW"] Found The following lines:"
          synechox searchw $i
        } else {
          synechox searchw $i
        }
      }
    }
    if !$found { synecho searchw "[eheader "SearchW"] No lines where found to contain $match..." } { synecho searchw "[eheader "SearchW"] End of Lines List..." }
  }
  killpipe searchw
  complete
}
alias grep {
  if { [raw_args] == "" } {
    set grep_old $grep_for
    set grep_for ""
    synecho grep "[eheader "Grep"] Turning off grep for $grep_old..."
    set x "[open "[get_syn_dir]/syntax/logs/grep.log" a+]" ; puts $x "Turning off grep for $grep_old" ; close $x
  } else {
    synecho grep "[eheader "Grep"] Turning on grep for [raw_args]"
    set grep_for [raw_args]
    set x "[open "[get_syn_dir]/syntax/logs/grep.log" a+]" ; puts $x "Turning on grep for [raw_args]" ; close $x
  }
  killpipe grep
  complete
}
alias flush_log {
	if { [llength [args]] == 0 } {
		set chan_list [channels]
	} else {
		set chan_list [list [string tolower [join [args]]]]
	}

	foreach chan $chan_list {
		set fileid [open "[get_syn_dir]/syntax/logs/$chan.log" a]

		if { [catch {set text $relaytext($chan)}] } {
			continue
		}
		
	  foreach line $text {
	    set line [powerstrip $line]
	    puts $fileid $line
	  }
	
	  close $fileid
	  unset relaytext($chan)
	}
	complete
}
alias rspy {
  global spylinks
  if {"[lindex [args] 0]" == "?"} { /help rspy ; complete ; return }
  if {![string length [lindex [args] 0]]} { synecho rspy "[eheader "Spy"] You must specify a location to remove the link from..."
  } else {
    foreach link $spylinks {
      if {[lindex $link 0] == [string tolower [lindex [args] 0]]} {
        synecho rspy "[eheader "Spy"] Spylink broken from [sb][string tolower [lindex [args] 0]][sb] to [sb][lindex $link 1][sb]..."
        set spylinks [rflist $spylinks $link]
        set flag 1
      }
    }
    if {[info exists flag]} { unset flag
    } else { synecho rspy "[eheader "Spy"] No matching spylinks found..." }
  }
  killpipe rspy
  noidle
  complete
}
alias reload {
  synecho reload "[eheader "Reload"] Reloading..."
  killpipe reload
  complete
  after idle { /load $synpath }
}
proc autoaccdcc { mask } {
  foreach mm "[split [get_cookie dccautoaceept "none"]]" {
    if {[wmatch $mm $mask]} { return 1 }
  }
  return 0
}
alias gt {
  input set_text "/topic [channel] [topic [channel]]"
  input set_sel_start [string length [split [input get_text]]]
  complete
}
alias dcc {
  if {"[lindex [args] 0]" == "?"} { /help dcc ; complete ; return }
  if {[string tolower [lindex [args] 0]] == "tsend"} {
    /tdcc send [join [lrange [args] 1 end]]
    complete
  } elseif {[string tolower [lindex [args] 0]] == "cancel"} {
    if {[isnum [lindex [args] 1]]} {
      for { set dccx 0 } { $dccx < [dcc_count] } { incr dccx } {
        if {[string tolower [lindex [dcc_info $dccx] 0]] != "send" && [string tolower [lindex [dcc_info $dccx] 0]] != "get"} {
          incr dccx
        }
        if {$dccx == [expr [lindex [args] 1] - 1]} {
          dcc_cancel $dccx
          set flag 1
          break
        }
      }
      if {![info exists flag]} {
        synecho dcc "[eheader "dcc"] No such dcc index ([b][lindex [args] 1][b])..."
      } else {
        unset flag
      }
    } else {
      for { set dccx 0 } { $dccx < [dcc_count] } { incr dccx } {
        if {[string tolower [lindex [dcc_info $dccx] 2]] == [string tolower [lindex [args] 1]]} {
          dcc_cancel $dccx
          set flag 1
          break
        }
      }
      if {![info exists flag]} {
        synecho dcc "[eheader "dcc"] No dccs active to\\from [b][lindex [args] 1][b]..."
      } else {
        unset flag
      }
    }
    complete
  } elseif {[string tolower [lindex [args] 0]] != "chat" && [string tolower [lindex [args] 0]] != "close" && [string tolower [lindex [args] 0]] != "tsend" && [string tolower [lindex [args] 0]] != "send" && [string tolower [lindex [args] 0]] != "get"} {
    if {[dcc_count] == "0"} { synecho dcc "[eheader "dcc"] You currently have no dccs active..."
    } else {
      synecho dcc "[boxtop "[b]dcc Status[b] [sb](([sb][su]dccs:[su] [b][dcc_count][b][sb]))[sb]"]"
      for { set dccx 0 } { $dccx < [dcc_count] } { incr dccx } {
        set info "[dcc_info $dccx]"
        set type "[lindex $info 0]"
        set start "[lindex $info 1]"
        set nick "[lindex $info 2]"
        set filename "[lindex $info 3]"
        set complete "[lindex $info 4]"
        set total "[lindex $info 5]"
        set elapsed "[lindex $info 6]"
        set remaining "[lindex $info 7]"
        set speed "[lindex $info 8]"
        if {$speed == "-1.0000"} { set speed "inactive" }
        if {$elapsed == "-1"} { set elapsed "inactive" }
        set pbar "[percentbar [lindex $info 4] [lindex $info 5]]"
        synecho dcc "[boxside "[applydccline1 [expr $dccx + 1] $type $start $nick $filename $complete $total $elapsed $remaining $speed $pbar]"]"
        if {[string length theme(dccline2)]} { synecho dcc "[boxside "[applydccline2 [expr $dccx + 1] $type $start $nick $filename $complete $total $elapsed $remaining $speed $pbar]"]" }
      }
      synecho dcc "[boxbottom "[b]dcc Status[b] [sb](([sb][su]dccs:[su] [b][dcc_count][b][sb]))[sb]"]"
    }
    killpipe dcc
    noidle
    complete
  }
  noidle
}
proc cmode { chan } {
  set chan "[string tolower $chan]"
  if {![string length [lindex [get_cookie cmode($chan)] 0]]} { return "+"
  } else { return "[lindex [get_cookie cmode($chan)] 0]" }
}
alias cmode {
  if {"[lindex [args] 0]" == "?"} { /help cmode ; complete ; return }
  if {![string length [lindex [args] 0]]} {
    if {[string length [get_cookie cmode]]} {
      synecho cmode "[boxtop "[b]Channel Modes[b] [sb](([sb][su]entries:[su] [b][llength [get_cookie cmode]][b][sb]))[sb]"]"
      set num 0
      foreach xx [get_cookie cmode] {
        if {[info exists onlyone] && $xx == $onlyone} { set flag 1
        } elseif {[info exists onlyone] && $xx != $onlyone} { set flag 0
        } else { set flag 1 }
        incr num
        if {$flag} {
          if {[lindex [get_cookie cmode($xx)] 2] == "off"} { set ml "[b]+[b]"
          } else { set ml "[b][lindex [get_cookie cmode($xx)] 2][b]" }
          if {[lindex [lindex [get_cookie cmode($xx)] 4] 0] == "0"} { set textfloodx "off"
          } else { set textfloodx "[b][lindex [lindex [get_cookie cmode($xx)] 4] 0][b] in [b][lindex [lindex [get_cookie cmode($xx)] 4] 1][b]" }
          if {[lindex [lindex [get_cookie cmode($xx)] 5] 0] == "0"} { set viofloodx "off"
          } else { set viofloodx "[b][lindex [lindex [get_cookie cmode($xx)] 5] 0][b] in [b][lindex [lindex [get_cookie cmode($xx)] 5] 1][b]" }
          if {[lindex [lindex [get_cookie cmode($xx)] 6] 0] == "0"} { set nickfloodx "off"
          } else { set nickfloodx "[b][lindex [lindex [get_cookie cmode($xx)] 6] 0][b] in [b][lindex [lindex [get_cookie cmode($xx)] 6] 1][b]" }
          if {[lindex [get_cookie cmode($xx)] 7] == "0"} { set maxlengthx "off"
          } else { set maxlengthx "[b][lindex [get_cookie cmode($xx)] 7][b]" }
          if {[lindex [get_cookie cmode($xx)] 13] == "0"} { set maxviox "off"
          } else { set maxviox "[b][lindex [get_cookie cmode($xx)] 13][b]" }
          if {[lindex [lindex [get_cookie cmode($xx)] 8] 0] == "0"} { set massdeopx "off"
          } else { set massdeopx "[b][lindex [lindex [get_cookie cmode($xx)] 8] 0][b] in [b][lindex [lindex [get_cookie cmode($xx)] 8] 1][b]" }
          if {[lindex [lindex [get_cookie cmode($xx)] 9] 0] == "0"} { set masskickx "off"
          } else { set masskickx "[b][lindex [lindex [get_cookie cmode($xx)] 9] 0][b] in [b][lindex [lindex [get_cookie cmode($xx)] 9] 1][b]" }
          if {[lindex [lindex [get_cookie cmode($xx)] 10] 0] == "0"} { set joinfloodx "off"
          } else { set joinfloodx "[b][lindex [lindex [get_cookie cmode($xx)] 10] 0][b] in [b][lindex [lindex [get_cookie cmode($xx)] 10] 1][b]" }
          synecho cmode "[boxside "[llb][b][align $num 2][b][lrb][sb]<<[sb][b][align $xx 18][b][sb]>>[sb]<[align "[b]internal:[b] [lindex [get_cookie cmode($xx)] 0]" 42]>"]"
          synecho cmode "[boxside "[llb]  [lrb][llb][align "[sb]textflood[sb]: $textfloodx" 20][lrb][llb][align "[sb]nickflood[sb]: $nickfloodx" 20][lrb][llb][align "[sb]joinflood[sb]: $joinfloodx" 20][lrb]"]"
          synecho cmode "[boxside "[llb]  [lrb][llb][align "[sb]masskick [sb]: $masskickx" 20][lrb][llb][align "[sb]massdeop [sb]: $massdeopx" 20][lrb][llb][align "[sb]vioflood [sb]: $viofloodx" 20][lrb]"]"
          synecho cmode "[boxside "[llb]  [lrb][llb][align "[sb]maxlength[sb]: $maxlengthx" 20][lrb][llb][align "[sb]maxvio   [sb]: $maxviox" 20][lrb][llb][align "[sb]mlock    [sb]: $ml" 20][lrb]"]"
          if {[lindex [get_cookie cmode($xx)] 3] != "off"} { synecho cmode "[boxside "[llb]  [lrb][llb][align "[sb]topiclock[sb]: [lindex [get_cookie cmode($xx)] 3]" 64][lrb]"]" }
          if {[lindex [get_cookie cmode($xx)] 12] != "off"} { synecho cmode "[boxside "[llb]  [lrb][llb][align "[sb]lockmessage[sb]: [lindex [get_cookie cmode($xx)] 12]" 64][lrb]"]" }
          set yy 0 ; foreach wk [lindex [get_cookie cmode($xx)] 1] { if {$wk != "off"} { incr yy ; synecho cmode "[boxside "[llb][sb][align $yy 2][sb][lrb][llb][align "[sb]wordkick[sb]: [lindex $wk 0]" 20][lrb][llb][align "[sb]reason[sb]: [lindex $wk 1]" 42][lrb]"]" } }
          if {$num != [llength [get_cookie cmode]] && ![info exists onlyone]} { synecho cmode "[boxside ""]" }
        }
        unset flag
      }
      synecho cmode "[boxbottom "[b]Channel Modes[b] [sb](([sb][su]entries:[su] [b][llength [get_cookie cmode]][b][sb]))[sb]"]"
      if {[info exists onlyone]} { unset onlyone }
    } else {
      synecho cmode "[eheader "Mode"] You currently have no channels on your internal database..."
    }
  } elseif {[lindex [args] 0] == "del" || [lindex [args] 0] == "-del" || [lindex [args] 0] == "-delete"} {
    if {![string length [lindex [args] 1]]} { synecho cmode "[eheader "Mode"] You must specify a channel to delete..."
    } elseif {[isnum [lindex [args] 1]]} {
      set countt "0"
      set la ""
      foreach chan [get_cookie cmode] {
        incr countt
        if {$countt == "[lindex [args] 1]"} {
          set flag "$chan"
        } else {
          lappend la "$chan"
        }
      }
      set_cookie cmode "$la"
      if {[info exists flag]} { synecho cmode "[eheader "Mode"] Removed cmode entry for ([b]$flag[b])..."
      } else { synecho cmode "[eheader "Mode"] Could not locate cmode entry ([b]#[lindex [args] 1][b])..." }
    } elseif {![isin [get_cookie cmode] [lindex [args] 1]]} { synecho cmode "[eheader "Mode"] That channel does not have a cmode entry..."
    } else {
      set_cookie cmode([string tolower [lindex [args] 1]]) ""
      set_cookie cmode "[rflist [get_cookie cmode] "[string tolower [lindex [args] 1]]"]"
      synecho cmode "[eheader "Mode"] Removed cmode entry for ([b][string tolower [lindex [args] 1]][b])..."
    }
  } else {
    if {[string match #* [lindex [args] 0]]} { set chan "[string tolower [lindex [args] 0]]" ; set args "x [lrange [args] 1 end]"
    } elseif {[string match #* [window_name]]} { set chan "[string tolower [window_name]]" ; set args "x [lrange [args] 0 end]"
    } else { set chan "" }
    if {[string length $chan]} {
      set xx "[lindex $args 1]"
      if {![string length $xx]} { set xx "+" }
      if {[isin [get_cookie cmode] $chan]} {
        if {$xx == "+"} {
          set onlyone "$chan"
          /cmode
        } elseif {$xx == "+wordkick"} {
          if {![string length [lindex $args 2]]} {
            synecho cmode "[eheader "Mode"] You must specify a word to place a kick on..."
          } elseif {![string length [lindex $args 3]]} {
            synecho cmode "[eheader "Mode"] You must specify a reason for the wordkick..."
          } else {
            set one "[lindex $args 2]"
            set two "[join [lrange $args 3 end]]"
            if {[lrange [get_cookie cmode($chan)] 1 1] == "off"} { set_cookie cmode($chan) "[lrange [get_cookie cmode($chan)] 0 0] [list [list "[list $one] [list $two]"]] [lrange [get_cookie cmode($chan)] 2 end]"
            } else { set_cookie cmode($chan) "[lrange [get_cookie cmode($chan)] 0 0] [list "[atlist "[join [lrange [get_cookie cmode($chan)] 1 1]]" "[list $one] [list $two]"]"] [lrange [get_cookie cmode($chan)] 2 end]" }
            synecho cmode "[eheader "Mode"] Added wordkick on [b]$chan[b] for ([b]$one[b]) with reason: [sb]$two[sb]"
          }
        } elseif {$xx == "-wordkick"} {
          if {![string length [lindex $args 2]]} {
            synecho cmode "[eheader "Mode"] Removed all wordkicks on [b]$chan[b]..."
            set_cookie cmode($chan) "[lrange [get_cookie cmode($chan)] 0 0] [list "off"] [lrange [get_cookie cmode($chan)] 2 end]"
          } else {
            set new ""
            set yy 0
            foreach zxc [join [lrange [get_cookie cmode($chan)] 1 1]] {
              incr yy
              if {[string tolower [lindex $zxc 0]] == [string tolower [lindex $args 2]] || [string tolower [lindex $args 2]] == $yy && [string tolower [lindex $zxc 0]] != "off"} {
                set flag 1
                set one "[lindex $zxc 0]"
                set two "[lindex $zxc 1]"
              } else {
                lappend new "$zxc"
              }
            }
            if {![string length $new]} { set new "off" }
            set_cookie cmode($chan) "[lrange [get_cookie cmode($chan)] 0 0] [list "$new"] [lrange [get_cookie cmode($chan)] 2 end]"
            if {[info exists flag]} { synecho cmode "[eheader "Mode"] Removed wordkick on [b]$chan[b] for ([b]$one[b]) with reason: [sb]$two[sb]" ; unset flag
            } else { synecho cmode "[eheader "Mode"] No wordkicks found matching ([b][lindex $args 2][b]) on [b]$chan[b]..." }
          }
        } elseif {$xx == "-modelock"} {
          if {![string length [lindex $args 2]] || [lindex $args 2] == "0" || [lindex $args 2] == "+"} {
            set one "off"
          } else {
            set one "[join [lrange $args 2 end]]"
          }
          set_cookie cmode($chan) "[lrange [get_cookie cmode($chan)] 0 1] [list "$one"] [lrange [get_cookie cmode($chan)] 3 end]"
          if {[lindex [get_cookie cmode($chan)] 2] == "off"} { synecho cmode "[eheader "Mode"] Mode Lock for [b]$chan[b] is now [b]off[b]..."
          } else { synecho cmode "[eheader "Mode"] Mode Lock for [b]$chan[b] is now set to: [b][lindex [get_cookie cmode($chan)] 2][b]" }
        } elseif {$xx == "-topiclock"} {
          if {![string length [lindex $args 2]] || [lindex $args 2] == "0"} {
            set one "off"
          } else {
            set one "[join [lrange $args 2 end]]"
          }
          set_cookie cmode($chan) "[lrange [get_cookie cmode($chan)] 0 2] [list "$one"] [lrange [get_cookie cmode($chan)] 4 end]"
          if {[lindex [get_cookie cmode($chan)] 3] == "off"} { synecho cmode "[eheader "Mode"] Topic Lock for [b]$chan[b] is now [b]off[b]..."
          } else { synecho cmode "[eheader "Mode"] Topic Lock for [b]$chan[b] is now set to: [b][lindex [get_cookie cmode($chan)] 3][b]" }
        } elseif {$xx == "-textflood"} {
          if {[lindex $args 2] == "off"} {
            set one "0"
            set two "0"
          } elseif {[string match *:* [lindex $args 2]] || [string match *-* [lindex $args 2]]} {
            if {![isnum [lindex [split [lindex $args 2] ":-"] 0]]} { set one "0" } else { set one "[lindex [split [lindex $args 2] ":-"] 0]" }
            if {![isnum [lindex [split [lindex $args 2] ":-"] 1]]} { set two "0" } else { set two "[lindex [split [lindex $args 2] ":-"] 1]" }
          } else {
            if {![isnum [lindex $args 2]]} { set one "0" } else { set one "[lindex $args 2]" }
            if {![isnum [lindex $args 3]]} { set two "0" } else { set two "[lindex $args 3]" }
          }
          set_cookie cmode($chan) "[lrange [get_cookie cmode($chan)] 0 3] [list "$one $two"] [lrange [get_cookie cmode($chan)] 5 10]"
          if {[lindex [lindex [get_cookie cmode($chan)] 4] 0] == "0" || [lindex [lindex [get_cookie cmode($chan)] 4] 1] == "0"} { synecho cmode "[eheader "Mode"] Text Flood for [b]$chan[b] is now [b]off[b]..."
          } else { synecho cmode "[eheader "Mode"] Text Flood for [b]$chan[b] is now triggered with [b][lindex [lindex [get_cookie cmode($chan)] 4] 0][b] lines in [b][lindex [lindex [get_cookie cmode($chan)] 4] 1][b] seconds..." }
        } elseif {$xx == "-violationflood" || $xx == "-vioflood"} {
          if {[lindex $args 2] == "off"} {
            set one "0"
            set two "0"
          } elseif {[string match *:* [lindex $args 2]] || [string match *-* [lindex $args 2]]} {
            if {![isnum [lindex [split [lindex $args 2] ":-"] 0]]} { set one "0" } else { set one "[lindex [split [lindex $args 2] ":-"] 0]" }
            if {![isnum [lindex [split [lindex $args 2] ":-"] 1]]} { set two "0" } else { set two "[lindex [split [lindex $args 2] ":-"] 1]" }
          } else {
            if {![isnum [lindex $args 2]]} { set one "0" } else { set one "[lindex $args 2]" }
            if {![isnum [lindex $args 3]]} { set two "0" } else { set two "[lindex $args 3]" }
          }
          set_cookie cmode($chan) "[lrange [get_cookie cmode($chan)] 0 4] [list "$one $two"] [lrange [get_cookie cmode($chan)] 6 end]"
          if {[lindex [lindex [get_cookie cmode($chan)] 5] 0] == "0" || [lindex [lindex [get_cookie cmode($chan)] 5] 1] == "0"} { synecho cmode "[eheader "Mode"] Violation Flood for [b]$chan[b] is now [b]off[b]..."
          } else { synecho cmode "[eheader "Mode"] Violation Flood for [b]$chan[b] is now triggered with [b][lindex [lindex [get_cookie cmode($chan)] 5] 0][b] changes in [b][lindex [lindex [get_cookie cmode($chan)] 5] 1][b] seconds..." }
        } elseif {$xx == "-nickflood"} {
          if {[lindex $args 2] == "off"} {
            set one "0"
            set two "0"
          } elseif {[string match *:* [lindex $args 2]] || [string match *-* [lindex $args 2]]} {
            if {![isnum [lindex [split [lindex $args 2] ":-"] 0]]} { set one "0" } else { set one "[lindex [split [lindex $args 2] ":-"] 0]" }
            if {![isnum [lindex [split [lindex $args 2] ":-"] 1]]} { set two "0" } else { set two "[lindex [split [lindex $args 2] ":-"] 1]" }
          } else {
            if {![isnum [lindex $args 2]]} { set one "0" } else { set one "[lindex $args 2]" }
            if {![isnum [lindex $args 3]]} { set two "0" } else { set two "[lindex $args 3]" }
          }
          set_cookie cmode($chan) "[lrange [get_cookie cmode($chan)] 0 5] [list "$one $two"] [lrange [get_cookie cmode($chan)] 7 10]"
          if {[lindex [lindex [get_cookie cmode($chan)] 6] 0] == "0" || [lindex [lindex [get_cookie cmode($chan)] 6] 1] == "0"} { synecho cmode "[eheader "Mode"] Nick Flood for [b]$chan[b] is now [b]off[b]..."
          } else { synecho cmode "[eheader "Mode"] Nick Flood for [b]$chan[b] is now triggered with [b][lindex [lindex [get_cookie cmode($chan)] 6] 0][b] changes in [b][lindex [lindex [get_cookie cmode($chan)] 6] 1][b] seconds..." }
        } elseif {$xx == "-maxlength" || $xx == "-overflow"} {
          if {[lindex $args 2] == "off"} {
            set one "0"
          } elseif {![isnum [lindex $args 2]]} { set one "0" } else { set one "[lindex $args 2]" }
          set_cookie cmode($chan) "[lrange [get_cookie cmode($chan)] 0 6] [list "$one"] [lrange [get_cookie cmode($chan)] 8 end]"
          if {[lindex [get_cookie cmode($chan)] 7] == "0"} { synecho cmode "[eheader "Mode"] Maximum string length for [b]$chan[b] is now [b]off[b]..."
          } else { synecho cmode "[eheader "Mode"] Maximum string length for [b]$chan[b] is now [b][lindex [get_cookie cmode($chan)] 7][b] characters..." }
        } elseif {$xx == "-massdeop"} {
          if {[lindex $args 2] == "off"} {
            set one "0"
            set two "0"
          } elseif {[string match *:* [lindex $args 2]] || [string match *-* [lindex $args 2]]} {
            if {![isnum [lindex [split [lindex $args 2] ":-"] 0]]} { set one "0" } else { set one "[lindex [split [lindex $args 2] ":-"] 0]" }
            if {![isnum [lindex [split [lindex $args 2] ":-"] 1]]} { set two "0" } else { set two "[lindex [split [lindex $args 2] ":-"] 1]" }
          } else {
            if {![isnum [lindex $args 2]]} { set one "0" } else { set one "[lindex $args 2]" }
            if {![isnum [lindex $args 3]]} { set two "0" } else { set two "[lindex $args 3]" }
          }
          set_cookie cmode($chan) "[lrange [get_cookie cmode($chan)] 0 7] [list "$one $two"] [lrange [get_cookie cmode($chan)] 9 end]"
          if {[lindex [lindex [get_cookie cmode($chan)] 8] 0] == "0" || [lindex [lindex [get_cookie cmode($chan)] 8] 1] == "0"} { synecho cmode "[eheader "Mode"] Mass Deop for [b]$chan[b] is now [b]off[b]..."
          } else { synecho cmode "[eheader "Mode"] Mass Deop for [b]$chan[b] is now triggered with [b][lindex [lindex [get_cookie cmode($chan)] 8] 0][b] deops in [b][lindex [lindex [get_cookie cmode($chan)] 8] 1][b] seconds..." }
        } elseif {$xx == "-masskick"} {
          if {[lindex $args 2] == "off"} {
            set one "0"
            set two "0"
          } elseif {[string match *:* [lindex $args 2]] || [string match *-* [lindex $args 2]]} {
            if {![isnum [lindex [split [lindex $args 2] ":-"] 0]]} { set one "0" } else { set one "[lindex [split [lindex $args 2] ":-"] 0]" }
            if {![isnum [lindex [split [lindex $args 2] ":-"] 1]]} { set two "0" } else { set two "[lindex [split [lindex $args 2] ":-"] 1]" }
          } else {
            if {![isnum [lindex $args 2]]} { set one "0" } else { set one "[lindex $args 2]" }
            if {![isnum [lindex $args 3]]} { set two "0" } else { set two "[lindex $args 3]" }
          }
          set_cookie cmode($chan) "[lrange [get_cookie cmode($chan)] 0 8] [list "$one $two"] [lrange [get_cookie cmode($chan)] 10 end]"
          if {[lindex [lindex [get_cookie cmode($chan)] 9] 0] == "0" || [lindex [lindex [get_cookie cmode($chan)] 9] 1] == "0"} { synecho cmode "[eheader "Mode"] Mass Kick for [b]$chan[b] is now [b]off[b]..."
          } else { synecho cmode "[eheader "Mode"] Mass Kick for [b]$chan[b] is now triggered with [b][lindex [lindex [get_cookie cmode($chan)] 9] 0][b] kicks in [b][lindex [lindex [get_cookie cmode($chan)] 9] 1][b] seconds..." }
        } elseif {$xx == "-joinflood"} {
          if {[lindex $args 2] == "off"} {
            set one "0"
            set two "0"
          } elseif {[string match *:* [lindex $args 2]] || [string match *-* [lindex $args 2]]} {
            if {![isnum [lindex [split [lindex $args 2] ":-"] 0]]} { set one "0" } else { set one "[lindex [split [lindex $args 2] ":-"] 0]" }
            if {![isnum [lindex [split [lindex $args 2] ":-"] 1]]} { set two "0" } else { set two "[lindex [split [lindex $args 2] ":-"] 1]" }
          } else {
            if {![isnum [lindex $args 2]]} { set one "0" } else { set one "[lindex $args 2]" }
            if {![isnum [lindex $args 3]]} { set two "0" } else { set two "[lindex $args 3]" }
          }
          set_cookie cmode($chan) "[lrange [get_cookie cmode($chan)] 0 9] [list "$one $two"] [lrange [get_cookie cmode($chan)] 11 end]"
          if {[lindex [lindex [get_cookie cmode($chan)] 10] 0] == "0" || [lindex [lindex [get_cookie cmode($chan)] 10] 1] == "0"} { synecho cmode "[eheader "Mode"] Join Flooding for [b]$chan[b] is now [b]off[b]..."
          } else { synecho cmode "[eheader "Mode"] Join Flooding for [b]$chan[b] is now triggered with [b][lindex [lindex [get_cookie cmode($chan)] 10] 0][b] joins in [b][lindex [lindex [get_cookie cmode($chan)] 10] 1][b] seconds..." }
        } elseif {$xx == "-lock" || $xx == "-lockmsg"} {
          if {[lindex $args 2] == "off" || ![string length [lindex $args 2]]} {
            set one "off"
          } else {
            set one "[join [lrange $args 2 end]]"
          }
          set_cookie cmode($chan) "[lrange [get_cookie cmode($chan)] 0 11] [list "$one"] [lrange [get_cookie cmode($chan)] 12 end]"
          if {[lindex [get_cookie cmode($chan)] 12] == "off"} { synecho cmode "[eheader "Mode"] Channel Lock message for [b]$chan[b] is now [b]default[b]..."
          } else { synecho cmode "[eheader "Mode"] Channel Lock message for [b]$chan[b] is now: [sb]$one[sb]" }
        } elseif {$xx == "-vio" || $xx == "-maxvio"} {
          if {[lindex $args 2] == "off" || ![string length [lindex $args 2]] || ![isnum [lindex $args 2]]} {
            set one "0"
          } else {
            set one "[join [lrange $args 2 end]]"
          }
          set_cookie cmode($chan) "[lrange [get_cookie cmode($chan)] 0 12] [list "$one"]"
          if {[lindex [get_cookie cmode($chan)] 13] == "0"} { synecho cmode "[eheader "Mode"] Violation maximum for [b]$chan[b] is now [b]off[b]..."
          } else { synecho cmode "[eheader "Mode"] Violation maximum for [b]$chan[b] is now ([b]$one[b])..." }
        } else {
          set_cookie cmode($chan) "[list "[sortby [modmode "[lindex [get_cookie cmode($chan)] 0]" "$xx"] "$mstring"]"] [lrange [get_cookie cmode($chan)] 1 end]"
          synecho cmode "[eheader "Mode"] Channel modes for [b]$chan[b] changed to ([b][lindex [get_cookie cmode($chan)] 0][b])..."
        }
      } else {
        set xx "[lindex $args 1]"
        if {![string length $xx] || [string range $xx 0 0] != "+"} { set xx "+" }
        set_cookie cmode($chan) "[list "[sortby $xx $mstring]"] [list "off"] [list "off"] [list "off"] [list "0 0"] [list "0"] [list "0 0"] [list "0"] [list "0 0"] [list "0 0"] [list "0 0"] [list "0 0"] [list "off"] [list "0"]"
        set_cookie cmode "[atlist [get_cookie cmode] "$chan"]"
        synecho cmode "[eheader "Mode"] Added [b]$chan[b] with ([b][lindex [get_cookie cmode($chan)] 0][b]) to channel mode list..."
      }
    } else { synecho cmode "[eheader "Mode"] Invalid channel specified..." }
  }
  noidle
  killpipe cmode
  complete
}
alias theme {
  set totalthemes 1
  set command ""
  if {![string length [args]]} {
    foreach pewt "[glob -nocomplain [get_syn_dir]/syntax/themes/*.thm *.thm]" {
      set searchfile [open "$pewt" r]
      set xx [gets $searchfile]
      if {$xx == "@define@ syntax theme"} {
        set xx [gets $searchfile]
        set pert "[string range $xx 9 end]"
        if {![string length $pert]} { set pert "???" }
        lappend command "[boxside "[llb][align $totalthemes 2][lrb][llb][align [replace "$pewt" "/" "\\"] 25][lrb][llb][align $pert 25][lrb]"]"
        incr totalthemes
      }
      close $searchfile
    }
    if {$totalthemes != "1"} {
      synecho theme "[boxtop "[b]Themes Listing[b] [sb](([sb][su]scripts:[su] [b][expr $totalthemes - 1][b][sb]))[sb]"]"
      synecho theme "[boxside "[llb][b]# [b][lrb][llb][b]File:                    [b][lrb][llb][b]Theme Name:              [b][lrb]"]"
      foreach line $command { synecho theme "$line" }
      synecho theme "[boxbottom "[b]Themes Listing[b] [sb](([sb][su]scripts:[su] [b][expr $totalthemes - 1][b][sb]))[sb]"]"
    } else {
      synecho theme "[eheader "Theme"] You currently have no themes on your disk..."
    }
  } elseif {[isnum [lindex [args] 0]]} {
    foreach pewt "[glob -nocomplain [get_syn_dir]/syntax/themes/*.thm *.thm]" {
      set searchfile [open "$pewt" r]
      set xx [gets $searchfile]
      if {$xx == "@define@ syntax theme"} {
        incr totalthemes
        close $searchfile
        if {[lindex [args] 0] == [expr $totalthemes - 1]} { set flag 1 ; /ltheme $pewt }
      } else {
        close $searchfile
      }
    }
    if {[info exists flag]} { unset flag
    } else { synecho theme "[eheader "Theme"] The theme number ([b][lindex [args] 0][b]) could not be located..." }
    if {$totalthemes == "1"} {
      synecho theme "[eheader "Theme"] You currently have no themes on your disk..."
    }
  } else {
    /ltheme [lindex [args] 0]
  }
  killpipe theme
  noidle
  complete
}
alias loadtheme {
  if {"[lindex [args] 0]" == "?"} { /help loadtheme ; complete ; return }
  if {![string length [lindex [args] 0]]} { synecho loadtheme "[eheader "Theme"] Please specify a filename to load from..."
  } elseif {![file exists [lindex [args] 0]]} { synecho loadtheme "[eheader "Theme"] Invalid theme file specified ([b][lindex [args] 0][b])..."
  } else {
    loadtheme [lindex [args] 0] 1
  }
  killpipe loadtheme
  noidle
  complete
}
proc loadtheme { x y } {
  global theme stylevar
  set flag ""
  set themeid ""
  set hazauth 0
  if {![wmatch *\\* $x]} { set zfile "[replace [get_syn_dir] "/" "\\"]\\$x"
  } else { set zfile "$x" }
  if {$y} { synecho loadtheme "[eheader "Theme"] Loading theme from file ([b][file tail $zfile][b])..." }
  set searchfile [open "$zfile" r]
  foreach svar [array names stylevar] { unset stylevar($svar) }
  while {![eof $searchfile]} {
    set xx "[gets $searchfile]"
    set varr 0
    set newh ""
    foreach xy [split $xx] {
      if {![string length $xy] && $varr == "2"} {
      } elseif {$varr > 2} { lappend newh "$xy"
      } else { lappend newh "$xy" ; incr varr }
    }
    set args "$newh"
    if {[lindex $args 0] == "stylevar"} {
      set stylevar([lindex $args 1]) "[join [lrange $args 2 end]]"
      eval "proc [lindex $args 1] \{ \} \{ global stylevar \; return \"\[eval \"return \$stylevar\([lindex $args 1]\)\"\]\" \}"
    } elseif {[lindex $args 0] == "themeecho" && $y} {
      set text "[join [lrange $args 1 end]]"
      eval "synecho loadtheme \"\[eheader \"Theme\"\] [string range $text 1 [expr {[string length $text] - 2}]]\""
    } elseif {[lindex $args 0] == "exec"} {
      set text "[join [lrange $args 1 end]]"
      eval "[string range $text 1 [expr {[string length $text] - 2}]]"
    } elseif {[lindex $args 0] == "styleset"} {
      set theme([lindex $args 1]) "[join [lrange $args 2 end]]"
    }
  }
  close $searchfile
}
proc getcountry { x } {
  global cname ccode
  set x [string tolower $x]
  if {[isnum $x]} { set x "ip address"
  } else { set x [lindex $cname [lsearch $ccode "$x"]] }
  if {![string length $x]} { set x "Unknown" }
  return $x
}
alias stats {
  if {[lindex [args] 0] == "L"} { lappend statslqueue "stats [lindex [args] 1]" }
}
alias frelsm {
  if {"[lindex [args] 0]" == "?"} { /help frelsm ; complete ; return }
  if {![string length [lindex [args] 0]]} { synecho frelsm "[eheader "FakeRelay"] Please specify who you messaged..."
  } elseif {![string length [lindex [args] 1]]} { synecho frelsm "[eheader "FakeRelay"] Please specify what you said..."
  } else {
    set dest "[window_name]"
    set text [applyrelsmvars "[lindex [args] 0]" "msg" "[join [lrange [args] 1 end]]"]
    /raw privmsg $dest :$text
    if {[isin [string tolower [channels]] [string tolower $dest]]} { echo "[applyselftext "[my_nick]" "$text"]" channel $dest ; spylink $dest "[applyselftext "[my_nick]" "$text"]"
    } elseif {[isin [string tolower [queries]] [string tolower $dest]]} { echo "[applyselftext "[my_nick]" "$text"]" query $dest ; spylink $dest "[applyselftext "[my_nick]" "$text"]"
    } else { echo "[applysmsgstyle "$dest" "$text"]" ; spylink $dest "[applysmsgstyle "$dest" "$text"]" }
  }
  killpipe frelsm
  noidle
  complete
}
alias frelm {
  if {"[lindex [args] 0]" == "?"} { /help frelm ; complete ; return }
  if {![string length [lindex [args] 0]]} { synecho frelsm "[eheader "FakeRelay"] Please specify a nickname to fake the message from..."
  } elseif {![string length [lindex [args] 1]]} { synecho frelsm "[eheader "FakeRelay"] Please specify something for that user to say..."
  } elseif {[info exists mask([lindex [args] 0])]} {
    set dest "[window_name]"
    set text [applyrelmvars "[lindex [split [getmask [lindex [args] 0]] "!@"] 0]" "[lindex [split [getmask [lindex [args] 0]] "!@"] 1]" "[lindex [split [getmask [lindex [args] 0]] "!@"] 2]" "msg" "[join [lrange [args] 1 end]]"]
    /raw privmsg $dest :$text
    if {[isin [string tolower [channels]] [string tolower $dest]]} { echo "[applyselftext "[my_nick]" "$text"]" channel $dest ; spylink $dest "[applyselftext "[my_nick]" "$text"]"
    } elseif {[isin [string tolower [queries]] [string tolower $dest]]} { echo "[applyselftext "[my_nick]" "$text"]" query $dest ; spylink $dest "[applyselftext "[my_nick]" "$text"]"
    } else { echo "[applysmsgstyle "$dest" "$text"]" ; spylink $dest "[applysmsgstyle "$dest" "$text"]" }
    killpipe frelm
  } elseif {[isnick [lindex [args] 0]]} {
    if {![info exists whoisqueue]} { set whoisqueue "" }
    lappend whoisqueue "frelm [window_name] [join [lrange [args] 1 end]]"
    addnullpipe whois
    whois [lindex [args] 0]
  } else { synecho frelsm "[eheader "FakeRelay"] Invalid nickname given..." }
  noidle
  complete
}
alias scheck {
  if {"[lindex [args] 0]" == "?"} { /help scheck ; complete ; return }
  if {![string length [lindex [args] 0]]} { synecho scheck "[eheader "SpoofTrace"] Please specify a nickname to trace..."
  } elseif {[isnick [lindex [args] 0]]} {
    if {![info exists whoisqueue]} { set whoisqueue "" }
    lappend whoisqueue "scheck [lindex [args] 0]"
    set nokill 1
    addnullpipe whois
    whois [lindex [args] 0]
  } else { synecho scheck "[eheader "SpoofTrace"] Invalid nickname given..." }

  noidle
  complete
}
alias ssave {
  if {"[lindex [args] 0]" == "?"} { /help ssave ; complete ; return }
  if {![string length [lindex [args] 0]]} { synecho ssave "[eheader "Save"] Please specify a filename to use for saving..."
  } else {
    if {![wmatch *\\* [lindex [args] 0]]} { set zfile "[replace [get_syn_dir] "/" "\\"]\\[lindex [args] 0]"
    } else { set zfile "[lindex [args] 0]" }
    set setfile [open "$zfile" w]
    synecho ssave "[eheader "Save"] Creating savefile ([b][file tail $zfile][b])..."
    puts $setfile "@define@ syntax datafile"
    synecho ssave "[eheader "Save"] Timestamping savefile ([sb][string tolower [clock format [clock seconds] -format "%m/%d/%y at %I:%M:%S%p"]][sb])..."
    puts $setfile "@create@ [string tolower [clock format [clock seconds] -format "%m/%d/%y at %I:%M:%S%p"]]"
    synecho ssave "[eheader "Save"] Writing settings to savefile..."
    foreach setting [array names config] {
      puts $setfile "[list "$setting"] [list "[config $setting]"]"
    }
    close $setfile
    synecho ssave "[eheader "Save"] Save process completed..."
  }
  killpipe ssave
  noidle
  complete
}
alias sload {
  if {"[lindex [args] 0]" == "?"} { /help sload ; complete ; return }
  if {![string length [lindex [args] 0]]} { synecho sload "[eheader "Load"] Please specify a filename to load from..."
  } elseif {![file exists [lindex [args] 0]]} { synecho sload "[eheader "Load"] Invalid settings file..."
  } else {
    set flag ""
    if {![wmatch *\\* [lindex [args] 0]]} { set zfile "[replace [get_syn_dir] "/" "\\"]\\[lindex [args] 0]"
    } else { set zfile "[lindex [args] 0]" }
    synecho sload "[eheader "Load"] Loading settings from file ([b][file tail $zfile][b])..."
    set searchfile [open "$zfile" r]
    set xx [gets $searchfile]
    if {$xx != "@define@ syntax datafile"} {
      synecho ssave "[eheader "Load"] File authentication failed... aborting..."
      break
    } else {
      synecho ssave "[eheader "Load"] File authenticated..."
    }
    set xx [gets $searchfile]
    if {[string range $xx 0 7] == "@create@"} {
      synecho ssave "[eheader "Load"] File created on ([b][string range $xx 9 end][b])..."
    } else {
      synecho ssave "[eheader "Load"] No creation date located..."
    }
    while {![eof $searchfile]} {
      set xx [gets $searchfile]
      if {[string length [string range $xx 0 4]]} {
        set_cookie config([lindex $xx 0]) "[lindex $xx 1]"
      }
    }
    if {![string length $flag]} { synecho sload "[eheader "Load"] Writing variables to registry..." ; synecho sload "[eheader "Load"] Load process successful..." }
    close $searchfile
  }
  killpipe sload
  noidle
  complete
}
alias wii {
  if {"[lindex [args] 0]" == "?"} { /help wii ; complete ; return }
  if {![string length [lindex [args] 0]]} { /wii [my_nick]
  } else {
    foreach user [split [args] ", "] { /whois [join $user] [join $user] }
  }
  noidle
  killpipe wii
  complete
}
alias whois {
  repipe wii whois
  repipe wi whois
  if {![string length [lindex [args] 0]]} { /wii [my_nick] ; complete }
}
alias massmsg { if {"[lindex [args] 0]" == "?"} { /help massmsg ; complete ; return } ; if {![string length [lindex [args] 0]]} { synecho massmsg "[eheader "MassMsg"] Please specify a mask to message..." } elseif {![string length [lrange [args] 1 end]]} { synecho massmsg "[eheader "MassMsg"] Please specify a message to send..." } else { set massmsg [join [lrange [args] 1 end]] ; synecho massmsg "[eheader "MassMsg"] Mass messaging ([b][lindex [args] 0][b]) with: $massmsg" ; if {![info exists whoqueue]} { set whoqueue "" } ; lappend whoqueue "massmsg [split [lindex [args] 0]] $massmsg" ; /raw who [lindex [args] 0] } ; noidle ; complete }
alias who {
  if {"[lindex [args] 0]" == "?"} { /help who ; complete ; return }
  set whotarg ""
  if {![string length [lindex [args] 0]]} { set whotarg "[channel]"
  } else { set whotarg [split [lindex [args] 0]] }
  if {[string length $whotarg]} {
    if {![info exists whoqueue]} { set whoqueue "" }
    lappend whoqueue "who $whotarg"
    /raw who [join $whotarg]
  } else { synecho who "[eheader "Who"] Invalid /who request given..." }
  noidle
  killpipe who
  complete
}
alias operscan {
  if {"[lindex [args] 0]" == "?"} { /help operlist ; complete ; return }
  set whotarg ""
  if {[string length [lindex [args] 0]]} { set whotarg "[lindex [args] 0]"
  } elseif {[string length [channel]]} { set whotarg "[channel]" }
  if {[string length $whotarg]} {
    if {![info exists whoqueue]} { set whoqueue "" }
    lappend whoqueue "operscan  $whotarg"
    /raw who [join $whotarg]
  } else { synecho who "[eheader "OperScan"] You must specify a channel to scan for opers on..." }
  noidle
  killpipe operscan
  complete
}
proc killwsock { y } {
  global wlast domainserv
  killpipe wquery
  if {[info exists domainserv]} { unset domainserv }
  if {[info exists wlast]} { unset wlast }
  catch {close $y}
  return
}
proc wqueryx { x y } {
  global wlast domainserv
  if {[eof $x]} { killwsock $x ; return }
  if {[catch {gets $x} text]} { killwsock $x ; return }
  regsub -all {\\} $text {\\\\} text
  regsub -all {\{} $text {\{} text
  regsub -all {\}} $text {\}} text
  regsub -all {\]} $text {\]} text
  regsub -all {\[} $text {\[} text
  regsub -all {\"} $text {\"} text
  if {$text == "The InterNIC Registration Services Host contains ONLY Internet Information"} { killwsock $x ; return }
  if {[wmatch "No match for \"*\"*" [join $text]]} { synecho wquery "[eheader "Whois"] The domain ([b][string tolower [string range [lindex $text 3] 1 [expr {[string length [lindex $text 3]] - 3}]]][b]) does not have an internic entry..." ; killwsock $x ; return }
  if {![info exists wlast]} { synecho wquery "[eheader "Whois"] " ; set wlast "x" }
  if {![string length $wlast] && ![string length $text]} { killwsock $x ; return }
  if {[info exists domainserv] && [string length $text]} {
    synecho wquery "[eheader "Whois"]    [align [string range [join "[lrange [split [string trim $text] "."] 0 [expr {[llength [split [string trim $text] "."]] - 4}]]" "."] 0 [expr {[string length [join "[lrange [split [string trim $text] "."] 0 [expr {[llength [split [string trim $text] "."]] - 4}]]" "."]] - 4}]] 20] ([string range [join "[lrange [split [string trim $text] "."] [expr {[llength [split [string trim $text] "."]] - 4}] end]" "."] 3 end])"
  } else {
    synecho wquery "[eheader "Whois"] [join $text]"
  }
  if {[string trim $text] == "Domain servers in listed order:"} { set domainserv 1 }
  set wlast "$text"
  if {[catch {flush $x}]} { killwsock $x ; return }
}
alias wquery {
  if {"[lindex [args] 0]" == "?"} { /help wquery ; complete ; return }
  if {![string length [lindex [args] 0]]} { synecho wquery "[eheader "Whois"] Please specify a word to lookup..."
  } else {
    if {![catch {socket -async 198.41.0.9 43} buf]} {
      synecho wquery "[eheader "Whois"] Retriving whois infoz for ([b][lindex [args] 0][b])..."
      if {![catch {puts $buf "whois [lindex [args] 0]"}]} {
        if ![catch {flush $buf}] {
          fconfigure $buf -buffering line
          fileevent $buf readable "wqueryx $buf [lindex [args] 0]"
        }
      }
    } else {
      synecho wquery "[eheader "Whois"] Server connection error..."
      killpipe wquery
    }
  }
  noidle
  complete
}
proc qresolve { host } {
  foreach serv [get_cookie "servers"] {
    if {[lindex $serv 1] == $host} { return [lindex $serv 2] }
    if {[lindex $serv 2] == $host} { return [lindex $serv 1] }
  }
  return ""
}
proc qiresolve { host } {
  if {[isip $host]} { return $host }
  foreach serv [get_cookie "servers"] {
    if {[lindex $serv 1] == $host} { return [lindex $serv 2] }
    if {[lindex $serv 2] == $host} { return [lindex $serv 1] }
  }
  return ""
}
alias serv {
  if {"[lindex [args] 0]" == "?"} { /help serv ; complete ; return }
  if {[lindex [args] 0] == "add"} {
    if {![string length [lindex [args] 1]]} { synecho serv "[eheader "Server"] Please specify a network to add this server to..."
    } elseif {![string length [lindex [args] 2]]} { synecho serv "[eheader "Server"] Please a server to add..."
    } elseif {![isip [lindex [args] 3]]} {
      if {[isnum [lindex [args] 3]]} { set port [lindex [args] 3]
      } else { set port 6667 }
      lappend dnsqueue "serv [lindex [args] 2] [lindex [args] 1] $port"
      set nokill 1
      lookup [lindex [args] 2]
    } else {
      set numb 0
      foreach serv [get_cookie "servers"] {
        if {[lindex $serv 1] == [lindex [args] 2]} { set flag 1 }
      }
      if {[info exists flag]} {
        synecho serv "[eheader "Server"] Server already on list ([b][lindex [args] 2][b]([b]ip:[b][lindex [args] 3]))..."
        unset flag
      } else {
        synecho serv "[eheader "Server"] Adding Server: ([b][lindex [args] 2][b]([b]ip:[b][lindex [args] 3]))([b]network:[b] [lindex [args] 1])([b]port:[b] [lindex [args] 4]) to list..."
        set servx [get_cookie "servers"]
        lappend servx "[list [lindex [args] 1]] [list [lindex [args] 2]] [list [lindex [args] 3]] [list [lindex [args] 4]]"
        set_cookie servers $servx
        set servindex 0
      }
    }
  } elseif {[lindex [args] 0] == "del"} {
    if {[isnum [lindex [args] 1]]} {
      set zz [lindex [get_cookie "servers"] [expr [lindex [args] 1] - 1]]
      if {[string length $zz]} {
        synecho serv "[eheader "Server"] Removing Server: ([b][lindex $zz 1][b]([b]ip:[b][lindex $zz 2]))([b]network:[b] [lindex $zz 0])([b]port:[b] [lindex $zz 3])..."
        set_cookie servers [lreplace [get_cookie "servers"] [expr [lindex [args] 1] - 1] [expr [lindex [args] 1] - 1]]
        set servindex 0
      } else {
        synecho serv "[eheader "Server"] Unable to locate server number ([b][lindex [args] 1][b])..."
      }
    } else {
      set servx ""
      foreach serv [get_cookie "servers"] {
        if {[lindex $serv 1] != [lindex [args] 1]} { lappend servx $serv
        } else { synecho serv "[eheader "Server"] Removing Server: ([b][lindex $serv 1][b]([b]ip:[b][lindex $serv 2]))([b]network:[b] [lindex $serv 0])([b]port:[b] [lindex $serv 3])..." ; set flag 1 }
      }
      if {![info exists flag]} { synecho serv "[eheader "Server"] Unable to locate server ([b][lindex [args] 1][b])..."
      } else { unset flag ; set servindex 0 }
      set_cookie servers $servx
    }
  } else {
    set numb 0
    foreach serv [get_cookie "servers"] {
      if {!$numb} {
        synecho serv "[boxtop "[b]Server Listing[b] [sb](([sb][su]servers:[su] [b][llength [get_cookie "servers"]][b][sb]))[sb]"]"
        synecho serv "[boxside "[llb][b]# [b][lrb][llb][b]Network:   [b][lrb][llb][b]Hostname:                [b][lrb][llb][b]IpAddress:               [b][lrb][llb][b]Port:[b][lrb]"]"
      }
      incr numb
      synecho serv "[boxside "[llb][b][align $numb 2][b][lrb][llb][align [lindex $serv 0] 11][lrb][llb][align [lindex $serv 1] 25][lrb][llb][align [lindex $serv 2] 25][lrb][llb][align [lindex $serv 3] 5][lrb]"]"
    }
    if {!$numb} { synecho serv "[eheader "Server"] You have no servers on your serverlist..."
    } else { synecho serv "[boxbottom "[b]Server Listing[b] [sb](([sb][su]servers:[su] [b][llength [get_cookie "servers"]][b][sb]))[sb]"]" }
  }
  set_cookie servers "[lsort [get_cookie servers]]"
  if {[info exists nokill]} { unset nokill
  } else { killpipe serv }
  noidle
  complete
}
proc dividedeops { nameslist sections } {
  set nameslist "[lsort -increasing [string tolower $nameslist]]"
  set each "[expr {[llength $nameslist] / $sections}]"
  set x ""
  set final ""
  set num 0
  foreach name $nameslist {
    incr num
    if {[llength $final] >= $sections} {
      lappend x "$name"
    } else {
      lappend x "$name"
      if {$num == $each} {
        lappend final "$x"
        set x ""
        set num 0
      }
    }
  }
  set num 0
  set fin ""
  foreach name $final {
    if {[llength $x]} {
      lappend name "[lindex $x 0]"
      set x "[lrange $x 1 end]"
    }
    lappend fin "$name"
  }
  return "$fin"
}
proc killdsock { y } {
  killpipe dict
  catch {close $y}
}
proc dictx { x y } {
  if {[eof $x]} { killdsock $x ; return }
  if {[catch {gets $x} text]} { killdsock $x ; return }

  switch -- "[string range $text 0 [expr {[string wordend $text 0] - 1}]]" {
    "500" { synecho dict "[eheader "dict"] Syntax error, command not recognized" }
    "501" { synecho dict "[eheader "dict"] Syntax error, illegal parameters" }
    "502" { synecho dict "[eheader "dict"] Command not implemented" }
    "503" { synecho dict "[eheader "dict"] Command parameter not implemented" }
    "420" { synecho dict "[eheader "dict"] Server temporarily unavailable" }
    "421" { synecho dict "[eheader "dict"] Server shutting down at operator request" }
    "220" { }
    "530" { synecho dict "[eheader "dict"] Access denied" }
    "550" { synecho dict "[eheader "dict"] Invalid database, use \"SHOW DB\" for list of databases" }
    "552" { synecho dict "[eheader "dict"] No match" }
    "150" { synecho dict "[eheader "dict"] [lindex $text 1] definitions retrieved - definitions follow" }
    "151" { echo "[b][lindex $text 1][b] from [b][join [lrange $text 3 end]][b]" }
    "250" { synecho dict "[eheader "dict"] Definitions End" }
    "."   { echo " " }
    default { echo "$text" }
  }

  if {[catch {flush $x}]} { killdsock $x ; return }
}
alias dict {
  if {"[lindex [args] 0]" == "?"} { /help dict ; complete ; return }
  if {![string length [join [args]]]} { synecho dict "[eheader "dict"] Please specify a word to lookup..."
  } else {
    if {![catch {socket -async dict.org 2628} buf]} {
      synecho dict "[eheader "dict"] Connected to server... Searching for word ([b][join [args]][b])..."
      if {![catch {puts $buf "DEFINE * [join [args]]"}]} {
        if ![catch {flush $buf}] {
          fconfigure $buf -buffering line
          fileevent $buf readable "dictx $buf [list [join [args]]]"
        }
      }
    } else {
      synecho dict "[eheader "dict"] Server connection error..."
      killpipe dict
    }
  }
  noidle
  complete
}
alias graburl {
  if {[info exists lasturl]} {
    set num 0
    set flag 0
    foreach ver [get_cookie url] { incr num ; if {[strip $uu] == [join [strip $ver]]} { set flag 1 } }
    if {$flag} {
      lappend noaddurl $lasturl
      synecho graburl "[eheader "GrabUrl"] Url is already on list ([b]$lasturl[b])..."
    } else {
      lappend noaddurl $lasturl
      synecho graburl "[eheader "GrabUrl"] Url caught ([b]$lasturl[b])..."
      set_cookie url [atlist [get_cookie url] "$lasturl"]
      unset lasturl
    }
  } else {
    synecho graburl "[eheader "GrabUrl"] No urls to grab..."
  }
  killpipe graburl
  noidle
  complete
}
alias url {
  if {"[lindex [args] 0]" == "?"} { /help url ; complete ; return }
  if {[lindex [args] 0] == "add"} {
    set num 0
    set flag 0
    if {[string range [join [lrange [args] 1 end]] 0 6] != "file://" && [string range [join [lrange [args] 1 end]] 0 5] != "ftp://" && [string range [join [lrange [args] 1 end]] 0 8] != "gopher://" && [string range [join [lrange [args] 1 end]] 0 6] != "http://" && [string range [join [lrange [args] 1 end]] 0 7] != "https://" && [string range [join [lrange [args] 1 end]] 0 8] != "mailto://" && [string range [join [lrange [args] 1 end]] 0 8] != "news://" && [string range [join [lrange [args] 1 end]] 0 8] != "telnet://" && [string range [join [lrange [args] 1 end]] 0 8] != "wais://"} { set uu "http://[file tail [join [lrange [args] 1 end]]]"
    } else { set uu "[join [lrange [args] 1 end]]" }
    foreach ver [get_cookie url] { incr num ; if {[strip $uu] == [join [strip $ver]]} { set flag 1 } }
    if {$flag} {
      unset flag
      lappend noaddurl $uu
      synecho url "[eheader "Url"] Url already on list: $uu"
    } else {
      lappend noaddurl $uu
      synecho url "[eheader "Url"] Added url: $uu"
      set_cookie url [atlist [get_cookie url] "$uu"]
    }
  } elseif {[lindex [args] 0] == "clear"} {
    set_cookie url ""
    synecho url "[eheader "Url"] Clearing urls list..."
  } elseif {[lindex [args] 0] == "del"} {
    set num 0
    set rver ""
    if {[isnum [lindex [args] 1]]} { foreach ver [get_cookie url] { incr num ; if {$num == [lindex [args] 1]} { set rver $ver ; set_cookie url [rflist [get_cookie url] $ver] } }
    } else {
      if {[string range [join [lrange [args] 1 end]] 0 6] != "file://" && [string range [join [lrange [args] 1 end]] 0 5] != "ftp://" && [string range [join [lrange [args] 1 end]] 0 8] != "gopher://" && [string range [join [lrange [args] 1 end]] 0 6] != "http://" && [string range [join [lrange [args] 1 end]] 0 7] != "https://" && [string range [join [lrange [args] 1 end]] 0 8] != "mailto://" && [string range [join [lrange [args] 1 end]] 0 8] != "news://" && [string range [join [lrange [args] 1 end]] 0 8] != "telnet://" && [string range [join [lrange [args] 1 end]] 0 8] != "wais://"} { set uu "http://[file tail [join [lrange [args] 1 end]]]"
      } else { set uu "[join [lrange [args] 1 end]]" }
      foreach ver [get_cookie url] { if {[strip $uu] == [join [strip $ver]]} { set rver $ver ; set_cookie url [rflist [get_cookie url] $ver] } }
    }
    if {[string length $rver]} {
      lappend noaddurl [join $rver]
      synecho url "[eheader "Url"] Removed url: [join $rver]"
    } elseif {[isnum [lindex [args] 1]]} { synecho url "[eheader "Url"] Url number ([sb][lindex [args] 1][sb]) could not be located..."
    } else {
      lappend noaddurl $uu
      synecho url "[eheader "Url"] Url \( $uu \) could not be located..."
    }
  } elseif {![string length [get_cookie url]]} {
    synecho url "[eheader "Url"] You have no urls captured..."
  } else {
    set num 0
    foreach ver [get_cookie url] { incr num }
    synecho url "[boxtop "[b]Urls List[b] [sb](([sb][su]entries:[su] [b]$num[b][sb]))[sb]"]"
    set num 0
    foreach ver [get_cookie url] { incr num ; synecho url "[boxside "[llb][b][align $num 2][b][lrb] [join $ver]"]" }
    synecho url "[boxbottom "[b]Urls List[b] [sb](([sb][su]entries:[su] [b]$num[b][sb]))[sb]"]"
  }
  killpipe url
  noidle
  complete
}

alias repeat {
  if {"[lindex [args] 0]" == "?"} { /help repeat ; complete ; return }
  if {![isnum [lindex [args] 0]]} { synecho repeat "[eheader "Repeat"] No repeat number given..."
  } elseif {![string length [lrange [args] 1 end]]} { synecho repeat "[eheader "Repeat"] Please specify a command to repeat..."
  } else {
    synecho repeat "[eheader "Repeat"] Repeating command ([b][join [lrange [args] 1 end]][b]) [b][lindex [args] 0][b] times..."
    if {![catch {/[string trimleft [join [lrange [args] 1 end]] "/"]}]} {
      for { set x "[expr [lindex [args] 0] - 1]" } { $x > 0 } { set x "[expr $x - 1]" } { /[string trimleft [join [lrange [args] 1 end]] "/"] }
    }
  }
  complete
}
alias rnick {
  if {[string match *dal.net [lindex [xserver] 0]]} {
    synecho rnick "[eheader "RandNick\[30\]"] Randomizing nickname..."
    /raw nick "\\[randnick 29]"
  } else {
    synecho rnick "[eheader "RandNick\[9\]"] Randomizing nickname..."
    /raw nick "\\[randnick 8]"
  }
  killpipe rnick
  noidle
  complete
}
alias tog {
  global sconfig config srconfig varorder togspecial
  set togspecialx "$togspecial"
  if {"[lindex [args] 0]" == "?"} { /help tog ; complete ; return }
  if {[isin [array names sconfig] [string tolower [lindex [args] 0]]] && ![isin [split "[lindex [args] 0]" ""] "*"]} {
    modconfig [string tolower [lindex [args] 0]] [join [lrange [args] 1 end]]
  } elseif {[string length [lindex [args] 0]] && ![isin [split "[lindex [args] 0]" ""] "*"]} {
    synecho tog "[eheader "Config"] No such toggle defined ([b][lindex [args] 0][b])..."
  } else {
    set sects ""
    foreach x $varorder { if {![isin $sects [lindex $config($x) 7]]} { lappend sects "[lindex $config($x) 7]" } }
    if {![isin [split "[lindex [args] 0]" ""] "*"]} { synecho tog "[eheader "Config"] Displaying all toggle refrences..."
    } else { synecho tog "[eheader "Config"] Displaying toggle refrences matching ([b][lindex [args] 0][b])..." }
    foreach sect $sects {
      if {(![isin [split "[lindex [args] 0]" ""] "*"]) || ([isin [split "[lindex [args] 0]" ""] "*"] && [wmatch [string tolower [lindex [args] 0]] [string tolower $sect]])} {
        set xtemplong ""
        set xtempshort ""
        set xtempsshort ""
        foreach x $varorder {
          if {$sect == [lindex $config($x) 7] && ![string match hidden* [lindex $config($x) 2]]} {
            if {([lindex $config($x) 2] == "boolean" || [lindex $config($x) 2] == "dynamicinteger") && [get_cookie config($x)] == "1"} { set retu "on"
            } elseif {([lindex $config($x) 2] == "boolean" || [lindex $config($x) 2] == "dynamicinteger") && [get_cookie config($x)] == "0"} { set retu "off"
            } elseif {[lindex $config($x)) 2] == "passwordstring" && [get_cookie config($x)] != "none"} { set retu "????"
            } else { set retu "[get_cookie config($x)]" }
            if {[lindex $config($x) 6] == "lstring"} {
              set templong($x) "\[[b]$srconfig($x)[b]\][xalign [lindex $config($x) 4] 25] [b]--[b] $retu"
              lappend xtemplong "$x"
            } elseif {[lindex $config($x) 6] == "sstring"} {
              set tempshort($x) "\[[b]$srconfig($x)[b]\][xalign [lindex $config($x) 4] 25] ([b]$retu[b])"
              lappend xtempshort "$x"
            } elseif {[lindex $config($x) 6] == "sepstring"} {
              set tempsshort($x) "\[[b]$srconfig($x)[b]\][xalign [lindex $config($x) 4] 25] ([b]$retu[b])"
              lappend xtempsshort "$x"
            }
          }
        }
        synecho tog "[boxtop "[b]$sect[b]"]"
        if {[info exists flag]} { unset flag }
        foreach entry $xtempshort {
          if {[info exists flag]} {
            set temp2 "$tempshort($entry)"
            synecho tog "[boxside "[align $temp1 45] [align $temp2 45]"]"
            unset flag
          } {
            set temp1 "$tempshort($entry)"
            set flag 1
          }
        }
        if {[info exists flag]} {
          synecho tog "[boxside "[align $temp1 45]"]"
          unset flag
        }
        foreach entry $xtempsshort {
          synecho tog "[boxside "$tempsshort($entry)"]"
        }
        foreach entry $xtemplong {
          synecho tog "[boxside "$templong($entry)"]"
        }
        set newx ""
        foreach entry $togspecialx {
          if {[lindex $entry 0] == $sect} {
            eval "set bitz \"[join [lindex $entry 1]]\""
            synecho tog "[boxside "$bitz"]"]"
          } else { lappend newx "$entry" }
        }
        set togspecialx "$newx"
        synecho tog "[boxbottom "[b]$sect[b]"]"
        if {[info exists templong]} { unset templong }
        if {[info exists tempshort]} { unset tempshort }
        if {[info exists tempsshort]} { unset tempsshort }
      }
      if {[info exists xtemplong]} { unset xtemplong }
      if {[info exists xtempshort]} { unset xtempshort }
      if {[info exists xtempsshort]} { unset xtempsshort }
    }
  }
  killpipe tog
  noidle
  complete
}
alias help {
  global helpdata helplink helpvarorder
  if {[string length [lindex [args] 0]] && ![isin [split "[lindex [args] 0]" ""] "*"]} {
    disphelp [lindex [args] 0]
  } else {
    set sects ""
    set sectstot ""
    foreach x [array names helpdata] { set sects "[aotlist $sects [lindex $helpdata($x) 4]]" }
    set ttcount "0"
    foreach sect $sects {
      set lcount 0
      set tcount 0
      set xline ""
      set echos ""
      foreach x [lsort [array names helplink]] {
        if {($sect == [lindex $helpdata($helplink($x)) 4]) && ((![string length [lindex [args] 0]]) || ([string length [lindex [args] 0]] && [wmatch [string tolower [lindex [args] 0]] [string tolower $x]]))} {
          append xline "[xalign [string tolower $x] 12] "
          incr lcount 1
          incr tcount 1
          if {$lcount == 6} { lappend echos "$xline" ; set lcount 0 ; set xline "" }
        }
      }
      if {$lcount} { lappend echos "$xline" ; set lcount 0 ; set xline "" }
      if {[llength $echos]} {
        synecho help "[boxtop "[b]$sect Help Index[b] [sb](([sb][su]commands:[su] [b]$tcount[b][sb]))[sb]"]"
        foreach lin $echos { synecho help "[boxside "$lin"]" }
        synecho help "[boxbottom "[b]$sect Help Index[b] [sb](([sb][su]commands:[su] [b]$tcount[b][sb]))[sb]"]"
        incr ttcount $tcount
      }
    }
    if {[info exists cmdcnt]} { unset cmdcnt }
    synecho help "[eheader "Help"] Total Commands ([b]$ttcount[b])..."
  }
  killpipe help
  noidle
  complete
}
proc addhelp { command sdesc synt links ldesc sect } {
  global helpdata helplink
  set command "[string tolower $command]"
  foreach link $links { if {[string tolower $link] != "none"} { set helplink([string tolower [string trim $link "/"]]) "$command" } }
  set helplink($command) "$command"
  set helpdata($command) "[list "$sdesc"] [list "$synt"] [list "$links"] [list "$ldesc"] [list "$sect"]"
}
proc linewrap { text } {
  set final ""
  set temp ""
  foreach werd [split $text " "] {
    if {$werd == ";"} {
      lappend final "[join $temp]" ; set temp ""
    } elseif {[expr {[string length [join $temp]] + [string length $werd]}] >= "80"} {
      lappend final "[join $temp]" ; set temp "[list "$werd"]"
    } else {
      lappend temp "$werd"
    }
  }
  if {[llength $temp]} { lappend final "[join $temp]" }
  return $final
}
proc parsehelp { text } {
  global bx bsx su ux
  regsub -all {\\} $text {\\\\} text
  regsub -all {\{} $text {\{} text
  regsub -all {\}} $text {\}} text
  regsub -all {\]} $text {\]} text
  regsub -all {\[} $text {\[} text
  regsub -all {\"} $text {\"} text
  regsub -all {%%} $text {%x} text
  regsub -all {%b} $text {[b]} text
  regsub -all {%sb} $text {[sb]} text
  regsub -all {%u} $text {[u]} text
  regsub -all {%su} $text {[su]} text
  regsub -all {%x} $text {%} text
  return "[eval "return \"$text\""]"
}
proc disphelp { command } {
  global helpdata helplink
  set command "[string tolower $command]"
  if {[info exists helpdata($command)]} { set flag "$command" ; set helpd "$helpdata($command)"
  } else { foreach link [array names helplink] { if {$link == $command} { set flag "$helplink($link)" ; set helpd "$helpdata($helplink($link))" } } }
  if {[info exists flag]} {
    if {[string length [lindex $helpd 2]]} { set stuff "[lindex $helpd 2]"
    } else { set stuff "none" }
    synecho help "[boxtop "[b][parsehelp [lindex $helpd 4]] Help[b] [sb]--[sb] [b]/$flag[b] [sb]([sb][parsehelp [lindex $helpd 0]][sb])[sb]"]"
    synecho help "[boxside "([b]syntax     :[b]) [parsehelp [lindex $helpd 1]]"]"
    synecho help "[boxside "([b]alternates :[b]) [parsehelp "[join [split $stuff " "] " -- "]"]"]"
    synecho help "[boxside "([b]description:[b])"]"
    foreach line [linewrap [lindex $helpd 3]] { synecho help "[boxside "  [parsehelp "$line"]"]" }
    synecho help "[boxbottom "[b][parsehelp [lindex $helpd 4]] Help[b] [sb]--[sb] [b]/$flag[b] [sb]([sb][parsehelp [lindex $helpd 0]][sb])[sb]"]"
    unset flag
  } else {
    synecho help "[eheader "Help"] No help available for topic ([b]$command[b])..."
  }
  return 0
}
proc addconfig { variable shortvar default parmtype parmmask sdesc ldesc dispstyle dispsect } {
  global config sconfig srconfig varorder
  set shortvar "[string tolower $shortvar]"
  set variable "[string tolower $variable]"
  if {[isin [array names sconfig] $shortvar] || [isin [array names srconfig] $variable]} {
    synecho x "[eheader "WARNING"] The setting id [b]$shortvar[b]\\[b]$variable[b] is already in use, unable to set..."
    return 0
  } else {
    lappend varorder "$variable"
    set sconfig($shortvar) "$variable"
    set srconfig($variable) "$shortvar"
    set config($variable) "[list "$variable"] [list "$default"] [list "$parmtype"] [list "$parmmask"] [list "$sdesc"] [list "$ldesc"]  [list "$dispstyle"]  [list "$dispsect"]"
    if {![string length [get_cookie config($variable)]]} { set_cookie config($variable) "$default" }
    return 1
  }
}
proc addconfigverb { variable shortvar default parmtype parmmask sdesc ldesc text dispsect } {
  global config sconfig srconfig varorder
  regsub -all {\\} $text {\\\\} text
  regsub -all {\{} $text {\{} text
  regsub -all {\}} $text {\}} text
  regsub -all {\]} $text {\]} text
  regsub -all {\[} $text {\[} text
  regsub -all {\"} $text {\"} text
  regsub -all {\$} $text {\$} text
  lappend varorder "$variable"
  set sconfig($shortvar) "$variable"
  set srconfig($variable) "$shortvar"
  set config($variable) "[list "$variable"] [list "$default"] [list "$parmtype"] [list "$parmmask"] [list "$sdesc"] [list "$ldesc"]  [list "$text"]  [list "$dispsect"] verbose"
  if {![string length [get_cookie config($variable)]]} { set_cookie config($variable) "$default" }
}
proc addconfigline { text dispsect } {
  global togspecial
  regsub -all {\\} $text {\\\\} text
  regsub -all {\{} $text {\{} text
  regsub -all {\}} $text {\}} text
  regsub -all {\]} $text {\]} text
  regsub -all {\[} $text {\[} text
  regsub -all {\"} $text {\"} text
  regsub -all {\$} $text {\$} text
  lappend togspecial "[list "$dispsect"] [list "$text"]"
}
proc modconfig { shortv setting } {
  global config sconfig
  if {[isin [array names sconfig] $shortv]} {
    set var "$sconfig($shortv)"
    set okay "0"
    set z "[lindex $config($var) 2]"
    if {[string range $z 0 5] == "hidden"} { set z "[string range $z 6 end]" }
    switch $z {
      "string" {
        if {[string match [lindex $config($var) 3] $setting] && [string length $setting]} { set setting "$setting" ; set okay "1"
        } else { set setting "[lindex $config($var) 1]" ; set okay "2" }
      }
      "passwordstring" {
        if {[string match [lindex $config($var) 3] $setting] && [string length $setting]} { set setting "$setting" ; set okay "1"
        } else { set setting "[lindex $config($var) 1]" ; set okay "2" }
      }
      "integer" {
        if {![isnum $setting]} { set setting "[lindex $config($var) 1]" ; set okay "2"
        } elseif {($setting >= [lindex [split [lindex $config($var) 3] "-:"] 0] || [lindex [split [lindex $config($var) 3] "-:"] 0] == "*") && ($setting <= [lindex [split [lindex $config($var) 3] "-:"] 1] || [lindex [split [lindex $config($var) 3] "-:"] 1] == "*")} { set setting "$setting" ; set okay "1"
        } else { set setting "[lindex $config($var) 1]" ; set okay "2" }
      }
      "boolean" {
        if {"$setting" == "on" || "$setting" == "1"} { set setting "1" ; set okay "1"
        } elseif {"$setting" == "off" || "$setting" == "0"} { set setting "0" ; set okay "1"
        } else { set setting "[lindex $config($var) 1]" ; set okay "2" }
      }
      "dynamicstring" {
        set laster ""
        set curr "[split [get_cookie config($var)]]"
        if {$curr == "none"} { set curr "" }
        if {[string match +* $setting] || [string match -* $setting]} {
          foreach x [split $setting " ,"] {
            if {"[string range $x 0 0]" == "+"} { set laster "+" ; set curr "[aotlist $curr "[string range $x 1 end]"]" ; set okay "1"
            } elseif {"[string range $x 0 0]" == "-"} { set laster "-" ; set curr "[rflist $curr "[string range $x 1 end]"]" ; set okay "1"
            } elseif {[string length $laster]} {
              if {"$laster" == "+"} { set curr "[aotlist $curr "$x"]"
              } elseif {"$laster" == "-"} { set curr "[rflist $curr "$x"]" }
            }
          }
          set setting "[join $curr]"
        } else {
          set setting "[join [split $setting ", "]]" ; set okay "1"
        }
        if {"$setting" == ""} { set setting "none" }
      }
      "chanlist" {
        set laster ""
        set curr "[split [get_cookie config($var)]]"
        if {$curr == "none"} { set curr "" }
        if {[string match +* $setting] || [string match -* $setting]} {
          foreach x [split $setting " ,"] {
            if {"[string range $x 0 0]" == "+"} { set laster "+" ; set y "[string range $x 1 end]" ; if {![string match #* $y]} { set y "#$y" } ; set curr "[aotlist $curr "$y"]" ; set okay "1"
            } elseif {"[string range $x 0 0]" == "-"} { set laster "-" ; set y "[string range $x 1 end]" ; if {![string match #* $y]} { set y "#$y" } ; set curr "[rflist $curr "$y"]" ; set okay "1"
            } elseif {[string length $laster]} {
              set y "$x" ; if {![string match #* $y]} { set y "#$y" } ;
              if {"$laster" == "+"} { set curr "[aotlist $curr "$y"]"
              } elseif {"$laster" == "-"} { set curr "[rflist $curr "$y"]" }
            }
          }
          set setting "[join $curr]"
        } else {
          set setting "[join [split $setting ", "]]" ; set okay "1"
        }
        if {"$setting" == ""} { set setting "none" }
      }
      "dynamicinteger" {
        if {"$setting" == "off" || "$setting" == "0"} { set setting "0" ; set okay "1"
        } elseif {![isnum $setting]} { set setting "[lindex $config($var) 1]" ; set okay "2"
        } elseif {($setting >= [lindex [split [lindex $config($var) 3] "-:"] 0] || [lindex [split [lindex $config($var) 3] "-:"] 0] == "*") && ($setting <= [lindex [split [lindex $config($var) 3] "-:"] 1] || [lindex [split [lindex $config($var) 3] "-:"] 1] == "*")} { set setting "$setting" ; set okay "1"
        } else { set setting "[lindex $config($var) 1]" ; set okay "2" }
      }
    }
    if {$okay} {
      set_cookie config($var) "$setting"
      if {($z == "boolean" || $z == "dynamicinteger") && $setting == "1"} { set setting "on"
      } elseif {($z == "boolean" || $z == "dynamicinteger") && $setting == "0"} { set setting "off"
      } elseif {$z == "passwordstring" && [get_cookie config($var)] != "none"} { set setting "????" }
      if {$okay == 2} {
        if {[lindex $config($var) 8] == "verbose"} {
          eval "set bitz \"[join [lindex $config($var) 5]]\""
          synecho tog "[eheader "Config"] $bitz ([b]Default[b])"
        } else {
          synecho tog "[eheader "Config"] Set [lindex $config($var) 5] to ([b]$setting[b]) ([b]Default[b])..."
        }
      } else {
        if {[lindex $config($var) 8] == "verbose"} {
          eval "set bitz \"[join [lindex $config($var) 5]]\""
          synecho tog "[eheader "Config"] $bitz"
        } else {
          synecho tog "[eheader "Config"] Set [lindex $config($var) 5] to ([b]$setting[b])..."
        }
      }
      return 1
    }
  } else {
    synecho tog "[eheader "Config"] Unknown toggle ([b]$shortv[b])..."
    return 0
  }
}
proc config { name } {
  return "[get_cookie config($name)]"
}
alias scripts {
  global synadd
  synecho scripts "[boxtop "[b]Scripts Listing[b] [sb](([sb][su]total:[su] [b][llength [scripts]][b][sb]))[sb]"]"
  synecho scripts "[boxside "[llb][b]# [b][lrb][llb][b]File:                         [b][lrb][llb][b]Type:               [b][lrb]"]"
  set num 0
  foreach link [scripts] {
    incr num
    synecho scripts "[boxside "[llb][b][align "$num" 2][b][lrb][llb][align $link 30][lrb][llb][align "script" 20][lrb]"]"
  }
  synecho scripts "[boxbottom "[b]Scripts Listing[b] [sb](([sb][su]total:[su] [b][llength [scripts]][b][sb]))[sb]"]"
  if {[llength $synadd]} {
    synecho scripts "[boxtop "[b]Addons Listing[b] [sb](([sb][su]total:[su] [b][llength $synadd][b][sb]))[sb]"]"
    synecho scripts "[boxside "[llb][b]# [b][lrb][llb][b]File:                         [b][lrb][llb][b]Name:               [b][lrb]"]"
    set num 0
    foreach link $synadd {
      incr num
      synecho scripts "[boxside "[llb][b][align "$num" 2][b][lrb][llb][align [replace [string tolower [lindex $link 0]] "/" "\\"] 30][lrb][llb][align "[lindex $link 1]" 20][lrb]"]"
    }
    synecho scripts "[boxbottom "[b]Addons Listing[b] [sb](([sb][su]total:[su] [b][llength $synadd][b][sb]))[sb]"]"
  }
  killpipe scripts
  noidle
  complete
}
alias clk {
  if {"[lindex [args] 0]" == "?"} { /help clk ; complete ; return }
  if {[info exists cloak]} {
    synecho cloak "[eheader "Cloak"] CTCP Cloak [sb]Disabled[sb]..."
    unset cloak
  } else {
    synecho cloak "[eheader "Cloak"] CTCP Cloak [sb]Enabled[sb]..."
    set cloak on
  }
  killpipe clk
  noidle
  complete
}
alias exec { if {"[lindex [args] 0]" == "?"} { /help exec ; complete ; return } ; exec [join [args]] & ; killpipe exec ; complete }
alias tcl { if {"[lindex [args] 0]" == "?"} { /help tcl ; complete ; return } ; eval [join [args]] ; killpipe tcl ; complete }
alias um { if {"[lindex [args] 0]" == "?"} { /help um ; complete ; return } ; if {[string length [lindex [args] 0]]} { /raw mode [my_nick] [lindex [args] 0] } elseif {[config defum] != "off"} { synecho um "[eheader "UserMode"] No user modes specified... Switching to default ([b][config defum][b])" ; /raw mode [my_nick] [config defum] } else { synecho um "[eheader "UserMode"] No usermode parameter specified..." } ; killpipe um ; noidle ; complete }
alias ji { if {"[lindex [args] 0]" == "?"} { /help ji ; complete ; return } ; if {![info exists lastinvite]} { synecho ji "[eheader "Invite"] You have not been invited anywhere..." } else { synecho ji "[eheader "Invite"] Joining last invited channel: [b]$lastinvite[b]" ; /join $lastinvite } ; killpipe ji ; noidle ; complete }
alias recnick { if {"[lindex [args] 0]" == "?"} { /help recnick ; complete ; return } ; if {[my_nick] == [config regnick]} { synecho recnick "[eheader "DefaultNick"] You are already using your default nickname..." } else { synecho recnick "[eheader "DefaultNick"] Switching to default nickname: [b][config regnick][b]" ; /raw nick [config regnick] } ; noidle ; complete }
alias cloak { if {"[lindex [args] 0]" == "?"} { /help cloak ; complete ; return } ; synecho cloak "[eheader "Cloak"] CTCP Cloak [sb]Enabled[sb]..." ; set cloak on ; killpipe cloak ; noidle ; complete }
alias uncloak { if {"[lindex [args] 0]" == "?"} { /help uncloak ; complete ; return } ; synecho uncloak "[eheader "Cloak"] CTCP Cloak [sb]Disabled[sb]..." ; if {[info exists cloak]} { unset cloak } ; killpipe uncloak ; noidle ; complete }
alias mass { if {"[lindex [args] 0]" == "?"} { /help mass ; complete ; return } ; if {[lindex [args] 0] == "o" || [lindex [args] 0] == "op" || [lindex [args] 0] == "+o"} { /mo [channel] } ; if {[lindex [args] 0] == "d" || [lindex [args] 0] == "deop" || [lindex [args] 0] == "-o"} { /md [channel] } ; if {[lindex [args] 0] == "v" || [lindex [args] 0] == "voice" || [lindex [args] 0] == "+v"} { /mv [channel] } ; if {[lindex [args] 0] == "u" || [lindex [args] 0] == "unvoice" || [lindex [args] 0] == "-v"} { /mu [channel] } ; noidle ; killpipe mass ; complete }
alias me {
  if {"[lindex [args] 0]" == "?"} { /help me ; complete ; return }
  if {![string length [chat]]} {
    if {[validchan [channel]]} { /raw privmsg [channel] :\001ACTION [raw_args]\001 ; echo "[applyselfaction "[my_nick]" "[raw_args]"]" channel [channel] ; spylink [channel] "[applyselfaction "[my_nick]" "[raw_args]"]" ; complete
    } elseif {[string length [query]]} { /raw privmsg [query] :\001ACTION [raw_args]\001 ; echo "[applyselfaction "[my_nick]" "[raw_args]"]" query [query] ; spylink [query] "[applyselfaction "[my_nick]" "[raw_args]"]" ; inc_relsm "[query]" "action" "* [my_nick] [raw_args]" ; complete
    } else { synecho me "[eheader "action"] Invalid window specified..." }
  }
  noidle
  killpipe me
}
alias pme {
  if {"[lindex [args] 0]" == "?"} { /help pme ; complete ; return }
  if {![string length [args]]} { synecho pme "[eheader "Action"] You must specify a destination for the action..."
  } elseif {![string length [lindex [args] 1]]} { synecho pme "[eheader "Action"] You must specify an action to send..."
  } else {
     /raw privmsg [lindex [args] 0] :\001ACTION [string range [raw_args] [expr [string length [lindex [args] 1]] + 2] end]\001
     echo "[applysactionstyle "[lindex [args] 0]" "[string range [raw_args] [expr [string length [lindex [args] 1]] + 2] end]"]"
     spylink [lindex [args] 0] "[applysactionstyle "[lindex [args] 0]" "[string range [raw_args] [expr [string length [lindex [args] 1]] + 2] end]"]"
     inc_tab "pme" "[lindex [args] 0]"
     inc_relsm "[lindex [args] 0]" "action" "* [my_nick] [string range [raw_args] [expr [string length [lindex [args] 1]] + 2] end]"
  }
  noidle
  complete
  killpipe me
}
alias ame { if {"[lindex [args] 0]" == "?"} { /help ame ; complete ; return } ; foreach chan [channels] { spylink $chan "[applyselfaction "[my_nick]" "[raw_args]"]" ; echo "[applyselfaction "[my_nick]" "[raw_args]"]" channel $chan ; /raw privmsg $chan :\001ACTION [raw_args]\001 } ; noidle ; killpipe ame ; complete }
alias asay { if {"[lindex [args] 0]" == "?"} { /help asay ; complete ; return } ; foreach chan [channels] { spylink $chan "[applyselftext "[my_nick]" "[raw_args]"]" ; echo "[applyselftext "[my_nick]" "[raw_args]"]" channel $chan ; /raw privmsg $chan :[raw_args] } ; noidle ; killpipe asay ; complete }
alias dns {
  if {"[lindex [args] 0]" == "?"} { /help dns ; complete ; return }
  if {![string length [lindex [args] 0]]} {
    synecho dns "[eheader "dns"] Please specify a nick\\address to resolve..."
  } elseif {![wmatch *.* [lindex [args] 0]] && [lindex [args] 0] != "localhost" && [isnick [lindex [args] 0]]} {
    if {![info exists whoisqueue]} { set whoisqueue "" }
    lappend whoisqueue "nslookup [lindex [args] 0]"
    addnullpipe whois
    whois [lindex [args] 0]
  } elseif {[wmatch *.* [lindex [args] 0]]} {
    synecho dns "[eheader "dns"] Attempting to resolve [b][lindex [args] 0][b]"
    lappend dnsqueue "nslookup [list [lindex [args] 0]]"
    lookup [lindex [args] 0]
  } else {
    synecho dns "[eheader "dns"] Invalid nickname given..."
    killpipe dns
  }
  noidle
  complete
}

alias pingoff { if {"[lindex [args] 0]" == "?"} { /help pingoff ; complete ; return } ; synecho pingoff "[eheader "Logoff"] Faking ping timeout..." ; /raw quit :Ping timeout ; noidle ; killpipe pingoff ; complete }
alias awaycapt { if {"[lindex [args] 0]" == "?"} { /help awaycapt ; complete ; return } ; if {[lindex [args] 0] == "del"} { set tempx [open "[get_syn_dir]/syntax/logs/awaycapt.log" w+] ; puts $tempx "" ; close $tempx ; set_cookie awaymsgs "0" ; synecho awaycapt "[eheader "Away"] Away captures deleted..." } else { if {![file exists "[get_syn_dir]/syntax/logs/awaymsgs.log"]} { set x "[open "[get_syn_dir]/syntax/logs/awaymsgs.log" a+]" ; puts $x "" ; close $x } ; exec [config editor] [get_syn_dir]/syntax/logs/awaycapt.log & ; synecho awaycapt "[eheader "Away"] Viewing away captures ([b][get_cookie awaycapt][b])..." ; set_cookie awaycapt "0" } ; noidle ; killpipe awaycapt ; complete }
alias awaymsgs { if {"[lindex [args] 0]" == "?"} { /help awaymsgs ; complete ; return } ; if {[lindex [args] 0] == "del"} { set tempx [open "[get_syn_dir]/syntax/logs/awaymsgs.log" w+] ; puts $tempx "" ; close $tempx ; set_cookie awaycapt "0" ; synecho awaycapt "[eheader "Away"] Away messages deleted..." } else { if {![file exists "[get_syn_dir]/syntax/logs/awaycapt.log"]} { set x "[open "[get_syn_dir]/syntax/logs/awaycapt.log" a+]" ; puts $x "" ; close $x } ; exec [config editor] [get_syn_dir]/syntax/logs/awaymsgs.log & ; synecho awaycapt "[eheader "Away"] Viewing away messages ([b][get_cookie awaymsgs][b])..." ; set_cookie awaymsgs "0" } ; noidle ; killpipe awaymsgs ; complete }
alias ai { if {"[lindex [args] 0]" == "?"} { /help ai ; complete ; return } ; if {![config antiidle]} { synecho ai "[eheader "AntiIdle"] No interval set..." } elseif {![info exists idle(x)]} { set idle(x) 1 ; set idle(time) 0 ; synecho ai "[eheader "AntiIdle"] AntiIdle Activated... Interval set at [b][config antiidle][b] seconds..." } else { unset idle(x) idle(time) ; synecho ai "[eheader "AntiIdle"] AntiIdle Deactivated..." } ; noidle ; killpipe ai ; complete }
alias a { if {"[lindex [args] 0]" == "?"} { /help a ; complete ; return } ; if {![info exists away(x)]} { repipe a away ; /away [raw_args] } else { repipe a back ; /back [raw_args] } ; noidle ; complete }
alias aj { if { [string tolower [config autojoin]] != "none" } { synecho x "[eheader "Syntax"] Joining autojoin channel(s)..." ; /join [join [split [config autojoin]] ","] } }
alias bans { if {"[lindex [args] 0]" == "?"} { /help bans ; complete ; return } ; if {[string match "#*" [join [lrange [args] 0 0]]]} { /raw mode [join [lrange [args] 0 0]] +b ; if {![info exists banqueue]} { set banqueue "" } ; lappend banqueue "bans" } elseif {![validchan [channel]]} { synecho bans "[eheader "Bans"] Invalid channel window..." } else { /raw mode [channel] +b ; if {![info exists banqueue]} { set banqueue "" } ; lappend banqueue "bans" } ; noidle ; complete }
alias msg { if {[string index [lindex [args] 0] 0] == "="} { return } ; if {"[lindex [args] 0]" == "?"} { /help msg ; complete ; return } ; if {![string length [lindex [args] 0]]} { synecho msg "[eheader "msg"] No destination specified..." } elseif {![string length [lindex [args] 1]]} { synecho msg "[eheader "msg"] No text to send..." } else { echo "[applysmsgstyle "[lindex [args] 0]" "[string range [raw_args] [expr [string length [lindex [args] 0]] + 1] end]"]" ; spylink [lindex [args] 0] "[applysmsgstyle "[lindex [args] 0]" "[string range [raw_args] [expr [string length [lindex [args] 0]] + 1] end]"]" ; inc_relsm "[lindex [args] 0]" "msg" "[string range [raw_args] [expr [string length [lindex [args] 0]] + 1] end]" ; inc_tab "msg" "[lindex [args] 0]" ; /quote privmsg [lindex [args] 0] :[string range [raw_args] [expr [string length [lindex [args] 0]] + 1] end] } ; noidle ; killpipe msg ; complete }
alias notice { if {"[lindex [args] 0]" == "?"} { /help notice ; complete ; return } ; if {![string length [lindex [args] 0]]} { synecho notice "[eheader "notice"] No destination specified..." } elseif {![string length [lindex [args] 1]]} { synecho notice "[eheader "notice"] No text to send..." } else { echo "[applysnoticestyle "[lindex [args] 0]" "[string range [raw_args] [expr [string length [lindex [args] 0]] + 1] end]"]" ; spylink [lindex [args] 0] "[applysnoticestyle "[lindex [args] 0]" "[string range [raw_args] [expr [string length [lindex [args] 0]] + 1] end]"]" ; inc_relsm "[lindex [args] 0]" "notice" "[string range [raw_args] [expr [string length [lindex [args] 0]] + 1] end]" ; inc_tab "notice" "[lindex [args] 0]" ; /quote notice [lindex [args] 0] :[string range [raw_args] [expr [string length [lindex [args] 0]] + 1] end] } ; noidle ; killpipe notice ; complete }
alias ctcp { if {"[lindex [args] 0]" == "?"} { /help ctcp ; complete ; return } ; if {![string length [lindex [args] 0]]} { synecho ctcp "[eheader "ctcp"] No destination specified..." } elseif {![string length [join [lrange [args] 1 1]]]} { synecho ctcp "[eheader "ctcp"] No text to send..." } else { echo "[applysctcpstyle "[lindex [args] 0]" "[string toupper [lindex [args] 1]]" "[string range [raw_args] [expr [expr [string length [lindex [args] 0]] + 2] + [string length [lindex [args] 1]]] end]"]" ; /quote privmsg [lindex [args] 0] :\x01[string toupper [lindex [args] 1]] [string range [raw_args] [expr [expr [string length [lindex [args] 0]] + 2] + [string length [lindex [args] 1]]] end]\x01 } ; noidle ; killpipe ctcp ; complete }
alias 4op { if {"[lindex [args] 0]" == "?"} { /help 4op ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set nicks [join [lrange [args] 1 end] ","] } else { set chan [channel] ; set nicks [join [args] ","] } ; if {![validchan $chan]} { synecho 4op "[eheader "4Op"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho 4op "[eheader "Op"] Operator status required to op on [sb]$chan[sb]..." } else { set command "" ; foreach nick [split $nicks ","] { if {[ison $nick $chan]} { append command "mode $chan +oooo $nick $nick $nick $nick[lf]" } else { synecho 4op "[eheader "???"] [b]$nick[b] could not be located on [b]$chan[b]..." } } ; if {[info exists command]} { /raw $command } } ; killpipe 4op ; complete }
alias 4deop { if {"[lindex [args] 0]" == "?"} { /help 4deop ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set nicks [join [lrange [args] 1 end] ","] } else { set chan [channel] ; set nicks [join [args] ","] } ; if {![validchan $chan]} { synecho 4op "[eheader "4Deop"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho 4op "[eheader "4Deop"] Operator status required to op on [sb]$chan[sb]..." } else { set command "" ; foreach nick [split $nicks ","] { if {[ison $nick $chan]} { append command "mode $chan -oooo $nick $nick $nick $nick[lf]" } else { synecho 4op "[eheader "???"] [b]$nick[b] could not be located on [b]$chan[b]..." } } ; if {[info exists command]} { /raw $command } } ; killpipe 4deop ; complete }
alias op { if {"[lindex [args] 0]" == "?"} { /help op ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set nicks [join [lrange [args] 1 end] ","] } else { set chan [channel] ; set nicks [join [args] ","] } ; if {![validchan $chan]} { synecho op "[eheader "Op"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho op "[eheader "Op"] Operator status required to op on [sb]$chan[sb]..." } else { smode +oooooo $chan $nicks } ; killpipe op ; complete }
alias deop { if {"[lindex [args] 0]" == "?"} { /help deop ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set nicks [join [lrange [args] 1 end] ","] } else { set chan [channel] ; set nicks [join [args] ","] } ; if {![validchan $chan]} { synecho deop "[eheader "Deop"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho deop "[eheader "Deop"] Operator status required to deop on [sb]$chan[sb]..." } else { smode -oooooo $chan $nicks } ; killpipe deop ; complete }
alias voice { if {"[lindex [args] 0]" == "?"} { /help voice ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set nicks [join [lrange [args] 1 end] ","] } else { set chan [channel] ; set nicks [join [args] ","] } ; if {![validchan $chan]} { synecho voice "[eheader "Voice"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho voice "[eheader "Voice"] Operator status required to voice on [sb]$chan[sb]..." } else { smode +vvvvvv $chan $nicks } ; killpipe voice ; complete }
alias unvoice { if {"[lindex [args] 0]" == "?"} { /help unvoice ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set nicks [join [lrange [args] 1 end] ","] } else { set chan [channel] ; set nicks [join [args] ","] } ; if {![validchan $chan]} { synecho unvoice "[eheader "Unvoice"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho unvoice "[eheader "Unvoice"] Operator status required to unvoice on [sb]$chan[sb]..." } else { smode -vvvvvv $chan $nicks } ; killpipe unvoice ; complete }
alias k { if {"[lindex [args] 0]" == "?"} { /help k ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set nicks [lindex [args] 1] ; set quote [join [lrange [args] 2 end]] } else { set chan [channel] ; set nicks [lindex [args] 0] ; set quote [join [lrange [args] 1 end]] } ; if {![validchan $chan]} { synecho k "[eheader "Kick"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho k "[eheader "Kick"] Operator status required to kick on [sb]$chan[sb]..." } else { skick noban $chan $nicks $quote } ; killpipe k ; complete }
alias kb { if {"[lindex [args] 0]" == "?"} { /help kb ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set nicks [lindex [args] 1] ; set quote [join [lrange [args] 2 end]] } else { set chan [channel] ; set nicks [lindex [args] 0] ; set quote [join [lrange [args] 1 end]] } ; if {![validchan $chan]} { synecho kb "[eheader "Kick"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho kb "[eheader "Kick"] Operator status required to kick on [sb]$chan[sb]..." } else { skick single $chan $nicks $quote } ; killpipe kb ; complete }
alias skb { if {"[lindex [args] 0]" == "?"} { /help skb ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set nicks [lindex [args] 1] ; set quote [join [lrange [args] 2 end]] } else { set chan [channel] ; set nicks [lindex [args] 0] ; set quote [join [lrange [args] 1 end]] } ; if {![validchan $chan]} { synecho skb "[eheader "Kick"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho skb "[eheader "Kick"] Operator status required to kick on [sb]$chan[sb]..." } else { skick screw $chan $nicks $quote } ; killpipe skb ; complete }
alias dkb { if {"[lindex [args] 0]" == "?"} { /help dkb ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set nicks [lindex [args] 1] ; set quote [join [lrange [args] 2 end]] } else { set chan [channel] ; set nicks [lindex [args] 0] ; set quote [join [lrange [args] 1 end]] } ; if {![validchan $chan]} { synecho dkb "[eheader "Kick"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho dkb "[eheader "Kick"] Operator status required to kick on [sb]$chan[sb]..." } else { skick domain $chan $nicks $quote } ; killpipe dkb ; complete }
alias t { if {"[lindex [args] 0]" == "?"} { /help t ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set quote [join [lrange [args] 1 end]] } else { set chan [channel] ; set quote [join [lrange [args] 0 end]] } ; if {![validchan $chan]} { synecho t "[eheader "Topic"] Invalid channel specified..." } elseif {![isop [my_nick] $chan] && [string match *t* [lindex [mode $chan] 0]]} { synecho t "[eheader "Topic"] Operator status required to set topic on [sb]$chan[sb]..." } else { if {![string length $quote]} { set quote "" } ; /raw topic $chan :$quote } ; killpipe t ; noidle; complete }
alias at { if {"[lindex [args] 0]" == "?"} { /help at ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set quote [join [lrange [args] 1 end]] } else { set chan [channel] ; set quote [join [lrange [args] 0 end]] } ; if {![validchan $chan]} { synecho t "[eheader "Topic"] Invalid channel specified..." } elseif {![isop [my_nick] $chan] && [string match *t* [lindex [mode $chan] 0]]} { synecho t "[eheader "Topic"] Operator status required to set topic on [sb]$chan[sb]..." } else { if {![string length $quote]} { set quote "" } ; /raw topic $chan :[topic $chan] $quote } ; killpipe t ; noidle; complete }
alias c { if {"[lindex [args] 0]" == "?"} { /help c ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set quote [join [lrange [args] 1 end]] } else { set chan [channel] ; set quote [join [lrange [args] 0 end]] } ; if {![validchan $chan]} { synecho m "[eheader "Mode"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho c "[eheader "Mode"] Operator status required to set mode on [sb]$chan[sb]..." } elseif {![string length $quote]} { synecho c "[eheader "Mode"] No modes to set..." } else { /mode $chan $quote } ; killpipe c ; noidle ; complete }
alias mode { if {[lindex [args] 1] == "+b" && ![string length [lindex [args] 2]]} { /bans [lindex [args] 0] ; complete } }
alias nck { if {"[lindex [args] 0]" == "?"} { /help nck ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set nicks [lindex [args] 1] ; set quote [join [lrange [args] 2 end]] } else { set chan [channel] ; set nicks [lindex [args] 0] ; set quote [join [lrange [args] 1 end]] } ; if {![validchan $chan]} { synecho nck "[eheader "CompleteKick"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho nck "[eheader "CompleteKick"] Operator status required to kick on [sb]$chan[sb]..." } else { set killlist "" ; foreach niq [split $nicks ","] { set x [nickc $chan $niq] ; if {[string length $x]} { append killlist "$x," } else { synecho nck "[eheader "CompleteKick"] The nickname [b]$niq[b] could not be completed..." } } ; if {[string length $killlist]} { skick noban $chan [string trimright $killlist ","] $quote } } ; killpipe nck ; noidle ; complete }
alias nckb { if {"[lindex [args] 0]" == "?"} { /help nckb ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set nicks [lindex [args] 1] ; set quote [join [lrange [args] 2 end]] } else { set chan [channel] ; set nicks [lindex [args] 0] ; set quote [join [lrange [args] 1 end]] } ; if {![validchan $chan]} { synecho nckb "[eheader "CompleteKick"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho nckb "[eheader "CompleteKick"] Operator status required to kick on [sb]$chan[sb]..." } else { set killlist "" ; foreach niq [split $nicks ","] { set x [nickc $chan $niq] ; if {[string length $x]} { append killlist "$x," } else { synecho nckb "[eheader "CompleteKick"] The nickname [b]$niq[b] could not be completed..." } } ; if {[string length $killlist]} { skick single $chan [string trimright $killlist ","] $quote } } ; killpipe nckb ; noidle ; complete }
alias lock { if {"[lindex [args] 0]" == "?"} { /help lock ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] } else { set chan [channel] } ; if {![validchan $chan]} { synecho lock "[eheader "Lock"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho lock "[eheader "Lock"] Operator status required to lock [sb]$chan[sb]..." } else { synecho lock "[eheader "Lock"] Locking [b]$chan[b]..." ; /raw mode $chan +milkb -777 ilIl,Illl *!*?@* } ; killpipe lock ; noidle ; complete }
alias unlock { if {"[lindex [args] 0]" == "?"} { /help unlock ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] } else { set chan [channel] } ; if {![validchan $chan]} { synecho unlock "[eheader "Unlock"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho unlock "[eheader "Unlock"] Operator status required to lock [sb]$chan[sb]..." } else { synecho unlock "[eheader "Unlock"] Unlocking [b]$chan[b]..." ; /raw mode $chan -milbbk *!*?@* *!*@* [getkey $chan] } ; killpipe unlock ; noidle ; complete }
alias lk { if {"[lindex [args] 0]" == "?"} { /help lk ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [string tolower [lindex [args] 0]] ; set quote [join [lrange [args] 1 end]] } else { set chan "[string tolower [channel]]" ; set quote [join [lrange [args] 0 end]] } ; if {![validchan $chan]} { synecho lk "[eheader "LastKick"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho lk "[eheader "LastKick"] Operator status required to kick on [sb]$chan[sb]..." } elseif {![info exists lastkick($chan)]} { synecho lk "[eheader "LastKick"] No previous user to lastkick..." } else { if {![string length $quote]} { set quote "LastKick" } ; skick noban $chan $lastkick($chan) $quote } ; killpipe lk ; complete }
alias lkb { if {"[lindex [args] 0]" == "?"} { /help lkb ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [string tolower [lindex [args] 0]] ; set quote [join [lrange [args] 1 end]] } else { set chan "[string tolower [channel]]" ; set quote [join [lrange [args] 0 end]] } ; if {![validchan $chan]} { synecho lkb "[eheader "LastKick"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho lkb "[eheader "LastKick"] Operator status required to kick on [sb]$chan[sb]..." } elseif {![info exists lastkick($chan)]} { synecho lkb "[eheader "LastKick"] No previous user to lastkick..." } else { if {![string length $quote]} { set quote "LastKick" } ; skick single $chan $lastkick($chan) $quote } ; killpipe lkb ; complete }
alias rm { if {"[lindex [args] 0]" == "?"} { /help rm ; complete ; return } ; if {[string match "#*" [lindex [args] 0]]} { set chan [string tolower [lindex [args] 0]] } else { set chan "[string tolower [channel]]" } ; if {![validchan $chan]} { synecho rm "[eheader "ReverseMode"] Invalid channel specified..." } elseif {![isop [my_nick] $chan]} { synecho rm "[eheader "ReverseMode"] Operator status required to change mode on [sb]$chan[sb]..." } elseif {![info exists lastmode($chan)]} { synecho rm "[eheader "ReverseMode"] No previous mode to reverse..." } else { /quote mode $chan [replace [replace [replace [lindex $lastmode($chan) 0] "+" "x"] "-" "+"] "x" "-"] [lrange $lastmode($chan) 1 end] } ; killpipe rm ; complete }
alias rank {
  if {"[lindex [args] 0]" == "?"} { /help rank ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set quote [join [lrange [args] 1 end]]
  } else { set chan [channel] ; set quote [join [lrange [args] 0 end]]  }
  if {![validchan $chan]} { synecho rank "[eheader "RandomKick"] Invalid channel specified..."
  } elseif {![llength [clist all $chan]]} { synecho rank "[eheader "RandomKick"] There are no users on [sb]$chan[sb] to kick..."
  } else {
    set nick [rword [clist all $chan]]
    skick noban $chan $nick $quote
  }
  killpipe rank
  complete
}
alias rannk {
  if {"[lindex [args] 0]" == "?"} { /help rannk ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set quote [join [lrange [args] 1 end]]
  } else { set chan [channel] ; set quote [join [lrange [args] 0 end]] }
  if {![validchan $chan]} { synecho rank "[eheader "RandomKick"] Invalid channel specified..."
  } elseif {![llength [clist -o $chan]]} { synecho rank "[eheader "RandomKick"] There are no users on [sb]$chan[sb] to kick..."
  } else {
    set nick [rword [clist -o $chan]]
    skick noban $chan $nick $quote
  }
  killpipe rank
  complete
}
alias ranok {
  if {"[lindex [args] 0]" == "?"} { /help ranok ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set quote [join [lrange [args] 1 end]]
  } else { set chan [channel] ; set quote [join [lrange [args] 0 end]]  }
  if {![validchan $chan]} { synecho rank "[eheader "RandomKick"] Invalid channel specified..."
  } elseif {![llength [clist +o $chan]]} { synecho rank "[eheader "RandomKick"] There are no users on [sb]$chan[sb] to kick..."
  } else {
    set nick [rword [clist +o $chan]]
    skick noban $chan $nick $quote
  }
  killpipe rank
  complete
}
alias gk {
  if {"[lindex [args] 0]" == "?"} { /help gk ; complete ; return }
  set nicks [lindex [args] 0]
  set quote [join [lrange [args] 1 end]]
  if {![string length $nicks]} { synecho gk "[eheader "GlobalKick"] Please specify a nick to globalkick..."
  } else {
    foreach nick [split $nicks ","] {
      foreach chan [channels] {
        if {[ison $nick $chan] && [isop [my_nick] $chan]} { set flag 1 ; skick noban $chan $nick $quote }
      }
      if {[info exists flag]} { unset flag
      } else { synecho gk "[eheader "GlobalKick"] You are not oped on any channels with [sb]$nick[sb]..." }
    }
  }
  killpipe gk
  complete
}
alias gkb {
  if {"[lindex [args] 0]" == "?"} { /help gkb ; complete ; return }
  set nicks [lindex [args] 0]
  set quote [join [lrange [args] 1 end]]
  if {![string length $nicks]} { synecho gkb "[eheader "GlobalKick"] Please specify a nick to globalkick..."
  } else {
    foreach nick [split $nicks ","] {
      foreach chan [channels] {
        if {[ison $nick $chan] && [isop [my_nick] $chan]} { set flag 1 ; skick single $chan $nick $quote }
      }
      if {[info exists flag]} { unset flag
      } else { synecho gkb "[eheader "GlobalKick"] You are not oped on any channels with [sb]$nick[sb]..." }
    }
  }
  killpipe gkb
  complete
}

alias note {
  if {"[lindex [args] 0]" == "?"} { /help note ; complete ; return }
  if {[string length [args]]} {
    set tempy [open "[get_syn_dir]/syntax/notes.txt" a+]
    puts $tempy "(n) [string tolower [clock format [clock seconds] -format "\[%m/%d/%y %I:%M:%S%p\]"]] [join [args]]"
    close $tempy
    synecho note "[eheader "Notepad"] Added note on [b][string tolower [clock format [clock seconds] -format "%m/%d/%y at %I:%M:%S%p"]][b]: [join [args]]"
  } else {
    synecho note "[eheader "Notepad"] Displaying notes..."
    exec [config editor] "[get_syn_dir]/syntax/notes.txt" &
  }
  killpipe note
  complete
}
alias calc {
  if {"[lindex [args] 0]" == "?"} { /help calc ; complete ; return }
  set x "[expr [args]]"
  synecho calc "[eheader "Calc"] [args] = $x"
  killpipe calc
  complete
}
alias country {
  if { [lindex [args] 0] == "-nick" } {
    set nick [lrange [arg] 1 end]
    if { [uhost $nick] == "" } {
      /quote who $nick
      synecho country "[eheader "Country"] No user@host for $nick. Try again in a few seconds..."
      complete
      return
    } else {
      set country [getcountry [set x [lindex [set xx [split [uhost $nick] .]] [expr [llength $xx] - 1]]]]
      set args $x
    }
  } else {
    set country [getcountry [args]]
    set args [args]
  }

  if { $country == "" } {
    synecho country "[eheader "Country"] Country for *.$args not found..."
  } else {
    synecho country "[eheader "Country"] Country for *.$args is $country..."
  }
  killpipe countru
  complete
}
alias pwall {
  if {"[lindex [args] 0]" == "?"} { /help pwall ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set wallmsg [join [lrange [args] 1 end]]
  } else { set chan [channel] ; set wallmsg [join [args]] }
  if {![validchan $chan]} { synecho pwall "[eheader "WallNonop"] Invalid channel specified..."
  } elseif {[isop [my_nick] $chan] && [llength [clist -o $chan]] == 0} { synecho pwall "[eheader "WallNonop"] There are no other nonops to wall to..."
  } elseif {![isop [my_nick] $chan] && [llength [clist -o $chan]] == 1} { synecho pwall "[eheader "WallNonop"] There are no other nonops to wall to..."
  } elseif {![string length $wallmsg]} { synecho pwall"[eheader "WallNonop"] No message to send..."
  } else {
    synecho pwall "([b]peonwall[b]($chan)) $wallmsg"
    set bynum [servmsgmax]
    set total 0
    set groups ""
    set nix ""
    foreach nick [rflist [clist -o $chan] [my_nick]] {
      if {$total == $bynum} { lappend groups [string trimright $nix ","] ; set total 0 ; set nix "" }
      incr total
      append nix "$nick,"
    }
    if {[string length $nix]} { lappend groups [string trimright $nix ","] }
    foreach group $groups { /raw notice $group :[applychannelwallopstyle "$chan" "$wallmsg" "[llength [clist -o $chan]]" "[percent [llength [clist -o $chan]] [llength [clist all $chan]]]"] }
  }
  noidle
  killpipe pwall
  complete
}
alias wall {
  if {"[lindex [args] 0]" == "?"} { /help wall ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set wallmsg [join [lrange [args] 1 end]]
  } else { set chan [channel] ; set wallmsg [join [args]] }
  if {![validchan $chan]} { synecho wall "[eheader "WallOp"] Invalid channel specified..."
  } elseif {[isop [my_nick] $chan] && [llength [clist +o $chan]] == 1} { synecho wall "[eheader "WallOp"] There are no other ops to wallop to..."
  } elseif {![isop [my_nick] $chan] && [llength [clist +o $chan]] == 0} { synecho wall "[eheader "WallOp"] There are no other ops to wallop to..."
  } elseif {![string length $wallmsg]} { synecho wall "[eheader "WallOp"] No message to send..."
  } else {
    synechox wall "[applyschannelwallopstyle "$chan" "$wallmsg"]"
    set bynum [servmsgmax]
    set total 0
    set groups ""
    set nix ""
    foreach nick [rflist [clist +o $chan] [my_nick]] {
      if {$total == $bynum} { lappend groups [string trimright $nix ","] ; set total 0 ; set nix "" }
      incr total
      append nix "$nick,"
    }
    if {[string length $nix]} { lappend groups [string trimright $nix ","] }
    foreach group $groups { /raw notice $group :[applychannelwallopstyle "$chan" "$wallmsg" "[llength [clist -o $chan]]" "[percent [llength [clist -o $chan]] [llength [clist all $chan]]]"] }
  }
  noidle
  killpipe wall
  complete
}
alias wallex {
  if {"[lindex [args] 0]" == "?"} { /help wallex ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set ex [lindex [args] 1] ; set wallmsg [join [lrange [args] 2 end]]
  } else { set chan [channel] ; set ex [lindex [args] 0] ; set wallmsg [join [lrange [args] 1 end]]  }
  if {![validchan $chan]} { synecho wallex "[eheader "WallOp"] Invalid channel specified..."
  } elseif {![string length $wallmsg]} { synecho wallex "[eheader "WallOp"] No message to send..."
  } else {
    set nicks "[string tolower [rflist [clist +o $chan] [my_nick]]]"
    foreach nick [string tolower [split $ex ","]] { set nicks [rflist $nicks "$nick"] }
    if {![llength $nicks]} { synecho wallex "[eheader "WallOp"] There are no other ops to wallop to..."
    } else {
      set wallmsg "(except: $ex) $wallmsg"
      synechox wall "[applyschannelwallopstyle "$chan" "$wallmsg"]"
      set bynum [servmsgmax]
      set total 0
      set groups ""
      set nix ""
      foreach nick $nicks {
        if {$total == $bynum} { lappend groups [string trimright $nix ","] ; set total 0 ; set nix "" }
        incr total
        append nix "$nick,"
      }
      if {[string length $nix]} { lappend groups [string trimright $nix ","] }
      foreach group $groups { /raw notice $group :[applychannelwallopstyle "$chan" "$wallmsg" "[llength [clist -o $chan]]" "[percent [llength [clist -o $chan]] [llength [clist all $chan]]]"] }
    }
  }
  noidle
  killpipe wallex
  complete
}
alias xwall {
  if {"[lindex [args] 0]" == "?"} { /help xwall ; complete ; return }
  set wallmsg [join [args]]
  if {[string tolower [config xwallnicks]] == "none"} { synecho xwall "[eheader "XWallOp"] There are no xwallops on your list..."
  } elseif {![string length $wallmsg]} { synecho xwall "[eheader "XWallOp"] No message to send..."
  } else {
    set wallmsg "[applyxwallopstyle "$wallmsg" "[llength [split [config xwallnicks]]]"]"
    synechox wall "[applysxwallopstyle "$wallmsg" "[llength [split [config xwallnicks]]]"]"
    set bynum [servmsgmax]
    set total 0
    set groups ""
    set nix ""
    foreach nick [split [join [split [config xwallnicks]] ","]] {
      if {$total == $bynum} { lappend groups [string trimright $nix ","] ; set total 0 ; set nix "" }
      incr total
      append nix "$nick,"
    }
    if {[string length $nix]} { lappend groups [string trimright $nix ","] }
    foreach group $groups { /raw notice $group :$wallmsg }
  }
  noidle
  killpipe xwall
  complete
}

alias seen {
  global seen
  if {[info exists seen([string tolower [lindex [args] 0]])]} {
    set seenx "$seen([string tolower [lindex [args] 0]])"
    switch "[lindex $seenx 0]" {
      "quit" { synecho seen "[eheader "Seen"] [b][lindex $seenx 2][b] was last seen quitting with message [b]([b][lindex $seenx 3][b])[b] on [b][lindex $seenx 4][b]" }
      "kick" { synecho seen "[eheader "Seen"] [b][lindex $seenx 2][b] was last seen being kicked from [b][lindex $seenx 1][b] by [b][lindex $seenx 5][b] with message [b]([b][lindex $seenx 3][b])[b] on [b][lindex $seenx 4][b]" }
      "part" { synecho seen "[eheader "Seen"] [b][lindex $seenx 2][b] was last seen leaving [b][lindex $seenx 1][b] on [b][lindex $seenx 4][b]" }
    }
  } else {
    synecho seen "[eheader "Seen"] No such user on your database ([b][lindex [args] 0][b])..."
  }
  killpipe seen
  noidle
  complete
}
alias kickquote {
  if {"[lindex [args] 0]" == "?"} { /help kickquote ; complete ; return }
  if {[string trim [lindex [args] 0] "-"] == "add"} {
    set num 0
    set flag 0
    foreach ver [get_cookie kickquote] { incr num ; if {[join [strip [lrange [args] 1 end]]] == [join [strip $ver]]} { set flag 1 } }
    if {$flag} { unset flag ; synecho kickquote "[eheader "KickQuote"] Kick quote already on list: [join [lrange [args] 1 end]]"
    } else { synecho kickquote "[eheader "KickQuote"] Added kick quote: [join [lrange [args] 1 end]]" ; set x [get_cookie kickquote] ; lappend x [lrange [args] 1 end] ; set_cookie kickquote "$x" }
  } elseif {[string range [string trim [lindex [args] 0] "-"] 0 2] == "res"} {
    set_cookie kickquote { "!@#$@!" }
    synecho kickquote "[eheader "KickQuote"] Restoring default kick quotes..."
  } elseif {[string trim [lindex [args] 0] "-"] == "del"} {
    set num 0
    set rver ""
    if {[isnum [lindex [args] 1]]} { foreach ver [get_cookie kickquote] { incr num ; if {$num == [lindex [args] 1]} { set rver $ver ; set_cookie kickquote [rflist [get_cookie kickquote] $ver] } }
    } else { foreach ver [get_cookie kickquote] { if {[join [strip [lrange [args] 1 end]]] == [join [strip $ver]]} { set rver $ver ; set_cookie kickquote [rflist [get_cookie kickquote] $ver] } } }
    if {[string length $rver]} {
      synecho kickquote "[eheader "KickQuote"] Removed kick quote: [join $rver]"
    } elseif {[isnum [lindex [args] 1]]} { synecho kickquote "[eheader "KickQuote"] Kick quote number ([b][lindex [args] 1][b]) could not be located..."
    } else { synecho kickquote "[eheader "KickQuote"] Kick quote ([b][lindex [args] 1][b]) could not be located..." }
  } elseif {![string length [get_cookie kickquote]]} {
    synecho kickquote "[eheader "KickQuote"] You have no quotes set..."
  } else {
    set num 0
    foreach ver [get_cookie kickquote] { incr num }
    synecho kickquote "[boxtop "[b]KickQuotes List[b] [sb](([sb][su]entries:[su] [b]$num[b][sb]))[sb]"]"
    set num 0
    foreach ver [get_cookie kickquote] { incr num ; synecho kickquote "[boxside "[llb][b][align $num 2][b][lrb] [join $ver]"]" }
    synecho kickquote "[boxbottom "[b]KickQuotes List[b] [sb](([sb][su]entries:[su] [b]$num[b][sb]))[sb]"]"
  }
  killpipe kickquote
  noidle
  complete
}
alias fakever {
  if {"[lindex [args] 0]" == "?"} { /help fakever ; complete ; return }
  if {[string trim [lindex [args] 0] "-"] == "add"} {
    set num 0
    set flag 0
    foreach ver [get_cookie fakever] { incr num ; if {[join [strip [lrange [args] 1 end]]] == [join [strip $ver]]} { set flag 1 } }
    if {$flag} { unset flag ; synecho fakever "[eheader "FakeVer"] Version reply already on list: [join [lrange [args] 1 end]]"
    } else { synecho fakever "[eheader "FakeVer"] Added version reply: [join [lrange [args] 1 end]]" ; set x [get_cookie fakever] ; lappend x [lrange [args] 1 end] ; set_cookie fakever "$x" }
  } elseif {[string range [string trim [lindex [args] 0] "-"] 0 2] == "res"} {
    set_cookie fakever { "BitchX-71alpha5 by panasync - Linux 2.2.14 : Keep it to yourself!" "ircII 2.9_roof Linux 2.0.29-ISS :+ phear 2.01 by ShadowImg (18-12-96)" "static orange 1.25c!03.28.97 final - digitally master`d by webba" "ircII 2.8.2^hADES%fINAL+CAVLINK by hellshock :StyX v10.20.96r1 by _vidiot" }
    synecho fakever "[eheader "FakeVer"] Restoring default version replies..."
  } elseif {[string trim [lindex [args] 0] "-"] == "del"} {
    set num 0
    set rver ""
    if {[isnum [lindex [args] 1]]} { foreach ver [get_cookie fakever] { incr num ; if {$num == [lindex [args] 1]} { set rver $ver ; set_cookie fakever [rflist [get_cookie fakever] $ver] } }
    } else { foreach ver [get_cookie fakever] { if {[join [strip [lrange [args] 1 end]]] == [join [strip $ver]]} { set rver $ver ; set_cookie fakever [rflist [get_cookie fakever] $ver] } } }
    if {[string length $rver]} {
      synecho fakever "[eheader "FakeVer"] Removed version reply: [join $rver]"
    } elseif {[isnum [lindex [args] 1]]} { synecho fakever "[eheader "FakeVer"] Version reply number ([b][lindex [args] 1][b]) could not be located..."
    } else { synecho fakever "[eheader "FakeVer"] Version reply ([b][lindex [args] 1][b]) could not be located..." }
  } elseif {![string length [get_cookie fakever]]} {
    synecho fakever "[eheader "FakeVer"] You have no replies set..."
  } else {
    set num 0
    foreach ver [get_cookie fakever] { incr num }
    synecho fakever "[boxtop "[b]FakeVersions List[b] [sb](([sb][su]entries:[su] [b]$num[b][sb]))[sb]"]"
    set num 0
    foreach ver [get_cookie fakever] { incr num ; synecho fakever "[boxside "[llb][b][align $num 2][b][lrb] [join $ver]"]" }
    synecho fakever "[boxbottom "[b]FakeVersions List[b] [sb](([sb][su]entries:[su] [b]$num[b][sb]))[sb]"]"
  }
  killpipe fakever
  noidle
  complete
}
alias quitquote {
  if {"[lindex [args] 0]" == "?"} { /help quitquote ; complete ; return }
  if {[string trim [lindex [args] 0] "-"] == "add"} {
    set num 0
    set flag 0
    foreach ver [get_cookie quitquote] { incr num ; if {[join [strip [lrange [args] 1 end]]] == [join [strip $ver]]} { set flag 1 } }
    if {$flag} { unset flag ; synecho quitquote "[eheader "QuitQuote"] Quit quote already on list: [join [lrange [args] 1 end]]"
    } else { synecho quitquote "[eheader "QuitQuote"] Added quit quote: [join [lrange [args] 1 end]]" ; set x [get_cookie quitquote] ; lappend x [lrange [args] 1 end] ; set_cookie quitquote "$x" }
  } elseif {[string range [string trim [lindex [args] 0] "-"] 0 2] == "res"} {
    set_cookie quitquote { ".[b]plop[b]." }
    synecho quitquote "[eheader "QuitQuote"] Restoring default quit quotes..."
  } elseif {[string trim [lindex [args] 0] "-"] == "del"} {
    set num 0
    set rver ""
    if {[isnum [lindex [args] 1]]} { foreach ver [get_cookie quitquote] { incr num ; if {$num == [lindex [args] 1]} { set rver $ver ; set_cookie quitquote [rflist [get_cookie quitquote] $ver] } }
    } else { foreach ver [get_cookie quitquote] { if {[join [strip [lrange [args] 1 end]]] == [join [strip $ver]]} { set rver $ver ; set_cookie quitquote [rflist [get_cookie quitquote] $ver] } } }
    if {[string length $rver]} {
      synecho quitquote "[eheader "QuitQuote"] Removed quit quote: [join $rver]"
    } elseif {[isnum [lindex [args] 1]]} { synecho quitquote "[eheader "QuitQuote"] Quit quote number ([b][lindex [args] 1][b]) could not be located..."
    } else { synecho quitquote "[eheader "QuitQuote"] Quit quote ([b][lindex [args] 1][b]) could not be located..." }
  } elseif {![string length [get_cookie quitquote]]} {
    synecho quitquote "[eheader "QuitQuote"] You have no quotes set..."
  } else {
    set num 0
    foreach ver [get_cookie quitquote] { incr num }
    synecho quitquote "[boxtop "[b]QuitQuotes List[b] [sb](([sb][su]entries:[su] [b]$num[b][sb]))[sb]"]"
    set num 0
    foreach ver [get_cookie quitquote] { incr num ; synecho quitquote "[boxside "[llb][b][align $num 2][b][lrb] [join $ver]"]" }
    synecho quitquote "[boxbottom "[b]QuitQuotes List[b] [sb](([sb][su]entries:[su] [b]$num[b][sb]))[sb]"]"
  }
  killpipe quitquote
  noidle
  complete
}
alias mystat {
  if {"[lindex [args] 0]" == "?"} { /help mystat ; complete ; return }
  synecho mystat "[boxtop "[b]UserStatus View[b]"]"
  synecho mystat "[boxside "[eheader "address    "] [b][my_nick][b]([my_user]@[my_host]) ([b]ip:[b] [sb][my_ip][sb])"]"
  synecho mystat "[boxside "[eheader "localhost  "] [b][info hostname][b]"]"
  synecho mystat "[boxside "[eheader "os uptime  "] [durationstyle [uptime] " year" " day" " hour" " minute" " second" "s" " " "16" ""]"]"
  synecho mystat "[boxside "[eheader "server     "] [b][lindex [xserver] 0][b] ([sb]port:[sb] [b][lindex [xserver] 1][b])"]"
  if {[get_cookie totalkicks] == ""} {set kicks 0} else {set kicks [get_cookie totalkicks]}
  synecho mystat "[boxside "[eheader "totalkicks "] [b]$kicks[b] users"]"
  if {[get_cookie timer(session)] != "0"} { synecho mystat "[boxside "[eheader "onlinetime "] [durationstyle [expr [clock seconds] - [get_cookie timer(session)]] " year" " day" " hour" " minute" " second" "s" " " "[boldstart]" ""]"]" }
  synecho mystat "[boxside "[eheader "totaltime  "] [durationstyle [get_cookie timer(total)] " year" " day" " hour" " minute" " second" "s" " " "[boldstart]" ""]"]"
  synecho mystat "[boxside "[eheader "idletime   "] [durationstyle $xidle " year" " day" " hour" " minute" " second" "s" " " "[boldstart]" ""]"]"
  if {[get_cookie awaymsgs "0"] > 0} { synecho mystat "[boxside "[eheader "awaymsgs   "] You have [b][get_cookie awaymsgs][b] old messages..."]" }
  if {[get_cookie awaycapt "0"] > 0} { synecho mystat "[boxside "[eheader "awaycapts  "] You have [b][get_cookie awaycapt][b] old captures..."]" }
  if {[info exists idle(x)]} { synecho mystat "[boxside "[eheader "idle       "] AntiIdle is set [b]ON[b]... (interval: [b][config antiidle]sec[b])"]"
  } else { synecho mystat "[boxside "[eheader "idle       "] AntiIdle is set [b]OFF[b]..."]" }
  if {[info exists away(x)]} { synecho mystat "[boxside "[eheader "away       "] Awaymode is set to [b]ON[b]... ([b]$away(msg)[b])"]"
  } else { synecho mystat "[boxside "[eheader "away       "] Awaymode is set to [b]OFF[b]..."]" }
  synecho mystat "[boxbottom "[b]UserStatus View[b]"]"
  killpipe mystat
  complete
}
alias timeclear {
  if {"[lindex [args] 0]" == "?"} { /help timeclear ; complete ; return }
  set_cookie timer(total) "0"
  set_cookie timer(tstarted) "[string tolower [clock format [clock seconds] -format "%m/%d/%y at %I:%M:%S%p"]]"
  synecho timeclear "[eheader "OnlineTimer"] Total online time timer has been resetted... ([sb]time:[sb] [b][get_cookie timer(tstarted)][b])"
  killpipe timeclear
  noidle
  complete
}
alias cs {
  if {"[lindex [args] 0]" == "?"} { /help cs ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [join [lindex [args] 0]] } else { set chan [channel] }
  if {![validchan $chan]} { synecho cs "[eheader "ChanStat"] Invalid channel specified..."
  } else {
    set total [llength [clist all $chan]]
    synecho cs "[boxtop "[b]Chanstats for $chan[b]"]"
    set nix 0
    set line ""
    foreach nick [nicks $chan] {
      incr nix
      if {[string match @* $nick]} { append line "[llb][sb]@[sb][align [string range [string trimleft $nick "@"] 0 9] 10][lrb] "
      } elseif {[string match +* $nick]} { append line "[llb][sb]+[sb][align [string range [string trimleft $nick "+"] 0 9] 10][lrb] "
      } else { append line "[llb] [string range [align $nick 10] 0 9][lrb] " }
      if {$nix == 5} { synecho cs "[boxside "$line"]" ; set nix 0 ; set line "" }
    }
    if {$nix} { synecho cs "[boxside "$line"]" }
    synecho cs "[boxside "[b](ops      )[b] ([sb][align [llength [clist +o $chan]] 3][sb])[align ([su][percent [llength [clist +o $chan]] $total][su]) 21] [b](voice    )[b] ([sb][align [llength [clist +v $chan]] 3][sb])[align ([su][percent [llength [clist +v $chan]] $total][su]) 21]"]"
    synecho cs "[boxside "[b](nonops   )[b] ([sb][align [llength [clist -o $chan]] 3][sb])[align ([su][percent [llength [clist -o $chan]] $total][su]) 21] [b](nonvoice )[b] ([sb][align [llength [clist -v $chan]] 3][sb])[align ([su][percent [llength [clist -v $chan]] $total][su]) 21]"]"
    synecho cs "[boxside "[b](total    )[b] [b][align =[llength [clist all $chan]]= 4][b]"]"
    synecho cs "[boxbottom "[b]Chanstats for $chan[b]"]"
  }
  killpipe cs
  noidle
  complete
}
alias nms {
  if {"[lindex [args] 0]" == "?"} { /help nms ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [join [lindex [args] 0]] } else { set chan [channel] }
  if {![validchan $chan]} { synecho nms "[eheader "Names"] Invalid channel specified..."
  } else {
    set total [llength [clist all $chan]]
    synecho nms "[boxtop "[b]Users on $chan[b] ([b][llength [clist all $chan]][b])"]"
    set nix 0
    set line ""
    foreach nick [nicks $chan] {
      incr nix
      if {[string match @* $nick]} { append line "[llb][sb]@[sb][align [string range [string trimleft $nick "@"] 0 9] 10][lrb] "
      } elseif {[string match +* $nick]} { append line "[llb][sb]+[sb][align [string range [string trimleft $nick "+"] 0 9] 10][lrb] "
      } else { append line "[llb] [string range [align $nick 10] 0 9][lrb] " }
      if {$nix == 5} { synecho nms "[boxside "$line"]" ; set nix 0 ; set line "" }
    }
    if {$nix} { synecho nms "[boxside "$line"]" }
    synecho nms "[boxbottom "[b]Users on $chan[b] ([b][llength [clist all $chan]][b])"]"
  }
  killpipe nms
  noidle
  complete
}
alias chops {
  if {"[lindex [args] 0]" == "?"} { /help nms ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [join [lindex [args] 0]] } else { set chan [channel] }
  if {![validchan $chan]} { synecho chops "[eheader "Chops"] Invalid channel specified..."
  } elseif {![llength [clist +o $chan]]} { synecho chops "[eheader "Chops"] There are currently no operators on [b]$chan[b]..."
  } else {
    set total [llength [clist +o $chan]]
    synecho chops "[boxtop "[b]Channel Ops on $chan[b] ([b][llength [clist +o $chan]][b])"]"
    set nix 0
    set line ""
    foreach nick [clist +o $chan] {
      incr nix
      append line "[sb]\[@[sb][string range [align $nick 10] 0 9][lrb] "
      if {$nix == 5} { synecho chops "[boxside "$line"]" ; set nix 0 ; set line "" }
    }
    if {$nix} { synecho chops "[boxside "$line"]" }
    synecho chops "[boxbottom "[b]Channel Ops on $chan[b] ([b][llength [clist +o $chan]][b])"]"
  }
  killpipe chops
  noidle
  complete
}
alias away {
  if {"[lindex [args] 0]" == "?"} { /help away ; complete ; return }
  if {[string length [lindex [args] 0]]} { set away(msg) "[raw_args]"
  } else { set away(msg) [config defawayqo] }
  if {[config awaynickchange]} { /raw nick [config awaynick] }
  set away(x) 1
  set away(since) "[clock seconds]"
  set away(time) 0
  synecho away "[eheader "Away"] You are now marked as [b]AWAY[b]: ($away(msg))"
  if {[config awaypager]} { set pager "on" } { set pager "off" }
  if {[config awaymessagelog]} { set msglog "on" } { set msglog "off" }
  /raw away :[applyrawawaymsgstyle "$away(msg)" "$pager" "$msglog" "[clock seconds]"]
  /ame [applyawaymsgstyle "$away(msg)" "$pager" "$msglog" "[clock seconds]"]
  killpipe away
  noidle
  complete
}
alias autoaway {
  if {"[lindex [args] 0]" == "?"} { /help away ; complete ; return }
  if {[config autoaway]} { set away(msg) "autoaway ([expr [config autoaway] / 60]min)"
  } else { set away(msg) "autoaway (5min)" }
  if {[config awaynickchange]} { /raw nick [config awaynick] }
  set away(x) 1
  set away(since) "[clock seconds]"
  set away(time) 0
  synecho away "[eheader "Away"] You are now marked as [b]AWAY[b]: ($away(msg))"
  if {[config awaypager]} { set pager "on" } { set pager "off" }
  if {[config awaymessagelog]} { set msglog "on" } { set msglog "off" }
  /raw away :[applyrawawaymsgstyle "$away(msg)" "$pager" "$msglog" "[clock seconds]"]
  /ame [applyawaymsgstyle "$away(msg)" "$pager" "$msglog" "[clock seconds]"]
  killpipe away
  noidle
  complete
}
alias back {
  if {"[lindex [args] 0]" == "?"} { /help back ; complete ; return }
  if {[info exists away(x)]} {
    if {[string length [lindex [args] 0]]} { set away(msg) "[raw_args]"
    } else { set away(msg) [config defbackqo] }
    if {[config awaynickchange]} { /raw nick [config regnick] }
    synecho back "[eheader "Away"] You are now marked as [b]BACK[b]: ($away(msg))"
    if {[get_cookie awaymsgs "0"] > 0} { synecho back "[eheader "Away"] You have [b][get_cookie awaymsgs][b] new messages... type /awaymsgs to read..." }
    if {[get_cookie awaycapt "0"] > 0} { synecho back "[eheader "Away"] You have [b][get_cookie awaycapt][b] new captures... type /awaycapt to read..." }
    /raw away
    if {[config awaypager]} { set pager "on" } { set pager "off" }
    /ame [applybackmsgstyle "$away(msg)" "$pager" "[clock seconds]"]
    unset away
  } else {
    if {[string length [lindex [args] 0]]} { set away(msg) "[raw_args]"
    } else { set away(msg) [config defbackqo] }
    synecho back "[eheader "Away"] You are now marked as [b]BACK[b]: ($away(msg))"
    /raw away
    if {[config awaypager]} { set pager "on" } { set pager "off" }
    /ame [applybackmsgstyle "$away(msg)" "$pager" "[clock seconds]"]
  }
  killpipe back
  noidle
  complete
}
alias fk {
  if {"[lindex [args] 0]" == "?"} { /help fk ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set mmask [lindex [args] 1] ; set quote [join [lrange [args] 2 end]]
  } else { set chan [channel] ; set mmask [lindex [args] 0] ; set quote [join [lrange [args] 1 end]] }
  if {![validchan $chan]} { synecho fk "[eheader "FilterKick"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} { synecho fk "[eheader "FilterKick"] Operator status required to FilterKick $chan..."
  } else {
    if {![string length $quote]} { set quote "FilterKick ($mmask)(%n" }
    set bann ""
    foreach niq [rflist [clist all $chan] [my_nick]] { if {[wmatch $mmask [getmask $niq]] && ![isprotected [getmask $niq] $chan]} { append bann "$niq," } }
    if {[string length $bann]} { synecho fk "[eheader "FilterKick\[$mmask\]"] Executing FilterKick on $chan..." ; skick noban $chan [string trimright $bann ","] [split $quote]
    } else { synecho fk "[eheader "FilterKick"] No users on [b]$chan[b] found matching [b]$mmask[b]..." }
  }
  killpipe fk
  noidle
  complete
}
alias fkb {
  if {"[lindex [args] 0]" == "?"} { /help fkb ; complete ; return } ;
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set mmask [lindex [args] 1] ; set quote [join [lrange [args] 2 end]]
  } else { set chan [channel] ; set mmask [lindex [args] 0] ; set quote [join [lrange [args] 1 end]] }
  if {![validchan $chan]} { synecho fkb "[eheader "FilterKickBan"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} { synecho fkb "[eheader "FilterKickBan"] Operator status required to FilterKick $chan..."
  } else {
    if {![string length $quote]} { set quote "FilterKick ($mmask)(%n" }
    set bann ""
    foreach niq [rflist [clist all $chan] [my_nick]] { if {[wmatch $mmask [getmask $niq]] && ![isprotected [getmask $niq] $chan]} { append bann "$niq," } }
    /raw mode $chan +b $mmask
    if {[string length $bann]} { synecho fkb "[eheader "FilterKickBan\[$mmask\]"] Executing FilterKickBan on $chan..." ; skick noban $chan [string trimright $bann ","] [split $quote]
    } else { synecho fkb "[eheader "FilterKickBan"] No users on [b]$chan[b] found matching [b]$mmask[b]..." }
  }
  killpipe fkb
  noidle
  complete
}
alias cycle {
  if {"[lindex [args] 0]" == "?"} { /help cycle ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [join [lindex [args] 0]]
  } else { set chan [channel] }
  set ll [llength [clist all $chan]]
  if {![validchan $chan] && $ll != "1"} { synecho cycle "[eheader "Cycle"] Cannot cycle channel -- Invalid Channel..."
  } elseif {[string match *i* [lindex [mode $chan] 0]] && [llength [clist all $chan]] > 1 && $ll != "1"} { synecho cycle "[eheader "Cycle"] Cannot cycle channel -- Channel is invite only \[[b]+i[b]\]"
  } elseif {[string match *l* [lindex [mode $chan] 0]] && [getlimit $chan] < [llength [clist all $chan]] && $ll != "1"} { synecho cycle "[eheader "Cycle"] Cannot cycle channel -- Channel has limited space \[[b]+l[b]\]"
  } else {
    if {[string match *k* [lindex [mode $chan] 0]]} { set key [getkey $chan]
    } else { set key "" }
    synecho cycle "[eheader "Cycle"] Cycling $chan..."
    /raw part $chan[lf]join $chan $key
    set jsynk($chan) "[clock clicks]"
  }
  killpipe cycle
  noidle
  complete
}
alias resynch {
  if {"[lindex [args] 0]" == "?"} { /help resynch ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set pri [lindex [args] 1]
  } else { set chan [channel] ; set pri [lindex [args] 0] }
  if {![validchan $chan]} { synecho resynch "[eheader "Resynch"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} { synecho resynch "[eheader "Resynch"] Operator status required to massdeop [sb]$chan[sb]..."
  } else {
    set priz ""
    set nicks [join [rflist [clist +o $chan] [my_nick]] ","]
    if {![string length $nicks]} {
      synecho resynch "[eheader "Resynch"] There are no other users to on [sb]$chan[sb]..."
    } else {
      synecho resynch "[eheader "Resynch\[[llength [split $nicks ","]]\]"] Executing resynch on [sb]$chan[sb]..."
      smode +oooooo $chan $nicks
    }
  }
  killpipe resynch
  noidle
  complete
}
alias md {
  if {"[lindex [args] 0]" == "?"} { /help md ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set pri [lindex [args] 1]
  } else { set chan [channel] ; set pri [lindex [args] 0] }
  if {![validchan $chan]} { synecho md "[eheader "MassDeop"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} { synecho md "[eheader "MassDeop"] Operator status required to massdeop [sb]$chan[sb]..."
  } else {
    set priz ""
    set nicks [join [rflist [clist +o $chan] [my_nick]] ","]
    foreach nick [revorder [split $pri ","]] { set x [isprotected [getmask $nick] $chan] ; if {[isop $nick $chan] && ![isin $nick $priz] && [ison $nick $chan] && !$x} { set nicks "$nick,[join [rflist [split $nicks ","] $nick] ","]" ; set priz "$nick $priz" } elseif {$x && [config massfriendprot]} { set priz "${nick}([b]p[b]) $priz" } elseif {[ison $nick $chan]} { set priz "${nick}([b]x[b]) $priz" } else { set priz "${nick}([b]?[b]) $priz" } }
    if {[config massfriendprot]} { foreach nick [split $nicks ","] { if {[isprotected [getmask $nick] $chan]} { set nicks [join [rflist [split $nicks ","] $nick] ","] } } }
    if {![string length $nicks]} {
      synecho md "[eheader "MassDeop"] There are no users to deop on [sb]$chan[sb]..."
    } else {
      synecho md "[eheader "MassDeop\[[llength [split $nicks ","]]\]"] Executing massdeop on [sb]$chan[sb]..."
      if {[string length $pri]} { synecho md "[eheader "MassDeop\[[llength [split $nicks ","]]\]"] Priority Deops: [string trimright $priz]" }
      smode -oooooo $chan [string trim $nicks ","]
    }
  }
  killpipe md
  noidle
  complete
}
alias mo {
  if {"[lindex [args] 0]" == "?"} { /help mo ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set pri [lindex [args] 1]
  } else { set chan [channel] ; set pri [lindex [args] 0] }
  if {![validchan $chan]} { synecho mo "[eheader "MassOp"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} { synecho mo "[eheader "MassOp"] Operator status required to massop [sb]$chan[sb]..."
  } else {
    set priz ""
    set nicks [join [clist -o $chan] ","]
    foreach nick [revorder [split $pri ","]] { if {![isop $nick $chan] && ![isin $nick $priz]} { set nicks "$nick,[join [rflist [split $nicks ","] $nick] ","]" ; set priz "$nick $priz" } elseif {[ison $nick $chan]} { set priz "${nick}([b]x[b]) $priz" } else { set priz "${nick}([b]?[b]) $priz" } }
    if {![string length $nicks]} {
      synecho mo "[eheader "MassOp"] There are no users to op on [sb]$chan[sb]... "
    } else {
      synecho mo "[eheader "MassOp\[[llength [split $nicks ","]]\]"] Executing massop on [sb]$chan[sb]..."
      if {[string length $pri]} { synecho mo "[eheader "MassOp\[[llength [split $nicks ","]]\]"] Priority Ops: [string trimright $priz]" }
      smode +oooooo $chan [string trim $nicks ","]
    }
  }
  killpipe mo
  noidle
  complete
}
alias mopu {
  if {"[lindex [args] 0]" == "?"} { /help mopu ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0]
  } else { set chan [channel] }
  if {![validchan $chan]} { synecho mopu "[eheader "MassUserOp"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} { synecho mopu "[eheader "MassUserOp"] Operator status required to mass user op [sb]$chan[sb]..."
  } else {
    set priz ""
    set nicks [join [clist -o $chan] ","]
    foreach nick [split $nicks ","] { if {![string match *o* [lindex [usersettings [getmask $nick] $chan] 1]]} { set nicks [join [rflist [split $nicks ","] $nick] ","] } }
    if {![string length $nicks]} {
      synecho mopu "[eheader "MassUserOp"] There are no users to op on [sb]$chan[sb]... "
    } else {
      synecho mopu "[eheader "MassUserOp\[[llength [split $nicks ","]]\]"] Executing massuserop on [sb]$chan[sb]..."
      smode +oooooo $chan [string trim $nicks ","]
    }
  }
  killpipe mopu
  noidle
  complete
}
alias mv {
  if {"[lindex [args] 0]" == "?"} { /help mv ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0]
  } else { set chan [channel] }
  if {![validchan $chan]} { synecho mv "[eheader "MassVoice"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} { synecho mv "[eheader "MassVoice"] Operator status required to massvoice [sb]$chan[sb]..."
  } else {
    set nicks [join [clist -v $chan] ","]
    if {![string length $nicks]} {
      synecho mv "[eheader "MassVoice"] There are no users to voice on [sb]$chan[sb]... "
    } else {
      synecho mv "[eheader "MassVoice\[[llength [split $nicks ","]]\]"] Executing massvoice on [sb]$chan[sb]..."
      smode +vvvvvv $chan $nicks
    }
  }
  killpipe mvk
  noidle
  complete
}
alias mu {
  if {"[lindex [args] 0]" == "?"} { /help mu ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0]
  } else { set chan [channel] }
  if {![validchan $chan]} { synecho mu "[eheader "MassDevoice"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} { synecho mu "[eheader "MassDevoice"] Operator status required to massdevoice [sb]$chan[sb]..."
  } else {
    set nicks [join [clist +v $chan] ","]
    if {![string length $nicks]} {
      synecho mu "[eheader "MassDevoice"] There are no users to devoice on [sb]$chan[sb]... "
    } else {
      synecho mu "[eheader "MassDevoice\[[llength [split $nicks ","]]\]"] Executing massdevoice on [sb]$chan[sb]..."
      smode -vvvvvv $chan $nicks
    }
  }
  killpipe mu
  noidle
  complete
}
alias mk {
  if {"[lindex [args] 0]" == "?"} { /help mk ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} {
    set chan [lindex [args] 0]
    if {[lindex [args] 1] == "-p"} { set pri [lindex [args] 2] ; set quote [join [lrange [args] 3 end]]
    } else { set pri "" ; set quote [join [lrange [args] 1 end]] }
  } else {
    set chan [channel]
    if {[lindex [args] 0] == "-p"} { set pri [lindex [args] 1] ; set quote [join [lrange [args] 2 end]]
    } else { set pri "" ; set quote [join [lrange [args] 0 end]] }
  }
  if {![string length $quote]} { set quote [config masskickqo] }
  if {![validchan $chan]} { synecho mk "[eheader "MassKick"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} { synecho mk "[eheader "MassKick"] Operator status required to masskick [sb]$chan[sb]..."
  } else {
    set priz ""
    set nicks [join [rflist [clist all $chan] [my_nick]] ","]
    foreach nick [revorder [split $pri ","]] { set x [isprotected [getmask $nick] $chan] ; if {![isin $nick $priz] && [ison $nick $chan] && !$x} { set nicks "$nick,[join [rflist [split $nicks ","] $nick] ","]" ; set priz "$nick $priz" } elseif {$x && [config massfriendprot]} { set priz "${nick}([b]p[b]) $priz" } elseif {[ison $nick $chan]} { set priz "${nick}([b]x[b]) $priz" } else { set priz "${nick}([b]?[b]) $priz" } }
    if {[config massfriendprot]} { foreach nick [split $nicks ","] { if {[isprotected [getmask $nick] $chan]} { set nicks [join [rflist [split $nicks ","] $nick] ","] } } }
    if {![string length $nicks]} {
      synecho mk "[eheader "MassKick"] There are no users to kick on [sb]$chan[sb]... "
    } else {
      synecho mk "[eheader "MassKick\[[llength [split $nicks ","]]\]"] Executing masskick on [sb]$chan[sb]..."
      if {[string length $pri]} { synecho mk "[eheader "MassKick\[[llength [split $nicks ","]]\]"] Priority Kicks: [string trimright $priz]" }
      skick noban $chan [string trim $nicks ","] $quote
    }
  }
  killpipe mk
  noidle
  complete
}
alias nmk {
  if {"[lindex [args] 0]" == "?"} { /help nmk ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} {
    set chan [lindex [args] 0]
    if {[lindex [args] 1] == "-p"} { set pri [lindex [args] 2] ; set quote [join [lrange [args] 3 end]]
    } else { set pri "" ; set quote [join [lrange [args] 1 end]] }
  } else {
    set chan [channel]
    if {[lindex [args] 0] == "-p"} { set pri [lindex [args] 1] ; set quote [join [lrange [args] 2 end]]
    } else { set pri "" ; set quote [join [lrange [args] 0 end]] }
  }
  if {![string length $quote]} { set quote [config masskickqo] }
  if {![validchan $chan]} { synecho nmk "[eheader "MassKick"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} { synecho nmk "[eheader "MassKick"] Operator status required to masskick [sb]$chan[sb]..."
  } else {
    set priz ""
    set nicks [join [clist -o $chan] ","]
    foreach nick [revorder [split $pri ","]] { set x [isprotected [getmask $nick] $chan] ; if {![isop $nick $chan] && ![isin $nick $priz] && [ison $nick $chan] && !$x} { set nicks "$nick,[join [rflist [split $nicks ","] $nick] ","]" ; set priz "$nick $priz" } elseif {$x && [config massfriendprot]} { set priz "${nick}([b]p[b]) $priz" } elseif {[ison $nick $chan]} { set priz "${nick}([b]x[b]) $priz" } else { set priz "${nick}([b]?[b]) $priz" } }
    if {[config massfriendprot]} { foreach nick [split $nicks ","] { if {[isprotected [getmask $nick] $chan]} { set nicks [join [rflist [split $nicks ","] $nick] ","] } } }
    if {![string length $nicks]} {
      synecho nmk "[eheader "MassKick"] There are no users to kick on [sb]$chan[sb]... "
    } else {
      synecho nmk "[eheader "MassKick\[[llength [split $nicks ","]]\]"] Executing nonopmasskick on [sb]$chan[sb]..."
      if {[string length $pri]} { synecho nmk "[eheader "MassKick\[[llength [split $nicks ","]]\]"] Priority Kicks: [string trimright $priz]" }
      skick noban $chan [string trim $nicks ","] $quote
    }
  }
  killpipe nmk
  noidle
  complete
}
alias omk {
  if {"[lindex [args] 0]" == "?"} { /help omk ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} {
    set chan [lindex [args] 0]
    if {[lindex [args] 1] == "-p"} { set pri [lindex [args] 2] ; set quote [join [lrange [args] 3 end]]
    } else { set pri "" ; set quote [join [lrange [args] 1 end]] }
  } else {
    set chan [channel]
    if {[lindex [args] 0] == "-p"} { set pri [lindex [args] 1] ; set quote [join [lrange [args] 2 end]]
    } else { set pri "" ; set quote [join [lrange [args] 0 end]] }
  }
  if {![string length $quote]} { set quote [config masskickqo] }
  if {![validchan $chan]} { synecho omk "[eheader "MassKick"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} { synecho omk "[eheader "MassKick"] Operator status required to masskick [sb]$chan[sb]..."
  } else {
    set priz ""
    set nicks [join [rflist [clist +o $chan] [my_nick]] ","]
    foreach nick [revorder [split $pri ","]] { set x [isprotected [getmask $nick] $chan] ; if {[isop $nick $chan] && ![isin $nick $priz] && [ison $nick $chan] && !$x} { set nicks "$nick,[join [rflist [split $nicks ","] $nick] ","]" ; set priz "$nick $priz" } elseif {$x && [config massfriendprot]} { set priz "${nick}([b]p[b]) $priz" } elseif {[ison $nick $chan]} { set priz "${nick}([b]x[b]) $priz" } else { set priz "${nick}([b]?[b]) $priz" } }
    if {[config massfriendprot]} { foreach nick [split $nicks ","] { if {[isprotected [getmask $nick] $chan]} { set nicks [join [rflist [split $nicks ","] $nick] ","] } } }
    if {![string length $nicks]} {
      synecho omk "[eheader "MassKick"] There are no users to kick on [sb]$chan[sb]... "
    } else {
      synecho omk "[eheader "MassKick\[[llength [split $nicks ","]]\]"] Executing opmasskick on [sb]$chan[sb]..."
      if {[string length $pri]} { synecho omk "[eheader "MassKick\[[llength [split $nicks ","]]\]"] Priority Kicks: [string trimright $priz]" }
      skick noban $chan [string trim $nicks ","] $quote
    }
  }
  killpipe omk
  noidle
  complete
}
alias omkb {
  if {"[lindex [args] 0]" == "?"} { /help omkb ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} {
    set chan [lindex [args] 0]
    if {[lindex [args] 1] == "-p"} { set pri [lindex [args] 2] ; set quote [join [lrange [args] 3 end]]
    } else { set pri "" ; set quote [join [lrange [args] 1 end]] }
  } else {
    set chan [channel]
    if {[lindex [args] 0] == "-p"} { set pri [lindex [args] 1] ; set quote [join [lrange [args] 2 end]]
    } else { set pri "" ; set quote [join [lrange [args] 0 end]] }
  }
  if {![string length $quote]} { set quote [config masskickqo] }
  if {![validchan $chan]} { synecho omkb "[eheader "MassKick"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} { synecho omkb "[eheader "MassKick"] Operator status required to masskick [sb]$chan[sb]..."
  } else {
    set priz ""
    set nicks [join [rflist [clist +o $chan] [my_nick]] ","]
    foreach nick [revorder [split $pri ","]] { set x [isprotected [getmask $nick] $chan] ; if {[isop $nick $chan] && ![isin $nick $priz] && [ison $nick $chan] && !$x} { set nicks "$nick,[join [rflist [split $nicks ","] $nick] ","]" ; set priz "$nick $priz" } elseif {$x && [config massfriendprot]} { set priz "${nick}([b]p[b]) $priz" } elseif {[ison $nick $chan]} { set priz "${nick}([b]x[b]) $priz" } else { set priz "${nick}([b]?[b]) $priz" } }
    if {[config massfriendprot]} { foreach nick [split $nicks ","] { if {[isprotected [getmask $nick] $chan]} { set nicks [join [rflist [split $nicks ","] $nick] ","] } } }
    if {![string length $nicks]} {
      synecho omkb "[eheader "MassKick"] There are no users to kick on [sb]$chan[sb]... "
    } else {
      synecho omkb "[eheader "MassKick\[[llength [split $nicks ","]]\]"] Executing opmasskickban on [sb]$chan[sb]..."
      if {[string length $pri]} { synecho omkb "[eheader "MassKick\[[llength [split $nicks ","]]\]"] Priority Kicks: [string trimright $priz]" }
      skick screw $chan [string trim $nicks ","] $quote
    }
  }
  killpipe omkb
  noidle
  complete
}
alias server {
  if {[info exists doserver]} {
    if {[connected]} { /quit switching servers... }
    unset doserver
    killpipe server
    noidle
  } else {
    if {[isnum [lindex [args] 0]]} {
      set zz [lindex [get_cookie "servers"] [expr [lindex [args] 0] - 1]]
      if {[string length $zz]} {
        synecho server "[eheader "Connect"] Attempting connection to [b][lindex $zz 1][b] on port [b][lindex $zz 3][b]..."
        set doserver "1"
        /server [lindex $zz 2] [lindex $zz 3]
      } else {
        synecho server "[eheader "Connect"] Unable to locate server number [b][lindex [args] 0][b]..."
      }
    } else {
      if {![string length [lindex [args] 0]]} { synecho server "[eheader "Connect"] Please specify a server to connect to..." ; complete ; return }
      set serv [lindex [args] 0]
      if {[string length [lindex [args] 1]]} { set servport [lindex [args] 1]
      } else { set servport 6667 }
      synecho server "[eheader "Connect"] Attempting connection to [b]$serv[b] on port [b]$servport[b]..."
      if {[string length [qiresolve $serv]]} {
        set doserver "1"
        /server [qiresolve $serv] $servport
      } else {
        lappend dnsqueue "conn $serv $servport"
        lookup $serv
      }
    }
    killpipe server
    noidle
    complete
    return
  }
}
alias rcon {
  if {![connected]} { synecho rcon "[eheader "Reconnect"] Connect to a server first..."
  } else {
    synecho rcon "[eheader "Reconnect"] Reconnecting to [b][lindex [xserver] 0][b] on port [b][lindex [xserver] 1][b]... "
    set x [lindex [xserver] 0]
    set y [lindex [xserver] 1]
    /quit reconnecting...
    /server $x $y 
  }
  killpipe rcon
  noidle
  complete
}
alias exit {
	/flush_log
  /quit [raw_args]
  if [config closeonquit] { window close main }
  complete
}
alias quit {
	/flush_log
  if {![string length [args]]} {
    if {[llength [get_cookie quitquote]] <= 0} { /raw quit :syntax: i'm rooled
    } else { /raw quit :syntax: [applyquitvars [join [rword [get_cookie quitquote]]]] }
  } else { /raw quit :syntax: [applyquitvars [join [args]]] }
  if {[string length [get_cookie emsockblock]] && $originalsyn} { killesock [get_cookie emsockblock] }
  killpipe quit
  complete
}
alias sv {
  if {"[lindex [args] 0]" == "?"} { /help sv ; complete ; return }
  if {[string length [lindex [args] 0]]} {
    set dest "[lindex [args] 0]"
  } else {
    if {[window_type] == "status"} { set dest ""
    } elseif {[window_type] == "chat"} { set dest "=[window_name]"
    } else { set dest "[window_name]" }
  }
  if {[string length $dest]} {
    set verq [rword $verquote]
    if {[lindex $verq 0] == "/me"} {
      parseaction $dest "[lrange $verq 1 end] [join $synver " + "]"
    } else {
      parsemsg $dest "[lrange $verq 1 end] [join $synver " + "]"
    }
    unset dest
  } else {
    synecho sv "[eheader "Version"] Invalid request..."
  }
  killpipe sv
  noidle
  complete
}
alias svn {
  if {"[lindex [args] 0]" == "?"} { /help svn ; complete ; return }
  if {[string length [lindex [args] 0]]} {
    set dest "[lindex [args] 0]"
  } else {
    if {[window_type] == "status"} { set dest ""
    } elseif {[window_type] == "chat"} { set dest "=[window_name]"
    } else { set dest "[window_name]" }
  }
  if {[string length $dest]} {
    parsemsg $dest "[join $synver " + "]"
    unset dest
  } else {
    synecho svn "[eheader "Version"] Invalid request..."
  }
  killpipe svn
  noidle
  complete
}
alias inv {
  if {"[lindex [args] 0]" == "?"} { /help inv ; complete ; return }
  if {[string match "#*" [lindex [args] 1]]} { set chan [lindex [args] 1] ; set dest [lindex [args] 0]
  } else { set chan [channel] ; set dest [lindex [args] 0] }
  if {![validchan $chan]} { synecho inv "[eheader "Invite"] Invalid channel specified..."
  } else {
    foreach send [split $dest ","] {
      if {![ison $send $chan]} {
        if {[isop [my_nick] $chan]} { /raw invite $send $chan }
        if {[string length [getkey $chan]]} { /raw notice $send :Inviting you to $chan... Key( [getkey $chan] )...
        } else { /raw notice $send :Inviting you to $chan... }
        if {[isop [my_nick] $chan]} { synecho inv "[eheader "Invite"] Invited [b]$send[b] to join [b]$chan[b]..."
        } else { synecho inv "[eheader "Invite"] Invited [b]$send[b] to join [b]$chan[b] (notice only)..." }
      } else {
        synecho inv "[eheader "Invite"] [b]$send[b] is already on [b]$chan[b]..."
      }
    }
  }
  killpipe inv
  noidle
  complete
}
alias ver {
  if {"[lindex [args] 0]" == "?"} { /help ver ; complete ; return }
  if {![string length [lindex [args] 0]]} {
    if {[isin [string tolower [channels]] [string tolower [channel]]]} { set dest "[channel]"
    } elseif {[isin [string tolower [queries]] [string tolower [query]]]} {set dest "[query]"
    } else { set dest "" }
  } else {
    set dest [lindex [args] 0]
  }
  if {[string length $dest]} {
    /raw privmsg $dest :\x01VERSION\x01
    foreach send [split $dest ","] {
      synecho ver "[eheader "Version"] Sent [b]VERSION[b] request to [b]$send[b]..."
    }
  } else {
    synecho ver "[eheader "Version"] Invalid request..."
  }
  killpipe ver
  noidle
  complete
}
alias ping {
  if {"[lindex [args] 0]" == "?"} { /help ping ; complete ; return }
  if {![string length [lindex [args] 0]]} {
    if {[isin [string tolower [channels]] [string tolower [channel]]]} { set dest "[channel]"
    } elseif {[isin [string tolower [queries]] [string tolower [query]]]} {set dest "[query]"
    } else { set dest "" }
  } else {
    set dest [lindex [args] 0]
  }
  if {[string length $dest]} {
    /raw privmsg $dest :\x01PING [clock clicks]\x01
    foreach send [split $dest ","] {
      synecho ping "[eheader "Ping"] Sent [b]PING[b] request to [b]$send[b]..."
    }
  } else {
    synecho ping "[eheader "Ping"] Invalid request..."
  }
  killpipe ping
  noidle
  complete
}
alias sping {
  if {"[lindex [args] 0]" == "?"} { /help sping ; complete ; return }
  if {[string length [lindex [args] 0]]} { set dest [lindex [args] 0]
  } else { set dest [lindex [xserver] 0] }
  if {![string length $dest]} {
    synecho sping "[eheader "ServerPing"] No destination given..."
  } elseif {[info exists sping($dest)]} {
    synecho sping "[eheader "ServerPing"] Ping pending from [b]$dest[b]... Please Wait..."
  } else {
    /quote VERSION $dest
    set sping([string tolower $dest]) "[clock clicks]"
    synecho sping "[eheader "ServerPing"] Sent [b]PING[b] request to [b]$dest[b]..."
  }
  killpipe sping
  noidle
  complete
}
alias servver {
  if {"[lindex [args] 0]" == "?"} { /help servver ; complete ; return }
  if {[string length [lindex [args] 0]]} { set dest [lindex [args] 0]
  } else { set dest [lindex [xserver] 0] }
  if {![string length $dest]} {
    synecho servver "[eheader "ServerVersion"] No destination given..."
  } else {
    /quote VERSION $dest
    synecho servver "[eheader "ServerVersion"] Sent [b]VERSION[b] request to [b]$dest[b]..."
  }
  killpipe servver
  noidle
  complete
}

alias relok {
  if {"[lindex [args] 0]" == "?"} { /help relok ; complete ; return }
  if {[string match "-l*" [lindex [args] 0]]} {
    synecho relok "[eheader "Relay"] Last [b][config relayslots][b] Message(s) Recieved:"
    for { set x 1 } { $x <= [config relayslots] } { incr x } {
      if {[info exists relok($x)]} {
        set text [applyrelokvars "[lindex $relok($x) 0]" "[lindex $relok($x) 1]" "[lindex $relok($x) 2]" "[lindex $relok($x) 3]"]
        synecho relok "([b]\#${x}[b]) $text"
      }
    }
  } else {
    if {[isnum [lindex [args] 0]] && [string length [lindex [args] 0]]} { set num [lindex [args] 0] ; set snd [lindex [args] 1]
    } else { set num "1" ; set snd [lindex [args] 0] }
    if {[string length $snd]} {
      set dest "$snd"
    } else {
      if {[window_type] == "status"} { set dest ""
      } elseif {[window_type] == "chat"} { set dest "=[window_name]"
      } else { set dest "[window_name]" }
    }
    if {![string length $dest]} {
      synecho relok "[eheader "Relay"] Invalid request..."
    } elseif {![info exists relsm($num)]} {
      synecho relok "[eheader "Relay"] Non-existant relay message specified ([b]#${num}[b])..."
    } else {
      set text [applyrelokvars "[lindex $relok($num) 0]" "[lindex $relok($num) 1]" "[lindex $relok($num) 2]" "[lindex $relok($num) 3]"]
      parsemsg $dest "$text"
      unset dest
    }
  }
  killpipe relok
  noidle
  complete
}
alias relm {
  if {"[lindex [args] 0]" == "?"} { /help relm ; complete ; return }
  if {[string match "-l*" [lindex [args] 0]]} {
    synecho relm "[eheader "Relay"] Last [b][config relayslots][b] Message(s) Recieved:"
    for { set x 1 } { $x <= [config relayslots] } { incr x } {
      if {[info exists relm($x)]} {
        set text [applyrelmvars "[lindex $relm($x) 0]" "[lindex $relm($x) 1]" "[lindex $relm($x) 2]" "[lindex $relm($x) 3]" "[lindex $relm($x) 4]"]
        synecho relm "([b]\#${x}[b]) $text"
      }
    }
  } else {
    if {[isnum [lindex [args] 0]] && [string length [lindex [args] 0]]} { set num [lindex [args] 0] ; set snd [lindex [args] 1]
    } else { set num "1" ; set snd [lindex [args] 0] }
    if {[string length $snd]} {
      set dest "$snd"
    } else {
      if {[window_type] == "status"} { set dest ""
      } elseif {[window_type] == "chat"} { set dest "=[window_name]"
      } else { set dest "[window_name]" }
    }
    if {![string length $dest]} {
      synecho relm "[eheader "Relay"] Invalid request..."
    } elseif {![info exists relm($num)]} {
      synecho relm "[eheader "Relay"] Non-existant relay message specified ([b]#${num}[b])..."
    } else {
      set text [applyrelmvars "[lindex $relm($num) 0]" "[lindex $relm($num) 1]" "[lindex $relm($num) 2]" "[lindex $relm($num) 3]" "[lindex $relm($num) 4]"]
      parsemsg $dest "$text"
      unset dest
    }
  }
  killpipe relm
  noidle
  complete
}
alias refresh {
  if {"[lindex [args] 0]" == "?"} { /help refresh ; complete ; return }
  if {[llength [channels]] > 5 && ![string length [lindex [args] 0]]} { synecho refresh "[eheader "Refresh"] You're currently on too many channels... More than 5 would kill you..."
  } elseif {[string length [lindex [args] 0]]} {
    synecho refresh "[eheader "Refresh"] Refreshing internal banlists\\addresslists for the specified channels..."
    foreach chan [split [lindex [args] 0] ","] {
      if {[ison [my_nick] $chan]} {
        synecho refresh "[eheader "Refresh"] Refreshing databases for ([b]$chan[b])..."
        /who $chan
        /bans $chan
      } else {
        synecho refresh "[eheader "Refresh"] You are not currently on ([b]$chan[b])..."
      }
    }
  } else {
    synecho refresh "[eheader "Refresh"] Refreshing internal banlists\\addresslists for all channels..."
    foreach chan [channels] {
      synecho refresh "[eheader "Refresh"] Refreshing databases for ([b]$chan[b])..."
      /who $chan
      /bans $chan
    }
  }
  killpipe refresh
  noidle
  complete
}
alias relsm {
  if {"[lindex [args] 0]" == "?"} { /help relsm ; complete ; return }
  if {[string match "-l*" [lindex [args] 0]]} {
    synecho relsm "[eheader "Relay"] Last [b][config relayslots][b] Message(s) Sent:"
    for { set x 1 } { $x <= [config relayslots] } { incr x } {
      if {[info exists relsm($x)]} {
        set text [applyrelsmvars "[lindex $relsm($x) 0]" "[lindex $relsm($x) 1]" "[lindex $relsm($x) 2]"]
        synecho relsm "([b]\#${x}[b]) $text"
      }
    }
  } else {
    if {[isnum [lindex [args] 0]] && [string length [lindex [args] 0]]} { set num [lindex [args] 0] ; set snd [lindex [args] 1]
    } else { set num "1" ; set snd [lindex [args] 0] }
    if {[string length $snd]} {
      set dest "$snd"
    } else {
      if {[window_type] == "status"} { set dest ""
      } elseif {[window_type] == "chat"} { set dest "=[window_name]"
      } else { set dest "[window_name]" }
    }
    if {![string length $dest]} {
      synecho relsm "[eheader "Relay"] Invalid request..."
    } elseif {![info exists relsm($num)]} {
      synecho relsm "[eheader "Relay"] Non-existant relay message specified ([b]#${num}[b])..."
    } else {
      set text [applyrelsmvars "[lindex $relsm($num) 0]" "[lindex $relsm($num) 1]" "[lindex $relsm($num) 2]"]
      parsemsg $dest "$text"
      unset dest
    }
  }
  killpipe relsm
  noidle
  complete
}
alias key {
  if {"[lindex [args] 0]" == "?"} { /help key ; complete ; return }
  if {![string length [lindex [args] 0]]} {
    set num 0
    foreach ver [get_cookie chankeys] { incr num }
    if {$num} {
      synecho key "[boxtop "[b]AutoKeys List[b] [sb](([sb][su]entries:[su] [b]$num[b][sb]))[sb]"]"
      synecho key "[boxside "[llb][b]#[b] [lrb][llb][b]Channel:[b]       [lrb][llb][b]Key:[b]           [lrb][llb][b]Last Update:[b]          [lrb]"]"
      set num 0
      foreach ver [get_cookie chankeys] { set ver "[string tolower $ver]" ; incr num ; synecho key "[boxside "[llb][b][align $num 2][b][lrb][llb][align $ver 15][lrb][llb][align [join [lindex [get_cookie chkey($ver)] 0]] 15][lrb][llb][align [join [lindex [get_cookie chkey($ver)] 1]] 22][lrb]"]" }
      synecho key "[boxbottom "[b]AutoKeys List[b] [sb](([sb][su]entries:[su] [b]$num[b][sb]))[sb]"]"
    } else {
      synecho key "[eheader "AutoKey"] You have no autokeys set..."
    }
  } elseif {[string range [lindex [args] 0] 0 0] == "a"} {
    if {![string length [lindex [args] 1]]} { synecho key "[eheader "AutoKey"] You must specify a channel to key..."
    } elseif {[isnum [lindex [args] 1]]} {
      set num 0
      foreach ver [get_cookie chankeys] {
        incr num
        if {$num == [lindex [args] 1]} {
          synecho key "[eheader "AutoKey"] Updating key for [b]$ver[b]: [sb][lindex [args] 2][sb]"
          set_cookie chkey($ver) "[list [split [lindex [args] 2]]] [list [string tolower [clock format [clock seconds] -format "%m/%d/%y at %I:%M:%S%p"]]]"
          set_cookie chankeys "[rflist [get_cookie chankeys ""] $ver]"
          set_cookie chankeys "[atlist [get_cookie chankeys ""] $ver]"
          set flag 1
        }
      }
      if {[info exists flag]} { unset flag
      } else { synecho key "[eheader "AutoKey"] ([b][lindex [args] 1][b]) Channel key number could not be located..." }
    } elseif {![string length [lindex [args] 2]]} { synecho key "[eheader "AutoKey"] You must specify a key to set..."
    } else {
      set_cookie chkey([string tolower [lindex [args] 1]]) "[list [split [lindex [args] 2]]] [list [string tolower [clock format [clock seconds] -format "%m/%d/%y at %I:%M:%S%p"]]]"
      set_cookie chankeys "[rflist [get_cookie chankeys ""] [string tolower [lindex [args] 1]]]"
      set_cookie chankeys "[atlist [get_cookie chankeys ""] [string tolower [lindex [args] 1]]]"
      synecho key "[eheader "AutoKey"] Updating key for [b][string tolower [lindex [args] 1]][b]: [sb][join [lindex [get_cookie chkey([string tolower [lindex [args] 1]])] 0]][sb]"
    }
  } elseif {[string range [lindex [args] 0] 0 0] == "d"} {
    if {![string length [lindex [args] 1]]} { synecho key "[eheader "AutoKey"] You must specify a channel to delete the key for..."
    } elseif {[isnum [lindex [args] 1]]} {
      set num 0
      foreach ver [get_cookie chankeys] {
        incr num
        if {$num == [lindex [args] 1]} {
          synecho key "[eheader "AutoKey"] Removing key for [b]$ver[b]: [sb][join [lindex [get_cookie chkey($ver)] 0]][sb]"
          set_cookie chankeys "[rflist [get_cookie chankeys ""] $ver]"
          set_cookie chkey($ver) ""
          set flag 1
        }
      }
      if {[info exists flag]} { unset flag
      } else { synecho key "[eheader "AutoKey"] ([b][lindex [args] 1][b]) Channel key number could not be located..." }
    } elseif {![string length [get_cookie chkey([lindex [args] 1])]]} { synecho key "[eheader "AutoKey"] The channel [b][lindex [args] 1][b] has no internal keys set..."
    } else {
      synecho key "[eheader "AutoKey"] Removing key for [b][string tolower [lindex [args] 1]][b]: [sb][join [lindex [get_cookie chkey([string tolower [lindex [args] 1]])] 0]][sb]"
      set_cookie chankeys "[rflist [get_cookie chankeys ""] [string tolower [lindex [args] 1]]]"
      set_cookie chkey([string tolower [lindex [args] 1]]) ""
    }
  } else {
    synecho key "[eheader "AutoKey"] Invalid switch specified..."
  }
  killpipe key
  noidle
  complete
}
alias join {
  if {"[lindex [args] 0]" == "?"} { /help join ; complete ; return }
  set joins ""
  foreach chan [string tolower [split [args] ","]] {
    set key [lindex $chan 1]
    if {![string match "#*" [lindex $chan 0]]} { set chan #[lindex $chan 0]
    } else { set chan [lindex $chan 0] }
    if {[ison [my_nick] $chan]} {
      synecho join "[eheader "Join"] You are already on [b]$chan[b]..."
    } elseif {[string length [lindex [get_cookie chkey($chan)] 0]] && ![string length $key]} {
      synecho join "[eheader "Join"] Joining channel: [b]$chan[b] ([b]AutoKey:[b] [join [lindex [get_cookie chkey($chan)] 0]])"
      append joins "join $chan [join [lindex [get_cookie chkey($chan)] 0]][lf]"
      set jsynk($chan) [clock clicks]
    } else {
      synecho join "[eheader "Join"] Joining channel: [b]$chan $key[b]"
      if {![string length $key]} { append joins "join $chan[lf]"
      } else { append joins "join $chan $key[lf]" }
      set jsynk($chan) [clock clicks]
    }
  }
  if {![string length $joins]} { synecho join "[eheader "Join"] No channels to join..."
  } else { /quote $joins ; unset joins }
  killpipe join
  noidle
  complete
}
alias partall {
  if {"[lindex [args] 0]" == "?"} { /help partall ; complete ; return }
  foreach chan [channels] { /part $chan }
  killpipe partall
  noidle
  complete
}
alias part {
  if {"[lindex [args] 0]" == "?"} { /help join ; complete ; return }
  set parts ""
  foreach chan [split [args] ","] {
    if {![string match "#*" [lindex $chan 0]]} { set chan #[lindex $chan 0]
    } else { set chan [lindex $chan 0] }
    if {![ison [my_nick] $chan]} {
      synecho join "[eheader "Part"] You are not currently on [b]$chan[b]..."
    } else {
      synecho join "[eheader "Part"] Leaving channel: [b]$chan[b]"
      lappend parts "$chan"
    }
  }
  if {![string length $parts]} { synecho join "[eheader "Part"] No channels to part..."
  } else { /quote part :[join $parts ","] ; unset parts }
  killpipe part
  noidle
  complete
}
alias ll {
  if {"[lindex [args] 0]" == "?"} { /help ll ; complete ; return }
  if {[string length [lindex [args] 0]]} { synecho ll "[eheader "LinkLooker"] Rebuilding master links listing..." ; set llmaster "1" ; /raw links
  } else { synecho ll "[eheader "LinkLooker"] Building current links listing..." ; set llcurrent "1" ; /raw links }
  complete
}
alias qk {
  if {"[lindex [args] 0]" == "?"} { /help qk ; complete ; return }
  if {![string length [join [args]]]} {
    synecho qk "[boxtop "[b]QuickKeys List[b]"]"
    synecho qk "[boxside "([b]F1[b]) [get_cookie quickkey(1) "none"]"]"
    synecho qk "[boxside "([b]F2[b]) [get_cookie quickkey(2) "none"]"]"
    synecho qk "[boxside "([b]F3[b]) [get_cookie quickkey(3) "none"]"]"
    synecho qk "[boxside "([b]F4[b]) [get_cookie quickkey(4) "none"]"]"
    synecho qk "[boxside "([b]F5[b]) [get_cookie quickkey(5) "none"]"]"
    synecho qk "[boxside "([b]F6[b]) [get_cookie quickkey(6) "none"]"]"
    synecho qk "[boxside "([b]F7[b]) [get_cookie quickkey(7) "none"]"]"
    synecho qk "[boxside "([b]F8[b]) [get_cookie quickkey(8) "none"]"]"
    synecho qk "[boxside "([b]F9[b]) [get_cookie quickkey(9) "none"]"]"
    synecho qk "[boxside "([b]F10[b]) [get_cookie quickkey(10) "none"]"]"
    synecho qk "[boxside "([b]F11[b]) [get_cookie quickkey(11) "none"]"]"
    synecho qk "[boxside "([b]F12[b]) [get_cookie quickkey(12) "none"]"]"
    synecho qk "[boxbottom "[b]QuickKeys List[b]"]"
  } elseif {[string trimleft [lindex [args] 0] "F"] > 0 && [string trimleft [lindex [args] 0] "Ff"] < 13} {
    if {[string length [join [lrange [args] 1 end]]]} {
      synecho qk "[eheader "QuickKey"] Set QuickKey ([b]\F[string trimleft [lindex [args] 0] "Ff"][b]) to: [join [lrange [args] 1 end]]"
    } else {
      synecho qk "[eheader "QuickKey"] Removed code for QuickKey ([b]\F[string trimleft [lindex [args] 0] "Ff"][b])..."
    }
    set_cookie quickkey([string trimleft [lindex [args] 0] "Ff"]) [join [lrange [args] 1 end]]
  } else {
    synecho qk "[eheader "QuickKey"] Invalid Parameters..."
  }
  killpipe qk
  noidle
  complete
}
alias mub {
  if {"[lindex [args] 0]" == "?"} { /help mub ; complete ; return }
  set mubtog 1
  repipe mub unban
  /unban [join [args]]
  noidle
  complete
}
alias ban {
  if {"[lindex [args] 0]" == "?"} { /help ban ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} {
    set chan [lindex [args] 0]
    set zuser [lindex [args] 1]
    if {[isnum [lindex [args] 2]] && [string length [lindex [args] 2]] && [lindex [args] 2] > 0 && [lindex [args] 2] <= 9} { set znum [lindex [args] 2]
    } else { set znum 5 }
  } else {
    set chan [channel]
    set zuser [lindex [args] 0]
    if {[isnum [lindex [args] 1]] && [string length [lindex [args] 1]] && [lindex [args] 1] > 0 && [lindex [args] 1] <= 9} { set znum [lindex [args] 1]
    } else { set znum 5 }
  }
  if {![validchan $chan]} { synecho ban "[eheader "Ban"] Invalid channel specified..."
  } elseif {![string length $zuser]} { synecho ban "[eheader "Ban"] Invalid Parameters..."
  } elseif {[isaddr $zuser]} {
    /raw mode $chan +b $zuser
  } elseif {[ison $chan $zuser]} {
    /raw mode $chan +b [banmask $znum [getmask $zuser]]
  } elseif {[isnick $zuser]} {
    if {![info exists whoisqueue]} { set whoisqueue "" }
    lappend whoisqueue "ban $znum $chan"
    set nokill 1
    addnullpipe whois
    whois $zuser
  } else { synecho ban "[eheader "Ban"] Invalid nickname given..." }
  if {[info exists nokill]} { unset nokill } else { killpipe ban }
  noidle
  complete
}
alias unban {
  if {"[lindex [args] 0]" == "?"} { /help unban ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set unmask [addrfill [lindex [args] 1]] ; set pure [lindex [args] 1]
  } else { set chan [channel] ; set unmask [addrfill [lindex [args] 0]] ; set pure [lindex [args] 0] }
  if {![validchan $chan]} { synecho unban "[eheader "Unban"] Invalid channel specified..."
  } elseif {![isop [my_nick] $chan]} { synecho unban "[eheader "Unban"] Operator status required to unban on $chan..."
  } elseif {![info exists banlist([string tolower $chan])] || ![string length $banlist([string tolower $chan])]} { synecho unban "[eheader "Unban"] There are no bans set on $chan..."
  } elseif {![string length $pure] && ![info exists mubtog]} {
    synecho unban "[boxtop "[b]Banlist[b] [sb](([sb][su]bans:[su] [b][llength $banlist([string tolower $chan])][b][sb]))[sb]"]"
    synecho unban "[boxside "[llb][b]# [b][lrb][llb][b]Ban:                                    [b][lrb]"]"
    set num 0
    foreach ban $banlist([string tolower $chan]) {
      incr num
      synecho unban "[boxside "[llb][b][align $num 2][b][lrb][llb][align $ban 40][lrb]"]"
    }
    synecho unban "[boxbottom "[b]Banlist[b] [sb](([sb][su]bans:[su] [b][llength $banlist([string tolower $chan])][b][sb]))[sb]"]"
  } elseif {[isnum [lindex [split $pure ","] 0]] && ![info exists mubtog]} {
    set num 0
    set numx 0
    set done ""
    set smax [servmodemax]
    set commands ""
    foreach ban $banlist([string tolower $chan]) {
      incr num
      if {[isin [split $pure ","] $num]} {
        incr numx
        lappend done "$ban"
        if {$numx == $smax} { append commands "mode $chan -[replicate b $smax] [join $done][lf]" ; set done "" ; set numx 0 }
      }
    }
    if {$num} { append commands "mode $chan -[replicate b [llength $done]] [join $done][lf]" ; set userq "" ; set num 0 }
    if {[string length $commands]} { /raw $commands
    } else { ynecho unban "[eheader "Unban"] No bans located matching ([b][join $pure ","][b])" }
  } elseif {![string match *.* $pure] && ![string match *@* $pure] && ![info exists mubtog] && [isnick $pure]} {
    if {![info exists whoisqueue]} { set whoisqueue "" }
    lappend whoisqueue "unban $chan"
    set nokill 1
    addnullpipe whois
    whois $pure
  } else {
    set num 0
    set tot 0
    set smax [servmodemax]
    set userq ""
    set commands ""
    if {[info exists mubtog]} { synecho mub "[eheader "MassUnban\[[llength $banlist($chan)]\]"] Executing MassUnban on $chan..." }
    foreach user $banlist([string tolower $chan]) {
      if {[wmatch $user $unmask] || [wmatch $unmask $user] || [info exists mubtog]} {
        incr num
        incr tot
        lappend userq $user
        if {$num == $smax} { append commands "mode $chan -[replicate b $smax] [join $userq][lf]" ; set userq "" ; set num 0 }
      }
    }
    if {$num} { append commands "mode $chan -[replicate b [llength $userq]] [join $userq][lf]" ; set userq "" ; set num 0 }
    if {![info exists mubtog] && !$tot} { synecho unban "[eheader "Unban"] No bans located matching ([b]$unmask[b])..." }
    if {[string length $commands]} { /raw $commands }
  }
  if {[info exists mubtog]} { killpipe mub ; unset mubtog }
  if {[info exists nokill]} { unset nokill } else { killpipe unban }
  noidle
  complete
}
alias clearscore {
  if {"[lindex [args] 0]" == "?"} { /help clearscore ; complete ; return }
  foreach op [get_cookie operkilllist] { set_cookie operkill($op) "" }
  set_cookie operkilllist ""
  synecho clearscore "[eheader "Scoreboard"] OperKill Scoreboard Cleared..."
  killpipe clearscore
  noidle
  complete
}
alias clear { /cls [raw_args] ; killpipe clear ; complete }
alias cls { if {"[lindex [args] 0]" == "?"} { /help clear ; complete ; return } ; window clear [window_type] [window_name] ; if { [config clearrelaytext] } { global relaytext ; set relaytext([string tolower [window_name]]) "" } ; killpipe cls ; complete }
alias score {
  if {"[lindex [args] 0]" == "?"} { /help score ; complete ; return }
  synecho score "[eheader "Scoreboard"] OperKill Scoreboard..."
  synecho score "[llb] [b]#[b] [lrb][llb][b]Nick:[b]     [lrb] [b]Kill Record:[b]"
  set minkills ""
  set oplist ""
  set totalkill 0
  set rank 1
  foreach op [get_cookie operkilllist] { set totalkill "[expr $totalkill + [get_cookie operkill($op)]]" ; lappend minkills "[get_cookie operkill($op)]" ; lappend oplist "$op" }
  set minkills [lrange [lsort -decreasing -integer $minkills] 0 9]
  foreach x $minkills {
    foreach op $oplist {
      if {$x == [get_cookie operkill($op)]} { synecho score "[llb][align $rank 3][lrb][llb][align [string range [join $op] 0 10] 10][lrb] [b][align [get_cookie operkill($op)] 3][b] \(\x1F[percent [get_cookie operkill($op)] $totalkill]\x1F\)" ; set minkills [rflist $minkills $x] ; set oplist [rflist $oplist $op] ; incr rank }
    }
  }
  synecho score "[eheader "Scoreboard"] You have witnessed: [b]$totalkill[b] Kills"
  killpipe score
  noidle
  complete
}
proc addevent { hook command } {
  global events
  if {![info exists events($hook)]} { set events($hook) "" }
  lappend events($hook) "$command"
}
proc delevent { hook command } {
  global events
  if {[info exists events($hook)]} { set events($hook) "[rflist $events($hook) $command]" }
}
alias privmsg {
  if {[config backonkey] && [info exists away(x)]} { /back [config defbackqo] }
  if {![string match "#*" [lindex [args] 0]]} {
    spylink [lindex [args] 0] "[applyselftext "[my_nick]" "[string range [raw_args] [expr [string length [window_name]] + 1] end]"]"
  } else {
    spylink [lindex [args] 0] "[applymsgselftext "[my_nick]" "[string range [raw_args] [expr [string length [window_name]] + 1] end]"]"
  }

  global events
  if {[info exists events(sprivmsg)]} {
    foreach ev $events(sprivmsg) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }

  if {[string match "#*" [lindex [args] 0]] && [string range [lindex [args] 1] [expr [string length [lindex [args] 1]] - 1] end] == "[config nickcompchar]" && [config autonickc]} {
    set niq "[nickc [lindex [args] 0] [string range [lindex [args] 1] 0 [expr [string length [lindex [args] 1]] - 2]]]"
    if {[string length $niq]} {
      /raw privmsg [lindex [args] 0] :[applynickcomplete "$niq"] [string range [raw_args] [expr [expr [string length [window_name]] + 2] + [string length [lindex [args] 1]]] end]
      echo "[applyselftext "[my_nick]" "[applynickcomplete "$niq"] [string range [raw_args] [expr [expr [string length [window_name]] + 2] + [string length [lindex [args] 1]]] end]"]" channel [lindex [args] 0]
    } else {
      /raw privmsg [lindex [args] 0] :[string range [raw_args] [expr [string length [window_name]] + 1] end]
      echo "[applyselftext "[my_nick]" "[string range [raw_args] [expr [string length [window_name]] + 1] end]"]" channel [lindex [args] 0]
    }
  } elseif {![string match "#*" [lindex [args] 0]]} {
    inc_tab "msg" "[lindex [args] 0]"
    /raw privmsg [lindex [args] 0] :[string range [raw_args] [expr [string length [window_name]] + 1] end]
    echo "[applymsgselftext "[my_nick]" "[string range [raw_args] [expr [string length [window_name]] + 1] end]"]" query [lindex [args] 0]
    inc_relsm "[lindex [args] 0]" "msg" "[string range [raw_args] [expr [string length [window_name]] + 1] end]"
  } elseif {[window_type] != "chat" && [window_type] != "status"} {
    echo "[applyselftext "[my_nick]" "[string range [raw_args] [expr [string length [window_name]] + 1] end]"]" [window_type] [lindex [args] 0]
    /raw privmsg [lindex [args] 0] :[string range [raw_args] [expr [string length [window_name]] + 1] end]
  }
  killpipe privmsg
  noidle
  complete
}
alias match {
  if {"[lindex [args] 0]" == "?"} { /help match ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0] ; set addr [lindex [args] 1]
  } else { set chan [channel] ; set addr [lindex [args] 0] }
  if {![validchan $chan]} { synecho match "[eheader "Match"] Invalid channel specified..."
  } elseif {![string length $addr]} { synecho match "[eheader "Match"] You must specify and address to match..."
  } else {
    set command ""
    set rnumb 0
    foreach user [clist all $chan] {
      if {[wmatch $addr [getmask $user]]} {
        incr rnumb
        lappend command "[boxside "[llb][b][align $rnumb 2][b][lrb][llb][align $user 11][lrb][llb][align [lindex [split [getmask $user] "!"] 1] 48][lrb]"]"
      }
    }
    if {[string length $command]} {
      synecho match "[boxtop "[b]Address Match[b] ([sb]$addr[sb]) [sb](([sb][su]users:[su] [b]$rnumb[b][sb]))[sb]"]"
      synecho match "[boxside "[llb][b]# [b][lrb][llb][b]Nickname:  [b][lrb][llb][b]Address:                                        [b][lrb]"]"
      foreach line $command { synecho match "$line" }
      synecho match "[boxbottom "[b]Address Match[b] ([sb]$addr[sb]) [sb](([sb][su]users:[su] [b]$rnumb[b][sb]))[sb]"]"
    } else { synecho match "[eheader "Match"] No users matching ([sb]$addr[sb]) are on $chan..." }
  }
  killpipe whou
  noidle
  complete
}
alias whou {
  if {"[lindex [args] 0]" == "?"} { /help whou ; complete ; return }
  if {[string match "#*" [lindex [args] 0]]} { set chan [lindex [args] 0]
  } else { set chan [channel] }
  if {![validchan $chan]} { synecho whou "[eheader "UserReport"] Invalid channel specified..."
  } else {
    set command ""
    set rnumb 0
    foreach user [clist all $chan] {
      set setstring "[usersettings [getmask $user] $chan]"
      if {[string length $setstring]} {
        incr rnumb
        lappend command "[boxside "[llb][b][align $rnumb 2][b][lrb][llb][align $user 11][lrb][llb][align [userlistmask [getmask $user] $chan] 30][lrb][llb][align [lindex $setstring 1] 10][lrb]"]"
      }
    }
    if {[string length $command]} {
      synecho whou "[boxtop "[b]Channel User Report[b] [sb](([sb][su]users:[su] [b]$rnumb[b][sb]))[sb] "]"
      synecho whou "[boxside "[llb][b]# [b][lrb][llb][b]Nickname:  [b][lrb][llb][b]Address:                      [b][lrb][llb][b]Flags:    [b][lrb]"]"
      foreach line $command { synecho whou "$line" }
      synecho whou "[boxbottom "[b]Channel User Report[b] [sb](([sb][su]users:[su] [b]$rnumb[b][sb]))[sb] "]"
    } else { synecho whou "[eheader "UserReport"] No database users are currently on $chan..." }
  }
  killpipe whou
  noidle
  complete
}
alias whon {
  if {"[lindex [args] 0]" == "?"} { /help whon ; complete ; return }
  set numb 0
  foreach user [array names ison] {
    if {!$numb} {
      synecho whon "[boxtop "[b]Notify Report[b] [sb](([sb][su]users:[su] [b][llength [array names ison]][b][sb]))[sb]"]"
      synecho whon "[boxside "[llb][b]# [b][lrb][llb][b]Nickname:  [b][lrb][llb][b]Logon:                 [b][lrb][llb][b]Address:                      [b][lrb]"]"
    }
    incr numb
    if {![lindex $ison($user) 2]} { set x2 "([b]?[b])[lindex $ison($user) 0]" } else { set x2 "[lindex $ison($user) 0]" }
    synecho whon "[boxside "[llb][b][align $numb 2][b][lrb][llb][align $user 11][lrb][llb][align [lindex $ison($user) 1] 23][lrb][llb][align $x2 30][lrb]"]"
  }
  if {!$numb} { synecho whon "[eheader "NotifyReport"] No notified users are currently logged in..."
  } else { synecho whon "[boxbottom "[b]Notify Report[b] [sb](([sb][su]users:[su] [b][llength [array names ison]][b][sb]))[sb]"]" }
  killpipe whon
  noidle
  complete
}
proc ignoremodeorder { modes } {
  set sw ""
  foreach x [split [lindex [args] 1] ""] {
    if {$x == "+"} { set sw "+"
    } elseif {$x == "-"} { set sw "-" }
    if {$sw == "+"} {
      if {$x == "o"} { set modes [rflist $modes "other"] ; lappend modes "other" }
      if {$x == "t"} { set modes [rflist $modes "text"] ; lappend modes "text" }
      if {$x == "d"} { set modes [rflist $modes "dcc"] ; lappend modes "dcc" }
      if {$x == "x"} { set modes [rflist $modes "xdcc"] ; lappend modes "xdcc" }
      if {$x == "c"} { set modes [rflist $modes "ctcp"] ; lappend modes "ctcp" }
      if {$x == "i"} { set modes [rflist $modes "invite"] ; lappend modes "invite" }
      if {$x == "p"} { set modes [rflist $modes "public"] ; lappend modes "public" }
    } elseif {$sw == "-"} {
     if {$x == "o"} { set modes [rflist $modes "other"] }
     if {$x == "t"} { set modes [rflist $modes "text"] }
     if {$x == "d"} { set modes [rflist $modes "dcc"] }
     if {$x == "x"} { set modes [rflist $modes "xdcc"] }
     if {$x == "c"} { set modes [rflist $modes "ctcp"] }
     if {$x == "i"} { set modes [rflist $modes "invite"] }
     if {$x == "p"} { set modes [rflist $modes "public"] }
    }
  }
  return $modes
}
alias unignore {
  if {"[lindex [args] 0]" == "?"} { /help unignore ; complete ; return }
  if {[isnum [lindex [args] 0]]} {
    set numb 0
    foreach addr [get_cookie ignorelist] {
      incr numb
      if {$numb == [lindex [args] 0]} {
        synecho unignore "[eheader "Ignore"] Removed ignore: ([b]$addr[b]\[[sb][get_cookie ignore($addr)][sb]\])..."
        set_cookie ignorelist [rflist [get_cookie ignorelist] $addr]
        set_cookie ignore($addr) ""
        set flag 1
      }
    }
    if {[info exists flag]} { unset flag
    } else { synecho unignore "[eheader "Ignore"] ([b][lindex [args] 0][b]) no such user number on ignorance list..." }
  } elseif {![wmatch *.* [lindex [args] 0]] && [isnick [lindex [args] 0]]} {
      if {![info exists whoisqueue]} { set whoisqueue "" }
      if {[isnum [lindex [args] 1]] && [lindex [args] 1] <= 9 && [lindex [args] 1] > 0} { lappend whoisqueue "unignore [join [lindex [args] 1]] [join [lindex [args] 2]]"
      } else { lappend whoisqueue "unignore 1 [join [lindex [args] 1]]" }
      set nokill 1
      addnullpipe whois
      whois [lindex [args] 0]
  } else {
    foreach addr [get_cookie ignorelist] {
      if {[wmatch [addrfill [lindex [args] 0]] $addr] || [wmatch $addr [addrfill [lindex [args] 0]]]} {
        synecho unignore "[eheader "Ignore"] Removed ignore: ([b]$addr[b]\[[sb][get_cookie ignore($addr)][sb]\]) from list..."
        set_cookie ignorelist [rflist [get_cookie ignorelist] $addr]
        set_cookie ignore($addr) ""
        set flag 1
      }
    }
    if {[info exists flag]} { unset flag
    } else { synecho unignore "[eheader "Ignore"] ([b][string tolower [addrfill [lindex [args] 0]]][b]) no such address on ignorance list..." }
  }
  if {[info exists nokill]} { unset nokill } else { killpipe unignore }
  noidle
  complete
}
alias ignore {
  if {"[lindex [args] 0]" == "?"} { /help ignore ; complete ; return }
  if {![string length [lindex [args] 0]]} {
    set numb 0
    foreach addr [get_cookie ignorelist] {
      if {!$numb} {
        synecho ignore "[boxtop "[b]Ignorance List[b] [sb](([sb][su]entries:[su] [b][llength [get_cookie ignorelist]][b][sb]))[sb]"]"
        synecho ignore "[boxside "[llb][b]# [b][lrb][llb][b]Address:                                     [b][lrb][llb][b]Types:              [b][lrb]"]"
      }
      incr numb
      synecho ignore "[boxside "[llb][b][align $numb 2][b][lrb][llb][align $addr 45][lrb][llb][align [get_cookie ignore($addr)] 20][lrb]"]"
    }
    if {!$numb} { synecho ignore "[eheader "Ignore"] You have no users on ignore..."
    } else { synecho ignore "[boxbottom "[b]Ignorance List[b] [sb](([sb][su]entries:[su] [b][llength [get_cookie ignorelist]][b][sb]))[sb]"]" }
  } else {
    set currmods ""
    if {![string length $currmods]} { set currmods "text" }
    if {[isnum [lindex [args] 0]]} {
      set numb 0
      foreach addr [get_cookie ignorelist] {
        incr numb
        if {$numb == [join [lindex [args] 0]]} {
          set currmods [ignoremodeorder [ignorez $addr]]
          synecho ignore "[eheader "Ignore"] Updated ignore: ([b]$addr[b]\[[sb]$currmods[sb]\])..."
          set_cookie ignore($addr) $currmods
          set flag 1
        }
      }
      if {[info exists flag]} { unset flag
      } else { synecho ignore "[eheader "Ignore"] ([b][lindex [args] 0][b]) no such user number on ignorance list..." }
    } elseif {![wmatch *.* [lindex [args] 0]] && ![wmatch *@* [lindex [args] 0]] && [isnick [lindex [args] 0]]} {
      if {![info exists whoisqueue]} { set whoisqueue "" }
      if {[isnum [lindex [args] 1]] && [lindex [args] 1] <= 9 && [lindex [args] 1] > 0} { lappend whoisqueue "ignore [join [lindex [args] 1]] [join [lindex [args] 2]]"
      } else { lappend whoisqueue "ignore 5 [join [lindex [args] 1]]" }
      set nokill 1
      addnullpipe whois
      whois [lindex [args] 0]
    } else {
      foreach addr [get_cookie ignorelist] {
        if {[wmatch $addr [addrfill [lindex [args] 0]]]} {
          set currmods [ignoremodeorder [ignorez $addr]]
          synecho ignore "[eheader "Ignore"] Updated ignore: ([b]$addr[b]\[[sb]$currmods[sb]\])..."
          set_cookie ignore($addr) $currmods
          set flag 1
        }
      }
      if {[info exists flag]} { unset flag
      } else {
        set currmods [ignoremodeorder ""]
        if {![string length $currmods]} { set currmods "[join "text"] [join "ctcp"]" }
        set temp6 [get_cookie ignorelist]
        lappend temp6 [addrfill [lindex [args] 0]]
        set_cookie ignorelist $temp6
        set_cookie ignore([addrfill [lindex [args] 0]]) $currmods
        synecho ignore "[eheader "Ignore"] Added ignore: ([b][addrfill [lindex [args] 0]][b]\[[sb]$currmods[sb]\]) to list..."
      }
    }
  }
  if {[info exists nokill]} { unset nokill } else { killpipe ignore }
  noidle
  complete
}
alias unnotify {
  if {"[lindex [args] 0]" == "?"} { /help unnotify ; complete ; return }
  if {[isnum [lindex [args] 0]]} {
    set numb 0
    foreach addr [get_cookie notifylist] {
      incr numb
      if {$numb == [join [lindex [args] 0]]} {
        if {[lindex [get_cookie notify($addr)] 1] == "yes"} { set wi "\[[sb]whois:[sb] yes\]"
        } else { set wi "" }
        synecho unnotify "[eheader "Notify"] Removed notify: ([b]$addr[b]${wi}\[[sb]addr:[sb] [lindex [get_cookie notify($addr)] 0]\]\[[sb]note:[sb] [join [lindex [get_cookie notify($addr)] 2]]\])..."
        set_cookie notifylist [rflist [get_cookie notifylist] $addr]
        set_cookie notify($addr) ""
        set flag 1
      }
    }
    if {[info exists flag]} { unset flag
    } else { synecho unnotify "[eheader "Notify"] ([b][lindex [args] 0][b]) no such user number on notify list..." }
  } else {
    foreach addr [get_cookie notifylist] {
      if {[string tolower $addr] == [string tolower [lindex [args] 0]]} {
        if {[lindex [get_cookie notify($addr)] 1] == "yes"} { set wi "\[[sb]whois:[sb] yes\]"
        } else { set wi "" }
        synecho unnotify "[eheader "Notify"] Removed notify: ([b]$addr[b]${wi}\[[sb]addr:[sb] [lindex [get_cookie notify($addr)] 0]\]\[[sb]note:[sb] [join [lindex [get_cookie notify($addr)] 2]]\])..."
        if {[info exists ison($addr)]} { unset ison($addr) }
        set_cookie notifylist [rflist [get_cookie notifylist] $addr]
        set_cookie notify($addr) ""
        set flag 1
      }
    }
    if {[info exists flag]} { unset flag
    } else { synecho unnotify "[eheader "Notify"] ([b][lindex [args] 0][b]) no such nickname on notify list..." }
  }
  killpipe unnotify
  noidle
  complete
}
alias notify {
  if {"[lindex [args] 0]" == "?"} { /help notify ; complete ; return }
  if {![string length [lindex [args] 0]] || "[lindex [args] 0]" == "list" } {
    set numb 0
    foreach addr [get_cookie notifylist] {
      if {!$numb} {
        synecho notify "[boxtop "[b]Notify List[b] [sb](([sb][su]entries:[su] [b][llength [get_cookie notifylist]][b][sb]))[sb]"]"
        synecho notify "[boxside "[llb][b]# [b][lrb][llb][b]Nickname:  [b][lrb][llb][b]Who:[b][lrb][llb][b]Address:                      [b][lrb][llb][b]Note:                    [b][lrb]"]"
      }
      incr numb
      if {[lindex [get_cookie notify($addr)] 1] == "yes"} { set wi "yes"
      } else { set wi "no " }
      synecho notify "[boxside "[llb][b][align $numb 2][b][lrb][llb][align $addr 11][lrb][llb]$wi [lrb][llb][align [lindex [get_cookie notify($addr)] 0] 30][lrb][llb][align [join [lindex [get_cookie notify($addr)] 2]] 25][lrb]"]"
    }
    if {!$numb} { synecho notify "[eheader "Notify"] You have no users on notify..."
    } else { synecho notify "[boxbottom "[b]Notify List[b] [sb](([sb][su]entries:[su] [b][llength [get_cookie notifylist]][b][sb]))[sb]"]" }
  } elseif { "[lindex [args] 0]" == "add" } {
    set currmods ""
    if {![string length $currmods]} { set currmods "text" }
    if {[isnum [lindex [args] 1]]} {
      set numb 0
      foreach addr [get_cookie notifylist] {
        incr numb
        if {$numb == [join [lindex [args] 1]]} {
          set toadd ""
          if {[string range [lindex [args] 2] 0 1] == "-a" && [wmatch *@* [lindex [args] 2]]} { lappend toadd [naddrfill [lindex [args] 2]]
          } else { lappend toadd [lindex [get_cookie notify($addr)] 0] }
          if {[string range [lindex [args] 2] 0 1] == "-w" && [lindex [args] 3] == "1" || [lindex [args] 3] == "yes"} { lappend toadd yes ; set wi "\[[sb]whois:[sb] yes\]"
          } elseif {[string range [lindex [args] 2] 0 1] == "-w" && [lindex [args] 3] == "0" || [lindex [args] 3] == "no"} { lappend toadd no ; set wi ""
          } else { lappend toadd [lindex [get_cookie notify($addr)] 1] ; set wi "" }
          if {[string range [lindex [args] 2] 0 1] == "-n" && [string length [lrange [args] 3 end]]} { lappend toadd "[lrange [args] 3 end]"
          } else { lappend toadd [lindex [get_cookie notify($addr)] 2] }
          set_cookie notify($addr) "$toadd"
          synecho notify "[eheader "Notify"] Updated notify: ([b]$addr[b]${wi}\[[sb]addr:[sb] [lindex [get_cookie notify($addr)] 0]\]\[[sb]note:[sb] [join [lindex [get_cookie notify($addr)] 2]]\])..."
          set flag 1
        }
      }
      if {[info exists flag]} { unset flag
      } else { synecho notify "[eheader "Notify"] ([b][lindex [args] 1][b]) no such user number on notify list..." }
    } else {
      foreach addr [get_cookie notifylist] {
        if {[string tolower $addr] == [string tolower [lindex [args] 1]]} {
          set toadd ""
          if {[string range [lindex [args] 2] 0 1] == "-a" && [wmatch *.* [lindex [args] 3]]  && [wmatch *@* [lindex [args] 3]]} { lappend toadd [naddrfill [lindex [args] 3]]
          } else { lappend toadd [lindex [get_cookie notify($addr)] 0] }
          if {[string range [lindex [args] 2] 0 1] == "-w" && [lindex [args] 3] == "1" || [lindex [args] 3] == "yes"} { lappend toadd yes ; set wi "\[[sb]whois:[sb] yes\]"
          } elseif {[string range [lindex [args] 1] 0 1] == "-w" && [lindex [args] 3] == "0" || [lindex [args] 3] == "no"} { lappend toadd no ; set wi ""
          } else { lappend toadd [lindex [get_cookie notify($addr)] 1] ; set wi "" }
          if {[string range [lindex [args] 2] 0 1] == "-n" && [string length [lrange [args] 3 end]]} { lappend toadd "[lrange [args] 3 end]"
          } else { lappend toadd [lindex [get_cookie notify($addr)] 2] }
          set_cookie notify($addr) "$toadd"
          synecho notify "[eheader "Notify"] Updated notify: ([b]$addr[b]${wi}\[[sb]addr:[sb] [lindex [get_cookie notify($addr)] 0]\]\[[sb]note:[sb] [join [lindex [get_cookie notify($addr)] 2]]\])..."
          set flag 1
        }
      }
      if {[info exists flag]} { unset flag
      } else {
        set temp6 [get_cookie notifylist]
        lappend temp6 [lindex [args] 1]
        set_cookie notifylist $temp6
        set toadd ""
        if {[string length [lindex [args] 3]] && [wmatch *.* [lindex [args] 3]]  && [wmatch *@* [lindex [args] 3]]} { lappend toadd [naddrfill [lindex [args] 3]]
        } else { lappend toadd "*@*" }
        if {[string length [lindex [args] 2]] && [lindex [args] 2] == 1} { lappend toadd yes ; set wi "\[[sb]whois:[sb] yes\]"
        } else { lappend toadd no ; set wi "" }
        if {[string length [lrange [args] 4 end]]} { lappend toadd "[lrange [args] 4 end]"
        } else { lappend toadd "none" }
        set_cookie notify([lindex [args] 1]) "$toadd"
        synecho notify "[eheader "Notify"] Added notify: ([b][lindex [args] 1][b]${wi}\[[sb]addr:[sb] [lindex [get_cookie notify([lindex [args] 1])] 0]\]\[[sb]note:[sb] [join [lindex [get_cookie notify([lindex [args] 1])] 2]]\])..."
      }
    }
  } elseif { "[lindex [args] 0]" == "rem" || "[lindex [args] 0]" == "del" } {
    /unnotify [lindex [args] 1]
  } else {
    /help notify ; complete ; return
  }
  killpipe notify
  noidle
  complete
}

####
#### RAW Events
####

on 377 {
  global events
  if {[info exists events(377)]} {
    foreach ev $events(377) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[config dispmotd]} { synechox x "[motdheader] [lindex [args] 1]" status }
}
on 372 {
  global events
  if {[info exists events(372)]} {
    foreach ev $events(372) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[config dispmotd]} { synechox x "[motdheader] [lindex [args] 1]" status }
}
on 376 {
  if {[config dispmotd]} { synechox x "[motdend]" status }
}
on 375 {
  if {[config dispmotd]} { synechox x "[motdstart]" status }
}

on 364 {
  global events
  if {[info exists events(364)]} {
    foreach ev $events(364) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[info exists llmaster]} {
    if {![info exists llnew]} { set_cookie linklook(master) "" ; set llnew "" }
    set_cookie linklook(master) [atlist [get_cookie linklook(master)] [lindex [args] 1]]
  } elseif {[info exists llcurrent]} {
    if {![info exists llnew]} { set linklook "[get_cookie linklook(master)]" ; set llnew "" ; set numb 0 ; set command "" }
    foreach link [get_cookie linklook(master)] {
      if {[string match $link [lindex [args] 1]] || [string match [lindex [args] 1] $link]} { set linklook "[rflist $linklook $link]" }
    }
  }
}
on 365 {
  global events
  if {[info exists events(365)]} {
    foreach ev $events(365) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[info exists llnew]} { unset llnew }
  if {[info exists llmaster]} {
    synecho ll "[eheader "LinkLooker"] Master links listing successfully rebuilt..."
    unset llmaster
  } elseif {[info exists llcurrent]} {
    set numb 0
    if {[llength $linklook]} {
      synecho ll "[boxtop "[b]Split Server Report[b] [sb](([sb][su]splits:[su] [b][llength $linklook][b][sb]))[sb]"]"
      synecho ll "[boxside  "[llb][b]# [b][lrb] [b]Server:[b]"]"
      foreach line $linklook { incr numb ; synecho ll "[boxside "[llb][b][align $numb 2][b][lrb] $line"]" }
      synecho ll "[boxbottom "[b]Split Server Report[b] [sb](([sb][su]splits:[su] [b][llength $linklook][b][sb]))[sb]"]"
    } else {
      synecho ll "[eheader "LinkLooker"] There are currently no split servers..."
    }
    unset llcurrent
  }
  killpipe ll
}
proc xserver { } {
  global realserver
  if {[info exists realserver]} {
    return "[list "$realserver"] [list "[lindex [server] 1]"]"
  } else {
    return "[list "[lindex [server] 0]"] [list "[lindex [server] 1]"]"
  }
}

on 004 {
  global events
  if {[info exists events(004)]} {
    foreach ev $events(004) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synload
  if {[isip [lindex [server] 0]]} {
    lappend dnsqueue "resolveserv [lindex [server] 0]"
    lookup [lindex [server] 0]
  }
}
on 376 {
  global events
  if {[info exists events(376)]} {
    foreach ev $events(376) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[config dispmotd]} { echo "[lindex [args] 1]" status }
}
on 375 {
  global events
  if {[info exists events(375)]} {
    foreach ev $events(375) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[config dispmotd]} { echo "[lindex [args] 1]" status }
}

on 471 {
  global events
  if {[info exists events(471)]} {
    foreach ev $events(471) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  dsynecho join "[eheader "[lindex [args] 1]"] Unable to join channel -- Channel is full \[[b]+l[b]\]"
  killpipe join
}
on 473 {
  global events
  if {[info exists events(473)]} {
    foreach ev $events(473) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  dsynecho join "[eheader "[lindex [args] 1]"] Unable to join channel -- Channel is invite only \[[b]+i[b]\]"
  killpipe join
}
on 474 {
  global events
  if {[info exists events(474)]} {
    foreach ev $events(474) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  dsynecho join "[eheader "[lindex [args] 1]"] Unable to join channel -- Banned from channel \[[b]+b[b]\]"
  if {![info exists banqueue]} { set banqueue "" }
  lappend banqueue "checkban"
  /quote mode [lindex [args] 1] +b
  killpipe join
}
on 475 {
  global events
  if {[info exists events(475)]} {
    foreach ev $events(475) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  dsynecho join "[eheader "[lindex [args] 1]"] Unable to join channel -- Channel requires correct key \[[b]+k[b]\]"
  killpipe join
  if {[string length [get_cookie chkey([string tolower [lindex [args] 1]])]]} {
    synecho join "[eheader "AutoKey"] Your autokey for [b][string tolower [lindex [args] 1]][b] is outdated.. Removing from database..." status
    set_cookie chkey([string tolower [lindex [args] 1]]) ""
  }
}
on 405 {
  global events
  if {[info exists events(405)]} {
    foreach ev $events(405) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  dsynecho x "[eheader "[lindex [args] 1]"] Unable to join channel -- You are on too many channels..."
}
on 431 {
  global events
  if {[info exists events(431)]} {
    foreach ev $events(431) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "No nickname given" status ; noidle
}
on 402 {
  global events
  if {[info exists events(402)]} {
    foreach ev $events(402) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[info exists sping([string tolower [lindex [args] 1]])]} {
    synecho sping "[eheader "[lindex [args] 1]"] No such server..." status
    unset sping([lindex [args] 1])
    killpipe sping
  } else {
    synecho sver "[eheader "[lindex [args] 1]"] No such server..." status
    killpipe sver
  }
}
on 403 {
  global events
  if {[info exists events(403)]} {
    foreach ev $events(403) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[eheader "[lindex [args] 1]"] No such channel" status ; killpipe bans
}
on 406 {
  global events
  if {[info exists events(406)]} {
    foreach ev $events(406) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho whowas "[eheader "[lindex [args] 1]"] There was no such nickname..." status ; killpipe whowas
}
on 411 {
  global events
  if {[info exists events(411)]} {
    foreach ev $events(411) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "No recipitent given" status
}
on 412 {
  global events
  if {[info exists events(412)]} {
    foreach ev $events(412) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "No text to send" status
}
on 421 {
  global events
  if {[info exists events(421)]} {
    foreach ev $events(421) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho [lindex [args] 1] "[eheader "[lindex [args] 1]"] Unknown command" status ; killpipe "[lindex [args] 1]"
}
on 432 {
  global events
  if {[info exists events(432)]} {
    foreach ev $events(432) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[eheader "[lindex [args] 1]"] Invalid nickname" status
}
on 433 {
  global events
  if {[info exists events(433)]} {
    foreach ev $events(433) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[info exists regainnick] && "[lindex [args] 1]" == "$regainnick"} {
  } {
    synecho x "[eheader "[lindex [args] 1]"] Nickname already in use" status
  }
}
on 404 {
  global events
  if {[info exists events(404)]} {
    foreach ev $events(404) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[ison [my_nick] [lindex [args] 1]] && ![string match *m* [lindex [mode [lindex [args] 1]] 0]]} { synecho x "[eheader "[lindex [args] 1]"] is desynched.. (cannot send to channel)" status
  } elseif {![string match *[lindex [args] 1]* [channels]]} { synecho x "[eheader "[lindex [args] 1]"] Cannot send to channel -- Channel doesn't accept external messages \[[b]+n[b]\]" status
  } else { synecho x "[eheader "[lindex [args] 1]"] Cannot send to channel -- Channel is moderated \[[b]+m[b]\]" status status }
}
on 442 {
  global events
  if {[info exists events(442)]} {
    foreach ev $events(442) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[ison [my_nick] [lindex [args] 1]]} { synecho x "[eheader "[lindex [args] 1]"] is desynched (you're not on that channel)..." status
  } else { synecho x "[eheader "[lindex [args] 1]"] You're not on that channel" status }
}
on 482 {
  global events
  if {[info exists events(482)]} {
    foreach ev $events(482) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[isop [my_nick] [lindex [args] 1]]} { synecho x "[eheader "[lindex [args] 1]"] is desynched (you're not a channel operator)..." status
  } else { synecho x "[eheader "[lindex [args] 1]"] You're not a channel operator." status }
}
on 443 {
  global events
  if {[info exists events(443)]} {
    foreach ev $events(443) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[eheader "[lindex [args] 1]"] Is already on [b][lindex [args] 2][b]..." status
}
on 381 {
  global events
  if {[info exists events(381)]} {
    foreach ev $events(381) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[eheader "Oper"] You are now an IRC Operator..." status
}
on 461 {
  global events
  if {[info exists events(461)]} {
    foreach ev $events(461) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "Not enough parameters" status
}
on 437 {
  global events
  if {[info exists events(437)]} {
    foreach ev $events(437) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "Cannot change nickname while banned on channel..." status
}
on 467 {
  global events
  if {[info exists events(467)]} {
    foreach ev $events(467) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "Channel key already set" status
}
on 472 {
  global events
  if {[info exists events(472)]} {
    foreach ev $events(472) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[eheader "[lindex [args] 1]"] Unknown mode flag" status
}
on 221 {
  global events
  if {[info exists events(221)]} {
    foreach ev $events(221) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[eheader "UserMode"] Your usermode is now: [b][lindex [args] 1][b]" status
}
on 481 {
  global events
  if {[info exists events(481)]} {
    foreach ev $events(481) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "You're not an IRC Operator" status
}
on 441 {
  global events
  if {[info exists events(441)]} {
    foreach ev $events(441) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[eheader "[lindex [args] 1]"] They arent on that channel" status
}
on 478 {
  global events
  if {[info exists events(478)]} {
    foreach ev $events(478) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[string match *dal.net* [xserver]]} { set maxban 60 } elseif {[string match *undernet.net* [xserver]]} { set maxban 30 } else {[string match *dal.net* [xserver]]} { set maxban 20 } ; synecho x "[eheader "[lindex [args] 1]"] Channel Ban list is full ([b]Max:[b] $maxban)" status
}
on 341 {
  global events
  if {[info exists events(341)]} {
    foreach ev $events(341) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[eheader "[lindex [args] 1]"] has been invited to [b][lindex [args] 2][b]..." status
}
on 465 {
  global events
  if {[info exists events(465)]} {
    foreach ev $events(465) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[eheader "Break"] You are banned from server [b][lindex [server] 0][b]: [join [lrange [args] 1 end]]" status
}
on 369 {
  global events
  if {[info exists events(369)]} {
    foreach ev $events(369) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists whoisqueue] && [info exists whowasact]} {
    if {[string length [applywhoisend "[lindex [args] 1]"]]} { synechox whowas "[applywhoisend "[lindex [args] 1]"]" status }
    if {[info exists wwpart] && [string length [applywhoisend "[lindex [args] 1]"]]} { synechox x "[applywhoisend "[lindex [args] 1]"]" }
    unset whowasact
  }
  if {[info exists wwpart]} { unset wwpart }
  killpipe whowas
}
on 314 {
  global events
  if {[info exists events(314)]} {
    foreach ev $events(314) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[info exists whoisqueue]} { if {![string length $whoisqueue]} { unset whoisqueue } }
  set whowasact "1"
  if {[config whoisactive]} { dsynechox whowas "[applywhowasstart "[lindex [args] 1]"]"
  } else { synechox whowas "[applywhowasstart "[lindex [args] 1]"]" status }
  if {[config whoisactive]} { dsynechox whowas "[applywhoisaddr "[lindex [args] 1]" "[lindex [args] 2]" "[lindex [args] 3]" "[getcountry "[lrange [split [lindex [args] 3] "."] end end]"]"]"
  } else { synechox whowas "[applywhoisaddr "[lindex [args] 1]" "[lindex [args] 2]" "[lindex [args] 3]" "[getcountry "[lrange [split [lindex [args] 3] "."] end end]"]"]" status }
  if {[config whoisactive]} { dsynechox whowas "[applywhoisquote "[lindex [args] 1]" "[join [lrange [args] 5 end]]"]"
  } else { synechox whowas "[applywhoisquote "[lindex [args] 1]" "[join [lrange [args] 5 end]]"]" status }
}
on 303 {
  global events
  if {[info exists events(303)]} {
    foreach ev $events(303) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  set nickz ""
  foreach nick [get_cookie notifylist] {
    if {[isin [string tolower [array names ison]] [string tolower $nick]] && ![isin [string tolower [lrange [split [join [args]]] 1 end]] [string tolower $nick]]} {
      foreach nickx [array names ison] { if {[string tolower $nickx] == [string tolower $nick]} { unset ison($nickx) ; set nnick $nickx } }
      if {[join [lindex [get_cookie notify($nnick)] 2]] != "none" && [string length [join [lindex [get_cookie notify($nnick)] 2]]]} { set notmsg "[join [lindex [get_cookie notify([lindex [args] 1])] 2]]"
      } else { set notmsg "" }
      if {[window_type] != "status" && [config notifyactive]} { echo "[applynotifylogoff "$nnick" "$notmsg"]" }
      echo "[applynotifylogoff "$nnick" "$notmsg"]" status
    } elseif {![isin [string tolower [array names ison]] [string tolower $nick]] && [isin [lrange [split [join [args]]] 1 end] $nick]} {
      if {![info exists whoisqueue]} { set whoisqueue "" }
      lappend whoisqueue "notify"
      set ison([string tolower $nick]) "[list "no information"] [list "no information"] [list "1"]"
      append nickz $nick,
    }
  }
  if {[string length $nickz]} { whois [string trim $nickz ","] }
}
on 401 {
  global events
  if {[info exists events(401)]} {
    foreach ev $events(401) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[info exists whoisqueue]} { if {![string length $whoisqueue]} { unset whoisqueue } }
  if {[info exists whoisqueue]} {
    switch "[lrange [lindex $whoisqueue 0] 0 0]" {
      "ignore"   { synecho ignore "[eheader "Ignore"] There is no such nick ([b][lindex [args] 1][b])..." ; killpipe ignore }
      "nslookup" { synecho dns "[eheader "Resolve"] There is no such nick ([b][lindex [args] 1][b])..." ; killpipe dns }
      "user"    { synecho auser "[eheader "User"] There is no such nick ([b][lindex [args] 1][b])..." ; killpipe auser }
      "ruser"    { synecho ruser "[eheader "User"] There is no such nick ([b][lindex [args] 1][b])..." ; killpipe ruser }
      "unignore" { synecho unignore "[eheader "Unignore"] There is no such nick ([b][lindex [args] 1][b])..." ; killpipe unignore }
      "ban"      { synecho ban "[eheader "Ban"] There is no such nick ([b][lindex [args] 1][b])..." ; killpipe ban }
      "frelm"    { synecho frelm "[eheader "FakeRelay"] There is no such nick ([b][lindex [args] 1][b])..." ; killpipe frelm }
      "unban"    { synecho unban "[eheader "Unban"] There is no such nick ([b][lindex [args] 1][b])..." ; killpipe unban }
      "scheck"   { synecho scheck "[eheader "SpoofCheck"] There is no such nick ([b][lindex [args] 1][b])..." ; killpipe scheck }
      "cflood"   { synecho cflood "[eheader "CloneFlood"] There is no such nick ([b][lindex [args] 1][b])..." ; killpipe cflood }
    }
    set whoisqueue [lrange $whoisqueue 1 end]
  } else {
    if {[info exists whoisact]} {
      if {[info exists wpart] && [string length [applywhoisend "[lindex [args] 1]"]]} { dsynechox whois "[applywhoisend "[lindex [args] 1]"]"
      } elseif {[string length [applywhoisend "[lindex [args] 1]"]]} { synechox whois "[applywhoisend "[lindex [args] 1]"]" status }
      unset whoisact
    }
    if {[config whoisactive]} { dsynecho whois "[eheader "[lindex [args] 1]"] No such nick\\channel"
    } else { synecho whois "[eheader "[lindex [args] 1]"] No such nick\\channel" status }
  }
}
on 311 {
  global events
  if {[info exists events(311)]} {
    foreach ev $events(311) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[info exists whoisqueue]} { if {![string length $whoisqueue]} { unset whoisqueue } }
  if {[info exists whoisqueue]} {
    switch "[lrange [lindex $whoisqueue 0] 0 0]" {
      "ignore"   { /ignore [banmask [lindex [lindex $whoisqueue 0] 1] [lindex [args] 1]![lindex [args] 2]@[lindex [args] 3]] [lrange [lindex $whoisqueue 0] 2 end] }
      "nslookup" { /dns [lindex [args] 3] }
      "ruser"    { /ruser [banmask [lindex [lindex $whoisqueue 0] 1] [lindex [args] 1]![lindex [args] 2]@[lindex [args] 3]] [join [lrange [lindex $whoisqueue 0] 2 end]] }
      "user"     { /user [banmask [lindex [lindex $whoisqueue 0] 1] [lindex [args] 1]![lindex [args] 2]@[lindex [args] 3]] [join [lrange [lindex $whoisqueue 0] 2 end]] }
      "unignore" { /unignore [banmask [lindex [lindex $whoisqueue 0] 1] [lindex [args] 1]![lindex [args] 2]@[lindex [args] 3]] [lrange [lindex $whoisqueue 0] 2 end] }
      "ban"      { /raw mode [lindex [lindex $whoisqueue 0] 2] +b [banmask [lindex [lindex $whoisqueue 0] 1] [lindex [args] 1]![lindex [args] 2]@[lindex [args] 3]] }
      "unban"    { /unban [lrange [lindex $whoisqueue 0] 1 end] [lindex [args] 1]![lindex [args] 2]@[lindex [args] 3] }
      "frelm"    {
        set text [applyrelmvars "[lindex [args] 1]" "[lindex [args] 2]" "[lindex [args] 3]" "msg" "[lrange [lindex $whoisqueue 0] 2 end]"]
        /raw privmsg [lrange [lindex $whoisqueue 0] 1 1] :$text
        if {[isin [string tolower [channels]] [string tolower [lrange [lindex $whoisqueue 0] 1 1]]]} { echo "[applyselftext "[my_nick]" "$text"]" channel [lrange [lindex $whoisqueue 0] 1 1]
        } elseif {[isin [string tolower [queries]] [string tolower [lrange [lindex $whoisqueue 0] 1 1]]]} { echo "[applyselftext "[my_nick]" "$text"]" query [lrange [lindex $whoisqueue 0] 1 1]
        } else { echo "[applysmsgstyle "[lrange [lindex $whoisqueue 0] 1 1]" "$text"]" ; spylink [lrange [lindex $whoisqueue 0] 1 1] "[applysmsgstyle "[lrange [lindex $whoisqueue 0] 1 1]" "$text"]" }
        killpipe frelm
      }
      "cflood"   {
        synecho cflood "[eheader "CloneFlood"] Clones flooding ([b][lindex [args] 1][b]) [b][lindex [lindex $whoisqueue 0] 1][b] times with: ([b][join [lindex [lindex $whoisqueue 0] 2]][b]) [join [lindex [lindex $whoisqueue 0] 3]]"
        set cmm "[list "[lindex [args] 1]"] [list "[lindex [args] 2]"] [list "[lindex [args] 3]"] [list "[lindex [lindex $whoisqueue 0] 1]"] [list "[lindex [lindex $whoisqueue 0] 2]"] [list "[lindex [lindex $whoisqueue 0] 3]"]"
      }
      "notify"   {
        if {[join [lindex [get_cookie notify([lindex [args] 1])] 2]] != "none" && [string length [join [lindex [get_cookie notify([lindex [args] 1])] 2]]]} { set notmsg "[join [lindex [get_cookie notify([lindex [args] 1])] 2]]"
        } else { set notmsg "" }
        if {![wmatch "[lindex [get_cookie notify([lindex [args] 1])] 0]" "[lindex [args] 2]@[lindex [args] 3]"]} { set notmsg "Invalid Address" ; set valid 0 } else { set valid 1 }
        if {[info exists ison([string tolower [lindex [args] 1]])]} { unset ison([string tolower [lindex [args] 1]]) }
        set ison([lindex [args] 1]) "[list [lindex [args] 2]@[lindex [args] 3]] [list [clock format [clock seconds] -format "%m/%d/%y at %I:%M:%S%p"]] [list $valid]"
        if {[join [lindex [get_cookie notify([lindex [args] 1])] 1]] == "yes"} { if {![info exists endwhonot]} { set endwhonot "" } ; append endwhonot "[lindex [args] 1]," }
        if {[window_type] != "status" && [config notifyactive]} { echo "[applynotifylogon "[lindex [args] 1]" "[lindex [args] 2]" "[lindex [args] 3]" "$notmsg"]" }
        echo "[applynotifylogon "[lindex [args] 1]" "[lindex [args] 2]" "[lindex [args] 3]" "$notmsg"]" status
      }
      "scheck"   {
        lappend statslqueue "scheck [lindex [args] 1] [lindex [args] 1]"
        /quote stats L [lindex [args] 1]
        lappend dnsqueue "[list "scheck"] [list "[lindex [args] 3]"] [list "[lindex [args] 1]"] [list "fake"]"
        lookup [lindex [args] 3]
        synecho scheck "[eheader "SpoofCheck"] Performing ip check for [b][lindex [args] 1][b]..."
      }
    }
    set whoisqueue [lrange $whoisqueue 1 end]
  } else {
    if {[info exists whoisact]} {
      if {[info exists wpart] && [string length [applywhoisend "[lindex [args] 1]"]]} { dsynechox whois "[applywhoisend "[lindex [args] 1]"]"
      } elseif {[string length [applywhoisend "[lindex [args] 1]"]]} { synechox whois "[applywhoisend "[lindex [args] 1]"]" status }
      unset whoisact
    }
    set whoisact "1"
    if {[config whoisactive]} { dsynechox whois "[applywhoisstart "[lindex [args] 1]"]"
    } else { synechox whois "[applywhoisstart "[lindex [args] 1]"]" status }
    if {[config whoisactive]} { dsynechox whois "[applywhoisaddr "[lindex [args] 1]" "[lindex [args] 2]" "[lindex [args] 3]" "[getcountry "[lrange [split [lindex [args] 3] "."] end end]"]"]"
    } else { synechox whois "[applywhoisaddr "[lindex [args] 1]" "[lindex [args] 2]" "[lindex [args] 3]" "[getcountry "[lrange [split [lindex [args] 3] "."] end end]"]"]" status }
    if {[config whoisactive]} { dsynechox whois "[applywhoisquote "[lindex [args] 1]" "[join [lrange [args] 5 end]]"]"
    } else { synechox whois "[applywhoisquote "[lindex [args] 1]" "[join [lrange [args] 5 end]]"]" status }
    if {[isuser [lindex [args] 1]![lindex [args] 2]@[lindex [args] 3]]} {
      if {[config whoisactive]} { dsynechox whois "[applywhoisdata "[lindex [args] 1]" "[gusersettings [lindex [args] 1]![lindex [args] 2]@[lindex [args] 3]]"]"
      } else { synechox whois "[applywhoisdata "[lindex [args] 1]" "[gusersettings [lindex [args] 1]![lindex [args] 2]@[lindex [args] 3]]"]" status }
    }
  }
}
on 312 {
  global events
  if {[info exists events(312)]} {
    foreach ev $events(312) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists whoisqueue]} {
    if {[info exists whowasact]} {
      if {[config whoisactive]} {  dsynechox whowas "[applywhoisserv "[lindex [args] 1]" "[lindex [args] 2]" "[join [lrange [args] 3 end]]"]"
      } else { synechox whowas "[applywhoisserv "[lindex [args] 1]" "[lindex [args] 2]" "[join [lrange [args] 3 end]]"]" status }
    } else {
      if {[config whoisactive]} { dsynechox whois "[applywhoisserv "[lindex [args] 1]" "[lindex [args] 2]" "[join [lrange [args] 3 end]]"]"
      } else { synechox whois "[applywhoisserv "[lindex [args] 1]" "[lindex [args] 2]" "[join [lrange [args] 3 end]]"]" status }
    }
  }
}
on 301 {
  global events
  if {[info exists events(301)]} {
    foreach ev $events(301) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists whoisqueue]} {
    if {[info exists whowasact]} {
      if {[config whoisactive]} { dsynechox whowas "[applywhoisaway "[lindex [args] 1]" "[join [lrange [args] 2 end]]"]"
      } else { synechox whowas "[applywhoisaway "[lindex [args] 1]" "[join [lrange [args] 2 end]]"]" status }
    } else {
      if {[config whoisactive]} { dsynechox whois "[applywhoisaway "[lindex [args] 1]" "[join [lrange [args] 2 end]]"]"
      } else { synechox whois "[applywhoisaway "[lindex [args] 1]" "[join [lrange [args] 2 end]]"]" status }
    }
  }
}
on 313 {
  global events
  if {[info exists events(313)]} {
    foreach ev $events(313) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists whoisqueue]} {
    if {[config whoisactive]} { dsynechox whois "[applywhoisoper "[lindex [args] 1]"]"
    } else { synechox whois "[applywhoisoper "[lindex [args] 1]"]" status  }
  }
}
on 310 {
  global events
  if {[info exists events(310)]} {
    foreach ev $events(310) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists whoisqueue]} {
    if {[config whoisactive]} { dsynechox whois "[applywhoishelpop "[lindex [args] 1]"]"
    } else { synechox whois "[applywhoishelpop "[lindex [args] 1]"]" status }
  }
}
on 317 {
  global events
  if {[info exists events(317)]} {
    foreach ev $events(317) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists whoisqueue]} {
    if {[config whoisactive]} { dsynechox whois "[applywhoisidle "[lindex [args] 1]" "[lindex [args] 2]"]"
    } else { synechox whois "[applywhoisidle "[lindex [args] 1]" "[lindex [args] 2]"]" status }
  }

}
on 319 {
  global events
  if {[info exists events(319]} {
    foreach ev $events(319) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists whoisqueue]} {
    if {[config whoisactive]} { dsynechox whois "[applywhoischan "[lindex [args] 1]" "[join [lrange [args] 2 end]]"]"
    } else { synechox whois "[applywhoischan "[lindex [args] 1]" "[join [lrange [args] 2 end]]"]" status }
  }
}
on 318 {
  global events
  if {[info exists events(318)]} {
    foreach ev $events(318) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists whoisqueue] && [info exists whoisact]} {
    if {[config whoisactive] && [string length [applywhoisend "[lindex [args] 1]"]]} { dsynechox whois "[applywhoisend "[lindex [args] 1]"]"
    } elseif {[string length [applywhoisend "[lindex [args] 1]"]]} { synechox whois "[applywhoisend "[lindex [args] 1]"]" status }
    unset whoisact
  }
  if {[info exists endwhonot]} { /raw whois [string trimright $endwhonot ","] ; unset endwhonot }
  if {[info exists cmm]} { unset cmm }
  killpipe whois
}
on 331 {
  global events
  if {[isin $hasjoined [lindex [args] 1]]} {
    echo "[applysjoinstyle "[my_nick]" "[my_user]" "[my_host]" "[lindex [args] 1]"]" channel [lindex [args] 1]
    set hasjoined "[rflist $hasjoined [lindex [args] 1]]"
  }
  if {[info exists events(331)]} {
    foreach ev $events(331) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[eheader "[lindex [args] 1]"] ([b]topic:  [b]) none" status
  if {[config joinstats]} {
    echo "[applyjointopic "[lindex [args] 1]" "None"]" channel [lindex [args] 1]
  }
}
on 332 {
  global events
  if {[isin $hasjoined [lindex [args] 1]]} {
    echo "[applysjoinstyle "[my_nick]" "[my_user]" "[my_host]" "[lindex [args] 1]"]" channel [lindex [args] 1]
    set hasjoined "[rflist $hasjoined [lindex [args] 1]]"
  }
  if {[info exists events(332)]} {
    foreach ev $events(332) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[eheader "[lindex [args] 1]"] ([b]topic:  [b]) [join [lrange [args] 2 end]]" status
  if {[config joinstats]} {
    echo "[applyjointopic "[lindex [args] 1]" "[join [lrange [args] 2 end]]"]" channel [lindex [args] 1]
  }
  if {[window get_title channel [lindex [args] 1]] != "[applychannelwindow [lindex [args] 1] [mode [lindex [args] 1]] [cmode [lindex [args] 1]] [join [lrange [args] 2 end]]]"} {
    window set_title "[applychannelwindow [lindex [args] 1] [mode [lindex [args] 1]] [cmode [lindex [args] 1]] [join [lrange [args] 2 end]]]" channel [lindex [args] 1]
  }
}
on 333 {
  global events
  if {[info exists events(333)]} {
    foreach ev $events(333) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[eheader "[lindex [args] 1]"] ([b]topic:  [b]) set by [b][join [lrange [args] 2 2]][b] on [clock format [join [lrange [args] 3 3]]]" status ; complete
  if {[config joinstats]} {
    echo "[applyjointopicsetby "[lindex [args] 1]" "[join [lrange [args] 2 2]]" "[clock format [join [lrange [args] 3 3]]]"]" channel [lindex [args] 1]
  }
}
on 328 {
  global events
  if {[info exists events(328)]} {
    foreach ev $events(328) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[eheader "[lindex [args] 1]"] ([b]url:    [b]) [join [lrange [args] 2 end]]" status
  if {[config joinstats]} {
    echo "[applyjoinurl "[lindex [args] 1]" "[join [lrange [args] 2 end]]"]" channel [lindex [args] 1]
  }
}
on 329 {
  global events
  if {[info exists events(329)]} {
    foreach ev $events(329) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[eheader "[lindex [args] 1]"] ([b]created:[b]) [clock format [join [lrange [args] 2 2]]]" status
  if {[config joinstats]} {
    echo "[applyjoincreated "[lindex [args] 1]" "[clock format [join [lrange [args] 2 2]]]"]" channel [lindex [args] 1]
  }
}
on 324 {
  global events
  if {[info exists events(324)]} {
    foreach ev $events(324) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  set extra ""
  if {[string match *k* [join [lindex [args] 2]]] && [ison [my_nick] [lindex [args] 1]]} {
    set modes [split [join [lindex [args] 2]] ""]
    set index 0
    foreach mod $modes {
      if {$mod == "k"} {
        incr index
        set_cookie chkey([string tolower [lindex [args] 1]]) "[list [split [lindex [lrange [args] 2 end] $index]]] [list [string tolower [clock format [clock seconds] -format "%m/%d/%y at %I:%M:%S%p"]]]"
        set_cookie chankeys "[rflist [get_cookie chankeys ""] [string tolower [lindex [args] 1]]]"
        set_cookie chankeys "[atlist [get_cookie chankeys ""] [string tolower [lindex [args] 1]]]"
        set extra "\[[b]autokey:[b] [sb][join [lindex [get_cookie chkey([string tolower [lindex [args] 1]])] 0]][sb]\]"
      } elseif {$mod == "l"} { incr index }
    }
  } elseif {![string match *k* [join [lindex [args] 2]]] && [ison [my_nick] [lindex [args] 1]] && [string length [get_cookie chkey([string tolower [lindex [args] 1]])]]} {
    set extra "\[[sb]removing key entry[sb]\]"
    set_cookie chankeys "[rflist [get_cookie chankeys ""] [lindex [args] 1]]"
    set_cookie chkey([string tolower [lindex [args] 1]]) ""
  }
  synecho x "[eheader "[lindex [args] 1]"] ([b]modes:  [b]) [join [lrange [args] 2 end]] $extra" status
  if {[config joinstats]} {
    echo "[applyjoinmodes "[lindex [args] 1]" "[join [lrange [args] 2 end]]"] $extra" channel [lindex [args] 1]
  }
  if {[window get_title channel [lindex [args] 1]] != "[applychannelwindow [lindex [args] 1] "[string trim "[join [lrange [args] 2 end]]" "+"]" [cmode [lindex [args] 1]] [topic [lindex [args] 1]]]"} {
    window set_title "[applychannelwindow [lindex [args] 1] "[string trim "[join [lrange [args] 2 end]]" "+"]" [cmode [lindex [args] 1]] [topic [lindex [args] 1]]]" channel [lindex [args] 1]
  }
}
on 351 {
  global events
  if {[info exists events(351)]} {
    foreach ev $events(351) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[info exists sping([lindex [args] 2])]} {
    set pingrep "[expr [clock clicks] - $sping([lindex [args] 2])]"
    if {![string length [string range $pingrep 0 [expr [string length $pingrep] - 4]]]} { set sect1 0
    } else { set sect1 "[string range $pingrep 0 [expr [string length $pingrep] - 4]]" }
    if {![string length [string range $pingrep [expr [string length $pingrep] - 3] end]]} { set sect2 000
    } else { set sect2 "[string range $pingrep [expr [string length $pingrep] - 3] end]" }
    set pingrep "$sect1\.$sect2"
    synecho sping "[eheader "ServerPing"] ([b][lindex [args] 2][b]) ping reply: [b]$pingrep secs[b]..."
    unset sping([lindex [args] 2]) pingrep sect1 sect2
    killpipe sping
  } else {
    synecho sver "[eheader "ServerVersion"] [b][lindex [args] 2][b] running [lindex [args] 1] ([join [lrange [args] 3 end]])"
    killpipe sver
  }
}
on 252 {
  global events
  if {[info exists events(252)]} {
    foreach ev $events(252) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[b](operators online: )[b] [b][lindex [args] 1][b] " status
}
on 254 {
  global events
  if {[info exists events(254)]} {
    foreach ev $events(254) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[b](channels formed:  )[b] [b][lindex [args] 1][b]" status
}
on 255 {
  global events
  if {[info exists events(255)]} {
    foreach ev $events(255) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[b](local clients:    )[b] [b][align [lindex [split [args]] 3] 6][b]" status
  synecho x "[b](local servers:    )[b] [b][align [lindex [split [args]] 6] 6][b]" status
}
on 265 {
  global events
  if {[info exists events(265)]} {
    foreach ev $events(265) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[b](local clients:    )[b] [b][align [lindex [split [args]] 5] 6][b] ([b]max:[b] [sb][string trim [lindex [split [args]] 8] "\}"][sb])" status
}
on 266 {
  global events
  if {[info exists events(266)]} {
    foreach ev $events(266) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  synecho x "[b](global clients:   )[b] [b][align [lindex [split [args]] 4] 6][b] ([b]max:[b] [sb][string trim [lindex [split [args]] 7] "\}"][sb])" status
}
on 353 {
  global events
  if {[info exists events(353)]} {
    foreach ev $events(353) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists nameslist]} { set nameslist "" }
  foreach nick [split [lindex [args] 3]] { lappend nameslist $nick }
}
on 366 {
  global events
  if {[isin $hasjoined [lindex [args] 1]]} {
    echo "[applysjoinstyle "[my_nick]" "[my_user]" "[my_host]" "[lindex [args] 1]"]" channel [lindex [args] 1]
    set hasjoined "[rflist $hasjoined [lindex [args] 1]]"
  }
  if {[info exists events(366)]} {
    foreach ev $events(366) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists nameslist]} { set nameslist "" }
  set nameslist [rflist $nameslist ""]
  set reg ""
  set opp ""
  set vee ""
  foreach nick $nameslist {
    if {[string match @* $nick]} { lappend opp $nick
    } elseif {[string match +* $nick]} { lappend vee $nick
    } else { lappend reg $nick }
  }
  set nameslist "[concat [lsort $opp] [lsort $vee] [lsort $reg]]"
  set nix 0
  set line ""
  synecho x "[eheader "[lindex [args] 1]"] ([b]names:  [b]) Listing users on [b][lindex [args] 1][b]([su][llength $nameslist][su])" status
  if {[config joinstats]} {
    synechox x "[applyjoinnames "[lindex [args] 1]" "[llength [clist all [lindex [args] 1]]]" "[llength [clist +o [lindex [args] 1]]]" "[llength [clist -o [lindex [args] 1]]]" "[llength [clist +v [lindex [args] 1]]]" "[llength [clist -v [lindex [args] 1]]]"]" channel [lindex [args] 1]
    synechox x "[applyjoinlstart "[lindex [args] 1]"]" channel [lindex [args] 1]
  }

  foreach nick $nameslist {
    incr nix
    if {$nix != 1} { append line "[applyjoinlseperator] " }
    if {[string match @* $nick]} { append line "[applyjoinlentry "@" "[string range [string trimleft $nick "@"] 0 9]" ]"
    } elseif {[string match +* $nick]} { append line "[applyjoinlentry "+" "[string range [string trimleft $nick "+"] 0 9]" ]"
    } else { append line "[applyjoinlentry " " "[string range $nick 0 9]" ]" }
    if {$nix == 5} {
      synecho x "[eheader "[lindex [args] 1]"] $line" status
      if {[config joinstats]} { synechox x "[applyjoinledge] $line" channel [lindex [args] 1] }
      set nix 0
      set line ""
    }
  }
  if {$nix} {
    synecho x "[eheader "[lindex [args] 1]"] $line" status
    if {[config joinstats]} { synechox x "[applyjoinledge] $line" channel [lindex [args] 1] }
  }

  if {[config joinstats]} { synechox x "[applyjoinlend "[lindex [args] 1]"]" channel [lindex [args] 1] }
  if {[info exists jsynk([lindex [args] 1])]} {
    set synch "[expr [clock clicks] - $jsynk([lindex [args] 1])]"
    if {![string length [string range $synch 0 [expr [string length $synch] - 4]]]} { set sect1 0
    } else { set sect1 "[string range $synch 0 [expr [string length $synch] - 4]]" }
    if {![string length [string range $synch [expr [string length $synch] - 3] end]]} { set sect2 000
    } else { set sect2 "[string range $synch [expr [string length $synch] - 3] end]" }
    set synch "$sect1\.$sect2"
    unset jsynk([lindex [args] 1])
    synecho x "[eheader "[lindex [args] 1]"] ([b]synch:  [b]) [b]$synch[b] seconds" status
    if {[config joinstats]} {
      synechox x "[applyjoinsynch "[lindex [args] 1]" "$synch"]" channel [lindex [args] 1]
    } else { synecho x "Now talking in [b][lindex [args] 1][b]... Join synched in [b]$synch[b] secs..." channel [lindex [args] 1] }
    killpipe join
  }

  if {[info exists nameslist]} { unset nameslist }
}
on 211 {
  global events
  if {[info exists events(211)]} {
    foreach ev $events(211) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  set lexec 1
  if {[info exists statslqueue]} {
    set text "[join [args]]"
    regsub -all {\\} $text {\\\\} text
    regsub -all {\{} $text {\{} text
    regsub -all {\}} $text {\}} text
    regsub -all {\]} $text {\]} text
    regsub -all {\[} $text {\[} text
    regsub -all {\"} $text {\"} text
    set qnick "[join [lrange [split [lindex $text 1] "\["] 0 [expr [llength [split [lindex $text 1] "\["]] - 2]] "\["]"
    set qaddr "[join [lrange [split [lindex $text 1] "\["] [expr [llength [split [lindex $text 1] "\["]] - 1] end] "\["]"
    set qident "[string trimleft [lindex [split [string range $qaddr 0 [expr [string length $qaddr] - 2]] "@"] 0] "(+)"]"
    set qport "[lindex [split [lindex [split [string range $qaddr 0 [expr [string length $qaddr] - 2]] "@"] 1] "."] 4]"
    set qaddr "[join [lrange [split [lindex [split [string range $qaddr 0 [expr [string length $qaddr] - 2]] "@"] 1] "."] 0 3] "."]"
    if {![string length $qport]} { set qport "unknown" }
    if {[lindex [lindex $statslqueue 0] 0] == "scheck"} {
      lappend dnsqueue "[list "scheck"] [list "$qaddr"] [list "$qnick"] [list "real"]"
      lookup $qaddr
    } elseif {[lindex [lindex $statslqueue 0] 0] == "stats"} {
      synecho stats "[boxtop "[b]extended information: $qnick[b]"]" status
      synecho stats "[boxside "[eheader "address   "] $qident@$qaddr"]" status
      synecho stats "[boxside "[eheader "localport "] $qport"]" status
      synecho stats "[boxside "[eheader "sendq     "] [lindex $text 2]"]" status
      synecho stats "[boxside "[eheader "msgs sent "] [align [lindex $text 4] 4] ([b]bytes:[b] [lindex $text 3])"]" status
      synecho stats "[boxside "[eheader "msgs recvd"] [align [lindex $text 6] 4] ([b]bytes:[b] [lindex $text 5])"]" status
      synecho stats "[boxbottom "[b]extended information: $qnick[b]"]" status
    }
    set statslqueue [lrange $statslqueue 1 end]
  }
}
on 212 {
  global events
  if {[info exists events(212)]} {
    foreach ev $events(212) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists temp(num)]} { set temp(num) "0" ; synecho stats "[eheader "Server"] Displaying [b]/stats m[b] query results..." status ; synecho stats "[gboxtop]" ; synecho stats "[gboxside "[llb] [b]#[b] [lrb][llb][b]Command:[b]  [lrb][llb][b]Uses:[b]     [lrb]"]" status }
  incr temp(num)
  synecho stats "[gboxside "[llb][align $temp(num) 3][lrb][llb][align [string range [lindex [args] 1] 0 26] 10][lrb][llb][align [string range [lindex [args] 2] 0 26] 10][lrb]"]"
}
on 213 {
  global events
  if {[info exists events(213)]} {
    foreach ev $events(213) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists temp(num)]} { set temp(num) "0" ; synecho stats "[eheader "Server"] Displaying [b]/stats c[b] query results..." status ; synecho stats "[gboxtop]" ; synecho stats "[gboxside "[llb] [b]#[b] [lrb][llb][b]Line:[b][lrb][llb][b]Hostname:[b]                  [lrb][llb][b]Name:[b]                      [lrb][llb][b]Port:[b][lrb][llb][b]Class:[b][lrb]"]" status }
  incr temp(num)
  synecho stats "[gboxside "[llb][align $temp(num) 3][lrb][llb][align "  [lindex [args] 1]" 5][lrb][llb][align [string range [lindex [args] 2] 0 26] 27][lrb][llb][align [string range [lindex [args] 4] 0 26] 27][lrb][llb][align [lindex [args] 5] 5][lrb][llb][align [lindex [args] 6] 6][lrb]"]"
}
on 214 {
  global events
  if {[info exists events(214)]} {
    foreach ev $events(214) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists temp(num)]} { set temp(num) "0" ; synecho stats "[eheader "Server"] Displaying [b]/stats c[b] query results..." status ; synecho stats "[gboxtop]" ; synecho stats "[gboxside "[llb] [b]#[b] [lrb][llb][b]Line:[b][lrb][llb][b]Hostname:[b]                  [lrb][llb][b]Name:[b]                      [lrb][llb][b]Port:[b][lrb][llb][b]Class:[b][lrb]"]" status }
  incr temp(num)
  synecho stats "[gboxside "[llb][align $temp(num) 3][lrb][llb][align "  [lindex [args] 1]" 5][lrb][llb][align [string range [lindex [args] 2] 0 26] 27][lrb][llb][align [string range [lindex [args] 4] 0 26] 27][lrb][llb][align [lindex [args] 5] 5][lrb][llb][align [lindex [args] 6] 6][lrb]"]"
}
on 215 {
  global events
  if {[info exists events(215)]} {
    foreach ev $events(215) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists temp(num)]} { set temp(num) "0" ; synecho stats "[eheader "Server"] Displaying [b]/stats i[b] query results..." status ; synecho stats "[gboxtop]" ; synecho stats "[gboxside "[llb] [b]#[b]  [lrb][llb][b]Line:[b][lrb][llb][b]Hostname:[b]                  [lrb][llb][b]Hostname:[b]                  [lrb][llb][b]Port:[b][lrb][llb][b]Class:[b][lrb]"]" status }
  incr temp(num)
  synecho stats "[gboxside "[llb][align $temp(num) 4][lrb][llb][align "  [lindex [args] 1]" 5][lrb][llb][align [string range [lindex [args] 2] 0 26] 27][lrb][llb][align [string range [lindex [args] 4] 0 26] 27][lrb][llb][align [lindex [args] 5] 5][lrb][llb][align [lindex [args] 6] 6][lrb]"]"
}
on 218 {
  global events
  if {[info exists events(218)]} {
    foreach ev $events(218) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists temp(num)]} { set temp(num) "0" ; synecho stats "[eheader "Server"] Displaying [b]/stats y[b] query results..." status ; synecho stats "[gboxtop]" ; synecho stats "[gboxside "[llb] [b]#[b]  [lrb][llb][b]Class:  [b][lrb][llb][b]Ping Freq:  [b][lrb][llb][b]Conn Freq:  [b][lrb][llb][b]Max SendQ:[b][lrb]"]" status }
  incr temp(num)
  synecho stats "[gboxside "[llb][align $temp(num) 4][lrb][llb][align "[lindex [args] 1]" 8][lrb][llb][align [lindex [args] 2] 12][lrb][llb][align [lindex [args] 4] 12][lrb][llb][align [lindex [args] 5] 10][lrb]"]"
}
on 243 {
  global events
  if {[info exists events(243)]} {
    foreach ev $events(243) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists temp(num)]} { set temp(num) "0" ; synecho stats "[eheader "Server"] Displaying [b]/stats o[b] query results..." status ; synecho stats "[gboxtop]" ; synecho stats "[gboxside "[llb] [b]#[b] [lrb][llb][b]Line:[b][lrb][llb][b]Hostname:[b]                               [lrb][llb][b]Username:[b]   [lrb]"]" status }
  incr temp(num)
  synecho stats "[gboxside "[llb][align $temp(num) 3][lrb][llb][align "  [lindex [args] 1]" 5][lrb][llb][align [lindex [args] 2] 40][lrb][llb][align [lindex [args] 4] 12][lrb]"]"
}
on 216 {
  global events
  if {[info exists events(216)]} {
    foreach ev $events(216) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists temp(num)]} { set temp(num) "0" ; synecho stats "[eheader "Server"] Displaying [b]/stats k[b] query results..." status ; synecho stats "[gboxtop]" ; synecho stats "[gboxside "[llb] [b]#[b] [lrb][llb][b]Line:[b][lrb][llb][b]Hostname:[b]                               [lrb][llb][b]Username:[b]   [lrb]"]" status }
  incr temp(num)
  synecho stats "[gboxside "[llb][align $temp(num) 3][lrb][llb][align "  [lindex [args] 1]" 5][lrb][llb][align [lindex [args] 2] 40][lrb][llb][align [lindex [args] 4] 12][lrb]"]"
}
on 219 {
  global events
  if {[info exists events(219)]} {
    foreach ev $events(219) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![info exists temp(num)]} { set temp(num) "0" }
  if {[lindex [args] 1] != "L"} {
    if {$temp(num)} { synecho stats "[gboxbottom]" }
    synecho stats "[eheader "Server"] End of [b]/stats [lindex [args] 1][b] report... [b]$temp(num)[b] lines found..." status
    unset temp
  } elseif {[info exists lexec]} {
    unset lexec
  } else {
    synecho stats "[eheader "Server"] Permission denied -- You're not an IRC Operator..." status
    if {[info exists statslqueue]} { set statslqueue [lrange $statslqueue 1 end] }
  }
  killpipe stats
}
on 367 {
  global events
  if {[info exists events(367)]} {
    foreach ev $events(367) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  set chan "[string tolower [lindex [args] 1]]"
  if {[info exists banqueue]} {
    switch "[lrange [lindex $banqueue 0] 0 0]" {
      "ignore" {
        if {![info exists bans]} {
          if {[ison [my_nick] $chan]} { set banlist($chan) "" }
          set bans "0"
        }
        if {[ison [my_nick] $chan]} { lappend banlist($chan) "[lindex [args] 2]" }
      }
      "bans" {
        if {![info exists bans]} {
          if {[ison [my_nick] $chan]} { set banlist($chan) "" }
          set bans "0"
          if {[config bansinactive]} { dsynecho bans "[eheader "Server"] Displaying [b]/mode $chan +b[b] query results..."
          } else { synecho bans "[eheader "Server"] Displaying [b]/mode $chan +b[b] query results..." status }
          if {[config bansinactive]} { dsynecho bans "[gboxtop]"
          } else { synecho bans "[gboxtop]" status }
          if {[config bansinactive]} { dsynecho bans "[gboxside "[llb] [b]\#[b] [lrb][llb][b]Banmask:[b]                                     [lrb][llb][b]On:[b]                 [lrb]"]"
          } else { synecho bans "[gboxside "[llb] [b]\#[b] [lrb][llb][b]Banmask:[b]                                     [lrb][llb][b]On:[b]                 [lrb]"]" status  }
        }
        if {[ison [my_nick] $chan]} { lappend banlist($chan) "[lindex [args] 2]" }
        incr bans
        if {[config bansinactive]} { dsynecho bans "[gboxside "[llb][b][align $bans 3][b][lrb][llb][align [string range [lindex [args] 2] 0 44] 45][lrb][llb][align [clock format [lindex [args] 4] -format "%m/%d/%y %I:%M:%S%p"] 20][lrb]"]"
        } else { synecho bans "[gboxside "[llb][b][align $bans 3][b][lrb][llb][align [string range [lindex [args] 2] 0 44] 45][lrb][llb][align [clock format [lindex [args] 4] -format "%m/%d/%y %I:%M:%S%p"] 20][lrb]"]" status }
        if {[config bansinactive]} { dsynecho bans "[gboxside "[llb]   [lrb] [b](by:)[b] [b][lindex [split [lindex [args] 3] "!@"] 0][b]([sb][lindex [split [lindex [args] 3] "!@"] 1]@[lindex [split [lindex [args] 3] "!@"] 2][sb])"]"
        } else { synecho bans "[gboxside "[llb]   [lrb] [b](by:)[b] [b][lindex [split [lindex [args] 3] "!@"] 0][b]([sb][lindex [split [lindex [args] 3] "!@"] 1]@[lindex [split [lindex [args] 3] "!@"] 2][sb])"]" status }
      }
      "checkban" {
        if {![info exists bans]} { set bans "0" }
        if {[wmatch [lindex [args] 2] [my_nick]![my_user]@[my_ip]] || [wmatch [lindex [args] 2] [my_nick]![my_user]@[my_host]]} {
          incr bans
          dsynecho bans "[chanbanned "[lindex [args] 2]" "$chan" "[lindex [args] 3]" "[lindex [args] 4]"]"
        }
      }
    }
  }
}
on 368 {
  global events
  if {[info exists events(368)]} {
    foreach ev $events(368) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  set chan "[string tolower [lindex [args] 1]]"
  if {[info exists banqueue]} {
    switch "[lrange [lindex $banqueue 0] 0 0]" {
      "ignore" {
        if {[info exists bans]} { unset bans }
        if {![info exists banlist($chan)]} { set banlist($chan) "" }
      }
      "bans" {
        if {[info exists bans]} {
          if {[config bansinactive]} { dsynecho bans "[gboxbottom]"
          } else { synecho bans "[gboxbottom]" status }
        } else {
          set bans 0
        }
        if {![info exists banlist($chan)]} { set banlist($chan) "" }

        if {[config bansinactive]} { dsynecho bans "[eheader "Server"] End of channel banlist on ([b]$chan[b])... [b]$bans[b] bans matched..."
        } else { synecho bans "[eheader "Server"] End of channel banlist on ([b]$chan[b])... [b]$bans[b] bans matched..." status }
        unset bans
      }
      "checkban" {
        if {[info exists bans]} { unset bans }
      }
    }
    set banqueue [lrange $banqueue 1 end]
    if {![string length $banqueue]} { unset banqueue }
  }
  killpipe bans
}
on 352 {
  global events
  if {[info exists events(352)]} {
    foreach ev $events(352) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[info exists whoqueue]} {
    switch "[lrange [lindex $whoqueue 0] 0 0]" {
      "getstat" {
        set mask([string tolower [lindex [args] 5]]) "[lindex [args] 5]![lindex [args] 2]@[lindex [args] 3]"
      }
      "massmsg" {
        if {![wmatch \\\* [lindex [args] 6]]} {
          if {![info exists massnix]} { set masscount 0 ; set massnix "" }
          incr masscount
          lappend massnix "[lindex [args] 5]"
          if {[llength $massnix] >= 80} {
            /quote privmsg [join $massnix ","] :[lrange [lindex $whoqueue 0] 2 end]
            synecho massmsg "[eheader "MassMsg"] messaging: [b]<[b][sb][join $massnix ","][sb][b]>[b] [lrange [lindex $whoqueue 0] 2 end]" status
            set massnix ""
          }
        }
      }
      "whokill" {
        if {[lindex [args] 5] != [my_nick]} {
          if {![info exists masscount]} { set masscount 0 }
          incr masscount
          /quote kill [lindex [args] 5] :[lrange [lindex $whoqueue 0] 2 end]
          synecho whokill "[eheader "WhoKill"] killing: [b][lindex [args] 5][b]([lindex [args] 2]@[lindex [args] 3]) with: [lrange [lindex $whoqueue 0] 2 end]"
        }
      }
      "who" {
        if {![info exists temp(num)]} {
          set temp(num) "0"
          if {[config whoactive]} { dsynecho who "[eheader "Server"] Displaying [b]/who [lindex [lindex $whoqueue 0] 1][b] query results..."
          } else { synecho who "[eheader "Server"] Displaying [b]/who [lindex [lindex $whoqueue 0] 1][b] query results..." status }
          if {[config whoactive]} { dsynecho who "[gboxtop]"
          } else { synecho who "[gboxtop]" status }
          if {[config whoactive]} { dsynecho who "[gboxside "[llb] [b]#[b] [lrb][llb][b]Nickname:[b] [lrb][llb][b]Hostname:[b]                           [lrb][llb][b]Server:[b]             [lrb]"]"
          } else { synecho who "[gboxside "[llb] [b]#[b] [lrb][llb][b]Nickname:[b] [lrb][llb][b]Hostname:[b]                           [lrb][llb][b]Server:[b]             [lrb]"]" status }
        }
        incr temp(num)
        set temp(mask) [string range "[lindex [args] 2]@[lindex [args] 3]" 0 39]
        set temp(serv) [string range [lindex [args] 4] 0 19]
        set temp(nick) [string range [lindex [args] 5] 0 9]
        set temp(setn) [lindex [args] 6]
        if {[ison [my_nick] [lindex [args] 1]]} { set mask([string tolower [lindex [args] 5]]) "[lindex [args] 5]![lindex [args] 2]@[lindex [args] 3]" }

        if {[config whoactive]} { dsynecho who "[gboxside "[llb][b][align $temp(num) 3][b][lrb][llb][sb][align $temp(nick) 10][sb][lrb][llb][align $temp(mask) 36][lrb][llb][align "$temp(serv)[sb]([sb][string index [lindex [args] 7] 0][sb])[sb]" 20][lrb]"]"
        } else { synecho who "[gboxside "[llb][b][align $temp(num) 3][b][lrb][llb][sb][align $temp(nick) 10][sb][lrb][llb][align $temp(mask) 36][lrb][llb][align "$temp(serv)[sb]([sb][string index [lindex [args] 7] 0][sb])[sb]" 20][lrb]"]" status }
        if {[config whoactive]} { dsynecho who "[gboxside "[llb]   [lrb][llb][align $temp(setn) 10][lrb][llb][align [string range [lindex [args] 7] 2 end] 58][lrb]"]"
        } else { synecho who "[gboxside "[llb]   [lrb][llb][align $temp(setn) 10][lrb][llb][align [string range [lindex [args] 7] 2 end] 58][lrb]"]" status }
      }
      "operscan" {
        if {[string match *\\\** [lindex [args] 6]]} {
          if {![info exists temp(num)]} {
            set temp(num) "0"
            if {[config whoactive]} { dsynecho who "[eheader "Server"] Displaying operscan results for [b][lindex [lindex $whoqueue 0] 1][b]..."
            } else { synecho who "[eheader "Server"] Displaying operscan results for [b][lindex [lindex $whoqueue 0] 1][b]..." status }
            if {[config whoactive]} { dsynecho who "[gboxtop]"
            } else { synecho who "[gboxtop]" status }
            if {[config whoactive]} { dsynecho who "[gboxside "[llb] [b]#[b] [lrb][llb][b]Nickname:[b] [lrb][llb][b]Hostname:[b]                           [lrb][llb][b]Server:[b]             [lrb]"]"
            } else { synecho who "[gboxside "[llb] [b]#[b] [lrb][llb][b]Nickname:[b] [lrb][llb][b]Hostname:[b]                           [lrb][llb][b]Server:[b]             [lrb]"]" status }
          }
          incr temp(num)
          set temp(mask) [string range "[lindex [args] 2]@[lindex [args] 3]" 0 39]
          set temp(serv) [string range [lindex [args] 4] 0 19]
          set temp(nick) [string range [lindex [args] 5] 0 9]
          set temp(setn) [lindex [args] 6]
          if {[ison [my_nick] [lindex [args] 1]]} { set mask([string tolower [lindex [args] 5]]) "[lindex [args] 5]![lindex [args] 2]@[lindex [args] 3]" }
          if {[config whoactive]} { dsynecho who "[gboxside "[llb][b][align $temp(num) 3][b][lrb][llb][sb][align $temp(nick) 10][sb][lrb][llb][align $temp(mask) 36][lrb][llb][align "$temp(serv)[sb]([sb][string index [lindex [args] 7] 0][sb])[sb]" 20][lrb]"]"
          } else { synecho who "[gboxside "[llb][b][align $temp(num) 3][b][lrb][llb][sb][align $temp(nick) 10][sb][lrb][llb][align $temp(mask) 36][lrb][llb][align "$temp(serv)[sb]([sb][string index [lindex [args] 7] 0][sb])[sb]" 20][lrb]"]" status }
        }
      }
    }
  }
}
on 315 {
  global events
  if {[info exists events(315)]} {
    foreach ev $events(315) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[info exists whoqueue]} {
    switch "[lrange [lindex $whoqueue 0] 0 0]" {
      "getstat" {
        synecho massmsg "[eheader "IALUpdate"] Address List updated for ([b][lindex [lindex $whoqueue 0] 1][b])..." status
      }
      "massmsg" {
        if {[info exists masscount]} {
          if {[llength $massnix]} {
            /quote privmsg [join $massnix ","] :$massmsg
            synecho massmsg "[eheader "MassMsg"] messaging: [b]<[b][sb][join $massnix ","][sb][b]>[b] $massmsg" status
          }
          synecho massmsg "[eheader "MassMsg"] Mass message completed... sent message to ([b]$masscount[b]) users..."
          unset massnix masscount
        } else {
          synecho massmsg "[eheader "MassMsg"] Found no users matching the given mask..."
        }
        killpipe massmsg
      }
      "whokill" {
        if {[info exists masscount]} {
          synecho whokill "[eheader "WhoKill"] Whokill completed... killed ([b]$masscount[b]) users..."
          unset masscount
        } else {
          synecho whokill "[eheader "WhoKill"] No users matching the given mask could be located..."
        }
        killpipe whokill
      }
      "operscan" {
        if {![info exists temp(num)]} { set temp(num) "0" }
        if {$temp(num)} {
          if {[config whoactive]} { dsynecho operscan "[gboxbottom]"
          } else { synecho who "[gboxbottom]" status }
        }
        if {[config whoactive]} { dsynecho operscan "[eheader "Server"] End of operscan on [b][lindex [lindex $whoqueue 0] 1][b]... [b]$temp(num)[b] opers found..."
        } else { synecho operscan "[eheader "Server"] End of operscan on [b][lindex [lindex $whoqueue 0] 1][b]... [b]$temp(num)[b] opers found..." status }
        unset temp
        killpipe operscan
      }
      "who" {
        if {![info exists temp(num)]} { set temp(num) "0" }
        if {$temp(num)} {
          if {[config whoactive]} { dsynecho who "[gboxbottom]"
          } else { synecho who "[gboxbottom]" status }
        }
        if {[config whoactive]} { dsynecho who "[eheader "Server"] End of who report for [b][lindex [lindex $whoqueue 0] 1][b]... [b]$temp(num)[b] matches found..."
        } else { synecho who "[eheader "Server"] End of who report for [b][lindex [lindex $whoqueue 0] 1][b]... [b]$temp(num)[b] matches found..." status }
        unset temp
        killpipe who
      }
    }
    set whoqueue [lrange $whoqueue 1 end]
    if {![string length $whoqueue]} { unset whoqueue }
  }
}

####
#### Events
####

on WALLOPS {
  global events
  if {[info exists events(wallops)]} {
    foreach ev $events(wallops) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[string length [nick]]} { echo "[applyuserwallopsstyle "[nick]" "[user]" "[host]" "[join [args]]"]" status
  } else { echo "[applyserverwallopsstyle "[host]" "[join [args]]"]" status }
}
on PRIVMSG {
  global events
  if {[info exists events(privmsg)]} {
    foreach ev $events(privmsg) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[nick] == [my_nick] && [join [lrange [args] 1 end]] == "."} { complete ; return }
  if {[isin [ignorez [nick]![user]@[host]] "text"]} { set hide 1
  } else { set hide 0 }
  if {![string match "#*" [lindex [args] 0]]} {
    if {!$hide} {
      set text "[join [lrange [args] 1 end]]"
      if {![config querywindows]} {
        if {[config autodecrypt] && [isencrypted $text]} {
          if {[window_type] != "status"} { echo "[applydecryptedmsgstyle "[nick]" "[user]" "[host]" "[decrypt $text]"]" }
          echo "[applydecryptedmsgstyle "[nick]" "[user]" "[host]" "[decrypt $text]"]" status
          spylink [nick] "[applydecryptedmsgstyle "[nick]" "[user]" "[host]" "[decrypt $text]"]"
        } else {
          if {[window_type] != "status"} { echo "[applymsgstyle "[nick]" "[user]" "[host]" "[join [lrange [args] 1 end]]"]" }
          echo "[applymsgstyle "[nick]" "[user]" "[host]" "[join [lrange [args] 1 end]]"]" status
          spylink [nick] "[applymsgstyle "[nick]" "[user]" "[host]" "[join [lrange [args] 1 end]]"]"
        }
      } else {
        if {[config autodecrypt] && [isencrypted $text]} {
          if {![string length [queries [nick]]]} { /query "[nick]" min }
          echo "[applydecryptedusertext "[nick]" "[decrypt $text]"]" query [nick]
          spylink [nick] "[applydecryptedusertext "[nick]" "[decrypt $text]"]"
        } else {
          if {![string length [queries [nick]]]} { /query "[nick]" min }
          echo "[applymsgusertext "[nick]" "$text"]" query [nick]
          spylink [nick] "[applymsgusertext "[nick]" "$text"]"
        }
      }
      if {[info exists away(x)] && [config awaymessagelog]} {
        set_cookie awaymsgs [expr [get_cookie awaymsgs "0"] + 1]
        logevent awaymsg m "[nick]([user]@[host]) [join [lrange [args] 1 end]]"
      }
      inc_relm "[nick]" "[user]" "[host]" "msg" "[join [lrange [args] 1 end]]"
      inc_tab "msg" "[nick]"
    } else { complete }
  } else {
    set mask([string tolower [nick]]) "[nick]![user]@[host]"
    if {![isin [ignorez [nick]![user]@[host]] "public"]} {
      set text [join [lrange [args] 1 end]]
      if {[config autodecrypt] && [isencrypted $text]} {
        echo "[applydecryptedusertext "[nick]" "[decrypt $text]"]" channel [lindex [args] 0]
        spylink [lindex [args] 0] "[applydecryptedusertext "[nick]" "[decrypt $text]"]"
      }
      if {[wmatch *[my_nick]* [join [lrange [args] 1 end]]] && [info exists away(x)] && [config awaynickcapt]} {
        set_cookie awaycapt [expr [get_cookie awaycapt "0"] + 1]
        logevent awaycapt m "[lindex [args] 0]\\[nick]([user]@[host]) [join [lrange [args] 1 end]]"
      }
      if {[config wordhilight] != "none"} {
        foreach wordy [config wordhilight] {
          set wordy \*[string trim $wordy "\*"]\*
          if {[wmatch [string tolower $wordy] [string tolower $text]]} { set xflag 1 }
        }
        if {[info exists xflag]} { spylink [lindex [args] 0] "[applyhighlighttext "[nick]" "$text"]" ; echo "[applyhighlighttext "[nick]" "$text"]" channel [lindex [args] 0] ; unset xflag
        } else { spylink [lindex [args] 0] "[applyusertext "[nick]" "$text"]" ; echo "[applyusertext "[nick]" "$text"]" channel [lindex [args] 0] }
      } else { spylink [lindex [args] 0] "[applyusertext "[nick]" "$text"]" ; echo "[applyusertext "[nick]" "$text"]" channel [lindex [args] 0] }
      if {![isprotected [nick]![user]@[host] [string tolower [lindex [args] 0]]] && [isop [my_nick] [string tolower [lindex [args] 0]]] && [chopcheck [nick] [string tolower [lindex [args] 0]]] && ![info exists haltkicks([string tolower [lindex [args] 0]]-[nick])] && [string match *n* [lindex [mode [string tolower [lindex [args] 0]]] 0]]} {
        if {[string match *w* [lindex [get_cookie cmode([string tolower [string tolower [lindex [args] 0]]])] 0]]} {
          foreach wk [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 1] {
            if {$wk != "off" && [string match [string tolower [lindex $wk 0]] [string tolower $text]]} {
              inc_violation "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]"
              set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
              /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[lindex $wk 1]"]
              set flag 1
            }
          }
        }
        if {[info exists flag]} { unset flag
        } else {
          if {[string match *o* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]] && [lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 7] 0] != "0" && [string length $text] >= [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 7]} {
            inc_violation "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]"
            set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
            /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[applytextoverflowkickmsg "[string tolower [lindex [args] 0]]" "[string length $text]" "[lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 7]"]"]
            set flag 1
          }
          if {[info exists flag]} { unset flag
          } else {
            if {[string match *t* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]] && [lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 4] 0] != "0"} {
              if {![info exists chanflood([string tolower [lindex [args] 0]]-[nick])]} { set chanflood([string tolower [lindex [args] 0]]-[nick]) "[clock seconds] 1 [string tolower [lindex [args] 0]]"
              } else { set chanflood([string tolower [lindex [args] 0]]-[nick]) "[lindex $chanflood([string tolower [lindex [args] 0]]-[nick]) 0] [expr [lindex $chanflood([string tolower [lindex [args] 0]]-[nick]) 1] + 1] [string tolower [lindex [args] 0]]" }
              if {[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 4] 0] == [lindex $chanflood([string tolower [lindex [args] 0]]-[nick]) 1]} {
                inc_violation "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]"
                set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
                /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[applytextfloodkickmsg "[string tolower [lindex [args] 0]]" "[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 4] 0]" "[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 4] 1]"]"]
                set flag 1
              }
            }
            if {[info exists flag]} { unset flag
            } else {
              if {[string match *r* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]]} {
                for { set x 5 } { $x > 0 } { set x [expr $x - 1] } {
                  if {[info exists repeat([string tolower [lindex [args] 0]]-[expr $x-1])]} {
                    if {[lindex $repeat([string tolower [lindex [args] 0]]-[expr $x-1]) 0] == [nick] && [lindex $repeat([string tolower [lindex [args] 0]]-[expr $x-1]) 1] == $text} {
                      inc_violation "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]"
                      set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
                      /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[applyrepeatkickmsg "[string tolower [lindex [args] 0]]"]"]
                      if {[info exists repeat([string tolower [lindex [args] 0]]-1)]} { unset repeat([string tolower [lindex [args] 0]]-1) }
                      if {[info exists repeat([string tolower [lindex [args] 0]]-2)]} { unset repeat([string tolower [lindex [args] 0]]-2) }
                      if {[info exists repeat([string tolower [lindex [args] 0]]-3)]} { unset repeat([string tolower [lindex [args] 0]]-3) }
                      if {[info exists repeat([string tolower [lindex [args] 0]]-4)]} { unset repeat([string tolower [lindex [args] 0]]-4) }
                      if {[info exists repeat([string tolower [lindex [args] 0]]-5)]} { unset repeat([string tolower [lindex [args] 0]]-5) }
                      set flagx 1
                      break
                    }
                    set repeat([string tolower [lindex [args] 0]]-$x) "$repeat([string tolower [lindex [args] 0]]-[expr $x-1])"
                  }
                }
              }
              if {[info exists flagx]} { unset flagx
              } else { set repeat([string tolower [lindex [args] 0]]-1) "[list [nick]] [list [string tolower $text]]" }
            }
          }
        }
      }
    }
  }
}
proc chopcheck { nick chan } {
  if {[string match *e* [lindex [get_cookie cmode([lindex [args] 0])] 0]] && [isop $nick $chan]} { return 0 }
  return 1
}
proc inc_violation { nick user host chan } {
  global violations
  set chan "[string tolower $chan]"
  if {[string match *a* [lindex [get_cookie cmode($chan)] 0]] && [lindex [get_cookie cmode($chan)] 13] != "0"} {
    if {![info exists violations($chan-$nick)]} { set violations($chan-$nick) "1"
    } else { incr violations($chan-$nick) }
    if {[lindex [get_cookie cmode($chan)] 13] >= $violations($chan-$nick)} {
      /raw mode $chan -o+b $nick [banmask 5 $nick!$user@$host]
      unset violations($chan-$nick)
    }
  }
}
proc ovecho { window text } {
  if {![string length [queries "Oper Vision"]]} { /query Oper Vision min }
  echo "[opervisiontag] $text" query Oper Vision
}

on NOTICE {
  global events
  if {[info exists events(notice)]} {
    foreach ev $events(notice) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  set args "[lindex [args] 1]"
  regsub -all {\\} $args {\\\\} args
  regsub -all {\{} $args {\{} args
  regsub -all {\}} $args {\}} args
  regsub -all {\]} $args {\]} args
  regsub -all {\[} $args {\[} args
  regsub -all {\"} $args {\"} args
  if (![string length [nick]]) {
    foreach nix [config killignorenicks] {
      if {[string match [string tolower $nix] [string tolower [split [lindex [split [join [args]]] 10]]]]} { set igflag 1 }
    }
    if {[string match "*Received*KILL*message*for*" [join [args]]] && ![wmatch "*.*" [lindex [split [join [args]]] 10]] && ![info exists igflag]} {
      if {![string length [get_cookie operkill([split [lindex [split [join [args]]] 10]])]]} { set_cookie operkilllist "[atlist "[get_cookie operkilllist ""]" "[string tolower [split [lindex [split [join [args]]] 10]]]"]" }
      set_cookie operkill([string tolower [split [lindex [split [join [args]]] 10]]]) "[expr [get_cookie operkill([string tolower [split [lindex [split [join [args]]] 10]]]) "0"] + 1]"
      if {[config viewkills]} {
        if {[config operkillactive]} {
          echo "[applyoperkillstyle "[string trimright [lindex [split [join [args]]] 8] "."]" "[lindex [split [join [args]]] 10]" "[get_cookie operkill([split [string tolower [lindex [split [join [args]]] 10]]]) "0"]" "[string range [join [lrange [split [join [args]]] 13 end]] 1 [expr [string length [join [lrange [split [join [args]]] 13 end]]] - 2]]"]"
        } else {
          echo "[applyoperkillstyle "[string trimright [lindex [split [join [args]]] 8] "."]" "[lindex [split [join [args]]] 10]" "[get_cookie operkill([split [string tolower [lindex [split [join [args]]] 10]]]) "0"]" "[string range [join [lrange [split [join [args]]] 13 end]] 1 [expr [string length [join [lrange [split [join [args]]] 13 end]]] - 2]]"]" status
        }
      }
      inc_relok "[string trimright [lindex [split [join [args]]] 8] "."]" "[lindex [split [join [args]]] 10]" "[get_cookie operkill([split [lindex [split [join [args]]] 10]]) "0"]" "[string range [join [lrange [split [join [args]]] 13 end]] 1 [expr [string length "[join [lrange [split [join [args]]] 13 end]]"] - 2]]"
    } elseif {[string match "*Too*many*recipients*" [join [args]]]} {
      synecho x "[eheader "ServerError"] Too many recipients from ([b][lindex [xserver] 0][b])..."
    } else {
      foreach server [split [config operserv]] {
        if {[string match $server [lindex [xserver] 0]]} { set flag 1 }
      }
      if {[config servervision] && ![string match "*Received*KILL*message*for*" [join $args]]} {
        echo "[servertag] [join $args]" status
      }
      if {[info exists flag] && [config opervision]} {
        unset flag
        if {[string match "*Notice*--*Client*connecting:*" [join [args]]]} {
          ovecho x "<[sb]client[sb]> Client connect: [b][lindex $args 5][b]([su][string range [lindex $args 6] 1 [expr [string length [lindex $args 6]] - 2]][su])"
        } elseif {[string match "*Notice*--*Client*exiting:*" [join [args]]]} {
          ovecho x "<[sb]client[sb]> Client disconnect: [b][lindex $args 5][b]([su][string range [lindex $args 6] 1 [expr [string length [lindex $args 6]] - 2]][su])"
        } elseif {[string match "*Notice*--*Kill*line*active*for*" [join [args]]]} {
          ovecho x "<[sb]kline[sb]> Client autokilled: [b][join [lrange [split [lindex $args 7] "\["] 0 [expr [llength [split [lindex $args 7] "\["]] - 2]] "\["][b]([su][string trim [join [lrange [split [lindex $args 7] "\["] end end]] "\]"][su])"
        } elseif {[string match "*Notice*--*Rejecting*for*too*many*clients:*" [join [args]]]} {
          ovecho x "<[sb]client[sb]> Client rejected([sb]overload[sb]): [b][lindex $args 8][b]([su][string range [lindex $args 9] 1 [expr [string length [lindex $args 9]] - 2]][su])"
        } elseif {[string match "*Global*--*from*Link*with*established*" [join [args]]]} {
          ovecho x "<[sb]connect[sb]> [ovledge][sb][string trim [lindex $args 4] ":"][sb] [ovlinkin] [sb][join [lrange [split [lindex $args 7] "\["] 0 [expr [llength [split [lindex $args 7] "\["]] - 2]] "\["][sb][b]\[[b][sb][string trim [join [lrange [split [join [lrange [split [lindex $args 7] "\["] end end]] "."] end end]] "\]"][sb][b]\][b][ovredge] link established..."
        } elseif {[string match "*Global*--*from*Server*closed*the*connection*" [join [args]]]} {
          ovecho x "<[sb]disconnect[sb]> [ovledge][sb][string trim [lindex $args 4] ":"][sb] [ovlinkbroke] [sb][join [lrange [split [lindex $args 6] "\["] 0 [expr [llength [split [lindex $args 6] "\["]] - 2]] "\["][sb][ovredge] link broken ([sb]remote server closed connection[sb])..."
        } elseif {[string match "*Global*--*no*response*from*closing*link*" [join [args]]]} {
          ovecho x "<[sb]disconnect[sb]> [ovledge][sb][lindex [xserver] 0][sb] [ovlinkbroke] [sb][join [lrange [split [lindex $args 6] "\["] 0 [expr [llength [split [lindex $args 6] "\["]] - 2]] "\["][b][ovredge] link broken ([sb]no response from remote server[sb])..."
        } elseif {[string match "*Notice*--*Write*error*to*closing*link*" [join [args]]]} {
          ovecho x "<[sb]disconnect[sb]> [ovledge][sb][lindex [xserver] 0][sb] [ovlinkbroke] [sb][join [lrange [split [lindex $args 6] "\["] 0 [expr [llength [split [lindex $args 6] "\["]] - 2]] "\["][b][ovredge] link broken ([sb]write error[sb])..."
        } elseif {[string match "*Notice*--*Connection*to*activated*" [join [args]]]} {
          ovecho x "<[sb]connect[sb]> [ovledge][sb][lindex [xserver] 0][sb] [ovlinkout] [sb][join [lrange [split [lindex $args 5] "\["] 0 [expr [llength [split [lindex $args 5] "\["]] - 2]] "\["][sb][ovredge] link established..."
        } elseif {[string match "*Notice*--*is*rehashing*Server*config*file*" [join [args]]]} {
          ovecho x "<[sb]config[sb]> [b][lindex $args 3][b] is rehashing server config file..."
        } elseif {[string match "*Global*--*from*Failed*OPER*attempt*by*" [join [args]]]} {
          ovecho x "<[sb]oper[sb]> Failed oper attempt by [b][lindex $args 9][b]([su][string range [lindex $args 10] 1 [expr [string length [lindex $args 10]] - 2]][su]) using userid [sb][lindex $args 13][sb]."
        } elseif {[string match "*Notice*--*is*now*operator*(O)*" [join [args]]]} {
          ovecho x "<[sb]oper[sb]> [b][lindex $args 3][b]([su][string range [lindex $args 4] 1 [expr [string length [lindex $args 4]] - 2]][su]) is now a global operator."
        } elseif {[string match "*Notice*--*is*now*operator*(o)*" [join [args]]]} {
          ovecho x "<[sb]oper[sb]> [b][lindex $args 3][b]([su][string range [lindex $args 4] 1 [expr [string length [lindex $args 4]] - 2]][su]) is now an operator."
        } elseif {[string match "*Notice*--*Link*with*established.*" [join [args]]]} {
          ovecho x "<[sb]connect[sb]> [ovledge][sb][lindex [xserver] 0][sb] [ovlinkout] [sb][string trim [join [lrange [split [lindex $args 5] "\["] end end]] "\]"][sb][b]\[[b][sb][string trim [join [lrange [split [join [lrange [split [lindex $args 5] "\["] end end]] "."] end end]] "\]"][sb][b]\][b][ovredge] by [b][lindex $args 10][b]..."
        } elseif {[string match "*Notice*--*Received*SQUIT*from*" [join [args]]]} {
          ovecho x "<[sb]squit[sb]> [ovledge][sb][lindex [xserver] 0][sb] [ovlinkbroke] [sb][lindex $args 5][sb][ovredge] link broken by [b][join [lrange [split [lindex $args 7] "\["] 0 [expr [llength [split [lindex $args 7] "\["]] - 2]] "\["][b]([sb][string trim [join [lrange [split [lindex $args 7] "\["] end end]] "\]"][sb]) ([sb][string range [lindex $args 8] 1 [expr [string length [lindex $args 8]] - 2]][sb])..."
        } elseif {[string match "*Global*--*Received*SQUIT*from*" [join [args]]]} {
          ovecho x "<[sb]squit[sb]> [ovledge][sb][string trim [lindex $args 4] ":"][sb] [ovlinkbroke] [sb][lindex $args 7][sb][ovredge] link broken by [b][lindex $args 9][b] ([sb][string range [lindex $args 10] 1 [expr [string length [lindex $args 10]] - 2]][sb])..."
        } elseif {[string match "*Global*--*Remote*CONNECT*from*" [join [args]]]} {
          ovecho x "<[sb]connect[sb]> [ovledge][sb][string trim [lindex $args 4] ":"][sb] [ovlinkout] [sb][lindex $args 7][sb][b]\[[b][sb][lindex $args 8][sb][b]\][b][ovredge] by [b][lindex $args 10][b]..."
        } elseif {[string match "*Global*--*from*ERROR*from*--*Terminated*by*" [join [args]]]} {
          ovecho x "<[sb]terminated[sb]> [b][string trim [lindex $args 4] ":"][b] recieved error from server [b][string trim [join [lrange [split [lindex $args 5] "\["] end end]] "\]"][b] -- Terminated by [b][join [lrange [split [lindex $args 12] "\["] 0 [expr [llength [split [lindex $args 12] "\["]] - 2]] "\["][b]..."
        } elseif {[string match "*Notice*--*ERROR*:from*--*Server*already*exists*" [join [args]]]} {
          ovecho x "<[sb]error[sb]> Error recieved from [b][string trim [join [lrange [split [lindex $args 5] "\["] end end]] "\]"][b] -- Server [b][lindex $args 8][b] already exists..."
        } elseif {[string match "*Notice*--*ERROR*:from*--*Closing*Link:*" [join [args]]]} {
          ovecho x "<[sb]error[sb]> Error recieved from [b][string trim [join [lrange [split [lindex $args 5] "\["] end end]] "\]"][b] -- Closing link: [join [lrange $args 9 end]]"
        } elseif {[string match "*Global*--*from*ERROR*from*--*" [join [args]]]} {
          ovecho x "<[sb]error[sb]> [b][string trim [lindex $args 4] ":"][b] recieved error from server [b][string trim [join [lrange [split [lindex $args 5] "\["] end end]] "\]"][b] -- [join [lrange $args 9 end]]"
        } elseif {[string match "*Global*--*from*" [join [args]]]} {
          ovecho x "<[sb]globalops[sb]> ([b][string trim [lindex $args 4] ":"][b]) [join [lrange $args 5 end]]"
        }
      }
      #getport: [string trim [join [lrange [split [join [lrange [split xxxxxxx "\["] end end]] "."] end end]] "\]"]
      #gethost: [string trim [join [lrange [split xxxxxx "\["] end end]] "\]"]
      #getnick: [join [lrange [split [lindex $args 6] "\["] 0 [expr [llength [split [lindex $args 6] "\["]] - 2]] "\["]
    }
    if {[info exists igflag]} { unset igflag }
  } else {
    set text "[lindex [args] 1]"
    regsub -all {\\} $text {\\\\} text
    regsub -all {\{} $text {\{} text
    regsub -all {\}} $text {\}} text
    regsub -all {\]} $text {\]} text
    regsub -all {\[} $text {\[} text
    regsub -all {\"} $text {\"} text
    if {[isin [ignorez [nick]![user]@[host]] "text"]} { set hide 1
    } else { set hide 0 }
    if {[info exists away(x)] && [config awaymessagelog] && !$hide && ![string match "#*" [lindex [args] 0]]} {
      set_cookie awaymsgs [expr [get_cookie awaymsgs "0"] + 1]
      logevent awaymsg n "[nick]([user]@[host]) [join [lrange [args] 1 end]]"
    }
    if {![string match "#*" [lindex [args] 0]] && !$hide} {
      if {[config wallformat]} {
        if {([string match *wall* [string tolower [strip [join [lrange $text 0 3]]]]] || [string match *op* [string tolower [strip [join [lrange $text 0 3]]]]] || [string match *@* [join [lrange $text 0 3]]]) && ([string match *#* [join [lrange $text 0 3]]])} {
          set fromchan ""
          foreach chann [channels] {
            if {[string match *[string tolower $chann]* [string tolower [strip [join [lrange $text 0 3]]]]] || [string match *[string tolower $chann]* [string tolower [strip [lindex $text 1]]]]} { set fromchan "$chann" }
          }
          if {[string length $fromchan]} {
            if {[window_type] != "status"} { echo "[applywallopprefix "$fromchan"][applynoticestyle "[nick]" "[user]" "[host]" "[join [lrange [args] 1 end]]"]" channel $fromchan }
            echo "[applywallopprefix "$fromchan"][applynoticestyle "[nick]" "[user]" "[host]" "[join [lrange [args] 1 end]]"]" status
            spylink [nick] "[applynoticestyle "[nick]" "[user]" "[host]" "[join [lrange [args] 1 end]]"]"
          } else {
            if {[window_type] != "status"} { echo "[applywallopprefix "???"][applynoticestyle "[nick]" "[user]" "[host]" "[join [lrange [args] 1 end]]"]" }
            echo "[applywallopprefix "???"][applynoticestyle "[nick]" "[user]" "[host]" "[join [lrange [args] 1 end]]"]" status
            spylink [nick] "[applynoticestyle "[nick]" "[user]" "[host]" "[join [lrange [args] 1 end]]"]"
          }

        } else {
          if {[window_type] != "status"} { echo "[applynoticestyle "[nick]" "[user]" "[host]" "[join [lrange [args] 1 end]]"]" }
          echo "[applynoticestyle "[nick]" "[user]" "[host]" "[join [lrange [args] 1 end]]"]" status
          spylink [nick] "[applynoticestyle "[nick]" "[user]" "[host]" "[join [lrange [args] 1 end]]"]"
        }
      } else {
        if {[window_type] != "status"} { echo "[applynoticestyle "[nick]" "[user]" "[host]" "[join [lrange [args] 1 end]]"]" }
        echo "[applynoticestyle "[nick]" "[user]" "[host]" "[join [lrange [args] 1 end]]"]" status
        spylink [nick] "[applynoticestyle "[nick]" "[user]" "[host]" "[join [lrange [args] 1 end]]"]"
      }
      inc_relm "[nick]" "[user]" "[host]" "notice" "[join [lrange [args] 1 end]]"
      inc_tab "notice" "[nick]"
    } elseif {!$hide} {
      set mask([string tolower [nick]]) "[nick]![user]@[host]"
      echo "[applycnoticestyle "[nick]" "[user]" "[host]" "[lindex [args] 0]" "[join [lrange [args] 1 end]]"]" channel [lindex [args] 0]
      echo "[applycnoticestyle "[nick]" "[user]" "[host]" "[lindex [args] 0]" "[join [lrange [args] 1 end]]"]" status
      spylink [lindex [args] 0] "[applycnoticestyle "[nick]" "[user]" "[host]" "[lindex [args] 0]" "[join [lrange [args] 1 end]]"]"
    }
    set text "[join [lrange [args] 1 end]]"
    if {![isprotected [nick]![user]@[host] [lindex [args] 0]] && [isop [my_nick] [lindex [args] 0]] && [chopcheck [nick] [lindex [args] 0]] && ![info exists haltkicks([lindex [args] 0]-[nick])] && [string match *n* [lindex [mode [lindex [args] 0]] 0]]} {
      if {[string match *w* [lindex [get_cookie cmode([string tolower [string tolower [lindex [args] 0]]])] 0]]} {
        foreach wk [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 1] {
          if {$wk != "off" && [string match [string tolower [lindex $wk 0]] [string tolower $text]]} {
            inc_violation "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]"
            set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
            /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[lindex $wk 1]"]
            set flag 1
          }
        }
      }
      if {[info exists flag]} { unset flag
      } else {
        if {[string match *o* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]] && [lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 7] 0] != "0" && [string length $text] >= [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 7]} {
          inc_violation "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]"
          set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
          /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[applytextoverflowkickmsg "[string tolower [lindex [args] 0]]" "[string length $text]" "[lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 7]"]"]
          set flag 1
        }
        if {[info exists flag]} { unset flag
        } else {
          if {[string match *t* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]] && [lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 4] 0] != "0"} {
            if {![info exists chanflood([string tolower [lindex [args] 0]]-[nick])]} { set chanflood([string tolower [lindex [args] 0]]-[nick]) "[clock seconds] 1 [string tolower [lindex [args] 0]]"
            } else { set chanflood([string tolower [lindex [args] 0]]-[nick]) "[lindex $chanflood([string tolower [lindex [args] 0]]-[nick]) 0] [expr [lindex $chanflood([string tolower [lindex [args] 0]]-[nick]) 1] + 1] [string tolower [lindex [args] 0]]" }
            if {[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 4] 0] == [lindex $chanflood([string tolower [lindex [args] 0]]-[nick]) 1]} {
              inc_violation "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]"
              set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
              /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[applytextfloodkickmsg "[string tolower [lindex [args] 0]]" "[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 4] 0]" "[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 4] 1]"]"]
              set flag 1
            }
          }
          if {[info exists flag]} { unset flag
          } else {
            if {[string match *r* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]]} {
              for { set x 5 } { $x > 0 } { set x [expr $x - 1] } {
                if {[info exists repeat([string tolower [lindex [args] 0]]-[expr $x-1])]} {
                  if {[lindex $repeat([string tolower [lindex [args] 0]]-[expr $x-1]) 0] == [nick] && [lindex $repeat([string tolower [lindex [args] 0]]-[expr $x-1]) 1] == $text} {
                    inc_violation "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]"
                    set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
                    /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[applyrepeatkickmsg "[string tolower [lindex [args] 0]]"]"]
                    if {[info exists repeat([string tolower [lindex [args] 0]]-1)]} { unset repeat([string tolower [lindex [args] 0]]-1) }
                    if {[info exists repeat([string tolower [lindex [args] 0]]-2)]} { unset repeat([string tolower [lindex [args] 0]]-2) }
                    if {[info exists repeat([string tolower [lindex [args] 0]]-3)]} { unset repeat([string tolower [lindex [args] 0]]-3) }
                    if {[info exists repeat([string tolower [lindex [args] 0]]-4)]} { unset repeat([string tolower [lindex [args] 0]]-4) }
                    if {[info exists repeat([string tolower [lindex [args] 0]]-5)]} { unset repeat([string tolower [lindex [args] 0]]-5) }
                    set flagx 1
                    break
                  }
                  set repeat([string tolower [lindex [args] 0]]-$x) "$repeat([string tolower [lindex [args] 0]]-[expr $x-1])"
                }
              }
            }
            if {[info exists flagx]} { unset flagx
            } else { set repeat([string tolower [lindex [args] 0]]-1) "[list [nick]] [list [string tolower $text]]" }
          }
        }
      }
    }
  }
}
on CTCP {
  global events
  if {[info exists events(ctcp)]} {
    foreach ev $events(ctcp) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[string toupper [lindex [args] 1]] == "ACTION"} {
    if {[string match "#*" [lindex [args] 0]]} {
      set mask([string tolower [nick]]) "[nick]![user]@[host]"
      if {![isin [ignorez [nick]![user]@[host]] "public"]} {
        set text [join [lrange [args] 2 end]]
        if {[config wordhilight] != "none"} {
          foreach wordy [config wordhilight] {
            set wordy \*[string trim $wordy "\*"]\*
            if {[wmatch [string tolower $wordy] [string tolower $text]]} { set xflag 1 }
          }
          if {[info exists xflag]} { spylink [lindex [args] 0] "[applyhighlightaction "[nick]" "$text"]" ; echo "[applyhighlightaction "[nick]" "$text"]" channel [lindex [args] 0] ; unset xflag
          } else { spylink [lindex [args] 0] "[applyuseraction "[nick]" "$text"]" ; echo "[applyuseraction "[nick]" "$text"]" channel [lindex [args] 0] }
        } else { spylink [lindex [args] 0] "[applyuseraction "[nick]" "$text"]" ; echo "[applyuseraction "[nick]" "$text"]" channel [lindex [args] 0] }
        if {[string match *[my_nick]* [join [lrange [args] 2 end]]] && [info exists away(x)] && [config awaynickcapt]} {
          set_cookie awaycapt [expr [get_cookie awaycapt "0"] + 1]
          logevent awaycapt c "[nick]([user]@[host]) [lindex [args] 0]\\[nick]([user]@[host]) * [nick] [join [lrange [args] 2 end]]"
        }
        set text "[join [lrange [args] 2 end]]"
        if {![isprotected [nick]![user]@[host] [string tolower [lindex [args] 0]]] && [isop [my_nick] [string tolower [lindex [args] 0]]] && [chopcheck [nick] [string tolower [lindex [args] 0]]] && ![info exists haltkicks([string tolower [lindex [args] 0]]-[nick])] && [string match *n* [lindex [mode [string tolower [lindex [args] 0]]] 0]]} {
          if {[string match *w* [lindex [get_cookie cmode([string tolower [string tolower [lindex [args] 0]]])] 0]]} {
            foreach wk [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 1] {
              if {$wk != "off" && [string match [string tolower [lindex $wk 0]] [string tolower $text]]} {
                inc_violation "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]"
                set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
                /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[lindex $wk 1]"]
                set flag 1
              }
            }
          }
          if {[info exists flag]} { unset flag
          } else {
            if {[string match *o* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]] && [lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 7] 0] != "0" && [string length $text] >= [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 7]} {
              inc_violation "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]"
              set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
              /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[applytextoverflowkickmsg "[string tolower [lindex [args] 0]]" "[string length $text]" "[lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 7]"]"]
              set flag 1
            }
            if {[info exists flag]} { unset flag
            } else {
              if {[string match *t* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]] && [lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 4] 0] != "0"} {
                if {![info exists chanflood([string tolower [lindex [args] 0]]-[nick])]} { set chanflood([string tolower [lindex [args] 0]]-[nick]) "[clock seconds] 1 [string tolower [lindex [args] 0]]"
                } else { set chanflood([string tolower [lindex [args] 0]]-[nick]) "[lindex $chanflood([string tolower [lindex [args] 0]]-[nick]) 0] [expr [lindex $chanflood([string tolower [lindex [args] 0]]-[nick]) 1] + 1] [string tolower [lindex [args] 0]]" }
                if {[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 4] 0] == [lindex $chanflood([string tolower [lindex [args] 0]]-[nick]) 1]} {
                  inc_violation "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]"
                  set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
                  /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[applytextfloodkickmsg "[string tolower [lindex [args] 0]]" "[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 4] 0]" "[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 4] 1]"]"]
                  set flag 1
                }
              }
              if {[info exists flag]} { unset flag
              } else {
                if {[string match *r* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]]} {
                  for { set x 5 } { $x > 0 } { set x [expr $x - 1] } {
                    if {[info exists repeat([string tolower [lindex [args] 0]]-[expr $x-1])]} {
                      if {[lindex $repeat([string tolower [lindex [args] 0]]-[expr $x-1]) 0] == [nick] && [lindex $repeat([string tolower [lindex [args] 0]]-[expr $x-1]) 1] == $text} {
                        inc_violation "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]"
                        set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
                        /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[applyrepeatkickmsg "[string tolower [lindex [args] 0]]"]"]
                        if {[info exists repeat([string tolower [lindex [args] 0]]-1)]} { unset repeat([string tolower [lindex [args] 0]]-1) }
                        if {[info exists repeat([string tolower [lindex [args] 0]]-2)]} { unset repeat([string tolower [lindex [args] 0]]-2) }
                        if {[info exists repeat([string tolower [lindex [args] 0]]-3)]} { unset repeat([string tolower [lindex [args] 0]]-3) }
                        if {[info exists repeat([string tolower [lindex [args] 0]]-4)]} { unset repeat([string tolower [lindex [args] 0]]-4) }
                        if {[info exists repeat([string tolower [lindex [args] 0]]-5)]} { unset repeat([string tolower [lindex [args] 0]]-5) }
                        set flagx 1
                        break
                      }
                      set repeat([string tolower [lindex [args] 0]]-$x) "$repeat([string tolower [lindex [args] 0]]-[expr $x-1])"
                    }
                  }
                }
                if {[info exists flagx]} { unset flagx
                } else { set repeat([string tolower [lindex [args] 0]]-1) "[list [nick]] [list [string tolower $text]]" }
              }
            }
          }
        }
      }
    } elseif {![isin [ignorez [nick]![user]@[host]] "text"]} {
      if {[info exists away(x)] && [config awaymessagelog]} {
        set_cookie awaymsgs [expr [get_cookie awaymsgs "0"] + 1]
        logevent awaymsg a "[nick]([user]@[host]) [nick]([user]@[host]) * [nick] [join [lrange [args] 2 end]]"
      }
      if {![config querywindows]} {
        if {[window_type] != "status"} { echo "[applyactionstyle "[nick]" "[user]" "[host]" "[join [lrange [args] 2 end]]"]" status }
        echo "[applyactionstyle "[nick]" "[user]" "[host]" "[join [lrange [args] 2 end]]"]"
        spylink [lindex [args] 0] "[applyactionstyle "[nick]" "[user]" "[host]" "[join [lrange [args] 2 end]]"]"
      } else {
        if {![string length [queries [nick]]]} { /query "[nick]" min }
        echo "[applymsguseraction "[nick]" "[join [lrange [args] 2 end]]"]" query [nick]
        spylink [lindex [args] 0] "[applymsguseraction "[nick]" "[join [lrange [args] 2 end]]"]"
      }
      inc_relm "[nick]" "[user]" "[host]" "msg" "* [nick] [join [lrange [args] 2 end]]"
      inc_tab "msg" "[nick]"
    }
  } else {
    if {[string match "#*" [lindex [args] 0]]} { set rep "[applycctcpstyle "[nick]" "[user]" "[host]" "[lindex [args] 0]" "[string toupper [lindex [args] 1]]" "[join [lrange [args] 2 end]]"]"
    } else { set rep "[applyctcpstyle "[nick]" "[user]" "[host]" "[string toupper [lindex [args] 1]]" "[join [lrange [args] 2 end]]"]" }
    set text [join [args]]
    regsub -all {\\} $text {\\\\} text
    regsub -all {\{} $text {\{} text
    regsub -all {\}} $text {\}} text
    regsub -all {\]} $text {\]} text
    regsub -all {\[} $text {\[} text
    regsub -all {\"} $text {\"} text
    if {[info exists cloak]} { set reply 0 ; set extra " [b]([b]CTCP Cloak Enabled[b])[b]"
    } elseif {[isin [ignorez [nick]![user]@[host]] "ctcp"] && [string tolower [lindex $text 1]] != "dcc" && [string tolower [lindex $text 1]] != "xdcc"} { set reply 0 ; set extra " [b]([b]Ignored[b])[b]" ; if {[config hideigctcp]} { set nodisplay "1" }
    } elseif {[isin [ignorez [nick]![user]@[host]] "dcc"] && [string tolower [lindex $text 1]] == "dcc"} { set reply 0 ; set extra " [b]([b]Ignored[b])[b]" ; if {[config hideigctcp]} { set nodisplay "1" }
    } elseif {[string tolower [lindex $text 1]] == "pass"} {
      if {![isuser [nick]![user]@[host]]} { set reply 0 ; set extra " [b]([b]No Access[b])[b]"
      } elseif {![string length [lindex $text 2]]} { set reply 0 ; set extra " [b]([b]Not Enough Arguments[b])[b]"
      } elseif {[string length [lindex [gusersettings [nick]![user]@[host]] 3]]} { set reply 0 ; set extra " [b]([b]Pass Already Set[b])[b]"
      } else { set reply 1 ; set nodisplay 1 ; echo "[applyctcpstyle "[nick]" "[user]" "[host]" "PASS" "????"]" status }
    } elseif {[string tolower [lindex $text 1]] == "newpass"} {
      if {![isuser [nick]![user]@[host]]} { set reply 0 ; set extra " [b]([b]No Access[b])[b]"
      } elseif {![string length [lindex [gusersettings [nick]![user]@[host]] 3]]} { set reply 0 ; set extra " [b]([b]No Password Set[b])[b]"
      } elseif {![string length [lindex $text 3]]} { set reply 0 ; set extra " [b]([b]Not Enough Arguments[b])[b]"
      } elseif {[lindex $text 2] != [lindex [gusersettings [nick]![user]@[host]] 3]} { set reply 0 ; set extra " [b]([b]Invalid Password[b])[b]"
      } else { set reply 1 ; set nodisplay 1 ; echo "[applyctcpstyle "[nick]" "[user]" "[host]" "NEWPASS" "???? ????"]" status }
    } elseif {[string tolower [lindex $text 1]] == "inv" || [string tolower [lindex $text 1]] == "invite"} {
      if {![string match *i* [lindex [usersettings [nick]![user]@[host] [lindex $text 3]] 1]]} { set reply 0 ; set extra " [b]([b]No Access[b])[b]"
      } elseif {![string length [lindex $text 3]]} { set reply 0 ; set extra " [b]([b]Not Enough Arguments[b])[b]"
      } elseif {[lindex $text 2] != [lindex [usersettings [nick]![user]@[host] [lindex $text 3]] 3]} { set reply 0 ; set extra " [b]([b]Invalid Password[b])[b]"
      } else { set reply 1 ; set nodisplay 1 ; echo "[applyctcpstyle "[nick]" "[user]" "[host]" "INVITE" "???? [lindex $text 3]"]" status }
    } elseif {[string tolower [lindex $text 1]] == "chops"} {
      if {![string match *c* [lindex [usersettings [nick]![user]@[host] [lindex $text 3]] 1]]} { set reply 0 ; set extra " [b]([b]No Access[b])[b]"
      } elseif {![string length [lindex $text 3]]} { set reply 0 ; set extra " [b]([b]Not Enough Arguments[b])[b]"
      } elseif {[lindex $text 2] != [lindex [usersettings [nick]![user]@[host] [lindex $text 3]] 3]} { set reply 0 ; set extra " [b]([b]Invalid Password[b])[b]"
      } else { set reply 1 ; set nodisplay 1 ; echo "[applyctcpstyle "[nick]" "[user]" "[host]" "CHOPS" "???? [lindex $text 3]"]" status }
    } elseif {[string tolower [lindex $text 1]] == "op"} {
      if {![string match *o* [lindex [usersettings [nick]![user]@[host] [lindex $text 3]] 1]]} { set reply 0 ; set extra " [b]([b]No Access[b])[b]"
      } elseif {![string length [lindex $text 3]]} { set reply 0 ; set extra " [b]([b]Not Enough Arguments[b])[b]"
      } elseif {[lindex $text 2] != [lindex [usersettings [nick]![user]@[host] [lindex $text 3]] 3]} { set reply 0 ; set extra " [b]([b]Invalid Password[b])[b]"
      } else { set reply 1 ; set nodisplay 1 ; echo "[applyctcpstyle "[nick]" "[user]" "[host]" "OP" "???? [lindex $text 3]"]" status }
    } elseif {[string tolower [lindex $text 1]] == "help"} {
      if {![string length [lindex [gusersettings [nick]![user]@[host]] 1]]} { set reply 0 ; set extra " [b]([b]No Access[b])[b]"
      } else { set reply 1 ; set extra "" }
    } elseif {[string tolower [lindex $text 1]] == "acc"} {
      if {![string length [lindex [gusersettings [nick]![user]@[host]] 1]]} { set reply 0 ; set extra " [b]([b]No Access[b])[b]"
      } else { set reply 1 ; set extra "" }
    } elseif {[string tolower [lindex $text 1]] == "unban"} {
      if {![string match *u* [lindex [usersettings [nick]![user]@[host] [lindex $text 3]] 1]]} { set reply 0 ; set extra " [b]([b]No Access[b])[b]"
      } elseif {![string length [lindex $text 3]]} { set reply 0 ; set extra " [b]([b]Not Enough Arguments[b])[b]"
      } elseif {[lindex $text 2] != [lindex [usersettings [nick]![user]@[host] [lindex $text 3]] 3]} { set reply 0 ; set extra " [b]([b]Invalid Password[b])[b]"
      } else { set reply 1 ; set nodisplay 1 ; echo "[applyctcpstyle "[nick]" "[user]" "[host]" "UNBAN" "???? [lindex $text 3]"]" status }
    } elseif {[string tolower [lindex $text 1]] == "ping"} { if {![isnum [lindex $text 2]] || [string length [join [lrange $text 2 end]]] > 21} { set reply 0 ; set extra " [b]([b]Invalid Ping[b])[b]" } else { set reply 1 ; set extra "" }
    } elseif {[string tolower [lindex $text 1]] == "page"} { if {![info exists away(x)] || ![config awaypager]} { set reply 0 ; set extra " [b]([b]Invalid Page[b])[b]" } else { set reply 1 ; set extra "" }
    } else { set reply 1 ; set extra "" }
    if {[info exists nodisplay]} { unset nodisplay
    } else { echo "${rep}$extra" status }
    if {$reply} {
      if {[string tolower [lindex [args] 1]] == "version"} {
        /raw notice [nick] :\001VERSION [retversion]\001
      } elseif {[string tolower [lindex $text 1]] == "pass"} {
        set host "[guserlistmask [nick]![user]@[host]]"
        set_cookie user($host) "[list "[lindex [get_cookie user($host)] 0]"] [list "[lindex [get_cookie user($host)] 1]"] [list "[lindex [get_cookie user($host)] 2]"] [list "[lindex $text 2]"] [list "[lindex [get_cookie user($host)] 4]"]"
        /raw notice [nick] :(syntax) Password now set to '[lindex $text 2]'...
      } elseif {[string tolower [lindex $text 1]] == "acc"} {
        /raw notice [nick] :(syntax) Your access modes are currently '[lindex [gusersettings [nick]![user]@[host]] 1]'...
      } elseif {[string tolower [lindex $text 1]] == "help"} {
        /raw notice [nick] :(syntax) CTCP Command help menu (access([lindex [gusersettings [nick]![user]@[host]] 1])
        set comm "pass newpass acc"
        if {[string match *o* [lindex [gusersettings [nick]![user]@[host]] 1]]} { append comm " op" }
        if {[string match *i* [lindex [gusersettings [nick]![user]@[host]] 1]]} { append comm " inv" }
        if {[string match *u* [lindex [gusersettings [nick]![user]@[host]] 1]]} { append comm " unban" }
        if {[string match *c* [lindex [gusersettings [nick]![user]@[host]] 1]]} { append comm " chops" }
        /raw notice [nick] :(syntax) You have access to the following commands: $comm
        /raw notice [nick] :(syntax) All commands are accessed via: /ctcp [my_nick] <command> <pass> <channel>
        unset comm
      } elseif {[string tolower [lindex $text 1]] == "newpass"} {
        set host "[guserlistmask [nick]![user]@[host]]"
        set_cookie user($host) "[list "[lindex [get_cookie user($host)] 0]"] [list "[lindex [get_cookie user($host)] 1]"] [list "[lindex [get_cookie user($host)] 2]"] [list "[lindex $text 3]"] [list "[lindex [get_cookie user($host)] 4]"]"
        /raw notice [nick] :(syntax) Password changed to '[lindex $text 3]'...
      } elseif {[string tolower [lindex $text 1]] == "op"} {
        if {![ison [my_nick] [lindex $text 3]]} { /raw notice [nick] :(syntax) I am not currently on [lindex $text 3]...
        } elseif {![ison [nick] [lindex $text 3]]} { /raw notice [nick] :(syntax) You are not currently on [lindex $text 3]...
        } elseif {[isop [nick] [lindex $text 3]]} { /raw notice [nick] :(syntax) You are already oped on [lindex $text 3]...
        } else { /raw mode [lindex $text 3] +o [nick] ; /raw notice [nick] :(syntax) Oping you on [lindex $text 3]... }
      } elseif {[string tolower [lindex $text 1]] == "inv" || [string tolower [lindex $text 1]] == "invite"} {
        if {![ison [my_nick] [lindex $text 3]]} { /raw notice [nick] :(syntax) I am not currently on [lindex $text 3]...
        } else { /inv [nick] [lindex $text 3] }
      } elseif {[string tolower [lindex $text 1]] == "unban"} {
        global banlist
        if {![info exists banlist([lindex $text 3])]} { set banlist([lindex $text 3]) "" }
        if {![ison [my_nick] [lindex $text 3]]} { /raw notice [nick] :(syntax) I am not currently on [lindex $text 3]...
        } elseif {![string length $banlist([lindex $text 3])]} { /raw notice [nick] :(syntax) There are currently no bans set on [lindex $text 3]...
        } else { /unban [lindex $text 3] [nick]![user]@[host] }
      } elseif {[string tolower [lindex $text 1]] == "chops"} {
        if {![ison [my_nick] [lindex $text 3]]} { /raw notice [nick] :(syntax) I am not currently on [lindex $text 3]...
        } else { /raw notice [nick] :(syntax) Channel ops on [lindex $text 3] are currently (( [join [clist +o [lindex $text 3]] ","] ))...  }
      } elseif {[string tolower [lindex $text 1]] == "page"} { mmplay page.wav ; synecho x "[eheader "Pager"] [b]You are being paged by [nick]...[b]"
      } elseif {[string tolower [lindex $text 1]] == "ping"} { /raw notice [nick] :\001PING [lrange $text 2 end]\001}
    }
  }
  if {![info exists reply]} { set reply 0 }
  if {[string tolower [lindex [args] 1]] == "dcc" && $reply} { unset reply
  } else { set completectcp "1" }
}
on JOIN {
  global events
  if {[info exists events(join)]} {
    foreach ev $events(join) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[nick] == [my_nick]} {
    if {[config personallog]} { logevent personal j "You have joined channel [join [args]]..." }
    noidle
    lappend hasjoined "[join [args]]"
    synecho x "Now talking in [b][join [args]][b]..." status
    if {![info exists banqueue]} { set banqueue "" }
    lappend banqueue "ignore"
    if {[config joinialupdate]} {
      if {![info exists whoqueue]} { set whoqueue "" }
      lappend whoqueue "getstat [join [args]]"
      /raw who [join [args]]
    }
  } else {
    if {[config userlog]} { logevent user j "[nick]([user]@[host]) has joined channel [join [args]]..." }
    set mask([string tolower [nick]]) "[nick]![user]@[host]"
    set tempp [usersettings [nick]![user]@[host] [join [args]]]
    if {[string match *o* [lindex $tempp 1]] && [string match *p* [lindex [get_cookie cmode([string tolower [join [args]]])] 0]]} {
      echo "[applyaopjoinstyle "[nick]" "[user]" "[host]" "[string tolower [join [args]]]"]" channel [join [args]]
      spylink [string tolower [join [args]]] "[applyaopjoinstyle "[nick]" "[user]" "[host]" "[join [args]]"]"
      if {[isop [my_nick] [string tolower [join [args]]]]} {
        if {[string length [lindex $tempp 2]] && [string tolower [lindex $tempp 2]] != "none"} { echo "[applyselftext "[my_nick]" "([nick]) [join [lindex $tempp 2]]"]" channel [string tolower [join [args]]] ; /quote privmsg [string tolower [join [args]]] :([nick]) [lindex $tempp 2] }
        /raw mode [string tolower [join [args]]] +o [nick]
      }
    } elseif {[string match *b* [lindex $tempp 1]]} {
      echo "[applyakickjoinstyle "[nick]" "[user]" "[host]" "[string tolower [join [args]]]"]" channel [join [args]]
      spylink [string tolower [join [args]]] "[applyakickjoinstyle "[nick]" "[user]" "[host]" "[join [args]]"]"
      if {[isop [my_nick] [string tolower [join [args]]]]} {
        /raw mode [string tolower [join [args]]] -o+b [nick] [userlistmask [nick]![user]@[host] [string tolower [join [args]]]]
        if {[string length [lindex $tempp 2]] && [string tolower [lindex $tempp 2]] != "none"} { /raw kick [string tolower [join [args]]] [nick] :[kickstyle "AutoKick: [lindex $tempp 2]"]
        } else { /raw kick [string tolower [join [args]]] [nick] :[kickstyle "AutoKick"] }
      }
    } elseif {[string match *v* [lindex $tempp 1]]} {
      echo "[applyavoicejoinstyle "[nick]" "[user]" "[host]" "[string tolower [join [args]]]"]" channel [join [args]]
      spylink [string tolower [join [args]]] "[applyavoicejoinstyle "[nick]" "[user]" "[host]" "[join [args]]"]"
      if {[isop [my_nick] [string tolower [join [args]]]]} {
        if {[string length [lindex $tempp 2]] && [string tolower [lindex $tempp 2]] != "none"} { echo "[applyselftext "[my_nick]" "([nick]) [join [lindex $tempp 2]]"]" channel [string tolower [join [args]]] ; /quote privmsg [string tolower [join [args]]] :([nick]) [lindex $tempp 2] }
        /raw mode [string tolower [join [args]]] +v [nick]
      }
    } else {
      if {![isprotected [nick]![user]@[host] [string tolower [join [args]]]] && [isop [my_nick] [string tolower [join [args]]]] && ![info exists haltkicks([string tolower [join [args]]]-[nick])]} {
        if {[string match *l* [lindex [get_cookie cmode([string tolower [join [args]]])] 0]]} {
          if {[lindex [get_cookie cmode([string tolower [join [args]]])] 12] == "off"} {
            set haltkicks([string tolower [join [args]]]-[nick]) "1"
            /raw mode [string tolower [join [args]]] -o+b [nick] [banmask 5 [nick]![user]@[host]]
            /raw kick [string tolower [join [args]]] [nick] :[kickstyle "Access Denied"]
          } else {
            set haltkicks([string tolower [join [args]]]-[nick]) "1"
            /raw mode [string tolower [join [args]]] -o+b [nick] [banmask 5 [nick]![user]@[host]]
            /raw kick [string tolower [join [args]]] [nick] :[kickstyle "[lindex [get_cookie cmode([string tolower [join [args]]])] 12]"]
          }
        } elseif {[string match *j* [lindex [get_cookie cmode([string tolower [join [args]]])] 0]] && [lindex [lindex [get_cookie cmode([string tolower [join [args]]])] 10] 0] != "0"} {
          if {![info exists joinflood([string tolower [join [args]]]-[host])]} { set joinflood([string tolower [join [args]]]-[host]) "[clock seconds] 1 [string tolower [join [args]]]"
          } elseif {$joinflood([string tolower [join [args]]]-[host]) != "HALT"} { set joinflood([string tolower [join [args]]]-[host]) "[lindex $joinflood([string tolower [join [args]]]-[host]) 0] [expr [lindex $joinflood([string tolower [join [args]]]-[host]) 1] + 1] [string tolower [join [args]]]" }
          if {[lindex [lindex [get_cookie cmode([string tolower [join [args]]])] 10] 0] == [lindex $joinflood([string tolower [join [args]]]-[host]) 1]} {
            set bann ""
            /raw mode [string tolower [join [args]]] +b [banmask 3 [nick]![user]@[host]]
            lappend filterkickqueue "[clock seconds] [string tolower [join [args]]] [banmask 3 [nick]![user]@[host]]"
          }
        }
      }
      if { [config jpqstatus] } {
        echo "[applyjoinstyle "[nick]" "[user]" "[host]" "[join [args]]"]" status
      } else {
        echo "[applyjoinstyle "[nick]" "[user]" "[host]" "[join [args]]"]" channel [join [args]]
      }
      spylink [string tolower [join [args]]] "[applyjoinstyle "[nick]" "[user]" "[host]" "[join [args]]"]"
      set lastkick([string tolower [join [args]]]) "[nick]"
    }
  }
}
on PART {
  global events relaytext
  if {[info exists events(part)]} {
    foreach ev $events(part) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[nick] == [my_nick]} {
    if {[config personallog]} { logevent personal p "You have left channel [join [args]]..." }
    noidle
    synecho x "You have left [b][join [args]][b]..." status
    
    /flush_log [join [args]]
  } else {
    if {[config userlog]} { logevent user p "[nick]([user]@[host]) has parted channel [join [args]]..." }
    if { [config jpqstatus] } {
      echo "[applypartstyle "[nick]" "[user]" "[host]" "[join [args]]"]" status
    } else {
      echo "[applypartstyle "[nick]" "[user]" "[host]" "[join [args]]"]" channel [join [args]]
    }
    spylink [join [args]] "[applypartstyle "[nick]" "[user]" "[host]" "[join [args]]"]"
    addseen "[nick]" "part" "[nick]![user]@[host]" "[join [args]]" "x" "[string tolower [clock format [clock seconds] -format "%m/%d/%y at %I:%M:%S%p"]]"
    clearmask "[nick]"
    if {[llength [nicks [join [args]]]] == "2" && [config gainops] && ![isop [my_nick] [join [args]]]} { synecho x "[eheader "GainOps"] AutoCycling [b][join [args]][b] to regain ops..." ; /cycle [join [args]] }
  }
}
alias js {
  if {"[lindex [args] 0]" == "?"} { /help js ; complete ; return }
  if {![info exists jumpserver]} {
    synecho js "[eheader "Jump"] No servers to jump to..."
  } else {
    synecho js "[eheader "Jump"] Jumping to server [b]$jumpserver[b]..."
    /server $jumpserver
  }
  killpipe js
  noidle
  complete
}
on QUIT {
  global events
  if {[info exists events(quit)]} {
    foreach ev $events(quit) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  set text [join [args]]
  regsub -all {\\} $text {\\\\} text
  regsub -all {\{} $text {\{} text
  regsub -all {\}} $text {\}} text
  regsub -all {\]} $text {\]} text
  regsub -all {\[} $text {\[} text
  regsub -all {\"} $text {\"} text
  if {([config activelinklooker]) && ([string match "*.com" [lindex $text 0]] || [string match "*.net" [lindex $text 0]] || [string match "*.org" [lindex $text 0]]) && ([string match "*.com" [lindex $text 1]] || [string match "*.net" [lindex $text 1]] || [string match "*.org" [lindex $text 1]]) && (![info exists lastsplit] || ([lindex $text 1] != $lastsplit))} {
    synecho x "[eheader "Netsplit"] Netsplit detected: ([sb][lindex $text 0][sb] [ovlinkbroke] [sb][lindex $text 1][sb])..." status
    if {[llength "[split "[lindex $text 1]" "*"]"] <= 1} { synecho x "[eheader "Netsplit"] Type /js to jump to [b][lindex $text 1][b]..." status ; set jumpserver [lindex $text 1] }
    set lastsplitx "[lindex $text 1]"
  }
  set done 0
  foreach chan [string tolower [channels]] {
    if {[ison [nick] $chan]} {
      spylink $chan "[applyquitstyle "[nick]" "[user]" "[host]" "$chan" "[join [args]]"]"
      if { !$done } {
        if { [config jpqstatus] } {
          set done 1
          echo "[applyquitstyle "[nick]" "[user]" "[host]" "$chan" "[join [args]]"]" status
        } else {
          echo "[applyquitstyle "[nick]" "[user]" "[host]" "$chan" "[join [args]]"]" channel $chan
        }
      }
      if {[info exists lastsplitx]} {
        synecho x "[eheader "Netsplit"] Netsplit detected: ([sb][lindex $text 0][sb] [ovlinkbroke] [sb][lindex $text 1][sb])..." channel $chan
        synecho x "[eheader "Netsplit"] Type [sb]/js[sb] to jump to [b][lindex $text 1][b]..." channel $chan
      }
      if {[string match *h* [lindex [get_cookie cmode($chan)] 0]] && [string match *.* [lindex $text 0]] && [string match *.* [lindex $text 1]] && [isop [nick] $chan]} {
        if {![info exists netjoin($chan)]} { set netjoin($chan) "" }
        lappend netjoin($chan) "[nick]"
      }
      if {[info exists haltkicks($chan-[nick])]} { unset haltkicks($chan-[nick]) }
      if {[llength [nicks $chan]] == "2" && [config gainops] && ![isop [my_nick] $chan]} { synecho x "[eheader "GainOps"] AutoCycling [b]$chan[b] to regain ops..." ; /cycle $chan }
    }
  }
  if {[info exists lastsplitx]} {
    set lastsplit $lastsplitx
    unset lastsplitx
  }
  if {[config userlog]} { logevent user q "[nick]([user]@[host]) has quit irc with message ([join [args]])..." }
  addseen "[nick]" "quit" "[nick]![user]@[host]" "x" "[join [args]]" "[string tolower [clock format [clock seconds] -format "%m/%d/%y at %I:%M:%S%p"]]"
  clearmask "[nick]"
}
on NICK {
  global events
  if {[info exists events(nick)]} {
    foreach ev $events(nick) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[nick] == [my_nick]} {
    if {[config personallog]} { logevent personal n "You have switched nicknames from [nick] to [join [args]]..." }
    echo "[applysnickstyle "[nick]" "[user]" "[host]" "[join [args]]"]" status
    if {[info exists regainnick] && "[join [args]]" == "$regainnick"} {
      synecho x "[eheader "NickRegain"] Nick regain suscessful... Regained nickname ([b]$regainnick[b])..."
      if {[info exists regtogg]} { unset regtogg }
      unset regainnick
    }
  } else {
    if {[config userlog]} { logevent user n "[nick]([user]@[host]) has changed nickname to [join [args]]..." }
    clearmask "[nick]"
    set mask([string tolower [join [args]]]) "[join [args]]![user]@[host]"
  }
  foreach chan [string tolower [channels]] {
    if {[nick] == [my_nick]} { echo "[applysnickstyle "[nick]" "[user]" "[host]" "[join [args]]"]" channel $chan
    } else {
      if {[ison [nick] $chan]} {
        echo "[applynickstyle "[nick]" "[user]" "[host]" "[join [args]]"]" channel $chan
        spylink $chan "[applynickstyle "[nick]" "[user]" "[host]" "[join [args]]"]"
        if {[info exists vioflood($chan-[nick])]} { set vioflood($chan-[join [args]]) "$vioflood($chan-[nick])" ; unset vioflood($chan-[nick]) }
        if {[info exists chanflood($chan-[nick])]} { set chanflood($chan-[join [args]]) "$chanflood($chan-[nick])" ; unset chanflood($chan-[nick]) }
        if {[info exists massdeopprot($chan-[nick])]} { set massdeopprot($chan-[join [args]]) "$massdeopprot($chan-[nick])" ; unset massdeopprot($chan-[nick]) }
        if {[info exists masskickprot($chan-[nick])]} { set masskickprot($chan-[join [args]]) "$masskickprot($chan-[nick])" ; unset masskickprot($chan-[nick]) }
        if {[info exists haltkicks($chan-[nick])]} { set haltkicks($chan-[join [args]]) "$haltkicks($chan-[nick])" ; unset haltkicks($chan-[nick]) }
        if {[info exists nickflood($chan-[nick])]} { set nickflood($chan-[join [args]]) "$nickflood($chan-[nick])" ; unset nickflood($chan-[nick]) }
        if {![isprotected [join [args]]![user]@[host] $chan] && [string match *n* [lindex [get_cookie cmode($chan)] 0]] && [lindex [lindex [get_cookie cmode($chan)] 6] 0] != "0" && [isop [my_nick] $chan] && ![info exists haltkicks($chan-[join [args]])]} {
          if {![info exists nickflood($chan-[join [args]])]} { set nickflood($chan-[join [args]]) "[clock seconds] 1 $chan"
          } elseif {$nickflood($chan-[join [args]]) != "HALT"} { set nickflood($chan-[join [args]]) "[lindex $nickflood($chan-[join [args]]) 0] [expr [lindex $nickflood($chan-[join [args]]) 1] + 1] $chan" }
          if {[lindex [lindex [get_cookie cmode($chan)] 6] 0] == [lindex $nickflood($chan-[join [args]]) 1]} {
            inc_violation "[nick]" "[user]" "[host]" "$chan"
            set haltkicks($chan-[join [args]]) "1"
            /raw kick $chan [join [args]] :[kickstyle "[applynickfloodkickmsg "$chan" "[lindex [lindex [get_cookie cmode($chan)] 6] 0]" "[lindex [lindex [get_cookie cmode($chan)] 6] 1]"]"]
          }
        }
      }
    }
  }
}
on KICK {
  global events
  if {[info exists events(kick)]} {
    foreach ev $events(kick) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[nick] == [my_nick]} { if {[config personallog]} { logevent personal k "You kicked [lindex [args] 1] off of channel [lindex [args] 0] with reason ([join [lrange [args] 2 end]])..." } ; noidle }
  if {[lindex [args] 1] == [my_nick]} {
    if {[config personallog]} { logevent personal k "You were kicked off [lindex [args] 0] by [nick]([user]@[host]) with reason ([join [lrange [args] 2 end]])..." }
    if {[config userlog]} { logevent user k "[nick]([user]@[host]) has kicked YOU off of [lindex [args] 0] with reason ([join [lrange [args] 2 end]])..." }
    echo "[applyskickstyle "[nick]" "[user]" "[host]" "[lindex [args] 0]" "[join [lrange [args] 2 end]]"]" status
    echo "[applyskickstyle "[nick]" "[user]" "[host]" "[lindex [args] 0]" "[join [lrange [args] 2 end]]"]" channel [lindex [args] 0]
    spylink [lindex [args] 0] "[applyskickstyle "[nick]" "[user]" "[host]" "[lindex [args] 0]" "[join [lrange [args] 2 end]]"]"
    if {[config autokickmenu]} { set rejkick([string tolower [lindex [args] 0]]) "[split [nick]] [expr [clock seconds] + 60] 1" }
    foreach nick [nicks [lindex [join [args]] 0]] { set nick [string trimleft $nick "@+"] ; clearmask "$nick" }
    if {[config autorejoin]} {
      if {[string length [lindex [get_cookie chkey([string tolower [lindex [args] 0]])] 0]]} {
        synecho x "[eheader "AutoRejoin"] Rejoining Channel: [b][lindex [args] 0][b] ([b]AutoKey:[b] [join [lindex [get_cookie chkey([string tolower [lindex [args] 0]])] 0]])" status
        /raw join [lindex [args] 0] [join [get_cookie chkey([string tolower [lindex [args] 0]])]]
      } else {
        synecho x "[eheader "AutoRejoin"] Rejoining Channel: [b][lindex [args] 0][b]" status
        /raw join [lindex [args] 0]
      }
    }
  } else {
    addseen "[lindex [args] 1]" "kick" "[lindex [args] 1]" "[lindex [args] 0]" "[join [lrange [args] 2 end]]" "[string tolower [clock format [clock seconds] -format "%m/%d/%y at %I:%M:%S%p"]]" "[nick]![user]@[host]"
    echo "[applykickstyle "[nick]" "[user]" "[host]" "[lindex [args] 0]" "[lindex [args] 1]" "[join [lrange [args] 2 end]]"]" channel [lindex [args] 0]
    spylink [string tolower [lindex [args] 0]] "[applykickstyle "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]" "[lindex [args] 1]" "[join [lrange [args] 2 end]]"]"
    if {[config userlog]} { logevent user k "[nick]([user]@[host]) has kicked [lindex [args] 1] off of [string tolower [lindex [args] 0]] with reason ([join [lrange [args] 2 end]])..." }
    if {[isprotected [getmask [lindex [args] 1]] [string tolower [lindex [args] 0]]] == "2" && [nick] != [my_nick] && [nick] != [lindex [args] 1]} {
      /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "Protected User"]
    } elseif {[isprotected [getmask [lindex [args] 1]] [string tolower [lindex [args] 0]]] == "3" && [nick] != [my_nick] && [nick] != [lindex [args] 1]} {
      /raw mode [string tolower [lindex [args] 0]] -o+b [nick] [banmask 5 [nick]![user]@[host]][lf]kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "Protected User"]
    }
    if {![isprotected [nick]![user]@[host] [string tolower [lindex [args] 0]]] && [string match *k* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]] && [lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 9] 0] != "0" && [isop [my_nick] [string tolower [lindex [args] 0]]] && ![info exists haltkicks([string tolower [lindex [args] 0]]-[nick])] && [nick] != [my_nick]} {
      if {![info exists masskickprot([string tolower [lindex [args] 0]]-[nick])]} { set masskickprot([string tolower [lindex [args] 0]]-[nick]) "[clock seconds] 1 [string tolower [lindex [args] 0]]"
      } elseif {$masskickprot([string tolower [lindex [args] 0]]-[nick]) != "HALT"} { set masskickprot([string tolower [lindex [args] 0]]-[nick]) "[lindex $masskickprot([string tolower [lindex [args] 0]]-[nick]) 0] [expr [lindex $masskickprot([string tolower [lindex [args] 0]]-[nick]) 1] + 1] [string tolower [lindex [args] 0]]" }
      if {[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 9] 0] == [lindex $masskickprot([string tolower [lindex [args] 0]]-[nick]) 1]} {
        /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[applymasskickkickmsg "[string tolower [lindex [args] 0]]" "[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 9] 0]" "[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 9] 1]"]"]
        set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
      }
    }
    if {[info exists vioflood([string tolower [lindex [args] 0]]-[lindex [args] 1])]} { unset vioflood([string tolower [lindex [args] 0]]-[lindex [args] 1]) }
    if {[info exists chanflood([string tolower [lindex [args] 0]]-[lindex [args] 1])]} { unset chanflood([string tolower [lindex [args] 0]]-[lindex [args] 1]) }
    if {[info exists massdeopprot([string tolower [lindex [args] 0]]-[lindex [args] 1])]} { unset massdeopprot([string tolower [lindex [args] 0]]-[lindex [args] 1]) }
    if {[info exists masskickprot([string tolower [lindex [args] 0]]-[lindex [args] 1])]} { unset masskickprot([string tolower [lindex [args] 0]]-[lindex [args] 1]) }
    if {[info exists haltkicks([string tolower [lindex [args] 0]]-[lindex [args] 1])]} { unset haltkicks([string tolower [lindex [args] 0]]-[lindex [args] 1]) }
    if {[info exists joinflood([string tolower [lindex [args] 0]]-[lindex [args] 1])]} { unset joinflood([string tolower [lindex [args] 0]]-[lindex [args] 1]) }
    if {[info exists nickflood([string tolower [lindex [args] 0]]-[lindex [args] 1])]} { unset nickflood([string tolower [lindex [args] 0]]-[lindex [args] 1]) }
    clearmask "[lindex [args] 1]"
  }
}
on TOPIC {
  global events
  if {[info exists events(topic)]} {
    foreach ev $events(topic) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[nick] == [my_nick]} {
    noidle
    if {[config personallog]} { logevent personal t "You topic on [lindex [args] 0] to ([join [lrange [args] 1 end]])..." }
  } else {
    if {[config userlog]} { logevent user t "[nick]([user]@[host]) has set topic on [lindex [args] 0] to ([join [lrange [args] 1 end]])..." }
    if {[lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 3] != "off" && [string match *c* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]] && "[join [lrange [args] 1 end]]" != "[lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 3]"} {
      if {![isprotected [nick]![user]@[host] [string tolower [lindex [args] 0]]] && [string match *v* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]] && [lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 5] 0] != "0" && [isop [my_nick] [string tolower [lindex [args] 0]]] && ![info exists haltkicks([string tolower [lindex [args] 0]]-[nick])]} {
        if {![info exists vioflood([string tolower [lindex [args] 0]]-[nick])]} { set vioflood([string tolower [lindex [args] 0]]-[nick]) "[clock seconds] 1"
        } else { set vioflood([string tolower [lindex [args] 0]]-[nick]) "[lindex $vioflood([string tolower [lindex [args] 0]]-[nick]) 0] [expr [lindex $vioflood([string tolower [lindex [args] 0]]-[nick]) 1] + 1]" }
        if {[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 5] 0] == [lindex $vioflood([string tolower [lindex [args] 0]]-[nick]) 1]} {
          set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
          inc_violation "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]"
          /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[applyviolationfloodkickmsg "[string tolower [lindex [args] 0]]" "[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 5] 0]" "[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 5] 1]"]"]
        }
      }
      /quote topic [lindex [args] 0] :[lindex [get_cookie cmode([lindex [args] 0])] 3]
    }
  }
  echo "[applytopicstyle "[nick]" "[user]" "[host]" "[lindex [args] 0]" "[join [lrange [args] 1 end]]"]" channel [lindex [args] 0]
  spylink [lindex [args] 0] "[applytopicstyle "[nick]" "[user]" "[host]" "[lindex [args] 0]" "[join [lrange [args] 1 end]]"]"
  set mask([string tolower [nick]]) "[nick]![user]@[host]"
  if {[window get_title channel [lindex [args] 0]] != "[applychannelwindow [lindex [args] 0] [mode [lindex [args] 0]] [cmode [lindex [args] 0]] [join [lrange [args] 1 end]]]"} {
    window set_title "[applychannelwindow [lindex [args] 0] [mode [lindex [args] 0]] [cmode [lindex [args] 0]] [join [lrange [args] 1 end]]]" channel [lindex [args] 0]
  }
}
on MODE-O {
  if {[config personallog] && [my_nick] == [lindex [args] 1]} { logevent personal o "You were deoped on [string tolower [lindex [args] 0]] by [nick]([user]@[host])..." }
  if {[isprotected [getmask [lindex [args] 1]] [string tolower [lindex [args] 0]]] == "2" && [nick] != [my_nick] && [nick] != [lindex [args] 1]} {
    /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "Protected User"][lf]mode [string tolower [lindex [args] 0]] +o [lindex [args] 1]
  } elseif {[isprotected [getmask [lindex [args] 1]] [string tolower [lindex [args] 0]]] == "3" && [nick] != [my_nick] && [nick] != [lindex [args] 1]} {
    /raw mode [string tolower [lindex [args] 0]] +ob-o [lindex [args] 1] [banmask 5 [nick]![user]@[host]] [nick][lf]kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "Protected User"]
  }
  if {![isprotected [getmask [lindex [args] 1]] [string tolower [lindex [args] 0]]] && [string match *d* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]] && [lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 8] 0] != "0" && [isop [my_nick] [string tolower [lindex [args] 0]]] && ![info exists haltkicks([string tolower [lindex [args] 0]]-[nick])] && [nick] != [my_nick]} {
    if {![info exists massdeopprot([string tolower [lindex [args] 0]]-[nick])]} { set massdeopprot([string tolower [lindex [args] 0]]-[nick]) "[clock seconds] 1 [string tolower [lindex [args] 0]]"
    } elseif {$massdeopprot([string tolower [lindex [args] 0]]-[nick]) != "HALT"} { set massdeopprot([string tolower [lindex [args] 0]]-[nick]) "[lindex $massdeopprot([string tolower [lindex [args] 0]]-[nick]) 0] [expr [lindex $massdeopprot([string tolower [lindex [args] 0]]-[nick]) 1] + 1] [string tolower [lindex [args] 0]]" }
    if {[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 8] 0] == [lindex $massdeopprot([string tolower [lindex [args] 0]]-[nick]) 1]} {
      /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[applymassdeopkickmsg "[string tolower [lindex [args] 0]]" "[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 8] 0]" "[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 8] 1]"]"]
      set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
    }
  }
}
on MODE+O {
  if {[config personallog] && [my_nick] == [lindex [args] 1]} { logevent personal o "You were oped on [string tolower [lindex [args] 0]] by [nick]([user]@[host])..." }
  if {[info exists rejkick([string tolower [string tolower [lindex [args] 0]]])] && [lindex $rejkick([string tolower [string tolower [lindex [args] 0]]]) 2] && [lindex [args] 1] == [my_nick]} {
    set rejkick([string tolower [string tolower [lindex [args] 0]]]) "[split [lindex $rejkick([string tolower [string tolower [lindex [args] 0]]]) 0]] [split [lindex $rejkick([string tolower [string tolower [lindex [args] 0]]]) 1]] 0"
    synecho x "[eheader "AutoKick"] AutoKick Target: [b][lindex $rejkick([string tolower [string tolower [lindex [args] 0]]]) 0][b]" channel [string tolower [lindex [args] 0]]
    synecho x "[eheader "AutoKick"] (([u]Shift[u][b]F1[b])) AutoKick" channel [string tolower [lindex [args] 0]]
    synecho x "[eheader "AutoKick"] (([u]Shift[u][b]F2[b])) AutoKickBan" channel [string tolower [lindex [args] 0]]
    synecho x "[eheader "AutoKick"] (([u]Shift[u][b]F3[b])) AutoDeop" channel [string tolower [lindex [args] 0]]
  }
  if {[string match *d* [lindex [usersettings [getmask [lindex [args] 1]] [string tolower [lindex [args] 0]]] 1]]} {
    /raw mode [string tolower [lindex [args] 0]] -o [lindex [args] 1]
  }
  if {![string length [nick]] && [string match *h* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]]} {
    if {[info exists netjoin([string tolower [lindex [args] 0]])] && ![isin $netjoin([string tolower [lindex [args] 0]]) [lindex [args] 1]]} {
      lappend noway([string tolower [lindex [args] 0]]) "[lindex [args] 1]"
    } elseif {![info exists netjoin([string tolower [lindex [args] 0]])]} {
      lappend noway([string tolower [lindex [args] 0]]) "[lindex [args] 1]"
    } else {
      set netjoin([string tolower [lindex [args] 0]]) "[rflist $netjoin([string tolower [lindex [args] 0]]) [lindex [args] 1]]"
      if {![string length $netjoin([string tolower [lindex [args] 0]])]} { unset netjoin([string tolower [lindex [args] 0]]) }
    }
  }
}
on MODE+B {
  if {![info exists banlist([string tolower [lindex [args] 0]])]} { set banlist([string tolower [lindex [args] 0]]) "" }
  if {[config personallog] && [wmatch [lindex [args] 1] [my_nick]![my_user]@[my_host]]} { logevent personal b "[nick]([user]@[host]) banned YOU on [string tolower [lindex [args] 0]] with mask ([lindex [args] 1])..." }
  if {[config userlog] && [wmatch [lindex [args] 1] [my_nick]![my_user]@[my_host]]} { logevent user b "[nick]([user]@[host]) banned YOU on [string tolower [lindex [args] 0]] with mask ([lindex [args] 1])..." }
  if {[nick] != [my_nick] && [isop [my_nick] [string tolower [lindex [args] 0]]] && [wmatch [lindex [args] 1] [my_nick]![my_user]@[my_host]] && [config selfbanprot]} {
    if {[string length [nick]]} {
      synecho x "[eheader "BanProtect"] Conflicting banmask ([b][lindex [args] 1][b]) set by [b][nick][b]..." channel [string tolower [lindex [args] 0]]
      /raw mode [string tolower [lindex [args] 0]] -ob+b [nick] [lindex [args] 1] [banmask 5 [getmask [nick]]]
      /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "Conflicting Banmask ([lindex [args] 1])"]
    } else {
      synecho x "[eheader "BanProtect"] Conflicting banmask ([b][lindex [args] 1][b]) set by [b][host][b]..." channel [string tolower [lindex [args] 0]]
      /raw mode [string tolower [lindex [args] 0]] -b [lindex [args] 1]
    }
  } elseif {![wmatch [lindex [args] 1] [my_nick]![my_user]@[my_host]] && [lindex [args] 1] != "*!*@*" && [lindex [args] 1] != "*!*?@*" && ![isprotected [lindex [args] 1] [string tolower [lindex [args] 0]]] && [string match *b* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]] && [isop [my_nick] [string tolower [lindex [args] 0]]]} {
    set bann ""
    foreach niq [rflist [clist all [string tolower [lindex [args] 0]]] [my_nick]] { if {[wmatch [lindex [args] 1] [getmask $niq]]} { append bann "$niq," } }
    if {[string length $bann]} { skick noban [string tolower [lindex [args] 0]] [string trimright $bann ","] Banned }
  }
  set banlist([string tolower [lindex [args] 0]]) [atlist $banlist([string tolower [lindex [args] 0]]) [lindex [args] 1]]
}
on MODE-B {
  if {[config personallog] && [wmatch [lindex [args] 1] [my_nick]![my_user]@[my_host]]} { logevent personal k "[nick]([user]@[host]) unbanned YOU on [string tolower [lindex [args] 0]] with mask ([lindex [args] 1])..." }
  if {[config userlog] && [wmatch [lindex [args] 1] [my_nick]![my_user]@[my_host]]} { logevent user b "[nick]([user]@[host]) unbanned YOU on [string tolower [lindex [args] 0]] with mask ([lindex [args] 1])..." }
  if {![info exists banlist([string tolower [lindex [args] 0]])]} { set banlist([string tolower [lindex [args] 0]]) "" }
  set banlist([string tolower [lindex [args] 0]]) [rflist $banlist([string tolower [lindex [args] 0]]) [lindex [args] 1]]
}
on MODE-K {
  synecho x "Saving key info for [b][string tolower [lindex [args] 0]][b]\[[sb]none[sb]\]..." status
  set_cookie chkey([string tolower [lindex [args] 0]]) ""
  set_cookie chankeys "[rflist [get_cookie chankeys ""] [string tolower [lindex [args] 0]]]"
}
on MODE+K {
  synecho x "Saving key info for [b][string tolower [lindex [args] 0]][b]\[[sb][lindex [args] 1][sb]\]..." status
  set_cookie chkey([string tolower [lindex [args] 0]]) "[list [split [lindex [args] 1]]] [list [string tolower [clock format [clock seconds] -format "%m/%d/%y at %I:%M:%S%p"]]]"
  set_cookie chankeys "[rflist [get_cookie chankeys ""] [string tolower [lindex [args] 0]]]"
  set_cookie chankeys "[atlist [get_cookie chankeys ""] [string tolower [lindex [args] 0]]]"
}
proc ismodeviolation { mode mask } {
  set modr ""
  set mod ""
  set totl ""
  foreach mod [split $mode ""] {
    if {$mod == "+"} { set modr "+"
    } elseif {$mod == "-"} { set modr "-"
    } else {
      lappend totl "$modr$mod"
    }
  }
  foreach mod [split $mask ""] {
    if {$mod == "+"} { set modr "-"
    } elseif {$mod == "-"} { set modr "+"
    } else {
      if {[isin $totl "$modr$mod"]} { return 1 }
    }
  }
  return 0
}
on MODE {
  global events
  if {[info exists events(mode)]} {
    foreach ev $events(mode) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  set text [join [lrange [args] 1 end]]
  regsub -all {\\} $text {\\\\} text
  regsub -all {\{} $text {\{} text
  regsub -all {\}} $text {\}} text
  regsub -all {\]} $text {\]} text
  regsub -all {\[} $text {\[} text
  regsub -all {\"} $text {\"} text
  if {[nick] == [my_nick]} { noidle
    if {[config personallog]} { logevent personal m "You set mode on [lindex [args] 0] ([join [lrange [args] 1 end]])..." }
  } elseif {[nick] == ""} {
    if {[lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 2] != "off" && [string match *m* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]] && [ismodeviolation "[lindex $text 0]" "[lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 2]"]} {
      /quote mode [string tolower [lindex [args] 0]] :[lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 2]
    }
  } else {
    if {[config userlog]} { logevent user m "[nick]([user]@[host]) set mode on [string tolower [lindex [args] 0]] ([join [lrange [args] 1 end]])..." }
    if {[lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 2] != "off" && [string match *m* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]] && [ismodeviolation "[lindex $text 0]" "[lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 2]"]} {
      if {![isprotected [nick]![user]@[host] [string tolower [lindex [args] 0]]] && [string match *v* [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 0]] && [lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 5] 0] != "0" && [isop [my_nick] [string tolower [lindex [args] 0]]] && ![info exists haltkicks([string tolower [lindex [args] 0]]-[nick])]} {
        if {![info exists vioflood([string tolower [lindex [args] 0]]-[nick])]} { set vioflood([string tolower [lindex [args] 0]]-[nick]) "[clock seconds] 1 [string tolower [lindex [args] 0]]"
        } else { set vioflood([string tolower [lindex [args] 0]]-[nick]) "[lindex $vioflood([string tolower [lindex [args] 0]]-[nick]) 0] [expr [lindex $vioflood([string tolower [lindex [args] 0]]-[nick]) 1] + 1] [string tolower [lindex [args] 0]]" }
        if {[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 5] 0] == [lindex $vioflood([string tolower [lindex [args] 0]]-[nick]) 1]} {
          set haltkicks([string tolower [lindex [args] 0]]-[nick]) "1"
          inc_violation "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]"
          /raw kick [string tolower [lindex [args] 0]] [nick] :[kickstyle "[applyviolationfloodkickmsg "[string tolower [lindex [args] 0]]" "[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 5] 0]" "[lindex [lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 5] 1]"]"]
        }
      }
      /quote mode [string tolower [lindex [args] 0]] :[lindex [get_cookie cmode([string tolower [lindex [args] 0]])] 2]
    }
  }
  if {[nick] == ""} {
    echo "[applysmodestyle "[host]" "[string tolower [lindex [args] 0]]" "[join [lrange [args] 1 end]]"]" channel [string tolower [lindex [args] 0]]
    spylink [string tolower [lindex [args] 0]] "[applysmodestyle "[host]" "[string tolower [lindex [args] 0]]" "[join [lrange [args] 1 end]]"]"
  } else {
    set mask([string tolower [nick]]) "[nick]![user]@[host]"
    echo "[applymodestyle "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]" "[join [lrange [args] 1 end]]"]" channel [string tolower [lindex [args] 0]]
    spylink [string tolower [lindex [args] 0]] "[applymodestyle "[nick]" "[user]" "[host]" "[string tolower [lindex [args] 0]]" "[join [lrange [args] 1 end]]"]"
  }
  set lastmode([string tolower [string tolower [lindex [args] 0]]]) "[join [lrange [args] 1 end]]"
  set fmode "[sortby [modmode "[lindex [mode [string tolower [lindex [args] 0]]] 0]" [lindex $text 0]] "[modesortorder]"]"
  set getkey "1"
  set getlim "1"
  set index "0"
  foreach modd [split [lindex $text 0] ""] {
    if {$modd == "+"} { set modden "+" }
    if {$modd == "-"} { set modden "-" }
    if {$modd == "k" && $modden == "+"} { incr index ; append fmode " [lindex $text $index]" ; set getkey 0
    } elseif {$modd == "k" && $modden == "-"} { set getkey 0 }
    if {$modd == "l" && $modden == "+"} { incr index ; append fmode " [lindex $text $index]" ; set getlim 0
    } elseif {$modd == "l" && $modden == "-"} { set getlim 0 }
  }
  if {[string length [getkey [string tolower [lindex [args] 0]]]] && $getkey} { append fmode " [getkey [string tolower [lindex [args] 0]]]" }
  if {[string length [getlimit [string tolower [lindex [args] 0]]]] && $getlim} { append fmode " [getlimit [string tolower [lindex [args] 0]]]" }
  if {[window get_title channel [string tolower [lindex [args] 0]]] != "[applychannelwindow [string tolower [lindex [args] 0]] $fmode [cmode [string tolower [lindex [args] 0]]] [topic [string tolower [lindex [args] 0]]]]"} {
    window set_title "[applychannelwindow [string tolower [lindex [args] 0]] $fmode [cmode [string tolower [lindex [args] 0]]] [topic [string tolower [lindex [args] 0]]]]" channel [string tolower [lindex [args] 0]]
  }
}

on load {
  set offline_timer 0 ; set offline_server 1
}

on CTCP_REPLY {
  global events
  if {[info exists events(ctcp_reply)]} {
    foreach ev $events(ctcp_reply) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[isin [ignorez [nick]![user]@[host]] "ctcp"] && [config hideigctcp]} {
  } else {
    if {[string toupper [lindex [args] 1]] == "PING" && [isnum [lindex [args] 2]]} {
      set pingrep "[expr [clock clicks] - [lindex [args] 2]]"
      if {![string length [string range $pingrep 0 [expr [string length $pingrep] - 4]]]} { set sect1 0
      } else { set sect1 "[string range $pingrep 0 [expr [string length $pingrep] - 4]]" }
      if {![string length [string range $pingrep [expr [string length $pingrep] - 3] end]]} { set sect2 000
      } else { set sect2 "[string range $pingrep [expr [string length $pingrep] - 3] end]" }
      if {[config ctcprepactive] && [window_type] != "status"} { echo "[applyctcprstyle "[nick]" "[user]" "[host]" "[string toupper [lindex [args] 1]]" "$sect1\.$sect2 secs"]" }
      echo "[applyctcprstyle "[nick]" "[user]" "[host]" "[string toupper [lindex [args] 1]]" "$sect1\.$sect2 secs"]" status
      unset sect1 sect2
      killpipe ping
    } else {
      if {[config ctcprepactive] && [window_type] != "status"} { echo "[applyctcprstyle "[nick]" "[user]" "[host]" "[string toupper [lindex [args] 1]]" "[join [lrange [args] 2 end]]"]" }
      echo "[applyctcprstyle "[nick]" "[user]" "[host]" "[string toupper [lindex [args] 1]]" "[join [lrange [args] 2 end]]"]" status
      if {[string toupper [lindex [args] 1]] == "VERSION"} { killpipe ver }
    }
  }
  killpipe ctcp
}
on ERROR {
  global events
  if {[info exists events(error)]} {
    foreach ev $events(error) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[string match "*Closing Link*" [split [join [args]] " "]]} { synecho x "[eheader "Break"] You have been disconnected from [b][lindex [server] 0][b] [join [lrange [split [join [args]] " "] 3 end]]"
  } else { echo "Error: [args]" }
}
on INVITE {
  global events
  if {[info exists events(invite)]} {
    foreach ev $events(invite) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![isin [ignorez [nick]![user]@[host]] "invite"]} {
    set lastinvite [lindex [args] 1] ; synecho x "[eheader "Invite"] [nick] invites you to join [b][lindex [args] 1][b] -- Type /ji to join"
    if {[config personallog]} { logevent personal i "You were invited to join [lindex [args] 0] by [nick]([user]@[host])..." }
  }
}
on LOOKUP {
  global events
  if {[info exists events(lookup)]} {
    foreach ev $events(lookup) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[info exists dnsqueue] && [lrange [lindex $dnsqueue 0] 1 1] == [lindex [args] 0]} {
    if {[lrange [lindex $dnsqueue 0] 0 0] == "wkill"} {
      if {![string length [lindex [args] 1]] && ![isin [ignorez *!*@[lindex [args] 0]] "other"]} { synecho x "[eheader "WinKill"] Winkill attempt detected from ([b][lindex [args] 0][b])..."
      } elseif {![isin [ignorez *!*@[lindex [args] 0]] "other"] && ![isin [ignorez *!*@[lindex [args] 1]] "other"]} { synecho x "[eheader "WinKill"] Winkill attempt detected from ([b][lindex [args] 1][b]([lindex [args] 0]))..." }
    } elseif {[lrange [lindex $dnsqueue 0] 0 0] == "scan"} {
      if {![string length [lindex [args] 1]] && ![isin [ignorez *!*@[lindex [args] 0]] "other"]} { synecho x "[eheader "PortScan"] Portscanning detected from ([b][lindex [args] 0][b])..."
      } elseif {![isin [ignorez *!*@[lindex [args] 0]] "other"] && ![isin [ignorez *!*@[lindex [args] 1]] "other"]} { synecho x "[eheader "PortScan"] Portscanning detected from ([b][lindex [args] 1][b]([lindex [args] 0]))..." }
    } elseif {[lrange [lindex $dnsqueue 0] 0 0] == "resolveserv"} {
      if {![string length [lindex [args] 1]]} { set realserver "[lindex [args] 0]"
      } else { set realserver "[lindex [args] 1]" }
    } elseif {[lrange [lindex $dnsqueue 0] 0 0] == "scheck"} {
      set nn "[lrange [lindex $dnsqueue 0] 2 2]"
      if {![info exists scheck($nn)]} {
        if {![string length [lindex [args] 1]] && [isip [lindex [args] 0]]} {
          set scheck($nn) "[list [lindex [args] 0]] [list "Unknown"] [lrange [lindex $dnsqueue 0] 3 3]"
        } elseif {![string length [lindex [args] 1]] && ![isip [lindex [args] 0]]} {
          set scheck($nn) "[list "Unknown"] [list [lindex [args] 0]] [lrange [lindex $dnsqueue 0] 3 3]"
        } elseif {[isip [lindex [args] 0]]} {
          set scheck($nn) "[list [lindex [args] 0]] [list [lindex [args] 1]] [lrange [lindex $dnsqueue 0] 3 3]"
        } elseif {[isip [lindex [args] 1]]} {
          set scheck($nn) "[list [lindex [args] 1]] [list [lindex [args] 0]] [lrange [lindex $dnsqueue 0] 3 3]"
        }
      } elseif {![info exists sxcheck($nn)]} {
        if {![string length [lindex [args] 1]] && [isip [lindex [args] 0]]} {
          set sxcheck($nn) "[list [lindex [args] 0]] [list "Unknown"] [lrange [lindex $dnsqueue 0] 3 3]"
        } elseif {![string length [lindex [args] 1]] && ![isip [lindex [args] 0]]} {
          set sxcheck($nn) "[list "Unknown"] [list [lindex [args] 0]] [lrange [lindex $dnsqueue 0] 3 3]"
        } elseif {[isip [lindex [args] 0]]} {
          set sxcheck($nn) "[list [lindex [args] 0]] [list [lindex [args] 1]] [lrange [lindex $dnsqueue 0] 3 3]"
        } elseif {[isip [lindex [args] 1]]} {
          set sxcheck($nn) "[list [lindex [args] 1]] [list [lindex [args] 0]] [lrange [lindex $dnsqueue 0] 3 3]"
        }
      }
      if {[info exists sxcheck($nn)] && [info exists scheck($nn)]} {
        set saddr ""
        if {[lindex $sxcheck($nn) 2] == "real"} {
          if {[lindex $sxcheck($nn) 0] != [lindex $scheck($nn) 0]} {
            if {[lindex $sxcheck($nn) 1] == "Unknown"} {
              set saddr "[b][lindex $sxcheck($nn) 0][b]"
            } else {
              set saddr "[b][lindex $sxcheck($nn) 1][b]\[[b][lindex $sxcheck($nn) 0][b]\]"
            }
          }
        } else {
          if {[lindex $sxcheck($nn) 0] != [lindex $scheck($nn) 0]} {
            if {[lindex $scheck($nn) 1] == "Unknown"} {
              set saddr "[b][lindex $scheck($nn) 0][b]"
            } else {
              set saddr "[b][lindex $scheck($nn) 1][b]\[[b][lindex $scheck($nn) 0][b]\]"
            }
          }
        }
        if {![string length $saddr]} {
          synecho scheck "[eheader "SpoofCheck"] Ip Check for [b][lindex [lindex $dnsqueue 0] 2][b] successful..."
        } else {
          synecho scheck "[eheader "SpoofCheck"] Ip Check for [b][lindex [lindex $dnsqueue 0] 2][b] failed... [b][lindex [lindex $dnsqueue 0] 2][b] is actually $saddr..."
        }
        unset scheck($nn) sxcheck($nn)
        killpipe scheck
      }
    } elseif {[lrange [lindex $dnsqueue 0] 0 0] == "serv"} {
      if {![string length [lindex [args] 1]]} { synecho dns "[eheader "Server"] Could not resolve [b][lindex [args] 0][b]..." status
      } elseif {[isip [lindex [args] 0]]} { /serv add [lrange [lindex $dnsqueue 0] 2 2] [lindex [args] 1] [lindex [args] 0] [lrange [lindex $dnsqueue 0] 3 3]
      } elseif {[isip [lindex [args] 1]]} { /serv add [lrange [lindex $dnsqueue 0] 2 2] [lindex [args] 0] [lindex [args] 1] [lrange [lindex $dnsqueue 0] 3 3] }
      killpipe serv
    } elseif {[lrange [lindex $dnsqueue 0] 0 0] == "conn"} {
      if {![string length [lindex [args] 1]]} { synecho server "[eheader "Connect"] Invalid server specified: [b][lindex [args] 0][b]" ; killpipe server
      } elseif {[isip [lindex [args] 0]]} { set doserver 1 ; /server [lindex [args] 0] [lrange [lindex $dnsqueue 0] 2 2]
      } elseif {[isip [lindex [args] 1]]} { set doserver 1 ; /server [lindex [args] 1] [lrange [lindex $dnsqueue 0] 2 2] }
    } elseif {[lrange [lindex $dnsqueue 0] 0 0] == "nslookup"} {
      if {![string length [lindex [args] 1]]} { synecho dns "[eheader "dns"] Could not resolve [b][lindex [args] 0][b]"
      } else { synecho dns "[eheader "dns"] Resolved [b][lindex [args] 0][b] to [b][lindex [args] 1][b]" }
      killpipe dns
    }
    set dnsqueue [lrange $dnsqueue 1 end]
  }
}
on DISCONNECT {
  global events
  if {[info exists events(disconnect)]} {
    foreach ev $events(disconnect) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  global realserver
  if {[array exists away]} { synecho x "[eheader "Away"] Disconnected from server... Away Mode Disabled..." ; unset away }
  if {[array exists idle]} { synecho x "[eheader "AntiIdle"] Disconnected from server... AntiIdle Disabled..." ; unset idle }
  if {[info exists realserver]} { unset realserver }
  set_cookie timer(session) "0"
}
on chat_send {
  global events
  if {[info exists events(chat_send)]} {
    foreach ev $events(chat_send) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[string range [raw_args] 1 7] == "\001ACTION" && [string range [raw_args] end end] == "\001"} {
    echo "[applydccselfaction "[my_nick]" "[string range [raw_args] 9 [expr [string length "[raw_args]"] - 1]]"]" chat [nick]
  } else {
    echo "[applydccselftext "[my_nick]" "[string range [raw_args] 1 end]"]" chat [nick]
  }
}

on connect {
  complete
}

on chat_text {
  global events
  if {[info exists events(chat_text)]} {
    foreach ev $events(chat_text) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[string range [raw_args] 1 7] == "\001ACTION" && [string range [raw_args] end end] == "\001"} {
    echo "[applydccuseraction "[nick]" "[string range [raw_args] 9 [expr [string length "[raw_args]"] - 1]]"]" chat [nick]
  } else {
    echo "[applydccusertext "[nick]" "[string range [raw_args] 1 end]"]" chat [nick]
  }
}
on url_output {
  global events
  if {[info exists events(url_output)]} {
    foreach ev $events(url_output) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {![isin $noaddurl [lindex [args] 0]]} {
    if {[string range [lindex [args] 0] 0 6] != "file://" && [string range [lindex [args] 0] 0 5] != "ftp://" && [string range [lindex [args] 0] 0 8] != "gopher://" && [string range [lindex [args] 0] 0 6] != "http://" && [string range [lindex [args] 0] 0 7] != "https://" && [string range [lindex [args] 0] 0 8] != "mailto://" && [string range [lindex [args] 0] 0 8] != "news://" && [string range [lindex [args] 0] 0 8] != "telnet://" && [string range [lindex [args] 0] 0 8] != "wais://"} { set uu "http://[file tail [lindex [args] 0]]"
    } else { set uu "[lindex [args] 0]" }
    if {[config autograb]} {
      set_cookie url [atlist [rflist [get_cookie "url"] $uu] $uu]
    } else {
      set lasturl $uu
    }
  } else {
    set noaddurl [roflist $noaddurl [lindex [args] 0]]
  }
}
on dcc_create {
  global events
  if {[info exists events(dcc_create)]} {
    foreach ev $events(dcc_create) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[lindex [args] 0] == "SEND"} { dsynecho x "[applydccsendrequest "[lindex [args] 1]" "[file tail [lindex [args] 2]]" "[expr [lindex [args] 3] / 1024]"]"
  } elseif {[lindex [args] 0] == "GET"} { dsynecho x "[applydccrecvrequest "[lindex [args] 1]" "[file tail [lindex [args] 2]]" "[expr [lindex [args] 3] / 1024]"]" }
}
on dcc_begin {
  global events
  if {[info exists events(dcc_begin)]} {
    foreach ev $events(dcc_begin) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[lindex [args] 0] == "SEND"} { dsynecho x "[applydccsendstarted "[lindex [args] 1]" "[file tail [lindex [args] 2]]" "[expr [lindex [args] 3] / 1024]"]"
  } elseif {[lindex [args] 0] == "GET"} { dsynecho x "[applydccrecvstarted "[lindex [args] 1]" "[file tail [lindex [args] 2]]" "[expr [lindex [args] 3] / 1024]"]" }
}
on dcc_complete {
  global events
  if {[info exists events(dcc_complete)]} {
    foreach ev $events(dcc_complete) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  set elapsed ""
  set speed ""
  foreach xx $dccxfers {
    if {[lindex $xx 0] == [lindex [args] 1] && [lindex $xx 1] == [file tail [lindex [args] 2]]} {
      set elapsed "[lindex $xx 2]"
      set speed "[lindex $xx 3]"
      break
    }
  }
  if {[lindex [args] 0] == "SEND"} { dsynecho x "[applydccsendcomplete "[lindex [args] 1]" "[file tail [lindex [args] 2]]" "[expr [lindex [args] 3] / 1024]" "$elapsed" "$speed"]"
  } elseif {[lindex [args] 0] == "GET"} {
    if { [config dccmove] } {
      file mkdir "[file dirname [lindex [args] 2]]/[lindex [args] 1]"
      file rename -force -- [lindex [args] 2] "[file dirname [lindex [args] 2]]/[lindex [args] 1]/[file tail [lindex [args] 2]]"
    }
    dsynecho x "[applydccrecvcomplete "[lindex [args] 1]" "[file tail [lindex [args] 2]]" "[expr [lindex [args] 3] / 1024]" "$elapsed" "$speed"]"
  }
}
on dcc_error {
  global events
  if {[info exists events(dcc_error)]} {
    foreach ev $events(dcc_error) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  set complete ""
  foreach xx $dccxfers {
    if {[lindex $xx 0] == [lindex [args] 1] && [lindex $xx 1] == [file tail [lindex [args] 2]]} {
      set complete "[lindex $xx 4]"
      break
    }
  }
  if {[lindex [args] 0] == "SEND"} { dsynecho x "[applydccsendterminated "[lindex [args] 1]" "[file tail [lindex [args] 2]]" "[expr [lindex [args] 3] / 1024]" "[expr $complete / 1024]"]"
  } elseif {[lindex [args] 0] == "GET"} { dsynecho x "[applydccrecvterminated "[lindex [args] 1]" "[file tail [lindex [args] 2]]" "[expr [lindex [args] 3] / 1024]" "[expr $complete / 1024]"]" }
}
on TIMER {
  global events
  if {[info exists events(timer)]} {
    foreach ev $events(timer) { if {![$ev]} { complete ; killpipe privmsg ; noidle ; return } }
  }
  if {[connected]} {
    incr isontimer
    if {$isontimer >= 8} { if {[string length [join [get_cookie notifylist]]]} { /raw ison [join [get_cookie notifylist]] } ; set isontimer 0 }
    if {![info exists away(x)]} { incr xidle } else { noidle }
    set_cookie timer(total) "[expr [get_cookie timer(total)] + 1]"
    if {[config autoaway] && $xidle >= [config autoaway]} { /a autoaway ([expr [config autoaway] / 60]min) }
    if {[info exists away(x)] && [config awayintr]} {
      incr away(time)
      if {[config awaypager]} { set pager "on" } { set pager "off" }
      if {[config awaymessagelog]} { set msglog "on" } { set msglog "off" }
      if {$away(time) >= [config awayintr]} { set away(time) 0
        /ame [applyawaymsgstyle "$away(msg)" "$pager" "$msglog" "$away(since)"]
      }
    }
    if {[info exists idle(x)] && [config antiidle]} {
      incr idle(time)
      if {$idle(time) >= [config antiidle]} { set idle(time) 0 ; /raw privmsg [my_nick] :. }
    }
    if {[info exists maxflood]} { if {[clock seconds] >= [lindex $maxflood 1]} { unset maxflood } }
    foreach nick [array names chanflood] {
      if {[clock seconds] >= [expr [lindex $chanflood($nick) 0] + [lindex [lindex [get_cookie cmode([lindex $chanflood($nick) 2])] 4] 1]]} { unset chanflood($nick) }
    }
    foreach nick [array names massdeopprot] {
      if {[clock seconds] >= [expr [lindex $massdeopprot($nick) 0] + [lindex [lindex [get_cookie cmode([lindex $massdeopprot($nick) 2])] 8] 1]]} { unset massdeopprot($nick) }
    }
    foreach nick [array names masskickprot] {
      if {[clock seconds] >= [expr [lindex $masskickprot($nick) 0] + [lindex [lindex [get_cookie cmode([lindex $masskickprot($nick) 2])] 9] 1]]} { unset masskickprot($nick) }
    }
    foreach nick [array names nickflood] {
      if {[clock seconds] >= [expr [lindex $nickflood($nick) 0] + [lindex [lindex [get_cookie cmode([lindex $nickflood($nick) 2])] 6] 1]]} { unset nickflood($nick) }
    }
    foreach nick [array names vioflood] {
      if {[clock seconds] >= [expr [lindex $vioflood($nick) 0] + [lindex [lindex [get_cookie cmode([lindex $vioflood($nick) 2])] 5] 1]]} { unset vioflood($nick) }
    }
    foreach nick [array names joinflood] {
      if {[clock seconds] >= [expr [lindex $joinflood($nick) 0] + [lindex [lindex [get_cookie cmode([lindex $joinflood($nick) 2])] 10] 1]]} { unset joinflood($nick) }
    }
    foreach nick [array names ctcpflood] { if {[clock seconds] >= [lindex $ctcpflood($nick) 1]} { unset ctcpflood($nick) } }
    foreach nick [array names textflood] { if {[clock seconds] >= [lindex $textflood($nick) 1]} { unset textflood($nick) } }
    foreach nick [array names xdccflood] { if {[clock seconds] >= [lindex $xdccflood($nick) 1]} { unset xdccflood($nick) } }
    foreach chan [array names rejkick] { if {[clock seconds] >= [lindex $rejkick($chan) 1]} { unset rejkick($chan) } }
    foreach chan [array names noway] { /deop $chan $noway($chan) ; unset noway($chan) }
    foreach x $filterkickqueue {
      if {[clock seconds] >= [expr 2 + [lindex $x 0]]} {
        if {[ison [my_nick] [lindex $x 1]]} {
          foreach niq [rflist [clist all [lindex $x 1]] [my_nick]] { if {[wmatch [lindex $x 2] [getmask $niq]]} { append bann "$niq," } }
          if {[string length $bann]} { skick noban [lindex $x 1] [string trimright $bann ","] [applyjoinfloodkickmsg "[lindex $x 1]" "[lindex [lindex [get_cookie cmode([lindex $x 1])] 10] 0]" "[lindex [lindex [get_cookie cmode([lindex $x 1])] 10] 1]"] }
        }
        set filterkickqueue "[rflist $filterkickqueue $x]"
      }
    }
    set newtimer ""
    foreach tt $timers {
      set ii "[expr [lindex $tt 1] + 1]"
      set ee "[lindex $tt 3]"
      if {$ii == [lindex $tt 0]} {
        set ii 0
        if {[lindex $tt 2] != 0} { incr ee }
        [lindex $tt 4]
      }
      if {$ee != [lindex $tt 2] || ![lindex $tt 2]} {
        lappend newtimer "[list "[lindex $tt 0]"] [list "$ii"] [list "[lindex $tt 2]"] [list "$ee"] [list "[lindex $tt 4]"]"
      }
    }
    set timers $newtimer
    set dccxfers ""
    for { set dccx 0 } { $dccx < [dcc_count] } { incr dccx } {
      set info "[dcc_info $dccx]"
      set nick "[lindex $info 2]"
      set elapsed "[lindex $info 6]"
      set speed "[lindex $info 8]"
      set filename "[lindex $info 3]"
      set completed "[lindex $info 4]"
      if {$speed == "-1.0000"} { set speed "???" }
      if {$elapsed == "-1"} { set elapsed "???" }
      lappend dccxfers "[list "$nick"] [list "$filename"] [list "$elapsed"] [list "$speed"] [list "$completed"]"
    }
    if {[info exists regainnick]} {
      if {![info exists regtogg]} { set regtogg "0" }
      incr regtogg
      if {$regtogg == 4} {
        /quote nick $regainnick
        unset regtogg
      }
    }
    if {[active]} {
      if {[window_type] == "query" && [window get_title main] != [applymainwindowquery]} { window set_title "[applymainwindowquery]" main
      } elseif {[window_type] == "chat" && [window get_title main] != [applymainwindowchat]} { window set_title "[applymainwindowchat]" main
      } elseif {[window_type] == "status" && [window get_title main] != [applymainwindowstat]} { window set_title "[applymainwindowstat]" main
      } elseif {[window_type] == "channel" && [window get_title main] != [applymainwindowchan]} { window set_title "[applymainwindowchan]" main }
    }
    if {[window get_title status] != [applystatuswindowcon]} { window set_title "[applystatuswindowcon]" status }

    set offline_timer 0
  } else {
    if {[active]} {
      if {[window get_title main] != [applymainwindowdiscon]} { window set_title "[applymainwindowdiscon]" main }
    }
    if {[window get_title status] != [applystatuswindowdcon]} { window set_title "[applystatuswindowdcon]" status }
    incr offline_timer
    if { $offline_timer >= 60  && [config arcon] } {
      set offline_timer 0
      if { [lindex [get_cookie "servers"] [expr $offline_server - 1]] == "" } { set offline_server 1 }
      echo [get_cookie "servers"]
      /server $offline_server
      incr offline_server
    }
  }
}
####
#### Procedures
####

proc synload { } {
  global firstload sping spylinks echopipe llnew ison llcurrent llmaster statslqueue dnsqueue whoisqueue laginter lagkillers noaddurl nickavoid tabs xidle
  synecho x "[eheader "Connect"] Connection established with [b][lindex [server] 0][b] on port [b][lindex [server] 1][b]..." status
  if {[window_type] != "status"} { synecho x "[eheader "Connect"] Connection established with [b][lindex [server] 0][b] on port [b][lindex [server] 1][b]..." }
  ascii
  synecho x "[eheader "Syntax"] Reloading script..." status
  synecho x "[eheader "Syntax"] Removing old variables..." status
  set noaddurl ""
  set nickavoid ""
  set tabs ""
  set xidle 0
  set dnsqueue ""
  set statslqueue ""
  if {[info exists realserver]} { unset realserver }
  if {[info exists chanflood]} { unset chanflood }
  if {[info exists massdeopprot]} { unset massdeopprot }
  if {[info exists masskickprot]} { unset masskickprot }
  if {[info exists nickflood]} { unset nickflood }
  if {[info exists vioflood]} { unset vioflood }
  if {[info exists joinflood]} { unset joinflood }
  if {[info exists whoisqueue]} { unset whoisqueue }
  if {[info exists banqueue]} { unset banqueue }
  if {[info exists sping]} { unset sping }
  if {[info exists echopipe]} { unset echopipe }
  if {[info exists ison]} { unset ison }
  if {[info exists llnew]} { unset llnew }
  if {[info exists llcurrent]} { unset llcurrent }
  if {[info exists llmaster]} { unset llmaster }
  if {[config defum] != "off"} {
    synecho x "[eheader "Syntax"] Switching to default usermodes ([b][config defum][b])..." status
    /raw mode [my_nick] [config defum]
  }
  if {[string length [get_cookie notifylist]]} { /raw ison [join [get_cookie notifylist]] }
  if {[string tolower [config autojoin]] != "none" && [config joncon] } { synecho x "[eheader "Syntax"] Joining autojoin channel(s)..." status ; /join [join [split [config autojoin]] ","] }
  if {[config clearscore]} { synecho x "[eheader "Syntax"] Clearing operkill scoreboard..." status ; /clearscore }
  if {[get_cookie awaymsgs "0"] > 0} { synecho x "[eheader "Syntax"] You have [b][get_cookie awaymsgs][b] old away messages... type /awaymsgs to read..." status }
  if {[get_cookie awaycapt "0"] > 0} { synecho x "[eheader "Syntax"] You have [b][get_cookie awaycapt][b] old away captures... type /awaycapt to read..." status }
  synecho x "[eheader "Syntax"] Resetting online timer..." status
  set_cookie timer(session) "[clock seconds]"
  if {[info exists firstload]} {
    synecho x "[eheader "Syntax"] Now autojoining [b]#syntax[b]... (one time only)"
    /raw join #syntax
    unset firstload
  }
  if {[isip [lindex [server] 0]]} {
    lappend dnsqueue "resolveserv [lindex [server] 0]"
    lookup [lindex [server] 0]
  }
  noidle
}
proc ascii { } {
  global internalver
  set x [random 1 5]
  synecho x "                                                                          " status
  synecho x "  abyss's...                                              version $internalver" status
  synecho x "                                                                          " status
  switch $x {
    "1" {
      synecho x "     ^^^^^^\"Ù$$? $$$    $$$ Ù\"^^^^^$$$ $$$        $$$Ù\"^^^^^ $$$Ù\"^  $$?  " status
      synecho x "     $$$     $$$ $$$    $$$ $$$    $$$ $$$Ù\"^^^^  $$$    $$$ $$$     $$$  " status
      synecho x "     $$$         $$$    $$$ $$$    $$$ $$$        $$$ $$$    $$$     $$$  " status
      synecho x "     Ù\"^^^^^^$$? $$$    $$$ $$$    $$$ $$$    i\?i $$$Ù\"^^$$$ $$$     $$$  " status
      synecho x "             $$$ $$$    $$$ $$$    $$$ $$$    $$$ $$$    $$$  $$Ù\"\"\"À$$   " status
      synecho x " ^^\"À$$$     $$$ Ù\"^^^^^$$$ $$$    $$$ $$$    $$$ $$$    $$$ $$$     $$$  " status
      synecho x "     $$$     $$$        $$$ $$$    $$$ $$$    $$$ $$$    $$$ $$$     $$$  " status
      synecho x "     $$$     $$$ $$$    $$$ $$$    $$$ $$$    $$$ $$$    $$$ $$$     $$$  " status
      synecho x "     $$$     $$$ $$$    $$$ $$$    $$$ $$$    $$$ $$$    $$$ $$$     $$$  " status
      synecho x "     $$$Ù\"^^^^^^ $$$Ù\"^^^^^ $$$        $$$Ù\"^^^^^ $$$Ù\"^^^^^ $$$          " status
    }
    "2" {
      synecho x "                                          _/                              " status
      synecho x "           _/_/_/  _/    _/  _/_/_/    _/_/_/_/    _/_/_/  _/    _/       " status
      synecho x "        _/_/      _/    _/  _/    _/    _/      _/    _/    _/_/          " status
      synecho x "           _/_/  _/    _/  _/    _/    _/      _/    _/  _/    _/         " status
      synecho x "      _/_/_/      _/_/_/  _/    _/      _/_/    _/_/_/  _/    _/          " status
      synecho x "                     _/                                                   " status
      synecho x "                 _/_/                                                     " status
    }
    "3" {
      synecho x "  i$$$Ù\"^^$$\$\i \i\$$$    $$\$\i i$$$Ù\"^^$$\$\i $$$$         \i$$$^^\"Ù$$\$\i i$$$   $$\$\i   " status
      synecho x "  $$$$    Ù\"^^ $$$$    $$$$ $$$$    $$$$ $$$$?isssss  ^^\"Ù    $$$$ $$$$   $$$$  " status
      synecho x "  $$$$         $$$$    $$$$ $$$$    $$$$ $$$$Ù\"^^^^^  ,i?$Ù\"^^$$$$ $$$$, ,$$$$  " status
      synecho x "  ^^^^^^\"Ù$$$$,^^^^^^\"Ù$$$$ $$$$    $$$$ $$$$         $$$$    $$$$,`$$$\$\i$$$$`, " status
      synecho x " $Ù\"^^$$$$    $Ù\"^^$$$$    $    $$$$    $    $$$$À\"^^$    $$$$    $$   $$$   $$ " status
      synecho x " $    $$$$    $    $$$$    $    $$$$    $    $$$$    $    $$$$    $$   $$$   $$ " status
      synecho x " $    $$$$    $    $$$$    $    $$$$    $    $$$$    $    $$$$    $$   $$$   $$ " status
      synecho x " $    $$$$    $    $$$$    $    $$$$    $    $$$$    $    $$$$    $$   $$$   $$ " status
      synecho x " $\$eeeeeeeeee$\$eeeeeeeeee$$\$eeee$$$\$eeee\$eeeeeeeeeeee\$eeeeeeeeeeee\$eee$$$\$eeee\$ " status
    }
    "4" {
      synecho x "    .::::::..-:.     ::-.:::.    :::.:::::::::::::::.      .,::      .:" status
      synecho x "   ;;;`    ` ';;.   ;;;;'`;;;;,  `;;;;;;;;;;;'''';;`;;     `;;;,  .,;;" status
      synecho x "   '\[==/\[\[\[\[,  '\[\[,\[\[\['    \[\[\[\[\[. '\[\[     \[\[    ,\[\[ '\[\[,     '\[\[,,\[\['" status
      synecho x "     '''    \$    c\$\$\"      \$\$\$ \"Y\$c\$\$     \$\$   c\$\$\$cc\$\$\$c     Y\$\$\$P" status
      synecho x "    88b    dP  ,8P\"`       888    Y88     88,   888   888,  oP\"``\"Yo,    " status
      synecho x "     \"YMmMY\"  mM\"          MMM     YM     MMM   YMM   \"\"`,m\"       \"Mm, " status
    }
    "5" {
      synecho x "         ,g&\$7\"` \$&g" status
      synecho x "    .  . \$\$\$.. ..\$\$\$ .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .  ." status
      synecho x "         \$\$\$     \$\$7                       \$\$\$" status
      synecho x "         \$\$\$     `\"' g&\$   \$&g \$&g.&\$&a.`\"Q\$\$\$7\"` `Q\$\" `\"Q\$&g `Q\$&a, ,g&\$7'" status
      synecho x "         \$\$\$         \$\$\$   \$\$\$ \$\$\$   \$\$\$   \$\$\$     7'     \$7'       \$" status
      synecho x "         \"\"\" `\"\"\"\$\$b \$\$\$   \$\$\$ \$\$\$   \$\$\$   \$\$\$    ,g&\$7\"` \$&g     .u'u." status
      synecho x "         .,,     \$\$\$ \$\$\$   \$\$\$ \$\$\$   \$\$\$   \$\$\$    \$\$\$     \$\$7   ,\$'   `\$," status
      synecho x "         \$\$\$     \$\$\$ \$\$\$   \$\$\$ \$\$\$   \$\$\$   \$\$\$    \$\$\$     \$\$\$  ,\$\$     \$\$," status
      synecho x "         \$\$\$  .,g\$\$\$ `Q\$,. \$\$\$ \$\$\$   \$\$\$   \$\$\$    `Q\$   .,\$\$7 ,\$\$\$     \$\$\$," status
      synecho x "                           \$\$\$  ::hFz::    \$7'" status
      synecho x "    .  . .. .. .. .. .. .. \$\$\$.. .. .. .. .7'.. .. .. .. .. .. .. .. .. .. .  ." status
      synecho x "                           \$\$\$             `" status
      synecho x "                           \$\$7" status
      synecho x "                      .,uuu\$7'" status
    }
  }
  synecho x "                                                                          " status
}
proc replicate { zzz numb } { set retr "" ; for { set x 0 } { $x < $numb } { incr x } { append retr "$zzz" } ; return $retr }
proc align { text extraspc } { set extraspc [expr {$extraspc - [string length [strip $text]]}] ; append text [replicate " " $extraspc] ; return $text }
proc xalign { text extraspc } { if {[string length $text] > $extraspc} { return "[string range $text 0 [expr {$extraspc - 1}]]" } ; set extraspc [expr {$extraspc - [string length [strip $text]]}] ; append text [replicate " " $extraspc] ; return $text }
proc ralign { text extraspc } { set extraspc [expr {$extraspc - [string length [strip $text]]}] ; set text "[replicate " " $extraspc]$text" ; return $text }
proc screw { mask } { set mask [split $mask ""] ; set build "" ; set screwnum 1 ; foreach char $mask { if {$char == "." || $char == "@" || $char == "*" || $char == "!"} { lappend build $char } elseif {$screwnum == 1} { set screwnum 0 ; lappend build $char } else { set screwnum 1 ; lappend build "?" } } ; return [join $build ""] }
proc rscrew { mask } { set mask [split $mask ""] ; set build "" ; foreach char $mask { set screwnum [random 0 1] ; if {$char == "." || $char == "@" || $char == "*" || $char == "!"} { lappend build $char } elseif {$screwnum == 1} { lappend build $char } else { lappend build "?" } } ; return [join $build ""] }
proc cscrew { mask } { set mask [split $mask ""] ; set build "" ; foreach char $mask { set screwnum [random 0 1] ; if {$char == "." || $char == "@" || $char == "*" || $char == "!"} { lappend build $char } else { lappend build "?" } } ; return [join $build ""] }
proc isnick { x } { if {[string length [string trim [string tolower $x] "_-^\\\[\]\{\}|`1234567890abcdefghijklmnopqrstuvwxyz"]] != 0 || ![string length $x] || [isnum [string index $x 0]] || [string length $x] > 30} { return 0 } ; return 1 }
proc isip { mask } { set mask [split $mask "."] ; if {[llength $mask] == 4 && [isnum [lindex $mask 0]] && [isnum [lindex $mask 1]] && [isnum [lindex $mask 2]] && [isnum [lindex $mask 3]]} { return 1 } ; return 0 }
proc isaddr { mask } { if {[wmatch *@* $mask]} { return 1 } ; return 0 }
proc isnum { x } { if {[string length [string trim $x "1234567890"]] != 0 || ![string length $x] || [string length $x] > 9} { return 0 } ; return 1 }
proc isop { nick chan } { foreach test [nicks $chan @*] { if {[string tolower $nick] == [string tolower [string trimleft $test "+@"]]} { return 1 } } ; return 0 }
proc isvoice { nick chan } { foreach test [nicks $chan] { if {[string tolower $nick] == [string tolower [string trimleft $test "+@"]]} { return 1 } } ; return 0 }
proc isin { list element } { foreach item $list { if {[string tolower $item] == [string tolower $element]} { return 1 } } ; return 0 }
proc iswin { list element } { foreach item $list { if {[wmatch $element $item]} { return 1 } } ; return 0 }
proc ison { nick chan } { foreach test [nicks $chan] { if {[string tolower $nick] == [string tolower [string trimleft $test "@+"]]} { return 1 } } ; return 0 }
proc getkey { chan } { set modes [split [lindex [mode $chan] 0] ""] ; set index 0 ; foreach mod $modes { if {$mod == "k"} { incr index ; return [lindex [split [mode $chan]] $index] } elseif {$mod == "l"} { incr index } } ; return "" }
proc getlimit { chan } { set modes [split [lindex [mode $chan] 0] ""] ; set index 0 ; foreach mod $modes { if {$mod == "l"} { incr index ; return [lindex [split [mode $chan]] $index] } elseif {$mod == "k"} { incr index } } ; return "" }
proc validchan { chan } { foreach channel [channels] { if {[string tolower $chan] == [string tolower $channel]} { return 1 } } ; return 0 }
proc servmodemax { } { if {[string match *undernet.net* [string tolower [lindex [xserver] 0]]] || [string match *dal.net* [string tolower [lindex [xserver] 0]]]} { return 6 } else { return 4 } }
proc servmsgmax { } { if {[string match *undernet.net* [string tolower [lindex [xserver] 0]]] || [string match *dal.net* [string tolower [lindex [xserver] 0]]]} { return 50 } else { return 10 } }
proc rword { x } { if {[string length $x]} { return [lindex $x [ro [expr {[random 0 [llength $x]] - 1}]]] } ; return "" }
proc ro { x } { if {$x < 0} { return 0 } else { return $x } }
proc rstring { x } { set y "" ; for { set x $x } { $x > 0 } { set x [expr {$x - 1}] } { append y [string index abcdefghijklmnopqrstuvwyxyzABCDEFGHIJKLMNOPQRSTUVWYXYZ0123456789 [random 0 62]] } ; return $y }
proc randshit { x } { set y "" ; for { set x $x } { $x > 0 } { set x [expr {$x - 1}] } { append y [string index àáâãäåæçèéêëìíîïððñòóôõöøùúûüýþÿß×¢ [random 0 34]] } ; return $y }
proc randnastyshit { x } { set y "" ; for { set x $x } { $x > 0 } { set x [expr {$x - 1}] } { append y [string index àáâãäåæçèéêëìíîïððñòóôõöøùúûüýþÿß×¢ [random 0 34]] ; if {[random 0 2]} { append y "[lindex "" [random 0 2]]" } ; if {[random 0 4] == "4"} { append y "[random 0 16],[random 0 16]" } } ; return $y }
proc randnick { x } { set y "" ; for { set x $x } { $x > 0 } { set x [expr {$x - 1}] } { append y [string index "\{\}\[\]\|\i\I\-\\" [random 0 8]] } ; return $y }
proc modmode { x y } { set w "+" ; set x [split $x ""] ; foreach mode [split $y ""] { if {$mode == "-"} { set w "-" } elseif {$mode == "+"} { set w "+" } else { if {$w == "-"} { if {[isin $x $mode]} { set x "[rflist $x $mode]" } } else { if {![isin $x $mode]} { set x "[atlist $x $mode]" } } } } ; return "[join $x ""]" }
proc uptime { } { return "[string range [clock clicks] 0 [expr {[string length [clock clicks]] - 4}]]" }
proc sortby { x y } { set z "" ; foreach char [split $y ""] { if {[wmatch *$char* $x]} { append z "[replicate $char [scount $x $char]]" } } ; return $z }
proc randorder { x } {
  set la ""
  for { set cnt [llength $x] } { $cnt > 0 } { incr cnt -1 } {
    set c "[rword $x]"
    lappend la "$c"
    set x "[rflist $x $c]"
  }
  return $la
}
proc spc { x } {
  set y ""
  for { set x $x } { $x > 0 } { incr x -1 } {
    append y " "
  }
  return "$y"
}
proc nickc { chan partial } {
  if {![string length $partial]} { return 0 }
  set x ""
  foreach nickx [rflist [split $partial ","] ""] {
#   foreach nick [clist all $chan] { if {[string match [string tolower $nickx]* [string tolower  $nick]]} { append x "$nick," ; break } }
    foreach nick [clist all $chan] { if {[string tolower $nickx] == [string tolower [string range $nick 0 [expr {[string length $nickx] - 1}]]]} { append x "$nick," ; break } }
  }
  if {[string length $x]} { return [string trimright $x ","]
  } else { return "" }
}
proc nnickc { chan partial } {
  global lastindex lastchan
  if {![info exists lastchan] || ![info exists lastindex] || $lastchan != $chan} {
    set lastchan $chan
    set x [nickc $chan $partial]
    set lastindex "[expr {[lsearch [string tolower [clist all $chan]] [string tolower [split $x]]] - 1}]"
    if {$lastindex < 0} { set lastindex 0 }
    incr lastindex
  } else {
    incr lastindex
    set x [lindex [clist all $chan] $lastindex]
  }
  if {![string length $x] || $x == 0} { set lastindex -1 ; return [nnickc $chan $partial]
  } else { return "$x" }
}
proc percentbar { part whole } {
  set rep [expr {[expr {$part * 100}] / $whole}]
  if {![string length [string range $rep 0 [expr {[string length $rep] - 1}]]]} { set sect1 0
  } else { set sect1 "[string range $rep 0 [expr {[string length $rep] - 1}]]" }
  set sect1 "[string range $sect1 0 [expr {[string length $sect1] - 2}]]"
  if {![string length $sect1]} { return ""
  } else { set sect1 [expr {$sect1 * 2}] }
  set bar ""
  for { set x 0 } { $x < $sect1 } { incr x } {
    if {$x >= 16} { append bar "[applypercentbar5]"
    } elseif {$x >= 12} { append bar "[applypercentbar4]"
    } elseif {$x >= 8} { append bar "[applypercentbar3]"
    } elseif {$x >= 4} { append bar "[applypercentbar2]"
    } else { append bar "[applypercentbar1]" }
  }
  return $bar
}
proc applykickvars { text } {
  global chan user numkick allkick
  return [replace [replace [replace [replace [replace [replace [replace [replace $text "%%" "
" ] "%m" "[my_nick]"] "%a" "$allkick"] "%c" "$chan"] "%n" "$numkick"] "%k" "$user"] "%t" "[get_cookie totalkicks]"] "
" "%"]
}
proc applyquitvars { text } {
  return [replace [replace [replace [replace [replace $text "%%" "
" ] "%m" "[my_nick]"] "%o" "[durationstyle [expr {[clock seconds] - [get_cookie timer(session) "0"]}] "y" "d" "h" "m" "s" "" "" "" ""]"] "%t" "[durationstyle [get_cookie timer(total) "0"] "y" "d" "h" "m" "s" "" "" "" ""]"] "
" "%"]
}
proc getmask { nick } {
  global mask
  if {[info exists mask([string tolower $nick])]} { return "$mask([string tolower $nick])" }
  return "$nick!<unknown>@<unknown>"
}
proc addseen { nick type addr chann message date args } {
  global seen
  if {[llength [array names seen]] > 50} {
    unset seen([lindex [array names seen] 0])
  }
  set seen([string tolower $nick]) "[list $type] [list $chann] [list $addr] [list $message] [list $date] [list $args]"
}
proc wmatch { string1 string2 } {
  if {[string match "*!<unknown>@<unknown>" $string1] || [string match "*!<unknown>@<unknown>" $string2]} { return 0 }
  return [string match [string tolower [replace [replace [replace $string1 "\[" "\\\["] "\]" "\\\]"] "\\" "\\\\"]] [string tolower $string2]]
}
proc rep {string what {with ""}} {
  set nstring $string
  set nlen 0
  while {[set x [string first $what $nstring]] != -1} {
    incr x $nlen
    set beg [string range $string 0 [expr {$x-1}]]$with
    set nlen [string length $beg]
    set string $beg[string range $string [expr {$x+[string length $what]}] end]
  }
  return $string
}
proc strep str {
    rep [rep [rep $str \\ \\\\] \] \\\]] \[ \\\[
}
proc wordstart {string place} {
    set ret [string last " " [string range $string 0 [expr {$place-1}]]]
    if {$place > [string length $string]} {return $place} else {incr ret}
}
proc strip { x } {
  regsub -all "" $x "" x
  regsub -all "" $x "" x
  regsub -all "" $x "" x
  regsub -all "" $x "" x
  regsub -all "\[1-9\]\[1-9\],\[1-9\]\[1-9\]" $x "" x
  regsub -all "\[1-9\],\[1-9\]\[1-9\]" $x "" x
  regsub -all "\[1-9\]\[1-9\],\[1-9\]" $x "" x
  regsub -all "\[1-9\]\[1-9\]" $x "" x
  regsub -all "\[1-9\]" $x "" x
  return $x
}
proc colorstrip { x } {
  regsub -all "\[0-9\]\[0-9\],\[0-9\]\[0-9\]" $x "" x
  regsub -all "\[0-9\],\[0-9\]\[0-9\]" $x "" x
  regsub -all "\[0-9\]\[0-9\],\[0-9\]" $x "" x
  regsub -all "\[0-9\]\[0-9\]" $x "" x
  regsub -all "\[0-9\]" $x "" x
  return $x
}
proc powerstrip { x } {
  regsub -all "" $x "" x
  regsub -all "" $x "" x
  regsub -all "" $x "" x
  regsub -all "" $x "" x
  regsub -all "" $x "" x
  regsub -all "\[0-9\]\[0-9\],\[0-9\]\[0-9\]" $x "" x
  regsub -all "\[0-9\],\[0-9\]\[0-9\]" $x "" x
  regsub -all "\[0-9\]\[0-9\],\[0-9\]" $x "" x
  regsub -all "\[0-9\]\[0-9\]" $x "" x
  regsub -all "\[0-9\]" $x "" x
  return $x
}
proc replace { string replace replacewith } {
  regsub -all -- {\\} $replacewith {\\\\} replacewith
  regsub -all -- "&" $replacewith {\\\&} replacewith
  regsub -all -- {\\} $replace {\\\\} replace
  regsub -all -- {\[} $replace {\[} replace
  regsub -all -- {\]} $replace {\]} replace
  regsub -all -- {\(} $replace {\(} replace
  regsub -all -- {\)} $replace {\)} replace
  regsub -all -- {\*} $replace {\*} replace
  regsub -all -- {\+} $replace {\+} replace
  regsub -all -- {\?} $replace {\?} replace
  regsub -all -- $replace $string $replacewith string
  return $string
}
proc ignorez { addr } {
  foreach xaddr [get_cookie ignorelist] {
    if {[wmatch $xaddr [addrfill $addr]]} {
      return [get_cookie ignore($xaddr)]
    }
  }
  return ""
}
proc addrfill { addr } {
  set addr [string trimleft [string tolower $addr] "!@"]
  if {![string length $addr]} { set addr "*!*@*"
  } elseif {![string match *@* $addr]} { set addr "*!*@$addr"
  } elseif {![string match *!* $addr]} { set addr "*!$addr"
  } else { set addr "$addr" }
  return $addr
}
proc percent { part whole } {
  set rep [expr {[expr {$part * 100000}] / $whole}]
  if {![string length [string range $rep 0 [expr {[string length $rep] - 4}]]]} { set sect1 0
  } else { set sect1 "[string range $rep 0 [expr {[string length $rep] - 4}]]" }
  if {![string length [string range $rep [expr {[string length $rep] - 3}] end]]} { set sect2 000
  } else { set sect2 "[string range $rep [expr {[string length $rep] - 3}] end]" }
  if {[string length $sect2] == "1"} { return "0.000%"
  } else { return "$sect1\.$sect2\%" }
}
proc roflist { list element } {
  set string ""
  set flag 1
  foreach item $list {
    if {[string tolower $item] == [string tolower $element] && $flag} { set flag 0
    } else { lappend string $item }
  }
  return $string
}
proc rflist { list element } {
  set string ""
  foreach item $list { if {[string tolower $item] != [string tolower $element]} { lappend string $item } }
  return $string
}
proc scount { string item } {
  set string "[join [split $string]]"
  set nstring [replace $string "$item" ""]
  return "[expr {[expr {[string length $string] - [string length $nstring]}] / [string length $item]}]"
}
proc atlist { list element } {
  set listx $list
  lappend listx $element
  return $listx
}
proc aotlist { list element } {
  set listx $list
  foreach item $list {
    if {[string tolower $item] == [string tolower $element]} { set flag 0 }
  }
  if {![info exists flag]} { lappend listx $element
  } else { unset flag }
  return $listx
}
proc clist { type chan } {
  set users ""
  switch -- "[string tolower $type]" {
    "all" { foreach nick [nicks $chan] { lappend users [string trimleft $nick "@+"] } }
    "+o"  { foreach nick [nicks $chan @*] { lappend users [string trimleft $nick "@"] } }
    "-o"  { foreach nick [nicks $chan] { if {![string match @* $nick]} { lappend users [string trimleft $nick "+"] } } }
    "+v"  { foreach nick [nicks $chan +*] { lappend users [string trimleft $nick "+"] } }
    "-v"  { foreach nick [nicks $chan] { if {![string match @* $nick] && ![string match +* $nick]} { lappend users $nick } } }
  }
  return $users
}
proc naddrfill { addr } {
  set addr [string trimleft [string tolower $addr] "!@"]
  if {![string length $addr]} { set addr "*@*"
  } elseif {![string match *\@* $addr]} { set addr "*@$addr"
  } else { set addr "$addr" }
  return $addr
}
proc banmask { type mask } {
  set mask [string trimleft $mask "!@"]
  if {![string match *@* $mask]} { set mask *!*@$mask
  } elseif {![string match *!* $mask]} { set mask *!$mask }
  set mask "[list [lindex [split $mask "!"] 0]] [list [lindex [split [lindex [split $mask "!"] 1] "@"] 0]] [list [lindex [split [lindex [split $mask "!"] 1] "@"] 1]]"
  set nick [lindex $mask 0]
  if {![string length mask]} { return "*" }
  set user [string range [string trimleft [lindex $mask 1] "~"] [expr {[string length [string trimleft [lindex $mask 1] "~"]] - 8}] end]
  set nick [string range $nick [expr {[string length $nick] - 8}] end]
  set fullhost [lindex $mask 2]
  if {$user == "<unknown>" || $fullhost == "<unknown>"} { return "*$nick!*@*" }
  if {[isip $fullhost]} {
    set rbanhost "[join [lrange [split $fullhost "."] 0 2] "."].*"
    set dbanhost $rbanhost
  } else {
    if {![string length [lindex [split $fullhost "."] [expr {[llength [split $fullhost "."]] - 3}]]]} {
      set rbanhost [lindex $mask 2] ; set dbanhost $rbanhost
    } else {
      set rbanhost "*.[join [lrange [split $fullhost "."] 1 end] "."]" ; set dbanhost "*.[join [lrange [split $fullhost "."] [expr {[llength [split $fullhost "."]] - 2}]  end] "."]"
    }
  }
  switch "$type" {
    "1" { return "*$nick!$user@$fullhost" }
    "2" { return "*!*$user@$fullhost" }
    "3" { return "*!*@$fullhost" }
    "4" { return "*$nick!$user@$rbanhost" }
    "5" { return "*!*$user@$rbanhost" }
    "6" { return "*!*@$rbanhost" }
    "7" { return "*!$user@$dbanhost" }
    "8" { return "*!*$user@$dbanhost" }
    "9" { return "*!*@$dbanhost" }
    default { return "" }
  }
}
proc noidle { } {
  global xidle lastindex lastchan
  if {[info exists lastindex]} { unset lastindex }
  if {[info exists lastchan]} { unset lastchan }
  set xidle 0
}

#>># 100% behemoth's code for the duration =).. theres just no better way to do it.
#>># modded by abyss to use styles.
proc durationstyle { s year day hour minute second ex sep numb numa } {
  if {$s < 1} {return "${numb}0${numa}${second}${ex}"}
  set m [expr {$s / 60}]; set s [expr {$s % 60}]
  set h [expr {$m / 60}]; set m [expr {$m % 60}]
  set d [expr {$h / 24}]; set h [expr {$h % 24}]
  set y [expr {$d / 365}]; set d [expr {$d % 365}]
  set end ""
  lappend end "[expr {$y==0?"":"${numb}$y${numa}${year}[expr {$y!=1?"$ex":""}]"}]"
  lappend end "[expr {$d==0?"":"${numb}$d${numa}${day}[expr {$d!=1?"$ex":""}]"}]"
  lappend end "[expr {$h==0?"":"${numb}$h${numa}${hour}[expr {$h!=1?"$ex":""}]"}]"
  lappend end "[expr {$m==0?"":"${numb}$m${numa}${minute}[expr {$m!=1?"$ex":""}]"}]"
  lappend end "[expr {$s==0?"":"${numb}$s${numa}${second}[expr {$s!=1?"$ex":""}]"}]"
  return "[string trim [join "$end" "$sep"]]"
}

proc smode { type chan users } {
  set num 0
  set smax [servmodemax]
  set userq ""
  set commands ""
  foreach user [split $users ","] {
    if {![ison $user $chan]} { synecho x "[eheader "???"] [b]$user[b] could not be located on [b]$chan[b]..."
    } else {
      incr num
      lappend userq $user
      if {$num == $smax} { append commands "mode $chan $type [join $userq][lf]" ; set userq "" ; set num 0 }
    }
  }
  if {$num} { append commands "mode $chan $type [join $userq][lf]" ; set userq "" ; set num 0 }
  if {[string length $commands]} { /raw $commands }
  noidle
}
proc skick { type channel users args } {
  global allkick numkick user quote
  set num 0
  set allkick 0
  set numkick 1
  set bmasq ""
  set userq ""
  set tempo ""
  set tempoo ""
  set commands ""
  foreach user [split $users ","] { if {[ison $user $channel]} { incr allkick } }
  foreach user [split $users ","] {
    incr num
    if {![ison $user $channel]} { synecho x "[eheader "???"] [b]$user[b] could not be located on [b]$channel[b]..."
    } else {
      if {![string length [join $args]]} {
        if {[llength [get_cookie kickquote]] <= 0} { set quote "*p0ink*"
        } else { set quote "[applykickvars [join [rword [get_cookie kickquote]]]]" }
      } else { set quote "[join $args]" }
      if {[string match *single* $type]} { lappend bmasq [banmask 5 [getmask $user]] ; lappend userq $user
      } elseif {[string match *domain* $type]} { lappend bmasq [banmask 9 [getmask $user]] ; lappend userq $user
      } elseif {[string match *screw* $type]} { lappend bmasq [rscrew [banmask 9 [getmask $user]]] ; lappend userq $user
      } elseif {[string match *noban* $type]} { lappend userq $user }
      lappend tempo "kick $channel $user :[kickstyle "$quote"]"
      incr numkick
      set_cookie totalkicks [expr {[get_cookie totalkicks] + 1}]
      if {[string length [lindex $userq 1]]} {
        if {[string length [lindex $bmasq 1]]} { append commands "mode $channel -oo+bb [join $userq] [join $bmasq][lf]" ; set bmasq "" ; set userq "" }
        foreach tempoo $tempo { append commands "$tempoo[lf]" }
        set tempo ""
      } elseif {$num == [llength [split $users ","]] && [string length [lindex $userq 0]]} {
        if {![string match *noban* $type]} { append commands "mode $channel -o+b [join $userq] [join $bmasq][lf]" ; set bmasq "" ; set userq ""  }
        foreach tempoo $tempo { append commands "$tempoo[lf]" }
        set tempo ""
      }
    }
  }
  if {[string length $commands]} { /raw $commands }
  noidle
}
proc inc_relsm { nick ttyp text } {
  global relsm
  for { set x [config relayslots] } { $x > 0 } { set x [expr {$x - 1}] } {
    if {[info exists relsm([expr {$x - 1}])]} { set relsm($x) "$relsm([expr {$x - 1}])" }
  }
  set relsm(1) "[list $nick] [list $ttyp] [list $text]"
}
proc inc_relm { nick user host ttyp text } {
  global relm
  for { set x [config relayslots] } { $x > 0 } { set x [expr {$x - 1}] } {
    if {[info exists relm([expr {$x - 1}])]} { set relm($x) "$relm([expr {$x - 1}])" }
  }
  set relm(1) "[list $nick] [list $user] [list $host] [list $ttyp] [list $text]"
}
proc inc_relok { killer killed oknum text } {
  global relok
  for { set x [config relayslots] } { $x > 0 } { set x [expr {$x - 1}] } {
    if {[info exists relok([expr {$x - 1}])]} { set relok($x) "$relok([expr {$x - 1}])" }
  }
  set relok(1) "[list $killer] [list $killed] [list $oknum] [list $text]"
}
proc inc_tab { command nick } {
  global tabs tabnum
  set tabnum 0
  if {$command == "msg" || $command == "notice"} {
    set tabs [rflist $tabs "/msg $nick "]
    set tabs [rflist $tabs "/notice $nick "]
  }
  if {![string length $tabs]} { lappend tabs "/$command $nick "
  } else { set tabs [lrange [linsert $tabs 0 "/$command $nick "] 0 [expr {[config tabbuffer] - 1}]] }
}
proc clearmask { nick } {
  if {[info exists mask([string tolower $nick])]} {
    unset mask([string tolower $nick])
  }
  complete
}

####
#### Flood control procedures
####

proc inc_maxflood { } {
  global maxflood
  if {[get_cookie tog(maxline)] != "off"} {
    if {![info exists maxflood]} { set maxflood "1 [expr {[clock seconds] + [config maxfloodtime]}]" }
    if {![info exists cloak]} {
      if {[lindex $maxflood 0] == [expr {[config maxfloodlines] - 1}]} {
        synecho x "[eheader "Flood"] [b]MAX Flood[b] exceeded.. cloaking.."
        unset maxflood
        /cloak
      } else {
        set maxflood "[expr {[lindex $maxflood 0] + 1}] [lindex $maxflood 1]"
      }
    }
  }
}
proc inc_ctcpflood { addr } {
  global ctcpflood
  if {[get_cookie tog(ctcpline)] != "off"} {
    set addr [join [string tolower $addr]]
    if {![info exists ctcpflood($addr)]} {
      set ctcpflood($addr) "1 [expr {[clock seconds] + [config ctcpfloodtime]}]"
    } elseif {[lindex $ctcpflood($addr) 0] == [expr {[config ctcpfloodlines] - 1}]} {
      synecho x "[eheader "Flood"] [b]CTCP Flooding[b] detected from address ([b]$addr[b]).."
      /ignore $addr +cxd
      unset ctcpflood($addr)
    } else {
      set ctcpflood($addr) "[expr {[lindex $ctcpflood($addr) 0] + 1}] [lindex $ctcpflood($addr) 1]"
    }
  }
  inc_maxflood
}
proc inc_xdccflood { addr } {
  global xdccflood
  if {[get_cookie tog(xdccline)] != "off"} {
    set addr [join [string tolower $addr]]
    if {![info exists xdccflood($addr)]} {
      set xdccflood($addr) "1 [expr {[clock seconds] + [config xdccfloodtime]}]"
    } elseif {[lindex $xdccflood($addr) 0] == [expr {[config xdccfloodlines] - 1}]} {
      synecho x "[eheader "Flood"] [b]xdcc Flooding[b] detected from address ([b]$addr[b]).."
      /ignore $addr +x
      unset xdccflood($addr)
    } else {
      set xdccflood($addr) "[expr {[lindex $xdccflood($addr) 0] + 1}] [lindex $xdccflood($addr) 1]"
    }
  }
  inc_maxflood
}
proc logevent { type idlet text } {
  global logevents
  set x ""
  foreach event $logevents { if {"[lindex $event 0]" == $type} { set x "[lindex $event 1]" } }
  if {[string length $x]} {
    if {![file exists "[get_syn_dir]/syntax/logs/$x"]} {
      set xx "[open "[get_syn_dir]/syntax/logs/$x" w]"
      close $xx
    }
    if {[file writable "[get_syn_dir]/syntax/logs/$x"]} {
      set y [open "[get_syn_dir]/syntax/logs/$x" a+]
      puts $y "[applylogstyle $type $idlet $text]"
      close $y
      return 1
    } else { return 0 }
  } else { return 0 }
}

####
#### Stylin Bitz
####

proc shade { x 1 2 3 } {
  set x [colorstrip $x]
  if {[string length $x] <= 2} { return "$1$x"
  } elseif {[string length $x] == 3} { return "$1[string range $x 0 0]$2[string range $x [expr {[string length $x] - 2}] [expr {[string length $x] - 2}]]$1[string range $x [expr {[string length $x] - 1}] [expr {[string length $x] - 1}]]"
  } else { return "$1[string range $x 0 0]$2[string range $x 1 1]$3[string range $x 2 [expr {[string length $x] - 3}]]$2[string range $x [expr {[string length $x] - 2}] [expr {[string length $x] - 2}]]$1[string range $x [expr {[string length $x] - 1}] [expr {[string length $x] - 1}]]" }
}

proc lf { } { return "" }
proc motdheader { } { global theme ; return "[eval "return $theme(motdheader)"]" }
proc motdend { } { global theme ; return "[eval "return $theme(motdend)"]" }
proc motdstart { } { global theme ; return "[eval "return $theme(motdstart)"]" }
proc chanbanned { banmask chan placer date } { global theme ; return "[eval "return $theme(chanbanned)"]" }
proc applyjoinledge { } { global theme ; return "[eval "return $theme(joinnamesledge)"]" }
proc applyjoinlseperator { } { global theme ; return "[eval "return $theme(joinnameslsep)"]" }
proc opervisiontag { } { global theme ; return "[eval "return $theme(opervisiontag)"]" }
proc lrb { } { global theme ; return "[eval "return $theme(lrb)"]" }
proc llb { } { global theme ; return "[eval "return $theme(llb)"]" }
proc modesortorder { } { global theme ; return "[eval "return $theme(modesortorder)"]" }
proc boldstart { } { global theme ; return "[eval "return $theme(bold)"]" }
proc lightboldstart { } { global theme ; return "[eval "return $theme(lightbold)"]" }
proc underlinestart { } { global theme ; return "[eval "return $theme(underline)"]" }
proc lightunderlinestart { } { global theme ; return "[eval "return $theme(lightunderline)"]" }
proc ovlinkin { } { global theme ; return "[eval "return $theme(ovlinkin)"]" }
proc ovlinkout { } { global theme ; return "[eval "return $theme(ovlinkout)"]" }
proc ovlinkbroke { } { global theme ; return "[eval "return $theme(ovlinkbroke)"]" }
proc ovledge { } { global theme ; return "[eval "return $theme(ovledge)"]" }
proc ovredge { } { global theme ; return "[eval "return $theme(ovredge)"]" }
proc servertag { } { global theme ; return "[eval "return $theme(servertag)"]" }
proc applypercentbar1 { } { global theme ; return "[eval "return $theme(percentbar1)"]" }
proc applypercentbar2 { } { global theme ; return "[eval "return $theme(percentbar2)"]" }
proc applypercentbar3 { } { global theme ; return "[eval "return $theme(percentbar3)"]" }
proc applypercentbar4 { } { global theme ; return "[eval "return $theme(percentbar4)"]" }
proc applypercentbar5 { } { global theme ; return "[eval "return $theme(percentbar5)"]" }
proc syn { } { global theme ; return "[eval "return $theme(defbullet)"]" }
proc applymainwindowquery { } { global theme ; return "[eval "return $theme(mainwindowquery)"]" }
proc applymainwindowchat { } { global theme ; return "[eval "return $theme(mainwindowdcc)"]" }
proc applymainwindowstat { } { global theme ; return "[eval "return $theme(mainwindowstat)"]" }
proc applymainwindowchan { } { global theme ; return "[eval "return $theme(mainwindowchan)"]" }
proc applymainwindowdiscon { } { global theme ; return "[eval "return $theme(mainwindowdcon)"]" }
proc applystatuswindowcon { } { global theme ; return "[eval "return $theme(statuswindowcon)"]" }
proc applystatuswindowdcon { } { global theme ; return "[eval "return $theme(statuswindowdcon)"]" }
proc applychannelwindow { chan mode cmode topic } { global theme ; return "[eval "return $theme(channelwindow)"]" }
proc applydccline1 { num type start nick filename complete total elapsed remaining speed pbar } { global theme ; return "[eval "return $theme(dccline1)"]" }
proc applydccline2 { num type start nick filename complete total elapsed remaining speed pbar } { global theme ; return "[eval "return $theme(dccline2)"]" }
proc applyawaymsgstyle { text pager msglog time  } { global theme ; return "[eval "return $theme(awaymsg)"]" }
proc applyrawawaymsgstyle { text pager msglog time } { global theme ; return "[eval "return $theme(rawawaymsg)"]" }
proc spylinktag { dest } { global theme ; return "[eval "return $theme(spylinktag)"]" }
proc applybackmsgstyle { text pager time } { global theme ; return "[eval "return $theme(backmsg)"]" }
proc applyrelsmvars { nick type text } { global theme ; return "[eval "return $theme(smsgrelay)"]" }
proc applyrelmvars { nick user host type text } { global theme ; return "[eval "return $theme(msgrelay)"]" }
proc applyrelokvars { nick oper killcount text } { global theme ; return "[eval "return $theme(operkillrelay)"]" }
proc boxtop { text } { global theme ; return "[eval "return $theme(boxtop)"]" }
proc boxside { text } { global theme ; return "[eval "return $theme(boxside)"]" }
proc boxbottom { text } { global theme ; return "[eval "return $theme(boxbottom)"]" }
proc gboxtop { } { global theme ; return "[eval "return $theme(gboxtop)"]" }
proc gboxside { text } { global theme ; return "[eval "return $theme(gboxside)"]" }
proc gboxbottom { } { global theme ; return "[eval "return $theme(gboxbottom)"]" }
proc applychannelwallopstyle { chan text count percent } { global theme ; return "[eval "return $theme(channelwallop)"]" }
proc applydccselftext { nick text } { global theme ; return "[eval "return $theme(dccselftext)"]" }
proc applydccselfaction { nick text } { global theme ; return "[eval "return $theme(dccselfaction)"]" }
proc applydccusertext { nick text } { global theme ; return "[eval "return $theme(dccusertext)"]" }
proc applydccuseraction { nick text } { global theme ; return "[eval "return $theme(dccuseraction)"]" }
proc applyschannelwallopstyle { chan text } { global theme ; return "[eval "return $theme(schanwallopstyle)"]" }
proc applyuserwallopsstyle { nick user host text } { global theme ; return "[eval "return $theme(usrwallopsstyle)"]" }
proc applyserverwallopsstyle { host text } { global theme ; return "[eval "return $theme(srvwallopsstyle)"]" }
proc applywallopprefix { chan } { global theme ; return "[eval "return $theme(wallopprefix)"]" }
proc applyswallopsstyle { text } { global theme ; return "[eval "return $theme(ssrvwallopstyle)"]" }
proc applylogstyle { type idlet text } { global theme ; return "[eval "return $theme(logstyle)"]" }
proc applyselftext { nick text } { global theme ; return "[eval "return $theme(selftext)"]" }
proc applyselfaction { nick text } { global theme ; return "[eval "return $theme(selfaction)"]" }
proc applyusertext { nick text } { global theme ; return "[eval "return $theme(usertext)"]" }
proc applyuseraction { nick text } { global theme ; return "[eval "return $theme(useraction)"]" }
proc applymsgselftext { nick text } { global theme ; return "[eval "return $theme(msgselftext)"]" }
proc applymsgselfaction { nick text } { global theme ; return "[eval "return $theme(msgselfaction)"]" }
proc applymsgusertext { nick text } { global theme ; return "[eval "return $theme(msgusertext)"]" }
proc applymsguseraction { nick text } { global theme ; return "[eval "return $theme(msguseraction)"]" }
proc applyhighlighttext { nick text } { global theme ; return "[eval "return $theme(highlighttext)"]" }
proc applyhighlightaction { nick text } { global theme ; return "[eval "return $theme(highlightaction)"]" }
proc applywhoisstart { nick } { global theme ; return "[eval "return $theme(whoisstart)"]" }
proc applywhowasstart { nick } { global theme ; return "[eval "return $theme(whowasstart)"]" }
proc applywhoisaddr { nick user host type } { global theme ; return "[eval "return $theme(whoisaddr)"]" }
proc applywhoisquote { nick text } { global theme ; return "[eval "return $theme(whoisquote)"]" }
proc applywhoischan { nick text } { global theme ; return "[eval "return $theme(whoischan)"]" }
proc applywhoisdata { nick text } { global theme ; return "[eval "return $theme(whoisdata)"]" }
proc applywhoisaway { nick text } { global theme ; return "[eval "return $theme(whoisaway)"]" }
proc applywhoisserv { nick serv text } { global theme ; return "[eval "return $theme(whoisserv)"]" }
proc applywhoisidle { nick text } { global theme ; return "[eval "return $theme(whoisidle)"]" }
proc applywhoisoper { nick } { global theme ; return "[eval "return $theme(whoisoper)"]" }
proc applywhoishelpop { nick } { global theme ; return "[eval "return $theme(whoishelpop)"]" }
proc applywhoisend { nick } { global theme ; return "[eval "return $theme(whoisend)"]" }
proc applysmsgstyle { nick text } { global theme ; return "[eval "return $theme(smsgstyle)"]" }
proc applysactionstyle { nick text } { global theme ; return "[eval "return $theme(sactionstyle)"]" }
proc applysnoticestyle { nick text } { global theme ; return "[eval "return $theme(snoticestyle)"]" }
proc applysctcpstyle { nick req text } { global theme ; return "[eval "return $theme(sctcpstyle)"]" }
proc applymsgstyle { nick user host text } { global theme ; return "[eval "return $theme(msgstyle)"]" }
proc applyactionstyle { nick user host text } { global theme ; return "[eval "return $theme(actionstyle)"]" }
proc applyaopjoinstyle { nick user host chan } { global theme ; return "[eval "return $theme(aopjoinstyle)"]" }
proc applyakickjoinstyle { nick user host chan } { global theme ; return "[eval "return $theme(akickjoinstyle)"]" }
proc applyavoicejoinstyle { nick user host chan } { global theme ; return "[eval "return $theme(avoicejoinstyle)"]" }
proc applyjoinstyle { nick user host chan } { global theme ; return "[eval "return $theme(joinstyle)"]" }
proc applysjoinstyle { nick user host chan } { global theme ; return "[eval "return $theme(sjoinstyle)"]" }
proc applypartstyle { nick user host chan } { global theme ; return "[eval "return $theme(partstyle)"]" }
proc applyquitstyle { nick user host chan text } { global theme ; return "[eval "return $theme(quitstyle)"]" }
proc applymodestyle { nick user host chan text } { global theme ; return "[eval "return $theme(modestyle)"]" }
proc applysmodestyle { host chan text } { global theme ; return "[eval "return $theme(servmodestyle)"]" }
proc applytopicstyle { nick user host chan text } { global theme ; return "[eval "return $theme(topicstyle)"]" }
proc applykickstyle { nick user host chan kicked text } { global theme ; return "[eval "return $theme(kickstyle)"]" }
proc applyskickstyle { nick user host chan text } { global theme ; return "[eval "return $theme(skickstyle)"]" }
proc applynickstyle { nick user host newnick } { global theme ; return "[eval "return $theme(nickstyle)"]" }
proc applysnickstyle { nick user host newnick } { global theme ; return "[eval "return $theme(snickstyle)"]" }
proc applycctcpstyle { nick user host chan req text } { global theme ; return "[eval "return $theme(cctcpstyle)"]" }
proc applyctcpstyle { nick user host req text } { global theme ; return "[eval "return $theme(ctcpstyle)"]" }
proc applyctcprstyle { nick user host req text } { global theme ; return "[eval "return $theme(ctcpreplystyle)"]" }
proc applynoticestyle { nick user host text } { global theme ; return "[eval "return $theme(noticestyle)"]" }
proc applycnoticestyle { nick user host chan text } { global theme ; return "[eval "return $theme(cnoticestyle)"]" }
proc applyjointopic { chan text } { global theme ; return "[eval "return $theme(jointopic)"]" }
proc applyjointopicsetby { chan nick date } { global theme ; return "[eval "return $theme(jointopicsetby)"]" }
proc applyjoinlstart { chan } { global theme ; return "[eval "return $theme(joinnameslstart)"]" }
proc applyjoinlentry { mode nick } { global theme ; return "[eval "return $theme(joinnameslentry)"]" }
proc applyjoinlend { chan } { global theme ; return "[eval "return $theme(joinnameslend)"]" }
proc applyxwallopstyle { text count } { global theme ; return "[eval "return $theme(xwallop)"]" }
proc applysxwallopstyle { text count } { global theme ; return "[eval "return $theme(sxwallopstyle)"]" }
proc applyjoinnames { chan total ops nonops voice unvoice } { global theme ; return "[eval "return $theme(joinnames)"]" }
proc applyjoinsynch { chan text } { global theme ; return "[eval "return $theme(joinsynch)"]" }
proc applyjoinmodes { chan text } { global theme ; return "[eval "return $theme(joinmodes)"]" }
proc applyjoincreated { chan text } { global theme ; return "[eval "return $theme(joincreated)"]" }
proc applyjoinurl { chan text } { global theme ; return "[eval "return $theme(joinurl)"]" }
proc applynickcomplete { nick } { global theme ; return "[eval "return $theme(nickcomplete)"]" }
proc eheader { text } { global theme ; return "[eval "return $theme(eheader)"]" }
proc loadechostyle { text } { global theme ; return "[eval "return $theme(loadechostyle)"]" }
proc kickstyle { text } { global theme ; return "[eval "return $theme(kickmsgstyle)"]" }
proc applytextfloodkickmsg { chan lines seconds } { global theme ; return "[eval "return $theme(textfloodkick)"]" }
proc applyjoinfloodkickmsg { chan joins seconds } { global theme ; return "[eval "return $theme(joinfloodkick)"]" }
proc applynickfloodkickmsg { chan changes seconds } { global theme ; return "[eval "return $theme(nickfloodkick)"]" }
proc applytextoverflowkickmsg { chan maxlen len } { global theme ; return "[eval "return $theme(textoverflowkick)"]" }
proc applymassdeopkickmsg { chan deops seconds } { global theme ; return "[eval "return $theme(massdeopkick)"]" }
proc applymasskickkickmsg { chan kicks seconds } { global theme ; return "[eval "return $theme(masskickkick)"]" }
proc applyviolationfloodkickmsg { chan violations seconds } { global theme ; return "[eval "return $theme(viofloodkick)"]" }
proc applyrepeatkickmsg { chan } { global theme ; return "[eval "return $theme(repeatkick)"]" }
proc applynotifylogon { nick user host text } { global theme ; return "[eval "return $theme(notifylogon)"]" }
proc applynotifylogoff { nick text } { global theme ; return "[eval "return $theme(notifylogoff)"]" }
proc applyoperkillstyle { nick oper killcount text } { global theme ; return "[eval "return $theme(operkillstyle)"]" }
proc applyselfspylinktext { nick text } { global theme ; return "[eval "return $theme(selfspylinktext)"]" }
proc applyselfspylinkmsg { nick text } { global theme ; return "[eval "return $theme(selfspylinkmsg)"]" }

proc applydecryptedselftext { nick text } { global theme ; return "[eval "return $theme(decryptedslftext)"]" }
proc applydecryptedusertext { nick text } { global theme ; return "[eval "return $theme(decryptedusrtext)"]" }
proc applydecryptedmsgstyle { nick user host text } { global theme ; return "[eval "return $theme(decryptedmsg)"]" }
proc applyscryptedmsgstyle { nick text } { global theme ; return "[eval "return $theme(scryptedmsgstyle)"]" }

proc applydccrecvcomplete { nick filename size elapsed kbps } { global theme ; return "[eval "return $theme(dccrecvcomplete)"]" }
proc applydccsendcomplete { nick filename size elapsed kbps } { global theme ; return "[eval "return $theme(dccsendcomplete)"]" }
proc applydccrecvrequest { nick filename size } { global theme ; return "[eval "return $theme(dccrecvrequest)"]" }
proc applydccsendrequest { nick filename size } { global theme ; return "[eval "return $theme(dccsendrequest)"]" }
proc applydccrecvstarted { nick filename size } { global theme ; return "[eval "return $theme(dccrecvstarted)"]" }
proc applydccsendstarted { nick filename size } { global theme ; return "[eval "return $theme(dccsendstarted)"]" }
proc applydccrecvterminated { nick filename size complete } { global theme ; return "[eval "return $theme(dccrecvtermd)"]" }
proc applydccsendterminated { nick filename size complete } { global theme ; return "[eval "return $theme(dccsendtermd)"]" }

proc b { } { global bx theme ; if {$bx == 1} { set bx 0 ; return "[eval "return $theme(bold)"]" } else { set bx 1 ; return "" } }
proc sb { } { global bsx theme ; if {$bsx == 1} { set bsx 0 ; return "[eval "return $theme(lightbold)"]" } else { set bsx 1 ; return "" } }
proc u { } { global ux theme ; if {$ux == 1} { set ux 0 ; return "[eval "return $theme(underline)"]" } else { set ux 1 ; return "" } }
proc su { } { global su theme ; if {$su == 1} { set su 0 ; return "[eval "return $theme(lightunderline)"]" } else { set su 1 ; return "" }  }

proc loadecho { text } {
  if {[window_type] != "status"} { echo "[loadechostyle "$text"]" }
  echo "[loadechostyle "$text"]" status
}

alias restoretheme {
  echo "\[%%%\] EMERGENCY THEME RESTORE INITIATED..."
  restoretheme
  complete
}
proc restoretheme { } {
  global theme stylevarz stylevar
  proc timerA { } { return "[string tolower [clock format [clock seconds] -format "11@14\[10%I14:10%M14:10%S14%p14\]"]]" }
  proc timerB { } { return "[string tolower [clock format [clock seconds] -format "11@14\[10%I14:10%M14:10%S14%p14\]"]]" }
  proc dbullet { } { return "14:15:16:15" }
  proc abullet { } { return "14÷15÷16÷15" }
  proc mbullet { } { return "14=15=16=15" }
  set stylevar(timerA) "\"\[string tolower \[clock format \[clock seconds\] -format \"11@14\\\[10%I14:10%M14:10%S14%p14\\\]\"\]\]\""
  set stylevar(timerB) "\"\[string tolower \[clock format \[clock seconds\] -format \"11@14\\\[10%I14:10%M14:10%S14%p14\\\]\"\]\]\""
  set stylevar(dbullet) "\"14:15:16:15\""
  set stylevar(abullet) "\"14÷15÷16÷15\""
  set stylevar(mbullet) "\"14=15=16=15\""
  set theme(bold) "\"\\\x02\\\00316\""
  set theme(lightbold) "\"\\\00316\""
  set theme(underline) "\"\\\x1F\\\00316\""
  set theme(lightunderline) "\"\\\x1F\\\00316\""
  set theme(channelwallop) "\"(ops/\$chan) \$text\""
  set theme(xwallop) "\"(xwallop) \$text\""
  set theme(wallopprefix) "\"14\\\[16wallop14\\\] \""
  set theme(schanwallopstyle) "\"\[dbullet\] (16wallop15(\$chan) \$text\""
  set theme(sxwallopstyle) "\"\[dbullet\] (16xwallop15(\[join \[config xwallnicks\] \",\"\]) \$text\""
  set theme(ssrvwallopstyle) "\"14Ä15Ä16> 14(15WallOps14)15 \$text\""
  set theme(srvwallopsstyle) "\"16!15\$host16!15 \$text\""
  set theme(usrwallopsstyle) "\"16!15\$nick\\\(\$user@\$host\\\)16!15 \$text\""
  set theme(modesortorder) "\"+iklmnpst\""
  set theme(dccselftext) "\"\[shade \"<\$nick>\" 14 15 16\] 15\$text\""
  set theme(dccselfaction) "\"ù \[shade \"\$nick\" 14 15 16\] 15\$text\""
  set theme(dccusertext) "\"<16\$nick15> 15\$text\""
  set theme(dccuseraction) "\"ù 16\$nick15 15\$text\""
  set theme(selftext) "\"\[shade \"<\$nick>\" 14 15 16\] 15\$text\""
  set theme(selfaction) "\"ù \[shade \"\$nick\" 14 15 16\] 15\$text\""
  set theme(highlighttext) "\"\[shade \"<\$nick>\" 14 10 11\] 15\$text\""
  set theme(highlightaction) "\"ù \[shade \"\$nick\" 14 10 11\] 15\$text\""
  set theme(usertext) "\"<16\$nick15> 15\$text\""
  set theme(useraction) "\"ù 16\$nick15 15\$text\""
  set theme(decryptedslftext) "\"\[shade \"<\$nick>\" 14 15 16\]16crypt14> 15\$text\""
  set theme(decryptedusrtext) "\"<16\$nick15>16crypt14> 15\$text\""
  set theme(percentbar1) "\"14o15\""
  set theme(percentbar2) "\"15o15\""
  set theme(percentbar3) "\"16o15\""
  set theme(percentbar4) "\"5o15\""
  set theme(percentbar5) "\"4o15\""
  set theme(dccline1) "\"\[llb\]\[b\]\[align \$num 2\]\[b\]\[lrb\]\[llb\]\[b\]\[align \$type 10\]\[b\]\[lrb\]\[llb\]\[align \$nick 10\]\[lrb\]\[llb\]\[align \$filename 20\]\[lrb\]\[llb\]\[align \[string tolower \[clock format \$start -format \"%I:%M%p\"\]\] 10\]\[lrb\]\""
  set theme(dccline2) "\"\[llb\]\[b\]  \[b\]\[lrb\]\[llb\]\[align \$complete 10\]\[lrb\]\[llb\]\[align \$total 10\]\[lrb\]\[llb\]\[align \$pbar 20\]\[lrb\]\[llb\]\[align \$speed 10\]\[lrb\]\""
  set theme(aopjoinstyle) "\"\[mbullet\] 14(11join(autoop)14\\\\\\10\$chan14) 11\$nick14\\\[10\$user14@10\$host14\\\] \[timerA\]\""
  set theme(akickjoinstyle) "\"\[mbullet\] 14(11join(autokick)14\\\\\\10\$chan14) 11\$nick14\\\[10\$user14@10\$host14\\\] \[timerA\]\""
  set theme(avoicejoinstyle) "\"\[mbullet\] 14(11join(autovoice)14\\\\\\10\$chan14) 11\$nick14\\\[10\$user14@10\$host14\\\] \[timerA\]\""
  set theme(joinstyle) "\"\[mbullet\] 14(11join14\\\\\\10\$chan14) 11\$nick14\\\[10\$user14@10\$host14\\\] \[timerA\]\""
  set theme(sjoinstyle) "\"\[mbullet\] 14(11join14\\\\\\10\$chan14) 11\$nick14\\\[10\$user14@10\$host14\\\] \[timerA\]\""
  set theme(partstyle) "\"\[mbullet\] 14(11part14\\\\\\10\$chan14) 11\$nick14\\\[10\$user14@10\$host14\\\] \[timerA\]\""
  set theme(quitstyle) "\"\[mbullet\] 14(11signoff14\\\\\\10\$chan14) 11\$nick14\\\[10\$user14@10\$host14\\\] \[timerA\] 14\\\[15\$text14\\\]15\""
  set theme(servmodestyle) "\"\[mbullet\] 14(11servermode14\\\\\\10\$chan14) 11\$host15 sets mode 14\\\[15\$text14\\\]15\""
  set theme(modestyle) "\"\[mbullet\] 14(11mode14\\\\\\10\$chan14) 11\$nick14\\\[10\$user14@10\$host14\\\]15 sets mode 14(15\$text14)15\""
  set theme(topicstyle) "\"\[mbullet\] 14(11topic14\\\\\\10\$chan14) 11\$nick14\\\[10\$user14@10\$host14\\\]15 sets topic 14(15\$text14)15\""
  set theme(kickstyle) "\"\[mbullet\] 14(11kick14\\\\\\10\$chan14) 11\$nick14\\\[10\$user14@10\$host14\\\]15 kicked 14\\\[10\$kicked14\\\]15 off \$chan 14\\\[15\$text14\\\]15\""
  set theme(skickstyle) "\"\[mbullet\] 14(11kick14\\\\\\10\$chan14) 11\$nick14\\\[10\$user14@10\$host14\\\]15 kicked YOU off \$chan 14\\\[15\$text14\\\]15\""
  set theme(nickstyle) "\"\[mbullet\] 14(11nick14\\\\\\10change14) 10\$nick14 14Ä15Ä16> 11\$newnick14\""
  set theme(snickstyle) "\"\[mbullet\] 14(11nick14\\\\\\10change14) 10\$nick14 14Ä15Ä16> 11\$newnick14\""
  set theme(ctcpreplystyle) "\"(16\$nick15(\$user@\$host) \$req Reply) \$text\""
  set theme(ctcpstyle) "\"(16\$nick15(\$user@\$host) \$req) \$text\""
  set theme(cctcpstyle) "\"(16\$nick15(\$user@\$host)(16\$chan15) \$req) \$text\""
  set theme(msgstyle) "\"14>4>5>15 16msg15(16\$nick15(\$user@\$host)) \$text\""
  set theme(decryptedmsg) "\"14>4>5>15 16c-msg15(16\$nick15(\$user@\$host)) \$text\""
  set theme(actionstyle) "\"14>4>5>15 16action15(16\$nick15(\$user@\$host)) ù 16\$nick15 \$text\""
  set theme(noticestyle) "\"-16\$nick15(\$user@\$host)- \$text\""
  set theme(msgselftext) "\"14\\\[\[align \"\[shade \"\$nick\" 14 15 16\]\" 10\]14) 15\$text\""
  set theme(msgselfaction) "\"ù 14\\\[\[shade \"\$nick\" 14 15 16\]14\\\] 15\$text\""
  set theme(msgusertext) "\"14\\\[16\[align \"\$nick\" 10\]14) 15\$text\""
  set theme(msguseraction) "\"ù 14\\\[16\$nick14\\\]15 \$text\""
  set theme(cnoticestyle) "\"-16\$nick15(\$user@\$host):16\$chan15- \$text\""
  set theme(smsgstyle) "\"14>4>5>15 (16msg15(\$nick)) \$text\""
  set theme(scryptedmsgstyle) "\"14>4>5>15 (16crypted-msg15(\$nick)) \$text\""
  set theme(sctcpstyle) "\"14>4>5>15 (16ctcp15(\$nick)) (16\$req15) \$text\""
  set theme(snoticestyle) "\"14>4>5>15 (16notice15(\$nick)) \$text\""
  set theme(sactionstyle) "\"14>4>5>15 (16action15(\$nick)) \$text\""
  set theme(whowasstart) "\"14ÚÄÄ15Ä16-15Ä14ÄÄ(( whowas information: 16\$nick14 ))ÄÄ-Ä-Ä15Ä16-15Ä15Ä14Ä--ÄÄ-Ä15Ä-16Ä-Ä 14-Ä15Ä16-Ä- 15-16Ä\""
  set theme(whoisstart) "\"14ÚÄÄ15Ä16-15Ä14ÄÄ(( whois information: 16\$nick14 ))ÄÄ-Ä-Ä15Ä16-15Ä15Ä14Ä--ÄÄ-Ä15Ä-16Ä-Ä 14-Ä15Ä16-Ä- 15-16Ä\""
  set theme(whoisaddr) "\"14³ 16address   14ð15 \$user14@15\$host 14\\\[15\$type14\\\]15\""
  set theme(whoisquote) "\"14³ 16quote     14ð15 \$text\""
  set theme(whoisdata) "\"14³ 16userinfo  14ð15 flags14(16\[lindex \$text 1\]14)15 channels14(16\[lindex \$text 0\]14)\""
  set theme(whoischan) "\"14³ 16channels  14ð15 \[replace \[replace \"\$text\" \"#\" \"16#15\"\] \"@\" \"16@15\"\]\""
  set theme(whoisserv) "\"14³ 16server    14ð15 16\$serv:15 \$text\""
  set theme(whoisidle) "\"14³ 16idle      14ð15 \[durationstyle \$text \" year\" \" day\" \" hour\" \" minute\" \" second\" \"s\" \" \" \"\[boldstart\]\" \"\"\]\""
  set theme(whoisaway) "\"14³ 16away      14ð15 \$text\""
  set theme(whoisoper) "\"14³ 16operator  14ð ..16!@#\$15\""
  set theme(whoishelpop) "\"14³ 16helpop    14ð ..16!@#\$15\""
  set theme(whoisend) "\"14ÀÄÄ15Ä16-15Ä14ÄÄÄÄÄÄÄ15Ä16Ä-15ÄÄ15Ä14ÄÄÄ--ÄÄÄ-Ä15ÄÄ-16ÄÄ-Ä 14Ä-Ä15Ä16-ÄÄ- 15-16Ä\""
  set theme(awaymsg) "\"is gone... \$text <since(\[string tolower \[clock format \$time -format \"%I:%M%p\"\]\])> <(l\\\\\$msglog p\\\\\$pager)syntax>\""
  set theme(backmsg) "\"is back... \$text\""
  set theme(rawawaymsg) "\"\$text <since(\[string tolower \[clock format \$time -format \"%I:%M%p\"\]\])>\""
  set theme(jointopic) "\"\[abullet\] (16topic\\\[15\$chan16\\\]15) \$text\""
  set theme(jointopicsetby) "\"\[abullet\] (16topic\\\[15\$chan16\\\]15) set by 16\$nick15 on \$date\""
  set theme(joinnames) "\"\[abullet\] (16names\\\[15\$chan16\\\]15) Listing users on 16\$chan15(16\$total15)\""
  set theme(joinnameslstart) "\"\[abullet\] 14ÚÄÄ15Ä16-15Ä14ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-Ä-Ä15Ä16-15Ä15Ä14Ä--ÄÄ-Ä15Ä-16Ä-Ä 14-Ä15Ä16-Ä- 15-16Ä\""
  set theme(joinnamesledge) "\"\[abullet\] 14³15\""
  set theme(joinnameslsep) "\"14ð\""
  set theme(joinnameslentry) "\"16\$mode15\[align \$nick 10\]\""
  set theme(joinnameslend) "\"\[abullet\] 14ÀÄÄ15Ä16-15Ä14ÄÄÄÄÄÄÄ15Ä16Ä-15ÄÄ15Ä14ÄÄÄ--ÄÄÄ-Ä15ÄÄ-16ÄÄ-Ä 14Ä-Ä15Ä16-ÄÄ- 15-16Ä\""
  set theme(joinsynch) "\"\[abullet\] (16synch\\\[15\$chan16\\\]15) 16\$text15 seconds\""
  set theme(joinmodes) "\"\[abullet\] (16modes\\\[15\$chan16\\\]15) 16\$text15\""
  set theme(joincreated) "\"\[abullet\] (16crted\\\[15\$chan16\\\]15) \$text\""
  set theme(joinurl) "\"\[abullet\] (16url  \\\[15\$chan16\\\]15) \$text\""
  set theme(kickmsgstyle) "\"<syn> \$text\""
  set theme(viofloodkick) "\"Violation Defiance on \$chan: \$violations violations in \$seconds seconds...\""
  set theme(textfloodkick) "\"TextFlood Detected on \$chan: \$lines lines in \$seconds seconds...\""
  set theme(nickfloodkick) "\"NickFlood Detected on \$chan: \$changes changes in \$seconds seconds...\""
  set theme(joinfloodkick) "\"JoinFlood Detected on \$chan: \$joins joins in \$seconds seconds...\""
  set theme(textoverflowkick) "\"TextFlood Detected on \$chan: \$len > \$maxlen character string max...\""
  set theme(massdeopkick) "\"MassDeop Detected on \$chan: \$deops deops in \$seconds seconds...\""
  set theme(masskickkick) "\"MassKick Detected on \$chan: \$kicks kicks in \$seconds seconds...\""
  set theme(repeatkick) "\"Repeating Detected on \$chan...\""
  set theme(msgrelay) "\"(\$nick(\$user@\$host) \$text\""
  set theme(smsgrelay) "\"(\$type(\$nick) \$text\""
  set theme(operkillrelay) "\"((OperKill)) \$nick was killed by \$oper(\$killcount) (\$text)\""
  set theme(nickcomplete) "\"\$nick:\""
  set theme(notifylogon) "\"\[abullet\] ((16Logon15)) \[timerA\] 11\$nick14\\\[10\$user14@10\$host14\\\]15 is on IRC 14\\\[15\$text14\\\]15...\""
  set theme(notifylogoff) "\"\[abullet\] ((16Logoff15)) \[timerA\] 10\$nick15 has left IRC...\""
  set theme(operkillstyle) "\"\[abullet\] ((16OperKill15)) 16\$nick15 was killed by 16\$oper14\\\(16\$killcount14\\\)15 14(15\$text14)\""
  set theme(boxtop) "\"14ÚÄÄ15Ä16-15Ä14ÄÄÍ4\\\[5\\\[ \$text 5\\\]4\\\]14ÍÄÄ-Ä-Ä15Ä16-15Ä15Ä14Ä-Ä15Ä-16Ä-Ä 14-Ä15Ä16-Ä- 15-16Ä\""
  set theme(boxside) "\"14³15 \$text\""
  set theme(boxbottom) "\"14ÀÄÄ15Ä16-15Ä14ÄÄÄÄÄÄÄ15Ä16Ä-15ÄÄ15Ä14ÄÄÄ--ÄÄÄ-Ä15ÄÄ-16ÄÄ-Ä 14Ä-Ä15Ä16-ÄÄ- 15-16Ä\""
  set theme(gboxtop) "\"14ÚÄÄ15Ä16-15Ä14ÄÄÄÄÄ-Ä-ÄÄÄÄÄ15Ä16Ä-15ÄÄ15Ä14ÄÄÄÄÄÄÄÄ-Ä-Ä15Ä16-15Ä15Ä14Ä-Ä15Ä-16Ä-Ä 14-Ä15Ä16-Ä- 15-16Ä\""
  set theme(gboxside) "\"14³15 \$text\""
  set theme(gboxbottom) "\"14ÀÄÄ15Ä16-15Ä14ÄÄÄÄÄÄÄ15Ä16Ä-15ÄÄ15Ä14ÄÄÄ--ÄÄÄ-Ä15ÄÄ-16ÄÄ-Ä 14Ä-Ä15Ä16-ÄÄ- 15-16Ä\""
  set theme(llb) "\"16\\\[15\""
  set theme(lrb) "\"16\\\]15\""
  set theme(eheader) "\"14(15(16\$text15)14)15\""
  set theme(mainwindowchan) "\"xIRC \\\[syntaxIRC\\\] \[my_nick\](\[my_user\]@\[my_host]\\\\\[lindex \[xserver\] 0\]) \[window_name\](m\\\[+\[mode \[window_name\]\]\\\] o\\\[\[llength \[clist +o \[window_name\]\]\]\\\] n\\\[\[llength \[clist -o \[window_name\]\]\]\\\] t\\\[\[llength \[clist all \[window_name\]\]\]\\\]) time(\[string tolower \[clock format \[clock seconds\] -format \"%I:%M:%S%p\"\]\]\)\""
  set theme(mainwindowstat) "\"xIRC \\\[syntaxIRC\\\] \[my_nick\](\[my_user\]@\[my_host]\\\\\[lindex \[xserver\] 0\]) (status window) time(\[string tolower \[clock format \[clock seconds\] -format \"%I:%M:%S%p\"\]\])\""
  set theme(mainwindowquery) "\"xIRC \\\[syntaxIRC\\\] \[my_nick\](\[my_user\]@\[my_host]\\\\\[lindex \[xserver\] 0\]) \[window_name\](query) time(\[string tolower \[clock format \[clock seconds\] -format \"%I:%M:%S%p\"\]\])\""
  set theme(mainwindowdcc) "\"xIRC \\\[syntaxIRC\\\] \[my_nick\](\[my_user\]@\[my_host]\\\\\[lindex \[xserver\] 0\]) \[window_name\](dcc) time(\[string tolower \[clock format \[clock seconds\] -format \"%I:%M:%S%p\"\]\])\""
  set theme(mainwindowdcon) "\"xIRC \\\[syntaxIRC\\\] \\\[disconnected\\\] time(\[string tolower \[clock format \[clock seconds\] -format \"%I:%M:%S%p\"\]\])\""
  set theme(statuswindowcon) "\"status\\\[connected\\\] \[my_nick\]\[expr \{\[string length \"\[my_host\]\"\]?\"(\[my_user\]@\[my_host\])\":\"\"\}\] mode(+\[mode\]) server(\[lindex \[xserver\] 0\](\[lindex \[xserver\] 1\]))\""
  set theme(statuswindowdcon) "\"status\\\[disconnected\\\]\""
  set theme(channelwindow) "\"\$chan (+\$mode) \$topic\""
  set theme(ovlinkin) "\"16<<15ÄÄ14Ä\""
  set theme(ovlinkout) "\"14Ä15ÄÄ16>>\""
  set theme(ovlinkbroke) "\"14Ä15Ä16\\\\15Ä14Ä\""
  set theme(ovledge) "\"14(\""
  set theme(defbullet) "\"14:15:16:\""
  set theme(ovredge) "\"14)\""
  set theme(servertag) "\"(16server15)\""
  set theme(selfspylinktext) "\"\[shade \"<\$nick>\" 14 15 16\]16spylink14>15 \$text\""
  set theme(selfspylinkmsg) "\"14>4>5>15 (16spylink14\\16msg15(\$nick)) \$text\""
  set theme(opervisiontag) "\"14<15o16v14>15\""
  set theme(logstyle) "\"(\$idlet) \[string tolower \[clock format \[clock seconds\] -format \"\\\[%m/%d/%y %I:%M:%S%p\\\]\"\]\] \$text\""
  set theme(spylinktag) "\"(\$dest)\""
  set theme(motdheader) "\"14\\\[16m15otd14\\\]\""
  set theme(motdstart) "\"14\\\[16m15otd14 16s15tart14\\\]\""
  set theme(motdend) "\"14\\\[16m15otd14 16e15nd14\\\]\""
  set theme(chanbanned) "\"\[eheader \"Banned\"\] Ban \[b\]\$banmask\[b\]\\\[\[sb\]\$chan\[sb\]\\\] was placed by \[b\]\[lindex \[split \$placer \"!@\"\] 0\]\[b\](\[sb\]\[lindex \[split \$placer \"!@\"\] 1\]@\[lindex \[split \$placer \"!@\"\] 2\]\[sb\]) on \[clock format \$date -format \"%m/%d/%y at %I:%M:%S%p\"\]...\""
  set theme(loadechostyle) "\"14%15%16%15 \[eheader \"Load\"\] \$text\""
  set theme(dccrecvcomplete) "\"\[eheader \"dcc\"\] Transfer completed(\[sb\]get\[sb\]\\\\\[b\]\$filename\[b\]\\\[\[sb\]\$\{size\}k\[sb\]\\\]) from \[b\]\$nick\[b\] in \[sb\]\$\{elapsed\}\[sb\]secs \\\[\[sb\]\$kbps\[sb\] kbps\\\]...\""
  set theme(dccsendcomplete) "\"\[eheader \"dcc\"\] Transfer completed(\[sb\]send\[sb\]\\\\\[b\]\$filename\[b\]\\\[\[sb\]\$\{size\}k\[sb\]\\\]) to \[b\]\$nick\[b\] in \[sb\]\$\{elapsed\}\[sb\]secs \\\[\[sb\]\$kbps\[sb\] kbps\\\]...\""
  set theme(dccrecvrequest) "\"\[eheader \"dcc\"\] Transfer request(\[sb\]get\[sb\]\\\\\[b\]\$filename\[b\]\\\[\[sb\]\$\{size\}k\[sb\]\\\]) from \[b\]\$nick\[b\]...\""
  set theme(dccsendrequest) "\"\[eheader \"dcc\"\] Transfer request(\[sb\]send\[sb\]\\\\\[b\]\$filename\[b\]\\\[\[sb\]\$\{size\}k\[sb\]\\\]) to \[b\]\$nick\[b\]...\""
  set theme(dccrecvstarted) "\"\[eheader \"dcc\"\] Transfer established(\[sb\]get\[sb\]\\\\\[b\]\$filename\[b\]\\\[\[sb\]\$\{size\}k\[sb\]\\\]) from \[b\]\$nick\[b\]...\""
  set theme(dccsendstarted) "\"\[eheader \"dcc\"\] Transfer established(\[sb\]send\[sb\]\\\\\[b\]\$filename\[b\]\\\[\[sb\]\$\{size\}k\[sb\]\\\]) to \[b\]\$nick\[b\]...\""
  set theme(dccrecvtermd) "\"\[eheader \"dcc\"\] Transfer terminated(\[sb\]get\[sb\]\\\\\[b\]\$filename\[b\]\\\[\[sb\]\$\{size\}k\[sb\]\\\]) from \[b\]\$nick\[b\] \\\[broken at: \[sb\]\$\{complete\}k\[sb\]\\\]...\""
  set theme(dccsendtermd) "\"\[eheader \"dcc\"\] Transfer terminated(\[sb\]send\[sb\]\\\\\[b\]\$filename\[b\]\\\[\[sb\]\$\{size\}k\[sb\]\\\]) to \[b\]\$nick\[b\] \\\[broken at: \[sb\]\$\{complete\}k\[sb\]\\\]...\""
  return 1
}

####
#### Load All
####

 #>># Version Information

set interver 25
set internalver one
set syntax "syntax(one\\10.06.97) - abyss"

 #>># Dynamic Variables

if {![info exists env(rid)]} { set env(rid) 0 }
set spylinks ""
set grep_for ""
set synpath [info script]
set dccxfers ""
set varorder ""
set helpvarorder ""
set togspecial ""
set hasjoined ""
set dnsqueue ""
set synadd ""
set filterkickqueue ""
set statslqueue ""
set laginter 0
set chanfloodinter 0
set lagkillers ""
set timers ""
set noaddurl ""
set su 1
set ux 1
set bx 1
set bsx 1
set synver ""
set nickavoid ""
set tabs ""
set xidle 0
set dccs 0
set isontimer 0
set mstring "+hptnjdkrolemcbvwa"
set ustring "+123icobduv"
set logevents "{awaycapt awaycapt.log} {awaymsg awaymsgs.log} {user user.log} {personal personal.log}"
set ccode { af al dz as ad ao ai aq ag ar am aw au at az bs bh bd bb by be bz bj bm bt bo ba bw bv br io bn bg bf bi by kh cm ca cv ky cf td cl cn cx cc co km cg ck cr ci hr cu cy cs cz dk dj dm do tp ec eg sv gq ee et fk fo fj fi fr gf pf tf ga gm ge de gh gi gr gl gd gp gu gt gn gw gy ht hm hn hk hu is in id ir iq ie il it jm jp jo kz ke ki kp kr kw kg la lv lb ls lr ly li lt lu mo mk mg mw my mv ml mt mh mq mr mu mx fm md mc mn ms ma mz mm na nr np nl an nt nc nz ni ne ng nu nf mp no om pk pw pa pg py pe ph pn pl pt pr qa re ro ru rw kn lc vc ws sm st sa sn sc sl sg sk si sb so za es lk sh pm sd sr sj sz se ch sy tw tj tz th tg tk to tt tn tr tm tc tv ug ua ae uk gb us um uy su uz vu va ve vn vi vg wf eh ye yu zr zm zw com edu net mil org gov }
set cname {
  "Afghanistan" "Albania" "Algeria" "American Samoa" "Andorra" "Angola" "Anguilla" "Antarctica" "Antigua and Barbuda" "Argentina" "Armenia" "Aruba" "Australia" "Austria" "Azerbaijan" "Bahamas" "Bahrain" "Bangladesh" "Barbados" "Belarus" "Belgium" "Belize" "Benin" "Bermuda" "Bhutan" "Bolivia" "Bosnia" "Botswana" "Bouvet Island" "Brazil" "British Indian Ocean Territory" "Brunei Darussalam" "Bulgaria" "Burkina Faso" "Burundi" "Byelorrusian SSR" "Cambodiah" "Cameroon" "Canada" "Cap Verde" "Cayman Islands" "Central African Republic" "Chad" "Chile" "China" "Christmas Island" "Cocos (Keeling) Islands" "Columbia" "Comoros" "Congo" "Cook Islands" "Costa Rica" "Cote D'Ivoire" "Croatia and Hrvatska" "Cuba" "Cyprus" "Czechoslovakia" "Czech" "Denmark" "Djibouti" "Dominica" "Dominican Republic" "East Timor" "Ecuador" "Egypt" "El Salvador" "Equatorial Guinea" "Estonia" "Ethiopia" "Falkland Islands and Malvinas" "Faroe Islands" "Fiji" "Finland" "France" "French Guiana" "French Polynesia" "French Southern Territories" "Gabon" "Gambia" "Georgia" "Germany and Deutschland" "Ghana" "Gibraltar" "Greece" "Greenland" "Grenada" "Guadeloupe" "Guam" "Guatemala" "Guinea" "Guinea Bissau" "Gyana" "Haiti" "Heard and Mc Donald Islands" "Honduras" "Hong Kong" "Hungary" "Iceland" "India" "Indonesia" "Iran" "Iraq" "Ireland" "Israel" "Italy" "Jamaica" "Japan" "Jordan" "Kazakhstan" "Kenya" "Kiribati" "North Korea (Democratic)" "South Korea (Republic)" "Kuwait" "Kyrgystan" "Laos" "Latvia" "Lebanon" "Lesotho" "Liberia" "Libyan Arab Jamahiraya" "Liechtenstein" "Madagascar" "Luxembourg" "Macau" "Macadonia" "Madagascar" "Malawi" "Malaysia" "Maldives" "Mali" "Malta" "Marshall Islands"
  "Martinique" "Mauritania" "Mauritius" "Mexico" "Micronesia" "Moldova" "Monaco" "Mongolia" "Montserrat" "Morocco" "Mozambique" "Myanmar" "Namibia" "Naupu" "Nepal" "Netherlands" "Netherlands Antilles" "Neutral Zone" "New Caledonia" "New Zealand" "Nicaragua" "Niger" "Nigeria" "Niue" "Norfolk Island" "Norther Mariana Islands" "Norway" "Oman" "Pakistan" "Palau" "Panama" "Papua New Guinea" "Paraguay" "Peru" "Philippines" "Pitcairn" "Poland" "Portugal" "Puerto Rico" "Qatar" "Reunion" "Romania" "Russian Federation" "Rwanda" "Saint Kitts and Nevis" "Saint Lucia" "Saint Vincent and The Frenadines" "Samoa" "San Marino" "Sao Tome and Principe" "Saudi Arabia" "Senegal" "Seychelles" "Sierra Leone" "Singapore" "Slovakia" "Slovenia" "Solomon Islands" "Somolia" "South Africa" "Spain" "Sri Lanka" "St. Helena" "St. Pierra and Miquelon" "Sudan" "Suriname" "Svalbard and Jam Mayen Islands" "Swaziland" "Sweden" "Switzerland and Cantons of Helvetia" "Syyrian Arab Republic" "Taiwan" "Tajikistan" "Tanzania" "Thailand" "Togo" "Tokelau" "Tonga" "Trinidad and Tobagao" "Tunisia" "Turkey" "Turkmenistan" "Turks and Caicos Islands" "Tuvalu" "Uganda" "Ukrainian SSR" "United Arab Emirates" "United Kingdom" "Great Britain" "United States of America" "United States Minor Outlying Islands" "Uruguay" "Russia" "Uzbekistan" "Vanuatu" "Vatican City State" "Venezuela" "Viet Nam" "Virgin Islands (US)" "Virgin Islands (UK)" "Wallis and Futuna Islands" "Western Sahara" "Yemen" "Yugoslavia" "Zaire" "Zambia" "Zimbabwe" "Commercial Organization" "Educational Institution" "Networking Organization" "Military" "Non-Profit Organization" "Government"
}

addverquote msg "juDo ChOp@\!\!@\#\$"
addverquote msg "happy mart is where I get my love..."
addverquote action "is a street tough..."

 #>># Restore Config Settings

addconfig antiidle ci 30 dynamicinteger "3-90000" "AntiIdle Interval" "anti idle timer interval" sstring "Toggles Section"
addconfig awayintr ai 0 dynamicinteger "3-90000" "Away Msg Interval" "away message timer interval" sstring "Toggles Section"
addconfig autoaway ad 0 dynamicinteger "3-90000" "AutoAway Delay" "autoaway time" sstring "Toggles Section"
addconfig poplogon pl none string "*" "POP Server Logon" "pop server logon" sstring "Toggles Section"
addconfig poppass pp none passwordstring "*" "POP Server Password" "pop server password" sstring "Toggles Section"
addconfig popserver ps none string "*" "POP Server" "pop server" sepstring "Toggles Section"
addconfig relayslots rb 6 integer "1-20" "Relay Buffer" "relay buffer length" sstring "Toggles Section"
addconfig tabbuffer tb 6 integer "1-40" "Tab Buffer" "tab buffer length" sstring "Toggles Section"
addconfig autokickmenu au 1 boolean "" "AutoKick Menu" "autokick menu display" sstring "Toggles Section"
addconfig gainops go 1 boolean "" "Gainops" "gainops" sstring "Toggles Section"
addconfig autonickc ac 1 boolean "" "Auto Nickcomplete" "automatic nick completion" sstring "Toggles Section"
addconfig autograb ag 1 boolean "" "Autograb URLs" "autograb urls" sstring "Toggles Section"
addconfig wallformat fw 1 boolean "" "Wallop Formatting" "wallop formatting" sstring "Toggles Section"
addconfig querywindows qw 1 boolean "" "Query Windows" "query window display" sstring "Toggles Section"
addconfig autorejoin ar 0 boolean "" "AutoRejoin on Kick" "autorejoin when kicked" sstring "Toggles Section"
addconfig awaynickchange an 0 boolean "" "Away Mode Nickchange" "nickchange when set away" sstring "Toggles Section"
addconfig switchtab sk 0 boolean "" "Switch Control+D and Tab" "switching of Control+D and Tab keys" sstring "Toggles Section"
addconfig dispmotd md 0 boolean "" "Display MOTD" "the displaying of motd" sstring "Toggles Section"
addconfig awaypager ap 1 boolean "" "Away Pager" "away mode pager" sstring "Toggles Section"
addconfig selfbanprot sb 1 boolean "" "Self Ban Protection" "self ban protection" sstring "Toggles Section"
addconfig clearscore cs 1 boolean "" "Clear Score on Logon" "clear score on logon" sstring "Toggles Section"
addconfig viewkills vk 1 boolean "" "View OperKills" "the viewing of operkills" sstring "Toggles Section"
addconfig joinialupdate al 0 boolean "" "IAL Update on Join" "internal address list update on join" sstring "Toggles Section"
addconfig massfriendprot mf 1 boolean "" "MassMode Friend Protect" "massmode friend protection" sstring "Toggles Section"
addconfig backonkey cp 0 boolean "" "Auto Back on Keypress" "auto back on keypress" sstring "Toggles Section"
addconfig joinstats jc 1 boolean "" "Chanstats on Join" "channelstats on join" sstring "Toggles Section"
addconfig hideigctcp hi 0 boolean "" "Hide ignored ctcps" "hiding of ignored ctcps" sstring "Toggles Section"
addconfig awaynick ak "none" string "*" "Away Nickname" "away mode nickname" sstring "Toggles Section"
addconfig regnick gd "none" string "*" "Default Nickname" "default nickname" sstring "Toggles Section"
addconfig defum gu "+iwsk" string "*" "Default Usermodes" "default usermodes" sstring "Toggles Section"
addconfig operpass op "none" passwordstring "*" "Oper Password" "oper password" sstring "Toggles Section"
addconfig operuser ou "none" string "*" "Oper Username" "oper username" sstring "Toggles Section"
addconfig activelinklooker ll "1" boolean "" "Active LinkLooker" "active link looker" sstring "Toggles Section"
addconfig opervision ov "0" boolean "" "Oper Vision" "oper vision" sstring "Toggles Section"
addconfig servervision sv "0" boolean "" "View Server Notices" "the display of server notices" sstring "Toggles Section"
addconfig operserv os "none" dynamicstring "*" "Oper Server" "oper server" sepstring "Toggles Section"
addconfig identd id "syntax" string "*" "IdentD Reply" "identd response" sstring "Toggles Section"
addconfig wordhilight wh "none" dynamicstring "" "Word Highlights" "highlited words" sepstring "Toggles Section"
addconfig xwallnicks xw "none" dynamicstring "" "XWallop Nicknames" "xwallop nicknames" sepstring "Toggles Section"
addconfig killignorenicks ki "NickServ" dynamicstring "" "Kill Ignore Nicks" "nicknames ignored on kill messages" sepstring "Toggles Section"
addconfig autojoin aj "none" chanlist "" "AutoJoin Channels" "autojoin channels" sepstring "Toggles Section"
addconfig offerchans xo "none" chanlist "" "AutoOffer Channels" "autooffer channels" sepstring "Toggles Section"
addconfig bansinactive ba 0 boolean "" "Banlists in Active" "the display of banlists in the active window" sstring "Windowing Section"
addconfig themefile dt "default" string "*" "Default Theme" "theme file" sepstring "Toggles Section"
addconfig ctcprepactive sa 1 boolean "" "CTCP Replys in Active" "showing of ctcp replies in active window" sstring "Windowing Section"
addconfig operkillactive oa 0 boolean "" "Operkill Active" "viewing of operkills in active window" sstring "Windowing Section"
addconfig whoisactive wa 1 boolean "" "Whois in Active" "whois in active window" sstring "Windowing Section"
addconfig whoactive aw 1 boolean "" "Who in Active" "who in active window" sstring "Windowing Section"
addconfig notifyactive na 0 boolean "" "Notifys in Active" "the display of notifys in the active window" sstring "Windowing Section"
addconfig defawayqo qa "generic away msg" string "*" "Default Away Quote" "default away quote" lstring "Quotes Section"
addconfig defbackqo qb "generic back msg" string "*" "Default Back Quote" "default back quote" lstring "Quotes Section"
addconfig clonekickqo qc "CloneKicK" string "*" "Default CloneKick Quote" "default clonekick quote" lstring "Quotes Section"
addconfig masskickqo qm "MassKicK" string "*" "Default MassKick Quote" "default masskick quote" lstring "Quotes Section"
addconfig nickcompchar nc ":" string "?" "NickCompletion Character" "nick completion activation character" sstring "Toggles Section"
addconfigline "\\\[\[b\]cfl\[b\]\\\\\[b\]cft\[b\]\\\] \[b\]CTCP Flooding\[b\] is triggered with \[align \"(\[b\]\[config ctcpfloodlines\]\[b\])\" 4\] lines in \[align \"(\[b\]\[config ctcpfloodtime\]\[b\])\" 4\] seconds" "Flooding Section"
addconfig ctcpfloodtime cft 12 hiddendynamicinteger "3-9000" "x" "ctcp flood reset time" sstring "Flooding Section"
addconfig ctcpfloodlines cfl 3 hiddendynamicinteger "3-9000" "x" "ctcp flood trigger lines" sstring "Flooding Section"
addconfigline "\\\[\[b\]xfl\[b\]\\\\\[b\]xft\[b\]\\\] \[b\]xdcc Flooding\[b\] is triggered with \[align \"(\[b\]\[config xdccfloodlines\]\[b\])\" 4\] lines in \[align \"(\[b\]\[config xdccfloodtime\]\[b\])\" 4\] seconds" "Flooding Section"
addconfig xdccfloodtime xft 12 hiddendynamicinteger "3-9000" "x" "xdcc flood reset time" sstring "Flooding Section"
addconfig xdccfloodlines xfl 3 hiddendynamicinteger "3-9000" "x" "xdcc flood trigger lines" sstring "Flooding Section"
addconfigline "\\\[\[b\]mfl\[b\]\\\\\[b\]mft\[b\]\\\] \[b\]MAX Flood\[b\]\[spc 4\] is triggered with \[align \"(\[b\]\[config maxfloodlines\]\[b\])\" 4\] lines in \[align \"(\[b\]\[config maxfloodtime\]\[b\])\" 4\] seconds" "Flooding Section"
addconfig maxfloodtime mft 15 hiddendynamicinteger "3-9000" "x" "max flood reset time" sstring "Flooding Section"
addconfig maxfloodlines mfl 5 hiddendynamicinteger "3-9000" "x" "max flood trigger lines" sstring "Flooding Section"
addconfigline "\\\[\[b\]qv\[b\]\\\]Default Version Quote \[spc 3\] \[b\]--\[b\] \[retuversion\]" "Quotes Section"
addconfigverb version qv [lindex $synver 0] hiddenstring "*" "x" "Set version reply to (\[b\]\[retuversion\]\[b\])" sstring "Flooding Section"
addconfig awaynickcapt cl 1 boolean "" "Away NickCapture Log" "away mode nick capture log" sstring "Logging Section"
addconfig awaymessagelog am 1 boolean "" "Away Message Log" "away mode message log" sstring "Logging Section"
addconfig userlog ul 1 boolean "" "User Activity Log" "user activity log" sstring "Logging Section"
addconfig personallog lp 1 boolean "" "Personal Activity Log" "personal activity log" sstring "Logging Section"
addconfig dccmove dm 1 boolean "" "Move dccs to Nick-Dir" "move recieved files to dir with nick" sstring "Specials Section"
addconfig joncon joc 1 boolean "" "Autojoin on Connect" "join autojoin channels on connect" sstring "Specials Section"
addconfig closeonquit coq 1 boolean "" "Close on Quit" "Close XiRCON on quit" sstring "Specials Section"
addconfig arcon arc 1 boolean "" "Autoreconnect to IRC Server" "Reconnect to servers" sstring "Specials Section"
addconfig clearrelaytext crt 1 boolean "" "Clear relaytext on /cls" "Clear relaytext var when clearing window (with /cls or /clear)" sstring "Specials Section"
addconfig editor ed "notepad.exe" string "*" "Default editor (internal)" "Default editor for internal script usage" sstring "Specials Section"
addconfig jpqstatus jpq 0 boolean "" "Echo J/P/Q in Status" "Echo Joins, Parts, and Quits in Status window" sstring "Specials Section"
addconfig cryptkey ck "12345" integer "1-99999" "Encryption Key" "encryption key" sstring "Toggles Section"
addconfig autodecrypt cr 1 boolean "" "Auto Decryption" "automatic text decryption" sstring "Toggles Section"

restoretheme
if {[config themefile] != "default"} {
  if {![file exists [config themefile]]} {
    loadecho "[b]Initializing SyntaxIRC...[b]"
    loadecho "Unable to locate specified theme file \[[sb][config themefile][sb]\]..."
  } else {
    loadtheme [config themefile] 0
    loadecho "[b]Initializing SyntaxIRC...[b]"
    loadecho "Loading theme from file \[[sb][config themefile][sb]\]..."
  }
} else {
  loadecho "[b]Initializing SyntaxIRC...[b]"
}
if {![string length [get_cookie timer(total)]]} { set_cookie timer(total) "0" }

 #>># Define Socket Procedures

if {![info exists env(synloaded)]} {
  proc sendident { x y z } {
    global env
    if {![isin [ignorez "*!*@$y"] "other"]} {
      gets $x blah
      if {[string match "* , *" $blah]} {
        if {$env(rid) > 0} { set env(rid) "[expr {$env(rid) - 1}]" ; set id "[string tolower [rstring 9]]" ; set idt Clone
        } else { set id [config identd] ; set idt Ident }
        if {$id != "off"} {
          if {![catch {puts $x "[join [lrange $blah 0 2]] : USERID : UNIX : $id"}]} {
            if {$idt == "Ident"} {
              synecho x "[eheader "IdentD"] Sent ident reply ([b]$id[b]) to ([b]$y[b])..." status
            }
          }
        } else {
          synecho x "[eheader "IdentD"] Request recieved from ([b]$y[b])... no reply sent..." status
        }
      } else {
        synecho x "[eheader "IdentD"] Invalid ident request recieved from ([b]$y[b])... closing connection..." status
      }
    }
    catch {flush $x}
    catch {close $x}
  }
  proc createsock { x y z } { fileevent $x readable "sendident $x $y $z" ; fconfigure $x -buffering line -blocking 1 }
  proc notifykill { x y z } { catch {close $x} ; global dnsqueue ; lappend dnsqueue "wkill $y" ; lookup $y }
  proc notifyscan { x y z } { catch {close $x} ; global dnsqueue ; lappend dnsqueue "scan $y" ; lookup $y }
  if {[catch {socket -server createsock 113} eyedent]} { loadecho "\[[sb]error[sb]\] Ident socket failed: [sb]$eyedent[sb]" }
  if {[catch {socket -server notifykill 139} winkill]} { loadecho "\[[sb]error[sb]\] Winkill socket failed: [sb]$winkill[sb]" }
  if {[catch {socket -server notifyscan 32} portscan]} { loadecho "\[[sb]error[sb]\] Portscan socket failed: [sb]$portscan[sb]" }
}

 #>># Get primary server

if {[isip [lindex [server] 0]]} {
  lappend dnsqueue "resolveserv [lindex [server] 0]"
  lookup [lindex [server] 0]
}

 #>># Restore Help Settings
addhelp "tog" "Setting Modification" "/tog <toggleid> \[newvalue\]" "/config" "Modifies your script default values. A complete listing of all toggles may be seen by typing /tog with no parameters. A toggle's identifier is the two letters found in bold and nested in brackets on the complete toggle listing screen. If \[newvalue\] is omitted, the toggle is set to it's default value. + and - may also be used to add and remove autojoin, highlight words, xwallop nicks, and xdcc channels. The following toggle identifiers are valid... ; ; %bak%b -- Your default away mode nickname. ; %bgd%b -- Your usual irc nickname. ; %bai%b -- The interval(in seconds) for your away message timer. Set to 'off' to disable. ; %bii%b -- The interval(in seconds) for your antiidle send. Set to 'off' to disable. ; %brb%b -- The number of messages to store in your relay buffer. ; %btb%b -- The number of lines to store in your tab-key buffer. ; %bap%b -- Toggles your away pager on or off. ; %bam%b -- Toggles your away message logging on or off. ; %baa%b -- Toggles your away nickname capturing on or off. ; %ban%b -- Specifies whether or not to change your nickname when setting away. ; %bac%b -- Specifies whether or not to automatically perform nick completion on sent text. ; %bsa%b -- Toggles the showing of ctcp replies in the active window on\\off. ; %bsb%b -- Toggles on or off the banning of users who place a ban matching your hostmask. \
  ; %bdu%b -- Sets your default logon usermode changes. ; %bfw%b -- Toggles channel wallop formatting on\\off. ; %bqw%b -- Specifies whether or not to show a query window for private messages. ; %btf%b -- Toggles the display of your userlists to a tree-like display. ; %bad%b -- The amount(in seconds) of idle required to trigger autoaway. ; %bvk%b -- Toggles the viewing of operkills in your status window. ; %bcs%b -- Toggles on or off the clearing of your operkill scoreboard on logon to irc. ; %bau%b -- Toggles the displaying of an autokick menu on reop. ; %baj%b -- Sets your autojoin channels. ; %bqv%b -- Sets your default ctcp version reply. Fake versions can be set with ; /tog qv <fakenum>. Random versions can be set through \"random\". ; %bqa%b -- Sets your default away mode quote. ; %bqb%b -- Sets your default back mode quote. ; %bqm%b -- Sets your default masskick quote. ; %bwa%b -- Toggles the showing of whois' in the active window. ; %bna%b -- Toggles the showing of notifies in the active window. \
  ; %bjc%b -- Toggles the showing of chanstats on join. ; %bid%b -- Sets your identd reply. ; %bhw%b -- Sets hilight words. ; %bag%b -- Toggles on or off the autograbbing of url's. ; %bid%b -- Sets your identD reply. ; %bdd%b -- Sets your addons string. ; %bsk%b -- Switches the Control+D and Tab keys functions. ; %boa%b -- Sets viewing of operkills in active window on or off. ; %bgo%b -- Sets whether or not to cycle empty channels for ops. ; %bar%b -- Specifies whether or not to autorejoin channels when kicked. ; %bxw%b -- Sets the users on your xwallop list. ; %bss%b -- Sets your sent message relay style where %n is the nick you messaged and ; %t is the type of message sent. ; %brs%b -- Sets your relay recieved message style where %n is nick, %u is user, ; and %h is host. ; %bmf%b -- Toggles whether or not to include protected users in mass commands. ; %bqc%b -- Default clone kick quote. ; %bcfld%b -- Sets ctcp flooding to trigger with \[arg1\] requests in \[arg2\] secs. ; %bxfld%b -- Sets xdcc flooding to trigger with \[arg1\] requests in \[arg2\] secs. ; %bmfld%b -- Sets max flooding to trigger with \[arg1\] requests in \[arg2\] secs. ; %bul%b -- Log user activities. ; %blp%b -- Personal activity log. ; %bpl%b -- POP server logon name. ; %bpp%b -- POP server password. ; %bpi%b -- EMail checking interval. ; %bop%b -- Oper password. ; %bou%b -- Username to use to oper. ; %bov%b -- Catch server messages into opervision. ; %bps%b -- EMail server. \
  ; %bos%b -- Default server to use oper password\\opervision." "Syntax"
addhelp "cmode" "Internal Channel Mode Settings" "/cmode \[channel\] \[setting|mode\] \[set|x\] \[y\]" "None" "Modifies your internal channel settings. A complete list of all channels in your database can be obtained by typing /cmode with no parameters. A partial list can be obtained through /cmode <channel>. To modify a channels internal mode, use /cmode \[channel\] <mode>. To modify a channels setting, user /cmode \[channel\] <-setting> <set>. The following are valid channel modes... ; ; %bp%b -- Password AutoOping OFF. %bt%b -- Text Flood Protection. ; %bn%b -- Nick Flood Protection.  %bj%b -- Join Flood Protection. ; %bw%b -- Wordkicks.              %bd%b -- Massdeop Protection. ; %bk%b -- Masskick protection.    %br%b -- Repeat Kick. ; %bo%b -- Text Overflow Kick.     %bl%b -- Channel Lock. ; %ba%b -- Maximum Violations.     %be%b -- Ops Exempt. ; %bm%b -- Modelock.               %bc%b -- Topiclock. ; %bb%b -- Bansweep.               %bv%b -- Violation Flood. ; %bh%b -- Nethack Protection. \
  ; ; The following are valid setting modifiers... ; ; %b-textflood%b -- Sets text flooding to \[X\] lines in \[Y\] seconds. ; %b-nickflood%b -- Sets nick flooding to \[X\] changes in \[Y\] seconds. ; %b-joinflood%b -- Sets join flooding to \[X\] joins in \[Y\] seconds. ; %b-massdeop%b -- Sets mass deop trigger to \[X\] deops in \[Y\] seconds. ; %b-masskick%b -- Sets mass kick trigger to \[X\] kicks in \[Y\] seconds. ; %b-vioflood%b -- Sets violation flooding to \[X\] violations in \[Y\] seconds. ; %b-maxlength%b -- Sets text overflow string length to \[X\] characters. ; %b-maxvio%b -- Sets maximum flooding violations before ban to \[X\] violations. ; %b-modelock%b -- Sets mode lock to \[X\]. ; %b-topiclock%b -- Sets topic lock to \[X\]. ; %b-lockmsg%b -- Sets kickban on join message to \[X\]. ; %b+wordkick%b -- Adds a wordkick for mask \[X\] with reason \[Y\]. ; %b-wordkick%b -- Removes a wordkick for mask \[X\]. ; ; Additionally, the -del flag may be used to delete a channel." "Syntax"
addhelp "refresh" "IAL\\IBL Refresh" "/refresh \[channels\]" "None" "Refreshes internal lists for all channels, or just the ones specified." "Syntax"
addhelp "frelsm" "Fake Relay Sent Message" "/frelsm <targ> <text>" "None" "Fakes a relay making it look like you sent <text> to <targ>." "Syntax"
addhelp "frelm" "Fake Relay Message" "/frelm <targ> <text>" "None" "Fakes a relay making it look like <targ> said <text> to you." "Syntax"
addhelp "about" "Script Information" "/about" "None" "Do it now!#!\$@#\$." "Syntax"
addhelp "pingoff" "Fake Ping Timeout" "/pingoff" "None" "Replicates the look of a ping timeout quit message." "Syntax"
addhelp "wallex" "Wallop Exclude" "/wallex \[channel\] <excludedusers> <message>" "None" "Sends the given <message> to all users on \[channel\] except the ones specified. If no channel is specified, the command defaults to the current channel." "Syntax"
addhelp "unban" "Unban" "/unban \[channel\] <user|address>" "None" "Removes any bans matching the given user on \[channel\]. If no channel is specified, the command defaults to the current channel." "Syntax"
addhelp "pme" "Private Action" "/pme <user> <text>" "/desc" "Sends an action to the given user." "Syntax"
addhelp "at" "Topic Append" "/at <text>" "None" "Adds the selected text to the begining of the channel topic." "Syntax"
addhelp "rm" "Reverse Mode" "/rm \[channel\]" "None" "Reverses the last mode executed in the given channel." "Syntax"
addhelp "loadtheme" "Theme Load" "/loadtheme <file>" "/ltheme" "Loads the specified theme." "Syntax"
addhelp "theme" "Theme Management" "/theme \[number|file\]" "None" "Displays a list of all themes in the xircon and /theme directories. If a theme number or file is specified, the approperate theme is loaded, otherwise the command returns a list of all themes availiable to you." "Syntax"
addhelp "graburl" "Grab URL" "/graburl" "None" "Adds the last displayed url to your url list." "Syntax"
addhelp "url" "URL Catcher Management" "/url \[switch\] \[args\]" "None" "Manages your url list. A complete listing of all caught url's may be seen by typing /url with no parameters. The following \[switch\]es are valid... ; ;  %bADD    %b -- Adds the url \[args\] to your url list. ;  %bDEL    %b -- Deletes the url number \[args\]. ;  %bCLEAR  %b -- Clears your internal URL list. ; " "Syntax"
addhelp "scheck" "Spoof Check" "/scheck <nick>" "None" "Checks if <nick> is using a spoofed domain. If he\\she is, the command will return their actual address." "Syntax"
addhelp "rank" "Random Kick" "/rank \[channel\] \[message\]" "None" "Kicks a random user off of \[channel\]. If \[channel\] is omitted, the command defaults to using your default channel. If \[message\] is omitted, one of your default kick messages is used." "Syntax"
addhelp "ranok" "Random Op Kick" "/ranok \[channel\] \[message\]" "None" "Kicks a random op off of \[channel\]. If \[channel\] is omitted, the command defaults to using your default channel. If \[message\] is omitted, one of your default kick messages is used." "Syntax"
addhelp "rannk" "Random Non-Op Kick" "/rannk \[channel\] \[message\]" "None" "Kicks a random non-op off of \[channel\]. If \[channel\] is omitted, the command defaults to using your default channel. If \[message\] is omitted, one of your default kick messages is used." "Syntax"
addhelp "gk" "Global Kick" "/gk <nick> \[message\]" "None" "Kicks \[nick\] off all channels where you have ops. If \[message\] is omitted, one of your default kick messages is used." "Syntax"
addhelp "gkb" "Global KickBan" "/gkb <nick> \[message\]" "None" "KickBans \[nick\] off all channels where you have ops. If \[message\] is omitted, one of your default kick messages is used." "Syntax"
addhelp "whokill" "Address Kill" "/whokill <mask> \[message\]" "None" "Kills all users matching <address> with \[message\]." "Syntax"
addhelp "whoc" "Clone Report" "/whoc" "None" "Returns a list of your active clones, their servers, and the channels they are on." "Syntax"
addhelp "match" "Channel Scan" "/match \[channel\] <mask>" "None" "Returns all users on \[channel\] matching <mask>. If no \[channel\] is specified, the command defaults to the current channel." "Syntax"
addhelp "note" "Note" "/note \[note\]" "None" "Records the note \[note\] to your notefile. If no \[note\] is given, your current notes are displayed." "Syntax"
addhelp "wquery" "InterNIC Whois Query" "/wquery \[domain\]" "None" "Queries InterNIC for information on \[domain\]." "Syntax"
addhelp "who" "User Match" "/who \[mask\]" "None" "Returns a list of users matching the specified mask. If no mask is given, the command is preformed on the current channel." "Syntax"
addhelp "serv" "Server Definition" "/serv \[command\] <network> <server> \[ipaddress\] \[port\]" "None" "Contorls your servers database. A listing of your current servers may be obtained through executing /serv with no parameters. Valid commands are as follows... ; ; %bADD%b -- Adds <server> to your server list for <network> with \[port\]. If an ip address is omitted, the server is resolved before addition to the list. If a \[port\] is not specified, the default is 6667. ; %bDEL%b -- Removes <server> from your server database. ; " "Syntax"
addhelp "clk" "Cloaking Toggle" "/clk" "None" "Enables or disables your ctcp cloak based on it's current state." "Syntax"
addhelp "dict" "Dictionary" "/dict <word>" "None" "Searches an online dictionary for <word>. If <word> is mispelled, it returns a list of possible corrections." "Syntax"
addhelp "seen" "User Database" "/seen <nick>" "None" "Searches your internal database to find the last time in which you saw <nick>." "Syntax"
addhelp "repeat" "Command Repetition" "/repeat <times> <command>" "None" "Repeats <command> <times> times." "Syntax"
addhelp "ssave" "Save Settings" "/ssave <savefile>" "None" "Saves all of your current toggles to <savefile> so that they may be later used." "Syntax"
addhelp "sload" "Load Settings" "/sload <loadfile>" "None" "Loads all of the toggles in <loadfile> into your script." "Syntax"
addhelp "rnick" "Randomize Nickname" "/rnick" "None" "Randomizes your nickname." "Syntax"
addhelp "sping" "Server Ping" "/sping \[server\]" "None" "Sends a ping request to \[server\]. If \[server\] is omitted, the command defaults to using your current server." "Syntax"
addhelp "sver" "Server Version" "/sver \[server\]" "None" "Sends a version request to \[server\]. If \[server\] is omitted, the command defaults to using your current server." "Syntax"
addhelp "redir" "Echo Redirection" "/redir \[destination\] <command>" "/re" "Messages \[destination\] with all displayed output from <command>. If \[destination\] is omitted, the command defaults to using the current window. Keep in mind that <command> is still executed." "Syntax"
addhelp "massmsg" "Net-Wide Message" "/massmsg <host> <message>" "None" "Sends a message to all non-invisible users from <host> currently on irc." "Syntax"
addhelp "ll" "Link Looker" "/ll \[-rebuild\]" "None" "Searches for split servers based on a master servers list. To rebuild the master list, use /ll -rebuild." "Syntax"
addhelp "away" "Set Away Mode" "/away \[reason\]" "None" "Sets away mode with optional message \[reason\]. If no reason is given, \[reason\] is substituted with your default away reason." "Syntax"
addhelp "back" "Set Back Mode" "/back \[reason\]" "None" "Sets back mode with optional message \[reason\]. If no reason is given, \[reason\] is substituted with your default back reason." "Syntax"
addhelp "rcon" "Server Reconnect" "/rcon" "None" "Reconnects to your current IRC server." "Syntax"
addhelp "server" "Connect" "/server <server> <port>" "None" "Connects to <server> on port <port>. If <server> is not a valid address, the command halts." "Syntax"
addhelp "whon" "Notify List Report" "/whon"  "None" "Generates a report showing all logged on notify listed users along with logon time and address.." "Syntax"
addhelp "whou" "User List Report" "/whou \[channel\]" "None" "Generates a report showing the users who have database entries from \[channel\]. If \[channel\] is omitted, the command defaults to using the active channel." "Syntax"
addhelp "c" "Channel Mode" "/c \[channel\] <mode>" "/mode" "Sets the channel mode for \[channel\] to <mode>. If \[channel\] is omitted, the command defaults to using the active channel." "Syntax"
addhelp "whowas" "Whowas User" "/whowas <nickname>" "/ww" "Executes a whowas for <nickname>." "Syntax"
addhelp "whois" "Whois" "/whois <nickname>" "/wi" "Executes a whois for <nickname>." "Syntax"
addhelp "wii" "Extended Whois" "/whois <nickname1,nickname2>" "None" "Executes an extended whois for the nicknames given." "Syntax"
addhelp "key" "Channel Key Management" "/key <add|del> <channel> <key>" "None" "Adds or deletes an autokey for <channel>." "Syntax"
addhelp "ruser" "User List Management" "/ruser \<address|id\> \[channel\]" "/deluser" "Deletes the specified user from your userlist. If no \[channel\] is given, the command removes the users access for all channels. No channel is needed when removing off of a id number." "Syntax"
addhelp "kickquote" "Kick Quote Management" "/kickquote \[switch\] \[args\]" "/kq" "Manages your kick quote list. A complete listing of all kick quotes may be viewed by typing /kickquote with no parameters. The following \[switch\]es are valid... ; ; %bADD    %b -- Adds the kick quote \[args\] to your kick quote list. ; %bDEL%b -- Deletes the kick quote number \[args\]. ; %bRESTORE%b -- Deletes all current kick quotes and resets the script default quotes. ; ; The following variables may also be used in your quotes. ; ; %b%m%b -- Your current nickname. ; %b%k%b -- The nickname of the user being kicked. ; %b%n%b -- The number of kicks completed in the current kick set. ; %b%c%b -- The channel that the user is being kicked from. ; %b%a%b -- The total number of kicks you are executing in this set. ; %b%t%b -- your total kick count. ; " "Syntax"
addhelp "quitquote" "Quit Quote Management" "/quitquote \[switch\] \[args\]" "/qq" "Manages your quit quote list. A complete listing of all quit quotes may be viewed by typing /quitquote with no parameters. The following \[switch\]es are valid... ; ; %bADD    %b -- Adds the quit quote \[args\] to your quit quote list. ; %bDEL%b -- Deletes the quit quote number \[args\]. ; %bRESTORE%b -- Deletes all current quit quotes and resets the script default quotes. ; ; The following variables may also be used in your quotes. ; ; %b%m%b -- Your current nickname. ; %b%o%b -- Your total online time for this session of IRC. ; %b%t%b -- Your total online time. ; " "Syntax"
addhelp "fakever" "Fake Version Reply Management" "/fakever \[switch\] \[args\]" "/fv" "Manages your fake version reply list. A complete listing of all fake versions may be seen by typing /fakever with no parameters. The following \[switch\]es are valid... ; ; %bADD    %b -- Adds the version reply \[args\] to your fake version list. ; %bDEL%b     -- Deletes the version reply number \[args\]. ; %bRESTORE%b -- Deletes all current versions and resets the script default fake replies. ; " "Syntax"
addhelp "ignore" "Ignorance List Management" "/ignore <nickname|mask|id> \[types\]" "/ig" "Manages your ignore list. A complete listing of all ignored users may be viewed by typing /ignore with no parameters. If <nickname> is specified, the command will lookup <nickname> and add the address to the ignore list. To set an ignore, use the following format: /ignore <user> +-<modes>. The following \[type\]s of ignores are valid... ; ; %bT%bEXT   -- Ignores all notices and private messages from the user. ; %bC%bTCP   -- Ignores all CTCP requests from the user. ; %bD%bCC    -- Ignores all dcc chat\\sends from the user. ; %bI%bNVITE -- Ignores all invites from the user. ; %bP%bUBLIC -- Ignores all public text from the user. ; %bO%bTHER  -- Ignores ident requests\\winkills\\portscans from the user. " "Syntax"
addhelp "unignore" "Ignorance List Management" "/unignore <nickname|mask|id>" "/unig" "Removes users matching <mask|id> from your ignore list. A complete listing of all ignored users may be viewed by typing /ignore with no parameters. If <nickname> is specified, the command will lookup <nickname> and remove the address from the ignorance list." "Syntax"
addhelp "notify" "Notify List Management" "/notify \[action\] <nickname|id> \[whoistog|switch\] \[address\] \[note\]" "/not" "Manages your notify list. A complete listing of all notify-listed users may be viewed by typing /notify with no parameters or with \[action\] being \"list\". When \[action\] is \"add\", <nickname> will be added to your notify list. If \[action\] is \"del\" or \"rem\", <nickname> will be removed from the notify list. If \[whoistog\] is specified as a non-zero string, a whois will be preformed on the user when the notify is activated. If an \[address\] is given and users using the notified nick will be checked against this address to check validity. If a \[note\] is given, this note will be displayed whenever a user logs onto irc. If the given <nickname> is already notify-listed \[switch\] may be used to change the users notification attributes. The following \[switch\]es are valid. ; %b-w%b -- Changes the whois toggle for the user. ; %b-n%b -- Changes the user's logon note. ; %b-a%b -- Changes the users registered address. " "Syntax"
addhelp "unnotify" "Notify List Management" "/unnotify <nickname|id>" "/unnot" "Removes users with the nickname <nickname> from your notification list. If <id> is specified instead, it removes users maching that id number." "Syntax"
addhelp "mystat" "Personal User Information" "/mystat" "/id /whoami" "Displays your irc address, idle time, total time spent on this session of irc, total time spent on irc, and any away or idle modes you have set." "Syntax"
addhelp "timeclear" "Online Clock Reset" "/timeclear" "None" "Resets your online clock" "Syntax"
addhelp "quit" "End IRC Session" "/quit \[message\]" "None" "Ends your current IRC session by logging off with \[message\]. If \[message\] is omitted, a default message from your quit quotes list is chosen." "Syntax"
addhelp "cs" "Channel Statistics\\Information" "/cs \[channel\]" "/cstat" "Displays the users on, user counts, and op\\nonop\\voice\\nonvoice percentages on a channel. If \[channel\] is omitted, the command defaults to the current channel. " "Syntax"
addhelp "nms" "Channel Names Listing" "/nms \[channel\]" "None" "Displays the users on a channel. If \[channel\] is omitted, the command defaults to the current channel. " "Syntax"
addhelp "chops" "Channel Operators Listing" "/chops \[channel\]" "None" "Displays the operators on a channel. If \[channel\] is omitted, the command defaults to the current channel. " "Syntax"
addhelp "t" "Set Topic" "/t \[channel\] \[newtopic\]" "/topic" "Sets the topic on \[channel\] to \[newtopic\]. If \[channel\] is omitted, the command defaults to using the current channel. " "Syntax"
addhelp "relm" "Recieved Message Relay" "/relm \[destination\] \[relaynum\]" "None" "Relays the message number \[relaynum\] from your recieved message buffer to \[destination\]. /relm -l may be used to view your recieved message buffer. If \[destination\] is omitted, the command defaults to the current window if \[relaynum\] is omitted, the command defaults to 1(the last message recieved)." "Syntax"
addhelp "relok" "OperKill Relay" "/relok \[destination\] \[relaynum\]" "None" "Relays the operkill number \[relaynum\] from your operkill message buffer to \[destination\]. /relok -l may be used to view your operkill message buffer. If \[destination\] is omitted, the command defaults to the current window if \[relaynum\] is omitted, the command defaults to 1(the last message recieved)." "Syntax"
addhelp "relm" "Sent Message Relay" "/relsm \[destination\] \[relaynum\]" "None" "Relays the message number \[relaynum\] from your sent message buffer to \[destination\]. /relsm -l may be used to view your sent message buffer. If \[destination\] is omitted, the command defaults to the current window if \[relaynum\] is omitted, the command defaults to 1(the last message sent)." "Syntax"
addhelp "version" "Version Request" "/version \[channel|nickname\]" "/ver" "Sends a CTCP version request to \[channel|nickname\]. If \[channel|nickname\] is omitted, the request is sent to the active window, whether it's a channel or query." "Syntax"
addhelp "ping" "Ping Request" "/ping \[channel|nickname\]" "None" "Sends a CTCP ping request to \[channel|nickname\]. If \[channel|nickname\] is omitted, the request is sent to the active window, whether it's a channel or query." "Syntax"
addhelp "4op" "Multiple Op" "/4op \[channel\] <nick1,nickN>" "None" "Ops the specified users on \[channel]\ four times. If \[channel\] is omitted, the command ops users in the current channel." "Syntax"
addhelp "4deop" "Multiple Deop" "/4deop \[channel\] <nick1,nickN>" "None" "Deops the specified users on \[channel]\ four times. If \[channel\] is omitted, the command ops users in the current channel." "Syntax"
addhelp "op" "Channel Management" "/op \[channel\] <nick1,nickN>" "/o" "Ops the specified users on \[channel]\. If \[channel\] is omitted, the command ops users in the current channel." "Syntax"
addhelp "deop" "Channel Management" "/deop \[channel\] <nick1,nickN>" "/d" "Deops the specified users on \[channel]\. If \[channel\] is omitted, the command deops users in the current channel." "Syntax"
addhelp "voice" "Channel Management" "/voice \[channel\] <nick1,nickN>" "/v" "Voices the specified users on \[channel]\. If \[channel\] is omitted, the command voices users in the current channel." "Syntax"
addhelp "unvoice" "Channel Management" "/unvoice \[channel\] <nick1,nickN>" "/u" "Devoices the specified users on \[channel]\. If \[channel\] is omitted, the command devoices users in the current channel." "Syntax"
addhelp "fk" "Filterkick" "/fk \[channel\] \[mask\] \[message\]" "None" "Kicks all users specified off the given channel whos addresses match \[mask\]. If no channel is given, it kicks using users on the current channel. If no default message is specified, it uses the script default filterkick message." "Syntax"
addhelp "fkb" "Filterkick Ban" "/fkb \[channel\] \[mask\] \[message\]" "None" "KickBans all users specified off the given channel whos addresses match \[mask\]. If no channel is given, it kicks using users on the current channel. If no default message is specified, it uses the script default filterkick message." "Syntax"
addhelp "nck" "Nick Completion Kick" "/nck \[channel\] <user1,userN> \[message\]" "None" "Kicks all users specified off the given channel where the users given need only be the beginning of the users nick. If no channel is given, it kicks using users on the current channel. If no default message is specified, it uses the script default kick message." "Syntax"
addhelp "nckb" "Nick Completion KickBan" "/nckb \[channel\] <user1,userN> \[message\]" "None" "KickBans all users specified off the given channel where the users given need only be the beginning of the users nick. If no channel is given, it kicks using users on the current channel. If no default message is specified, it uses the script default kick message." "Syntax"
addhelp "lk" "Last Join Kick" "/lk \[channel\] \[message\]" "None" "Kicks the last user to join the given channel off that channel. If no channel is given, it kicks using users on the current channel. If no default message is specified, it uses the script default kick message." "Syntax"
addhelp "lkb" "Last Join KickBan" "/lkb \[channel\] \[message\]" "None" "KickBans the last user to join the given channel off that channel. If no channel is given, it kicks using users on the current channel. If no default message is specified, it uses the script default kick message." "Syntax"
addhelp "k" "Kick" "/k \[channel\] <user1,userN> \[message\]" "/kick" "Kicks all users specified off the given channel. If no channel is given, it kicks using users on the current channel. If no default message is specified, it uses the script default kick message." "Syntax"
addhelp "kb" "KickBan" "/kb \[channel\] <user1,userN> \[message\]" "/bk /kickban" "KickBans all users specified off the given channel. If no channel is given, it kicks using users on the current channel. If no default message is specified, it uses the script default kick message." "Syntax"
addhelp "dkb" "Domain KickBan" "/dkb \[channel\] <user1,userN> \[message\]" "/dbk" "Kicks all users specified off the given channel with a domain ban. If no channel is given, it kicks using users on the current channel. If no default message is specified, it uses the script default kick message." "Syntax"
addhelp "skb" "Screw KickBan" "/skb \[channel\] <user1,userN> \[message\]" "/sbk" "Kicks all users specified off the given channel with a screw ban. If no channel is given, it kicks using users on the current channel. If no default message is specified, it uses the script default kick message." "Syntax"
addhelp "cycle" "Channel Rejoin" "/cycle \[channel\]" "/r" "Quickly parts then rejoins \[channel\]. If no \[channel\] is given, the command cycles the current window." "Syntax"
addhelp "wall" "Channel Operator Notice" "/wall \[channel\] \<text\>" "/w /on" "Sends a wallop notice to all channel operators of \[channel\]. If \[channel\] is not specified, the command is executed on the current channel." "Syntax"
addhelp "xwall" "Selected User Notice" "/xwall <text>" "/xw" "Sends the given text to all users on your xwallop list." "Syntax"
addhelp "inv" "Invite" "/inv <user1,userN> \[channel\]" "/invite" "Invites all specified users to \[channel\]. If \[channel\] is not specified, the users are invited to the current channel. Conditionally, The channel key is automatically sent to the users as well." "Syntax"
addhelp "tcl" "TCL Command Execution" "/tcl <expression> \[channel\]" "None" "Evaluates the TCL expression <expression>. " "Syntax"
addhelp "ji" "Join Invited Channel" "/ji" "F6" "Joins the channel you were last invited to." "Syntax"
addhelp "recnick" "Default Nickname Switch" "/recnick" "F5 /rn" "Switches your nickname to your script-default nickname." "Syntax"
addhelp "join" "Channel Join" "/join <channel1,channelN>" "/j" "Joins the specified channels." "Syntax"
addhelp "um" "Usermode Change" "/um \[newmode\]" "/umode" "Changes your current usermode to \[newmode\]. If \[newmode\] is omitted, your usermode is set to your default usermode." "Syntax"
addhelp "me" "Action" "/me <action>" "None" "Sends an action to the current channel\\query." "Syntax"
addhelp "cloak" "CTCP Flood Protection" "/cloak" "F7" "Enables your CTCP Cloak. The CTCP Cloak ignores all CTCP requests from other users." "Syntax"
addhelp "uncloak" "CTCP Flood Protection" "/uncloak" "F8" "Disables your CTCP Cloak." "Syntax"
addhelp "score" "OperKill Scoreboard" "/score" "None" "Displays the top-10 opers in terms of killing." "Syntax"
addhelp "clearscore" "OperKill Scoreboard" "/clearscore" "None" "Clears all rankings on the operkill scoreboard." "Syntax"
addhelp "asay" "Message" "/asay <text>" "None" "Sends the given text to all channels you're currently on." "Syntax"
addhelp "ame" "Action" "/ame <text>" "None" "Sends an action to all channels you're currently on." "Syntax"
addhelp "dns" "Domain Resolution" "/dns <domain|ip|nickname>" "None" "Attempts to resolve <domain|ip>." "Syntax"
addhelp "awaymsgs" "Away Message System" "/awaymsgs" "/am" "Views your away messages. Use /awaymsgs del to delete your current messages." "Syntax"
addhelp "awaycapt" "Away Nickname Capture System" "/awaycapt" "/ac" "Views your away nickname captures. Use /awaycapt del to delete your current captures." "Syntax"
addhelp "a" "Away System" "/a \[message\]" "None" "Toggles into or out of away mode. If no \[message\] is given, the script default message is used." "Syntax"
addhelp "ai" "AntiIdle System" "/ai" "None" "Toggles into or out of antiidle mode." "Syntax"
addhelp "clear" "Buffer Clear" "/clear" "/cls" "Clears the current window buffer." "Syntax"
addhelp "bans" "List Channel Bans" "/bans \[channel\]" "None" "Views a list of bans on \[channel\]. If \[channel\] is omitted, the command displays a list of bans on the current channel." "Syntax"
addhelp "ctcp" "Send CTCP Request" "/ctcp <nickname> <request> \[other\]" "None" "Sends a CTCP request to <nickname>." "Syntax"
addhelp "msg" "Send Message" "/msg <nickname> <text>" "None" "Sends a message to <nickname>." "Syntax"
addhelp "notice" "Send Notice" "/notice <nickname> <text>" "/n" "Sends a notice to <nickname>." "Syntax"
addhelp "qk" "QuickKey Settings" "/qk \[keynumber\] \[command\] " "None" "Manages your QuickKeys. /qk with no parameters will display a list of your currently set quickkeys. To set a quickkey, simply /qk \[keynumber\] \[command\]. To use the quickkey press the F\[keynumber\] and the \[command\] will execute. " "Syntax"
addhelp "mub" "Mass Unban" "/mub \[channel\]" "None" "Clears all bans on \[channel\]. If \[channel\] is omitted, the command defaults to using the active window. " "Syntax"
addhelp "lock" "Takeover Lock" "/lock \[channel\]" "None" "Attempts to lock all users out of \[channel\] by setting modes +mkbil. If \[channel\] is omitted, the command defaults to using the active window. " "Syntax"
addhelp "unlock" "Takeover Unlock" "/unlock \[channel\]" "None" "Attempts to unlock \[channel\] by unsetting setting modes -mkbil. If \[channel\] is omitted, the command defaults to using the active window. " "Syntax"
addhelp "resynch" "Channel Resynch" "/resynch \[channel\]" "None" "Attempts to resynch the channel \[channel\] by reoping all ops. If \[channel\] is omitted, the command defaults to using the active window." "Syntax"
addhelp "md" "Mass Deop" "/md \[channel\] \[-p|priority1,priorityN\]" "/mass" "Removes all channel ops on \[channel\]. \[priority\]s should be set to the nicknames of people you want deoped first. If \[channel\] is omitted, the command defaults to using the active window. This command avoids deoping any protected users." "Syntax"
addhelp "mo" "Mass Op" "/mo \[channel\] \[-p|priority1,priorityN\]" "/mass" "Makes all non ops on \[channel\] ops. \[priority\]s should be set to the nicknames of people you want oped first. If \[channel\] is omitted, the command defaults to using the active window." "Syntax"
addhelp "mopu" "Mass Op AutoOps" "/mopu \[channel\]" "None" "Makes all non-oped autoops on \[channel\] ops. If \[channel\] is omitted, the command defaults to using the active window." "Syntax"
addhelp "mv" "Mass Voice" "/mv \[channel\]" "/mass" "Voices all non ops on \[channel\]. If \[channel\] is omitted, the command defaults to using the active window." "Syntax"
addhelp "mu" "Mass Devoice" "/mu \[channel\]" "/mass" "Devoices all voiced users on \[channel\]. If \[channel\] is omitted, the command defaults to using the active window." "Syntax"
addhelp "mk" "Mass Kick" "/mk \[channel\] \[-p|priority1,priorityN\]" "None" "Kicks all users off of \[channel\]. \[prioritys\] should be set to the nicknames of people you want kicked first. If \[channel\] is omitted, the command defaults to using the active window. This command avoids kicking protected users." "Syntax"
addhelp "omk" "Mass OpKick" "/omk \[channel\] \[-p|priority1,priorityN\]" "None" "Kicks all oped users off of \[channel\]. \[prioritys\] should be set to the nicknames of people you want kicked first. If \[channel\] is omitted, the command defaults to using the active window. This command avoids kicking protected users." "Syntax"
addhelp "nmk" "Mass NonOpKick" "/nmk \[channel\] \[-p|priority1,priorityN\]" "None" "Kicks all nonoped users off of \[channel\]. \[prioritys\] should be set to the nicknames of people you want kicked first. If \[channel\] is omitted, the command defaults to using the active window. This command avoids kicking protected users." "Syntax"
addhelp "omkb" "Mass OpKickBan" "/omkb \[channel\] \[-p|priority1,priorityN\]" "None" "Kicks and bans all oped users on \[channel\]. \[prioritys\] should be set to the nicknames of people you want kicked first. If \[channel\] is omitted, the command defaults to using the active window. This command avoids kicking protected users." "Syntax"
addhelp "sv" "Show Version" "/sv \[destination\]" "None" "Messages \[destination\] with your current script version and a lame quote." "Syntax"
addhelp "svn" "Show Version (No Quote)" "/svn \[destination\]" "None" "Messages \[destination\] with your current script version." "Syntax"
addhelp "operscan" "Oper Scan" "/operscan \[channel\]" "None" "Scans the given channel for irc operators." "Syntax"
addhelp "ban" "Ban External User" "/ban \[channel\] \[nickname|mask\] \[banlevel\]" "None" "Bans the user \[nickname\] on \[channel\] with no kick. If \[banlevel\] is omitted, the command will default to level 5. If \[channel\] is omitted, the command will default to the current channel." "Syntax"
addhelp "nickregain" "Steal Nickname" "/nickregain \[nick\]" "None" "Attempts to regain the nickname specified. If no nickname is specified, the command halts all active regains." "Syntax"
addhelp "oper" "Oper" "/oper \[nickname\] \[pass\]" "None" "Sends your oper password, or the oper password given, to your current server. If no username is given, your defaults are used." "Syntax"
addhelp "unoper" "unOper" "/unoper" "None" "Removes your ircop status." "Syntax"
addhelp "kill" "Kill User" "/kill <nick1,nick2> \[reason\]" "None" "Kills the nicknames given with the specified reason." "Syntax"
addhelp "mass" "Mass Commands" "/mass <d|o|u|v> \[channel\]" "None" "Executes a mass command on the given channel, d being deop, o being op, v being voice, and u being unvoice." "Syntax"
addhelp "rekey" "Change Channel Key" "/rekey \[newkey\]" "None" "If a key is specifed, unsets the old channel key, and replaces it with the one given. If no key is specified, the channel's current key is removed." "Syntax"
addhelp "spy" "Establish Spylink" "/spy <spy on> <redirect to>" "None" "Sends all messages from a given user\\channel to the specified location." "Syntax"
addhelp "rspy" "Break Spylink" "/rspy <spy on>" "None" "Breaks a spylink with the given user\\channel." "Syntax"
addhelp "chattr" "Change Attributes" "/chattr <num|hostmask> \[attrs\]" "None" "Modifies the given hostmask's attributes by the specified ones. If no attributes are specified, the hostmasks's current attributes are displayed." "Syntax"
addhelp "chpass" "Change Password" "/chpass <num|hostmask> \[pass\]" "None" "Changes a users password. If no password is specified, removes the given user's password." "Syntax"
addhelp "user" "Maintain Userlist" "/user <nick|num|hostmask> <channels> <flags> \[comment\]" "None" "Modifies or adds the specifed user to the user database. A complete listing of all users on your database may be obtained by calling user with no arguments. Valid user flags are as follows: ; ; %bi%b -- User can request to be invited. ; %bc%b -- User can request chops. ; %bu%b -- User can request to be unbanned. ; %bo%b -- User may recieve ops. ; %bd%b -- User may not recieve ops. ; %bv%b -- User may recieve voice. ; %bb%b -- User is autokickbanned. ; %b1%b -- User has mass command protection. ; %b2%b -- User has mass command\\kick protection. ; %b3%b -- User has mass command\\kickban protection. ; " "Syntax"
addhelp "ruser" "Maintain Userlist" "/user <nick|num|hostmask>" "None" "Removes the given hosts from the userlist." "Syntax"
addhelp "dcc" "DCC Information\\Control" "/dcc \[tsend|send|cancel|chat|get\] \[nick\] \[file\]" "/dc" "Manipulates current dcc's. Calling dcc with no arguments displays a list of currently active transfers. The tsend parameter is used to send a user a local file via the improved dcc protocol, Chat is used to initiate a chat session with a user, Send is used to send a local file via the plain dcc protocol, Get is used to accept a file from a user, and Cancel is used to end a transfer with a user." "Syntax"
addhelp "partall" "Part" "/partall" "None" "Parts all channels you are currently in." "Syntax"
addhelp "autoaway" "Hide from lamers" "/autoaway" "None" "Sets away with a message that looks like the default idle away message." "Syntax"
addhelp "timer" "Timed Event Control" "/timer <interval> <repeats> <command>" "None" "Executes the given <command> <repeats> times every <interval> seconds. Use /timer with no parameters to obtain a list of active timers. A timer may be disabled with /timer <number> off, or /timers off to disable all timers." "Syntax"
addhelp "snt" "Set mode +snt" "/snt \[channel\]" "None" "Sets mode +snt on the specified channel, or the active channel if no channels are specified." "Syntax"
addhelp "nt" "Set mode +nt" "/nt \[channel\]" "None" "Sets mode +nt on the specified channel, or the active channel if no channels are specified." "Syntax"
addhelp "country" "Country Retrieval" "/country <-nick nick|2-letter abbrev" "None" "Retrieves the name of the country of  a hostname. If -nick is used the country of 'nick' will be retrieved." "Syntax"
addhelp "calc" "Calculator" "/calc <expression>" "/expr" "Does math evaluation of expression" "Syntax"
addhelp "gt" "Grab Topic" "/gt" "None" "Inserts topic of active channel in command line" "Syntax"
addhelp "at" "Append Topic" "/at <Topic>" "None" "Appends topic to the channels current topic" "Syntax"
addhelp "cryptmsg" "Send Encrypted Message" "/cryptmsg <targ> <text>" "None" "Encrypts <text> and sends it in a message to <targ>." "Syntax"
addhelp "crypt" "Encryption" "/crypt <text>" "None" "Sends an encrypted string based on <text> to the current window." "Syntax"

 #>># Create directories

file mkdir "[get_syn_dir]/syntax/logs"
file mkdir "[get_syn_dir]/syntax/themes"
file mkdir "[get_syn_dir]/syntax/addons"
checkfile "[get_syn_dir]/syntax/notes.txt"
if {[config awaynickcapt]} { checkfile [get_syn_dir]/syntax/logs/awaycapt.log }
if {[config awaymessagelog]} { checkfile [get_syn_dir]/syntax/logs/awaymsgs.log }
if {[config userlog]} { checkfile [get_syn_dir]/syntax/logs/user.log }
if {[config personallog]} { checkfile [get_syn_dir]/syntax/logs/personal.log }

 #>># Check versions

if {$interver > [get_cookie loadver "0"]} {
  if {![string length [get_cookie loadver]]} {
    loadecho "Welcome to abyss' syntax... For command help type /help. To get extensive command help, use /help <command>. Also remember to set your toggles by typing /tog. When a new script version is released, it will automatically update with your old toggles in this fashion. In order for syntax to allow themes, you *must* set all of your backgrounds to black in your Tools|Preferences|Colors setup menu. This notice will only display once. Have fun :>"
    if {[connected]} {
      loadecho "Now autojoining [b]#syntax[b]... (one time only)"
      /raw join #syntax
    } else {
      set firstload 1
    }
  }
  set oldver "[get_cookie loadver "0"]"
  set_cookie loadver $interver
  loadecho "New syntax version detected \[[sb]$internalver[sb]\]... AutoUpdating..."
  set_cookie config(version) "$syntax"
  loadecho "Set version reply to -- $syntax"
}

proc @define@ { args } { }
proc @adname@ { args } { }

 #>># Load Addons

foreach pewt "[glob -nocomplain [get_syn_dir]/syntax/addons/*.syn *.syn]" {
  set loadatime [clock clicks]
  set searchfile [open "$pewt" r]
  set xx [gets $searchfile]
  if {$xx == "@define@ syntax extension"} {
    set xx [gets $searchfile]
    set pert "[string range $xx 9 end]"
    if {![string length $pert]} { set pert "unknown" }
    lappend synadd "[list "$pewt"] [list "$pert"]"
    if {[catch "source $pewt" out]} {
      loadecho "\[[sb]error[sb]\] Error loading module \[[sb]$pewt[sb]\]: $out"
    } else {
      loadecho "Loaded module \[[sb][file tail $pewt][sb]\] (in [expr {[clock clicks] - $loadatime}] ms)..."
    }
  }
  close $searchfile
}

 #>># Echo Syntax Loaded

upver "$syntax"
if {[window_type] != "status"} { echo " " status }
echo " "
loadecho "$syntax, now loaded (in [expr {[clock clicks] - $loadtime}] ms)..."
if {[window_type] != "status"} { echo " " status }
echo " "

on 307 { complete } ;#>># Halt dalnet "is a registered nick"
on 309 { complete } ;#>># Halt dalnet "is a Services Administrator"
on 308 { complete } ;#>># Halt dalnet "is an IRC Server Administrator"

on 353 { complete }
on 364 { complete }
on 365 { complete }
on 001 { complete }
on 002 { complete }
on 003 { complete }
on 004 { complete }
on 005 { complete }
on 376 { complete }
on 375 { complete }
on 372 { complete }
on 471 { complete }
on 473 { complete }
on 474 { complete }
on 475 { complete }
on 431 { complete }
on 305 { complete }
on 306 { complete }
on 402 { complete }
on 403 { complete }
on 406 { complete }
on 411 { complete }
on 412 { complete }
on 421 { complete }
on 432 { complete }
on 433 { complete }
on 404 { complete }
on 442 { complete }
on 482 { complete }
on 443 { complete }
on 377 { complete }
on 376 { complete }
on 375 { complete }
on 381 { complete }
on 461 { complete }
on 437 { complete }
on 467 { complete }
on 472 { complete }
on 221 { complete }
on 481 { complete }
on 441 { complete }
on 472 { complete }
on 478 { complete }
on 341 { complete }
on 465 { complete }
on 369 { complete }
on 314 { complete }
on 303 { complete }
on 401 { complete }
on 311 { complete }
on 312 { complete }
on 301 { complete }
on 313 { complete }
on 310 { complete }
on 317 { complete }
on 319 { complete }
on 318 { complete }
on 331 { complete }
on 332 { complete }
on 333 { complete }
on 328 { complete }
on 329 { complete }
on 324 { complete }
on 351 { complete }
on 252 { complete }
on 254 { complete }
on 255 { complete }
on 265 { complete }
on 266 { complete }
on 366 { complete }
on 211 { complete }
on 213 { complete }
on 405 { complete }
on 214 { complete }
on 215 { complete }
on 218 { complete }
on 212 { complete }
on 243 { complete }
on 216 { complete }
on 219 { complete }
on 367 { complete }
on 372 { complete }
on 368 { complete }
on 352 { complete }
on 315 { complete }
on CTCP { if {[info exists completectcp]} { unset completectcp ; complete } }
on WALLOPS { complete }
on PRIVMSG { complete }
on NOTICE { complete }
on JOIN { complete }
on PART { complete }
on QUIT { complete }
on NICK { complete }
on KICK { complete }
on TOPIC { complete }
on MODE { complete }
on CTCP_REPLY { complete }
on ERROR { complete }
on INVITE { complete }
on DISCONNECT { complete }
on dcc_create { complete }
on dcc_begin { complete }
on dcc_complete { complete }
on dcc_error { complete }
on LOAD { complete }
on UNLOAD { complete }
on CONNECT { complete }
on CHAT_SEND { complete }
on CHAT_TEXT { complete }

if {![info exists env(synloaded)]} {
  set env(synloaded) "1"
  set originalsyn "1"
} else {
  set originalsyn "0"
}

